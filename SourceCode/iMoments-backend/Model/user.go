package Model

import (
	"errors"
	"iMoments-app/Database"
	"log"
	"math/rand"
)

type User struct {
	Id int64 `json:"id" form:"id" binding:"-"`
	Username string `json:"username" form:"username" binding:"-"`
	Password string `json:"password" form:"password" binding:"-"`
	Token string `json:"token" form:"token" binding:"-"`
}

func (user *User) Register() (error, int){
	_, err := Database.MysqlDB.Exec("INSERT INTO user(username, password) values(?,?)", user.Username, user.Password)

	id := 0
	if err != nil {
		log.Println("Error:", err)
	}else{
		log.Println("New User Registered:", user.Username)
		rows, _ := Database.MysqlDB.Query("select * from user where username=?" , user.Username)
		var p string
		var c int8
		var t string
		var por string
		if rows.Next() {_ = rows.Scan(&id, &user.Username, &p, &c, &t, &por)}
	}
	return err, id
}

func (user *User) Login() (error, string){
	rows, err := Database.MysqlDB.Query("select * from user where username=?" , user.Username)

	token := ""
	if err != nil {
		log.Println("Error:", err)
	}else if rows.Next(){
		var p string
		var c string
		var t string
		var por string
		_ = rows.Scan(&user.Id, &user.Username, &p, &c, &t, &por)
		if p == user.Password{
			if c != "f" {
				i := 64
				for i>0 {
					token += string(byte(rand.Int() % 26 + 65))
					i --
				}
				_, err = Database.MysqlDB.Exec("update user set token=? where username=?", token, user.Username)
				if err != nil{
					return err, ""
				}
				log.Println("User Login:", user.Username, token)
			}else{
				err = errors.New("forbidden")
			}
		} else {
			err = errors.New("unauthorized")
		}
	}else {
		err = errors.New("no such user")
	}
	return err, token
}

func (user *User) Update() error{
	if user.Token == ""{
		err := errors.New("no token")
		return err
	}
	rows, err := Database.MysqlDB.Query("select * from user where token=?" , user.Token)

	defer func(){
		if rows!=nil {
			_ = rows.Close()
		}
	}()

	if err != nil {
		log.Println("Error:", err)
	}else if !rows.Next() {
		err = errors.New("wrong token")
		return err
	}

	_, err = Database.MysqlDB.Exec("update user set password=?,username=? where token=?", user.Password, user.Username, user.Token)

	if err != nil {
		log.Println("Error:", err)
	}else {
		log.Println("Info Updated:", user.Username)
	}
	return err
}

func (user *User) GetInfo() (error,string) {
	if user.Token == "" {
		err := errors.New("no token")
		return err,""
	}

	rows, err := Database.MysqlDB.Query("select * from user where token=?", user.Token)

	result := ""

	var por string
	var s string
	if rows.Next() {
		_ = rows.Scan(&user.Id, &user.Username, &user.Password, &s, &user.Token, &por)
	}else{
		err = errors.New("wrong token")
	}
	result += `{"username":"` + user.Username + `", `
	result += `"password":"` + user.Password + `"}`

	log.Println("Get Info:", result)
	return err, result
}


func (user *User) GetPortrait() (error,string) {
	if user.Token == "" {
		err := errors.New("no token")
		return err,""
	}

	rows, err := Database.MysqlDB.Query("select * from user where token=?", user.Token)

	por := ""
	var s string
	for rows.Next() {
		_ = rows.Scan(&user.Id, &user.Username, &user.Password, &s, &user.Token, &por)
	}
	log.Println("Get Portrait:", por)
	return err, por
}

func (user *User) SavePortrait(fileName string) error {
	if user.Token == "" {
		err := errors.New("no token")
		return err
	}
	_, err := Database.MysqlDB.Exec("update user set portrait=? where token=?", fileName, user.Token)

	if err != nil {
		log.Println("Error:", err)
	}else {
		log.Println("Portrait Updated:", fileName)
	}
	return err
}