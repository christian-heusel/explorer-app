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

func setupStations(db *gorm.DB, filepath string) error {
	// Open the file
	csvfile, err := os.Open(filepath)
	if err != nil {
		log.Fatalln("Couldn't open the csv file", filepath, err)
	}

	// Parse the file
	r := csv.NewReader(csvfile)

	header, err := r.Read()
	log.Println(strings.Join(header, ", "))

	// Iterate through the station
	for {
		// Read each station from csv
		record, err := r.Read()
		if err == io.EOF {
			break
		}
		if err != nil {
			log.Fatal(err)
		}
		fmt.Println("Line: ", strings.Join(record, ", "))
		station := model.Station{
			StationNumber: getInt(record[0]),
			Points:        getInt(record[1]),
			StationType:   getInt(record[2]),
			Coordinates:   &record[3],
			GridSquare:    &record[4],
			Title:         &record[5],
		}

		result := db.Create(&station)

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

	setupStations(db, "initial_data/stations.csv")

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
		log.Printf("connect to http://localhost:%s/ for GraphQL playground", port)
	}
	http.Handle("/query", srv)

	log.Fatal(http.ListenAndServe(":"+port, nil))
}
