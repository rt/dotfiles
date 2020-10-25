package main

import (
	"fmt"
	"time"
)

// sending and receiving are blocking functions
func main() {
	c := make(chan string)
	go count("sheep", c)

	for msg := range c {
		// for {
		// 	msg, open := <-c

		// if !open {
		// 	break
		// }

		fmt.Println(msg)
	}
}

func count(thing string, c chan string) {
	for i := 1; i < 5; i++ {
		c <- thing
		time.Sleep(time.Millisecond * 500)
	}
	close(c)
}
