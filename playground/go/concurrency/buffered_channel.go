package main

import (
	"fmt"
)

// sending/receiving block so without buffering the channel you would get deadlock
func main() {
	c := make(chan string, 2)
	// sending here would block until a receiver is ready if there wasn't a buffer
	c <- "hello"
	c <- "world"

	msg := <-c
	fmt.Println(msg)

	msg = <-c
	fmt.Println(msg)
}
