// src/routes/router.go
package routes

import (
	"world-map-go-api/src/controllers"

	"github.com/gin-gonic/gin"
)

func InitRouter() *gin.Engine {
	router := gin.Default()

	helloController := controllers.NewHelloController()

	// Hello World のルートを定義
	router.GET("/hello", helloController.HelloWorld)

	if err := router.RunTLS(":8080", "cert.pem", "key.pem"); err != nil {
		panic(err)
	}

	return router
}
