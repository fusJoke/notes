#### 1.多个defer的执行顺序

写在前面的defer比写在后面的defer玩执行。是个栈结构后进先出

```go
package main

import "fmt"

func main() {
    defer func1()
    defer func2()
    defer func3()
}
	
func func1() {
    fmt.Println("A")
}

func func2() {
    fmt.Println("B")
}

func func3() {
    fmt.Println("C")
}
```



### 2. defer与return 谁先谁后

```go
package main

import "fmt"

func deferFunc() int {
    fmt.Println("defer func called")
    return 0
}

func returnFunc() int {
    fmt.Println("return func called")
    return 0
}

func returnAndDefer() int {

    defer deferFunc()

    return returnFunc()
}

func main() {
    returnAndDefer()
}

```

**return之后的语句先执行，defer后的语句后执行**



### 3.函数的返回值初始化

```
func DeferFunc(i int) (t int) {	//这边函数声明也包含了t的声明，所以一进入函数就有

    fmt.Println("t = ", t)

    return 2
}
// t=0
```



### 4.有名函数返回值遇见defer情况

```go
package main

import "fmt"

func returnButDefer() (t int) {  //t初始化0， 并且作用域为该函数全域

    defer func() {
        t = t * 10
    }()

    return 1
}

func main() {
    fmt.Println(returnButDefer())
}
// t = 10
```



### 5.defer遇见panic

那么，遇到panic时，遍历本协程的defer链表，并执行defer。在执行defer过程中:遇到recover则停止panic，返回recover处继续往下执行。如果没有遇到recover，遍历完本协程的defer链表后，向stderr抛出panic信息。

```go
package main

import (
    "fmt"
)

func main() {
    defer_call()
    fmt.Println("main 正常结束")
}

func defer_call() {
    defer func() { fmt.Println("defer: panic 之前1") }()
    defer func() { fmt.Println("defer: panic 之前2") }()

    panic("异常内容")  //触发defer出栈

    defer func() { fmt.Println("defer: panic 之后，永远执行不到") }()
}
```

```
https://segmentfault.com/a/1190000022112411
```

