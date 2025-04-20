package main

import (
    "fmt"
    "os/exec"
)

func main() {
	fmt.Println("Hello from Main Service")

    out, err := exec.Command("/outputter").Output()
	if err != nil {
		fmt.Println("Cannot execute outputter binary")
		return
	}
    fmt.Println("Outputter string result : ", string(out))
}
