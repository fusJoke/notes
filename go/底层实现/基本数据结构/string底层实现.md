Go 语言中的字符串只是一个只读的字节数组。

我们仍然可以通过在 `string` 和 `[]byte` 类型之间反复转换实现修改这一目的：

+ 先将这段内存拷贝到堆或者栈上；
+ 将变量的类型转换成 `[]byte` 后并修改字节数据；
+ 将修改后的字节数组转换回 `string`

string的数据结构：

```go
type stringStruct struct {
    str unsafe.Pointer
    len int
}
```

两种字面量声明方式：

```go
str1 := "this is a string"
str2 := `this is another
string`
```

拼接：

使用+符号进行拼接