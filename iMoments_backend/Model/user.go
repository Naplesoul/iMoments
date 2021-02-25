package Model

import (
	"errors"
	"gin-test/Database"
	"log"
)

type User struct {
	Id int64 `json:"id" form:"id" binding:"-"`
	Username string `json:"username" form:"username" binding:"required"`
	Password string `json:"password" form:"password" binding:"required"`
}

func (user *User) Register() error{
	_, err := Database.MysqlDB.Exec("INSERT INTO user(username, password) values(?,?)", user.Username, user.Password)
	if err != nil {
		log.Println("Error:", err)
	}else{
		log.Println("New User Registered:", user.Username)
	}
	return err
}

func (user *User) Login() error{
	rows, err := Database.MysqlDB.Query("select * from user where username=?" , user.Username)

	if err != nil {
		log.Println("Error:", err)
	}else if rows.Next(){
		var p string
		var c int8
		_ = rows.Scan(&user.Id, &user.Username, &p, &c)
		if p == user.Password {
			if c != 'f' {
				log.Println("User Login:", user.Username)
			}else{
				err = errors.New("forbidden")
			}
		} else {
			err = errors.New("unauthorized")
		}
	}else {
		err = errors.New("no such user")
	}
	return err
}

func (user *User) Update() error{
	rows, err := Database.MysqlDB.Query("select * from user where username=?" , user.Username)

	defer func(){
		if rows!=nil {
			_ = rows.Close()
		}
	}()

	if err != nil {
		log.Println("Error:", err)
	}else if !rows.Next() {
		err = errors.New("no such user")
		return err
	}

	_, err = Database.MysqlDB.Exec("update user set password=? where username=?", user.Password, user.Username)

	if err != nil {
		log.Println("Error:", err)
	}else {
		log.Println("Password Updated:", user.Username)
	}
	return err
}

