package APIs

import (
	"gin-test/Model"
	"github.com/axgle/mahonia"
	"github.com/gin-gonic/gin"
	"log"
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

	if err := user.Register(); err != nil{
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"status": "register successfully"})
}

func LoginAPI(c *gin.Context)  {
	var user Model.User
	if err := c.ShouldBindJSON(&user); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	if err := user.Login(); err != nil{
		c.JSON(http.StatusUnauthorized, gin.H{"status": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"status": "login successfully"})
}

func UpdateAPI(c *gin.Context)  {
	var user Model.User
	if err := c.ShouldBindJSON(&user); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	if err := user.Update(); err != nil{
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
