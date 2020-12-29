package utils

import (
	"log"
	"strconv"
)

func getInt(input string) int {
	if result, err := strconv.Atoi(input); err == nil {
		return result
	} else {
		log.Fatalln(input, "is not an integer.")
		return 0
	}
}
