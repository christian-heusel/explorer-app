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
	"gorm.io/gorm"
)

func checkForColHeaders(indexMap map[string]int, necessary []string, optional []string) {
	// check that all the necessary keys exist in the indexMap
	for _, key := range necessary {
		if _, inserted := indexMap[key]; !inserted {
			log.Fatalln("You are missing the", key, "column in the Stations CSV!")
		}
	}

	// check for all the optional keys in the indexMap
	for _, key := range optional {
		if _, inserted := indexMap[key]; !inserted {
			log.Println("You are missing the optional", key, "column in the Stations CSV!")
		}
	}
}

func getOptionalString(input []string, indexMap map[string]int, key string) *string {
	if index, ok := indexMap[key]; ok {
		return &input[index]
	} else {
		return nil
	}
}

func CreateStationFromSplice(db *gorm.DB, input []string, indexMap map[string]int) *gorm.DB {
	necessaryHeaders := []string{"id", "points", "station_type"}
	optionalHeaders := []string{"coordinates", "grid_square", "title"}

	checkForColHeaders(indexMap, necessaryHeaders, optionalHeaders)

	return db.Create(&model.Station{
		ID:          getInt(input[indexMap["id"]]),
		Points:      getInt(input[indexMap["points"]]),
		StationType: getInt(input[indexMap["station_type"]]),
		Coordinates: getOptionalString(input, indexMap, "coordinates"),
		GridSquare:  getOptionalString(input, indexMap, "grid_square"),
		Title:       getOptionalString(input, indexMap, "title"),
	})
}

func CreateTeamFromSplice(db *gorm.DB, input []string, indexMap map[string]int) *gorm.DB {
	necessaryHeaders := []string{"authcode"}
	optionalHeaders := []string{"name", "members", "hometown"}

	checkForColHeaders(indexMap, necessaryHeaders, optionalHeaders)

	var members *int
	if result, err := strconv.Atoi(input[indexMap["members"]]); err == nil {
		members = &result
	} else {
		members = nil
	}

	return db.Create(&model.Team{
		Name:     getOptionalString(input, indexMap, "name"),
		Hometown: getOptionalString(input, indexMap, "hometown"),
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
	err := ioutil.WriteFile("/initialized", []byte("intialized"), 0644)
	if err != nil {
		log.Printf("Unable to write file: %v", err)
	}
	ansibleErr := ioutil.WriteFile("initial_data/ansible_initialized", []byte("intialized"), 0755)
	if ansibleErr != nil {
		log.Printf("Unable to write file: %v", ansibleErr)
	}
	log.Println("--> Finished the initialization! <--")
}
