// src/controllers/hello_controller.go
package controllers

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

type HelloController struct{}

func NewHelloController() *HelloController {
	return &HelloController{}
}

func (hc *HelloController) HelloWorld(ctx *gin.Context) {
	ctx.JSON(http.StatusOK, gin.H{"message": "Hello World"})
}
