package main

import (
	"log"
	"net/http"
	"os"

	"github.com/99designs/gqlgen/graphql/handler"
	"github.com/99designs/gqlgen/graphql/playground"
	"github.com/christian-heusel/explorer-app/server/graph"
	"github.com/christian-heusel/explorer-app/server/graph/generated"
	"github.com/christian-heusel/explorer-app/server/utils"
	_ "github.com/jinzhu/gorm/dialects/postgres"
)

const defaultPort = "8080"

func main() {
	port := os.Getenv("PORT")
	deploymentEnv := os.Getenv("DEPLOYMENT_ENV")
	if port == "" {
		port = defaultPort
	}

	srv := handler.NewDefaultServer(generated.NewExecutableSchema(generated.Config{Resolvers: &graph.Resolver{DB: utils.InitDB()}}))

	if deploymentEnv == "testing" {
		http.Handle("/", playground.Handler("GraphQL playground", "/query"))
		log.Printf("connect to http://127.0.0.1:%s/ for GraphQL playground", port)
	}
	http.Handle("/query", srv)

	log.Fatal(http.ListenAndServe(":"+port, nil))
}
