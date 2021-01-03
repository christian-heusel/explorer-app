package utils

import (
	"encoding/csv"
	"io"
	"io/ioutil"
	"log"
	"os"
	"strconv"
	"strings"

	"github.com/christian-heusel/explorer-app/server/graph/model"
	"github.com/jinzhu/gorm"
)

func CreateStationFromSplice(db *gorm.DB, input []string, indexMap map[string]int) *gorm.DB {
	// check that all the keys exist in the indexMap
	for _, key := range [...]string{"id", "points", "station_type", "coordinates", "grid_square", "title"} {
		if _, inserted := indexMap[key]; !inserted {
			log.Fatalln("You are missing the", key, "column in the Stations CSV!")
		}
	}

	return db.Create(&model.Station{
		ID:          getInt(input[indexMap["id"]]),
		Points:      getInt(input[indexMap["points"]]),
		StationType: getInt(input[indexMap["station_type"]]),
		Coordinates: &input[indexMap["coordinates"]],
		GridSquare:  &input[indexMap["grid_square"]],
		Title:       &input[indexMap["title"]],
	})
}

func CreateTeamFromSplice(db *gorm.DB, input []string, indexMap map[string]int) *gorm.DB {
	// check that all the keys exist in the indexMap
	for _, key := range [...]string{"name", "authcode", "members"} {
		if _, inserted := indexMap[key]; !inserted {
			log.Fatalln("You are missing the", key, "column in the Teams CSV!")
		}
	}

	var members *int
	if result, err := strconv.Atoi(input[indexMap["members"]]); err == nil {
		members = &result
	} else {
		members = nil
	}

	return db.Create(&model.Team{
		Name:     &input[indexMap["name"]],
		Members:  members,
		Authcode: input[indexMap["authcode"]],
	})
}

func SetupTableFromCSV(db *gorm.DB, filepath string, adapter func(*gorm.DB, []string, map[string]int) *gorm.DB) error {
	// Open the file
	csvfile, err := os.Open(filepath)
	if err != nil {
		log.Fatalln("Couldn't open the csv file", filepath, err)
	}

	// Parse the file
	r := csv.NewReader(csvfile)

	header, err := r.Read()
	log.Println("Header:" + strings.Join(header, ", "))

	indexMap := make(map[string]int)
	for index, colHead := range header {
		// Check that the value has not already been inserted
		// since this would mean that we have a column twice
		if _, inserted := indexMap[colHead]; inserted {
			log.Fatalln("The column", colHead, "has already been inserted into the indexMap which means that you defined it twice in the CSV file!")
		} else {
			indexMap[strings.ToLower(colHead)] = index
		}
	}
	log.Println(indexMap)

	// Iterate through the csv data
	for {
		// Read each row from csv
		record, err := r.Read()
		if err == io.EOF {
			break
		}
		if err != nil {
			log.Fatal(err)
		}
		log.Println("Line:", strings.Join(record, ", "))

		result := adapter(db, record, indexMap)

		if result.Error != nil {
			log.Fatalln("Error while inserting into the DB", result.Error)
			return result.Error
		}
	}
	return nil
}

func HasToInitialize() bool {
	_, fileErr := os.Stat("/initialized")
	forceInitialization, envPresent := os.LookupEnv("FORCE_INITIALIZATION")

	if envPresent {
		if forceInitializationBool, err := strconv.ParseBool(forceInitialization); err == nil {
			log.Println("envvar 'FORCE_INITIALIZATION' has value", forceInitializationBool)
			return forceInitializationBool
		}
		log.Fatalln(forceInitialization, "is not parsable as a bool.")
	}
	log.Println("No envvar 'FORCE_INITIALIZATION' found!")
	log.Println("File '/initialized' exists:", !os.IsNotExist(fileErr))
	return os.IsNotExist(fileErr)
}

func FinishInitialization() {
	err := ioutil.WriteFile("/initialized", []byte("intialized"), 0755)
	if err != nil {
		log.Printf("Unable to write file: %v", err)
	}
	ansibleErr := ioutil.WriteFile("initial_data/ansible_initialized", []byte("intialized"), 0755)
	if ansibleErr != nil {
		log.Printf("Unable to write file: %v", ansibleErr)
	}
	log.Println("--> Finished the initialization! <--")
}
