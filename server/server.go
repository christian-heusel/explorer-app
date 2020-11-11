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
	"github.com/jinzhu/gorm"
	_ "github.com/jinzhu/gorm/dialects/postgres"
)

const defaultPort = "8080"

func initDB() *gorm.DB {
	databaseConnectionType := "postgres"
	databaseConnectionString := os.Getenv("DB_CONNECTION_STRING")

	if databaseConnectionString != "" {
		log.Println(databaseConnectionString)
	} else {
		log.Println("DB_CONNECTION_STRING empty!")
		os.Exit(1)
	}
	err := fmt.Errorf("initial connect failed")

	db, err := gorm.Open(databaseConnectionType, databaseConnectionString)
	for err != nil {
		db, err = gorm.Open(databaseConnectionType, databaseConnectionString)
		log.Println(err)
		time.Sleep(500 * time.Millisecond)
	}

	log.Print("connected successfully to the Database")

	// db.AutoMigrate(&model.Comment{})

	return db
}

func main() {
	port := os.Getenv("PORT")
	if port == "" {
		port = defaultPort
	}

	srv := handler.NewDefaultServer(generated.NewExecutableSchema(generated.Config{Resolvers: &graph.Resolver{DB: initDB()}}))

	http.Handle("/", playground.Handler("GraphQL playground", "/query"))
	http.Handle("/query", srv)

	log.Printf("connect to http://localhost:%s/ for GraphQL playground", port)
	log.Fatal(http.ListenAndServe(":"+port, nil))
}
