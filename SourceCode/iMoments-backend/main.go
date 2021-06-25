package main

import (
	"iMoments-app/Database"
	"math/rand"
	"time"
)

func main() {
	rand.Seed(time.Now().Unix())
	defer Database.MysqlDB.Close()
	router1 := initRouter()
	//go router1.Run(":8080")
	router1.RunTLS(":8080", "./server.crt", "./server.key")
}
