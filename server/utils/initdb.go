package utils

import (
	"fmt"
	"log"
	"os"
	"time"

	"github.com/christian-heusel/explorer-app/server/graph/model"
	"github.com/jinzhu/gorm"
)

func InitDB() *gorm.DB {
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
