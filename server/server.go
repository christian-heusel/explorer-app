package main

import (
	"encoding/csv"
	"fmt"
	"io"
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
	"github.com/sethvargo/go-diceware/diceware"
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

func createStationFromSplice(db *gorm.DB, input []string) *gorm.DB {
	return db.Create(&model.Station{
		StationNumber: getInt(input[0]),
		Points:        getInt(input[1]),
		StationType:   getInt(input[2]),
		Coordinates:   &input[3],
		GridSquare:    &input[4],
		Title:         &input[5],
	})
}

func createTeamFromSplice(db *gorm.DB, input []string) *gorm.DB {
	var members *int
	if result, err := strconv.Atoi(input[1]); err == nil {
		members = &result
	} else {
		members = nil
	}

	authcode, err := diceware.Generate(2)
	if err != nil {
		log.Fatalln("Error while creating the password", err, authcode)
	}

	return db.Create(&model.Team{
		Name:     &input[0],
		Members:  members,
		Authcode: strings.Join(authcode, " "),
	})
}

func setupTableFromCSV(db *gorm.DB, filepath string, adapter func(*gorm.DB, []string) *gorm.DB) error {
	// Open the file
	csvfile, err := os.Open(filepath)
	if err != nil {
		log.Fatalln("Couldn't open the csv file", filepath, err)
	}

	// Parse the file
	r := csv.NewReader(csvfile)

	header, err := r.Read()
	log.Println("Header:" + strings.Join(header, ", "))

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
		log.Println("Line: ", strings.Join(record, ", "))

		result := adapter(db, record)

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

	db.AutoMigrate(&model.Answer{})
	db.AutoMigrate(&model.Device{})
	db.AutoMigrate(&model.Station{})
	db.AutoMigrate(&model.Team{})

	setupTableFromCSV(db, "initial_data/stations.csv", createStationFromSplice)
	setupTableFromCSV(db, "initial_data/teams.csv", createTeamFromSplice)

	return db
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
