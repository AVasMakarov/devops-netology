package main

import "fmt"

func main() {
	firstnumber := 15
	secondnumber := 100
	if firstnumber < secondnumber {
		println("первое меньше второго")
	} else if firstnumber > secondnumber {
		println("второе меньше первого")
	} else {
		println("числа равны")
	}
	x := 0
	fmt.Scan(&x)
	switch x {
	case 1:
		println("100")
	case 2:
		println(200)
	}
}
