package main

import (
	"bytes"
	"encoding/json"
	"fmt"
	"log"
	"net/http"
)

type HelloReply struct {
	Message              string `json:"message"`
}

func main() {
	host := "http://localhost:8080"
	path := "/v1/api/greet"
	url := host + path

	payload := []byte("{ \"name\": \"Foo\" }")
	req, err := http.NewRequest("POST", url, bytes.NewBuffer(payload))
	if err != nil {
		log.Fatal("NewRequest: ", err)
		return
	}
	req.Header.Set("Content-Type", "application/json")


	client := &http.Client{}

	resp, err := client.Do(req)
	if err != nil {
		log.Fatal("Do: ", err)
		return
	}

	defer resp.Body.Close()
	
	var reply HelloReply
	
	if err := json.NewDecoder(resp.Body).Decode(&reply); err != nil {
		log.Printf("JSON decode error: %v\n", err)
	}

	expected := "Hello Foo!"
	actual := reply.Message

	if actual != expected {
		log.Fatalf("Want %s, got %s", expected, actual)
	}
	
	fmt.Printf("SUCCESS! %s\n", actual)
}
