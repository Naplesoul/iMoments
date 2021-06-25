package APIs

import (
	"github.com/axgle/mahonia"
	"github.com/gin-gonic/gin"
	"iMoments-app/Model"
	"log"
	"math/rand"
	"net/http"
	"os/exec"
)

func ConvertToByte(src string, srcCode string, targetCode string) []byte {
	srcCoder := mahonia.NewDecoder(srcCode)
	srcResult := srcCoder.ConvertString(src)
	tagCoder := mahonia.NewDecoder(targetCode)
	_, cdata, _ := tagCoder.Translate([]byte(srcResult), true)
	return cdata
}

func TestAPI(c *gin.Context) {
	c.JSON(http.StatusBadRequest, gin.H{"test": "OK"})
}

func RegisterAPI(c *gin.Context)  {
	var user Model.User
	if err := c.ShouldBindJSON(&user); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	err, id := user.Register()
	if err != nil{
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"status": "register successfully", "id":id})
}

func LoginAPI(c *gin.Context)  {
	var user Model.User
	if err := c.ShouldBindJSON(&user); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	err, token := user.Login()
	if err != nil{
		c.JSON(http.StatusUnauthorized, gin.H{"status": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"status": "login successfully", "token": token})
}

func UpdateAPI(c *gin.Context)  {
	var user Model.User

	if err := c.ShouldBindJSON(&user); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	user.Token = c.Query("token")
	err := user.Update()

	if err != nil{
		c.JSON(http.StatusUnauthorized, gin.H{"status": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"status": "update successfully"})
}

func GraphicAnalyzeAPI(c *gin.Context)  {

	file, _ := c.FormFile("file")
	log.Println(file.Filename)

	// save file
	err := c.SaveUploadedFile(file, "./uploads/"+file.Filename)
	if err != nil{
		log.Println(err)
		c.String(http.StatusBadRequest, "%s", err.Error())
		return
	}

	//...Ask for result at www.baidu.com
	//...

	args := []string{"demo.py", "./uploads/"+file.Filename}
	out, err := exec.Command("python", args...).Output()
	result := string(out)

	if err != nil {
		log.Println(err)
		result = err.Error()
		return
	}
	c.String(http.StatusOK, "%s",ConvertToByte(result, "gbk", "utf-8"))
	return
}

func WordsAnalyzeAPI(c *gin.Context)  {
	file, _ := c.FormFile("file")
	log.Println(file.Filename)

	// save file
	err := c.SaveUploadedFile(file, "./uploads/"+file.Filename)
	if err != nil{
		log.Println(err)
		c.String(http.StatusBadRequest, "%s", err.Error())
		return
	}

	args := []string{"demo2.py", "./uploads/"+file.Filename}
	out, err := exec.Command("python", args...).Output()
	result := string(out)

	if err != nil {
		log.Println(err)
		result = err.Error()
		return
	}
	c.String(http.StatusOK, "%s",ConvertToByte(result, "gbk", "utf-8"))
	return
}

func WordsAnalyzeAPI2(c *gin.Context)  {
	text := c.PostForm("text")
	text = string(ConvertToByte(text, "gbk", "utf-8"))

	args := []string{"demo3.py", text}
	out, err := exec.Command("python", args...).Output()
	result := string(out)
	log.Println(result)

	if err != nil {
		log.Println(err)
		result = err.Error()
		return
	}
	c.String(http.StatusOK, "%s", ConvertToByte(result, "gbk", "utf-8"))
	return
}


func InfoAPI(c *gin.Context)  {
	var user Model.User

	user.Token = c.Query("token")

	err, info := user.GetInfo()
	if err != nil{
		c.JSON(http.StatusUnauthorized, gin.H{"status": err.Error()})
		return
	}
	c.String(http.StatusOK, "%s", info)
}

func GetPortraitAPI(c *gin.Context) {
	var user Model.User

	user.Token = c.Query("token")

	err, fileName := user.GetPortrait()
	if err != nil{
		c.JSON(http.StatusUnauthorized, gin.H{"status": err.Error()})
		return
	}

	c.File("./uploads/" + fileName)
}

func SavePortraitAPI(c *gin.Context) {
	var user Model.User
	user.Token = c.Query("token")

	file, _ := c.FormFile("file")
	// save file

	saveName := file.Filename
	i := 32
	for i>0 {
		saveName = string(byte(rand.Int() % 26 + 65)) + saveName
		i --
	}

	err := c.SaveUploadedFile(file, "./uploads/"+ saveName)
	if err != nil {
		log.Println(err)
		c.JSON(http.StatusUnauthorized, gin.H{"status": err.Error()})
		return
	}
	err = user.SavePortrait(saveName)
	if err != nil {
		log.Println(err)
		c.JSON(http.StatusUnauthorized, gin.H{"status": err.Error()})
		return
	}
	c.JSON(http.StatusOK, gin.H{"status": "upload successfully"})
}

