package main

import "gin-test/Database"

func main() {
	defer Database.MysqlDB.Close()
	router := initRouter()
	_ = router.Run(":58888")
}
