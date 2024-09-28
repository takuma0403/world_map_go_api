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

	return router
}
