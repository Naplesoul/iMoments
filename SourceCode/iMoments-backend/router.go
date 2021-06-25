package main

import (
	"github.com/gin-gonic/gin"
	"github.com/unrolled/secure"
	"iMoments-app/APIs"
)


func initRouter() *gin.Engine {
	router := gin.Default()

	router.Use(TlsHandler())

	router.GET("/test", APIs.TestAPI)

	router.POST("/register", APIs.RegisterAPI)

	router.POST("/login", APIs.LoginAPI)

	router.GET("/info", APIs.InfoAPI)
	router.POST("/info", APIs.UpdateAPI)

	router.POST("/graphic", APIs.GraphicAnalyzeAPI)
	router.POST("/words", APIs.WordsAnalyzeAPI)
	router.POST("/word", APIs.WordsAnalyzeAPI2)

	router.GET("/portrait", APIs.GetPortraitAPI)
	router.POST("/portrait", APIs.SavePortraitAPI)

	return router
}

func TlsHandler() gin.HandlerFunc {
	return func(c *gin.Context) {
		secureMiddleware := secure.New(secure.Options{
			SSLRedirect: true,
			SSLHost:     ":443",
		})
		err := secureMiddleware.Process(c.Writer, c.Request)

		// If there was an error, do not continue.
		if err != nil {
			return
		}

		c.Next()
	}
}