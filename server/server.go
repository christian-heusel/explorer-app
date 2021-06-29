package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
	"time"

	"github.com/99designs/gqlgen/graphql/handler"
	"github.com/99designs/gqlgen/graphql/playground"
	"github.com/christian-heusel/explorer-app/server/graph"
	"github.com/christian-heusel/explorer-app/server/graph/generated"
	"github.com/christian-heusel/explorer-app/server/graph/model"
	"github.com/christian-heusel/explorer-app/server/utils"
	"gorm.io/driver/postgres"
	_ "gorm.io/driver/postgres"
	"gorm.io/gorm"
)

const defaultPort = "8080"

func initDB() *gorm.DB {
	databaseConnectionString := os.Getenv("DB_CONNECTION_STRING")

	if databaseConnectionString != "" {
		log.Println(databaseConnectionString)
	} else {
		log.Fatal("DB_CONNECTION_STRING empty!")
	}
	err := fmt.Errorf("initial connect failed")

	db, err := gorm.Open(
		postgres.Open(databaseConnectionString),
		&gorm.Config{},
	)
	for err != nil {
		log.Println(err)
		db, err = gorm.Open(
			postgres.Open(databaseConnectionString),
			&gorm.Config{},
		)
		time.Sleep(500 * time.Millisecond)
	}

	log.Print("connected successfully to the Database")

	deploymentEnv := os.Getenv("DEPLOYMENT_ENV")
	if deploymentEnv != "production" {
		log.Print("deployment environment: " + deploymentEnv)
		// db.LogMode(true)
	}

	if utils.HasToInitialize() {
		db.AutoMigrate(&model.Answer{})
		db.AutoMigrate(&model.Device{})
		db.AutoMigrate(&model.Station{})
		db.AutoMigrate(&model.Team{})

		utils.SetupTableFromCSV(db, "initial_data/stations.csv", utils.CreateStationFromSplice)
		utils.SetupTableFromCSV(db, "initial_data/teams_with_pw.csv", utils.CreateTeamFromSplice)

		utils.FinishInitialization()
	}

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
