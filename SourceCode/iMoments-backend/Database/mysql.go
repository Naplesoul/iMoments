package Database

import (
	"database/sql"
	_"github.com/go-sql-driver/mysql"
	"log"
)

var MysqlDB *sql.DB

func init() {
	var err error
	MysqlDB, err = sql.Open("mysql", "root:655566@tcp(127.0.0.1:3306)/test?parseTime=true&charset=utf8")
	if err != nil {
		log.Fatal(err.Error())
	}
	err = MysqlDB.Ping()
	if err != nil {
		log.Fatal(err.Error())
	}
}