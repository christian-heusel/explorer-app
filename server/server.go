package main

import (
	"encoding/csv"
	"fmt"
	"io"
	"io/ioutil"
	"log"
	"net/http"
	"os"
	"strconv"
	"strings"
	"time"

	"github.com/99designs/gqlgen/graphql/handler"
	"github.com/99designs/gqlgen/graphql/playground"
	"github.com/christian-heusel/explorer-app/server/graph"
	"github.com/christian-heusel/explorer-app/server/graph/generated"
	"github.com/christian-heusel/explorer-app/server/graph/model"
	"github.com/jinzhu/gorm"
	_ "github.com/jinzhu/gorm/dialects/postgres"
)

const defaultPort = "8080"

func getInt(input string) int {
	if result, err := strconv.Atoi(input); err == nil {
		return result
	} else {
		log.Fatalln(input, "is not an integer.")
		return 0
	}
}

func createStationFromSplice(db *gorm.DB, input []string, indexMap map[string]int) *gorm.DB {
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

func createTeamFromSplice(db *gorm.DB, input []string, indexMap map[string]int) *gorm.DB {
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

func setupTableFromCSV(db *gorm.DB, filepath string, adapter func(*gorm.DB, []string, map[string]int) *gorm.DB) error {
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

func initDB() *gorm.DB {
	databaseConnectionType := "postgres"
	databaseConnectionString := os.Getenv("DB_CONNECTION_STRING")

	if databaseConnectionString != "" {
		log.Println(databaseConnectionString)
	} else {
		log.Fatal("DB_CONNECTION_STRING empty!")
	}
	err := fmt.Errorf("initial connect failed")

	db, err := gorm.Open(databaseConnectionType, databaseConnectionString)
	for err != nil {
		log.Println(err)
		db, err = gorm.Open(databaseConnectionType, databaseConnectionString)
		time.Sleep(500 * time.Millisecond)
	}

	log.Print("connected successfully to the Database")

	deploymentEnv := os.Getenv("DEPLOYMENT_ENV")
	if deploymentEnv != "production" {
		log.Print("deployment environment: " + deploymentEnv)
		db.LogMode(true)
	}

	if hasToInitialize() {
		db.AutoMigrate(&model.Answer{})
		db.AutoMigrate(&model.Device{})
		db.AutoMigrate(&model.Station{})
		db.AutoMigrate(&model.Team{})

		setupTableFromCSV(db, "initial_data/stations.csv", createStationFromSplice)
		setupTableFromCSV(db, "initial_data/teams_with_pw.csv", createTeamFromSplice)

		finishInitialization()
	}

	return db
}

func hasToInitialize() bool {
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

func finishInitialization() {
	err := ioutil.WriteFile("/initialized", []byte("intialized"), 0755)
	if err != nil {
		log.Printf("Unable to write file: %v", err)
	}
	log.Println("--> Finished the initialization! <--")
}

func main() {
	port := os.Getenv("PORT")
	deploymentEnv := os.Getenv("DEPLOYMENT_ENV")
	if port == "" {
		port = defaultPort
	}

	srv := handler.NewDefaultServer(generated.NewExecutableSchema(generated.Config{Resolvers: &graph.Resolver{DB: initDB()}}))

	if deploymentEnv == "testing" {
		http.Handle("/", playground.Handler("GraphQL playground", "/query"))
		log.Printf("connect to http://127.0.0.1:%s/ for GraphQL playground", port)
	}
	http.Handle("/query", srv)

	log.Fatal(http.ListenAndServe(":"+port, nil))
}
