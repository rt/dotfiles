package main

import (
	"fmt"
	"os"
	"time"
)

func main() {

	method := os.Args[1]
	fmt.Println(method)

	c1 := make(chan string)
	c2 := make(chan string)

	go func() {
		for {
			c1 <- "Every 500ms"
			time.Sleep(time.Millisecond * 500)
		}
	}()

	go func() {
		for {
			c2 <- "Every two seconds"
			time.Sleep(time.Second * 2)
		}
	}()

	if method == "fast" {
		for {
			select {
			case msg1 := <-c1:
				fmt.Println(msg1)
			case msg2 := <-c2:
				fmt.Println(msg2)
			}
		}
	} else if method == "slow" {
		for {
			fmt.Println(<-c1)
			fmt.Println(<-c2)
		}
	}

}
