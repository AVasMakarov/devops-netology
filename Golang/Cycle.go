package main

import (
	"sort"
)

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
	//fmt.Scan(&x)
	switch x {
	case 1:
		println("100")
	case 2:
		println(200)
	}

	println("First task")
	boys := []string{"Peter", "Alex", "John", "Arthur", "Richard"}
	girls := []string{"Kate", "Liza", "Kira", "Emma", "Trisha"}
	sort.Strings(boys)
	sort.Strings(girls)
	lengthBoys := len(boys)
	lengthGirls := len(girls)
	if lengthBoys == lengthGirls {
		println("Идеальные пары:")
		for count := 0; count <= lengthBoys-1; count++ {
			println(boys[count] + " и " + girls[count])
		}
	} else {
		print("Кто-то может остаться без пары!")
	}
}
