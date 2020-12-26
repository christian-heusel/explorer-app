package main

import (
	"encoding/csv"
	"io"
	"log"
	"os"
	"strings"

	"github.com/sethvargo/go-diceware/diceware"
)

func main() {

	inputFilepath := "teams.csv"
	// Open the file
	csvfile, err := os.Open(inputFilepath)
	if err != nil {
		log.Fatalln("Couldn't open the csv file", inputFilepath, err)
	}

	// Parse the file
	r := csv.NewReader(csvfile)

	file, err := os.Create("teams_with_pw.csv")
	checkError("Cannot create file", err)
	defer file.Close()

	writer := csv.NewWriter(file)
	defer writer.Flush()

	first := true
	for {
		// Read each row from csv
		record, err := r.Read()
		if err == io.EOF {
			break
		}
		if err != nil {
			log.Fatal(err)
		}
		log.Println(record)
		if first {
			record = append(record, "authcode")
			first = false
		} else {

			authcode, err := diceware.Generate(2)
			if err != nil {
				log.Fatalln("Error while creating the password", err, authcode)
			}
			record = append(record, strings.Join(authcode, ""))
		}
		log.Println("Inserting: ", strings.Join(record, ","))
		writeErr := writer.Write(record)
		checkError("Cannot write to file", writeErr)
	}
}

func checkError(message string, err error) {
	if err != nil {
		log.Fatal(message, err)
	}
}
