package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
)

func handler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintln(w, "Hello from k3d app!")
}

func main() {
	http.HandleFunc("/", handler)

	port := os.Getenv("SERVER_PORT")
	if port == "" {
		log.Fatalln("Cannot start the app with no port!")
	}

	err := http.ListenAndServe(":"+port, nil)
	if err != nil {
		log.Fatalf("Failed to start server: %v", err)
	}
}
