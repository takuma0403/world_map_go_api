// src/cmd/main.go
package main

import (
	"log"
	"world-map-go-api/src/routes"
)

func main() {
	router := routes.InitRouter()
	if err := router.Run(":8080"); err != nil {
		log.Fatalf("Server failed to start: %v", err)
	}
}
