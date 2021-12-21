

1. 断言

   ```go
   func myFunc(arg interface{}){
     value, ok != arg.(string)  //必须是interface{}类型，返回值有两个arg的值以及bool值
     if !ok {
       fmt.Println("arg not is string type")
     } else {
       fmt.Println("arg is string type, value =", value)
       fmt.Printf("value type is %T", value)
     }
   }
   ```

   

2. 静态变量和动态变量区别
   静态变量static type，变量声明的时候的变量

   ```go
   var age int
   var name string
   ```

   动态变量concrete type, 是程序运行时系统才能看见的类型

   ```go
   var i interface{}
   i = 18
   i = "go编程"
   ```

   <img src="/Users/wangfusheng/Library/Application Support/typora-user-images/image-20210622162755598.png" alt="image-20210622162755598" style="zoom:33%;" />

3. 反射机制

```go
//panic: reflect.Value.Interface: cannot return value obtained from unexported field or method
//go语言里面struct里面变量如果大写则是public,如果是小写则是private的，private的时候通过反射不能获取其值
package main

import (
	"fmt"
	"reflect"
)

type User struct {
	Id int
	Name string
	Age int
}

func (user *User)Call(){
	fmt.Println("user is called")
	fmt.Printf("%v\n", user)
}

func DofeilddAndMethod(input interface{}){
	inputType := reflect.TypeOf(input)
	inputValue := reflect.ValueOf(input)
	fmt.Println("input type is :", inputType)
	fmt.Println("input value is :", inputValue)

	for i := 0; i < inputType.NumField(); i++ {
		field := inputType.Field(i)
		value := inputValue.Field(i).Interface()
		fmt.Printf("%s: %v = %v\n", field.Name, field.Type, value )
	}

	for i :=0; i < inputType.NumMethod(); i++ {
		m := inputType.Method(i)
		fmt.Printf("%s: %v\n", m.Name, m.Type)
	}
}

func main(){
	user := User{1, "fus", 11}
	DofeilddAndMethod(user)
}

```

