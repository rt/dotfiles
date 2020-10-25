package main

import (
	"fmt"
)

func main() {
	jobs := make(chan int, 100)
	results := make(chan int, 100)

	// create as many as you like but you are limited to the number of cores you have
	go worker(jobs, results)
	go worker(jobs, results)
	go worker(jobs, results)
	go worker(jobs, results)

	// create jobs
	for i := 0; i < 100; i++ {
		jobs <- i
	}
	close(jobs)

	for j := 0; j < 100; j++ {
		fmt.Println(<-results)
	}
}

// notice specifying specifically the receive/send channel to avoid just passing the full channel
func worker(jobs <-chan int, results chan<- int) {
	for n := range jobs {
		results <- fib(n)
	}
}

func fib(n int) int {
	if n <= 1 {
		return n
	}

	return fib(n-1) + fib(n-2)
}
