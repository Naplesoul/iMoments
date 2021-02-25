package main

import (
	"gin-test/APIs"
	"github.com/gin-gonic/gin"
)


func initRouter() *gin.Engine {
	router := gin.Default()

	router.Static("/static", "./static")
	router.StaticFile("/favicon.ico", "./favicon.ico")

	router.GET("/test", APIs.TestAPI)

	router.POST("/register", APIs.RegisterAPI)

	router.POST("/login", APIs.LoginAPI)

	router.POST("/update", APIs.UpdateAPI)

	router.POST("/graphic", APIs.GraphicAnalyzeAPI)

	return router
}
