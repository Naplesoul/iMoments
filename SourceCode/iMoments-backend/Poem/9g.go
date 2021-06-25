package Poem

import (
	"io"
	"log"
	"os"
	"os/exec"
)

var PoemStdin *io.WriteCloser
var PoemStdout *io.Writer
var PoemCmd *exec.Cmd

func init()  {
	args := []string{"gen_ui.py", "-t", "single", "-b", "20"}
	PoemCmd = exec.Command("python", args...)
	stdin, err := PoemCmd.StdinPipe()
	PoemCmd.Stdout = os.Stdout
	if(err != nil){
		log.Println(err)
	}else{
		PoemStdin = &stdin
	}
}