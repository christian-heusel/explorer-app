package main

import (
	"fmt"
	"log"
	"os"
	"time"

	"github.com/99designs/gqlgen/graphql/handler"
	"github.com/99designs/gqlgen/graphql/playground"
	"github.com/christian-heusel/explorer-app/server/auth"
	"github.com/christian-heusel/explorer-app/server/graph"
	"github.com/christian-heusel/explorer-app/server/graph/generated"
	"github.com/christian-heusel/explorer-app/server/graph/model"
	"github.com/christian-heusel/explorer-app/server/utils"
	"github.com/gin-gonic/gin"
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

// Defining the Graphql handler
func graphqlHandler(db *gorm.DB) gin.HandlerFunc {
	// NewExecutableSchema and Config are in the generated.go file
	// Resolver is in the resolver.go file
	h := handler.NewDefaultServer(generated.NewExecutableSchema(generated.Config{Resolvers: &graph.Resolver{DB: db}}))

	return func(c *gin.Context) {
		h.ServeHTTP(c.Writer, c.Request)
	}
}

// Defining the Playground handler
func playgroundHandler() gin.HandlerFunc {
	h := playground.Handler("GraphQL", "/query")

	return func(c *gin.Context) {
		h.ServeHTTP(c.Writer, c.Request)
	}
}

func main() {
	port := os.Getenv("PORT")
	deploymentEnv := os.Getenv("DEPLOYMENT_ENV")
	if port == "" {
		port = defaultPort
	}

	db := initDB()
	// Setting up Gin
	r := gin.Default()
	if deploymentEnv == "testing" {
		r.GET("/", playgroundHandler())
		log.Printf("connect to http://127.0.0.1:%s/ for GraphQL playground", port)
	}
	authWare := auth.InitJWTMiddleware(db)
	r.POST("/v1/login", authWare.LoginHandler)
	r.GET("/v1/refresh_token", authWare.RefreshHandler)
	r.Use(authWare.MiddlewareFunc())
	r.Use(auth.TeamFromContextToContext())
	r.POST("/query", graphqlHandler(db))

	r.Run()

}
