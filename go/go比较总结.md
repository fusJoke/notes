## 一、基本类型的比较

基本类型有：

​	int，uint，int8，uint8，int16，uint16，int32，uint32，int64，uint64，byte，rune，uintptr

​	float32，float64

​	complex64，complex128

​	string

​	bool

基本类型的比较：

​	两个变量类型必须相等。go没有隐式类型转换。比较的两个变量必须类型完全一样，类型别名也不行。除非做完类型转换在进行比较。

```go
fmt.Println("2" == 2) //invalid operation: "2" == 2 (mismatched types string and int)

type A int
var a int = 1
var b A = 1
fmt.Println(a == b) //invalid operation: a == b (mismatched types int and A)
fmt.Println(a == int(b)) //true

type C = int
var c C = 1
fmt.Println(a == c) //true
```

​	

## 二、复合类型的比较

复合类型是逐个字段，逐个元素比较的。array 或者struct中每个元素必须要是可比较的，否则复合类型也不能比较。map和slice就是不可比较的

1. 数组类型的比较

   - 不同长度的数组不能比较
   - 逐个元素比较类型和值。每个对应元素的比较遵循基本类型变量的比较规则

2. struct类型变量的比较

   逐个成员比较类型和值。每个对应成员的比较遵循基本类型变量的比较规则

​		

## 三、引用类型的比较

1. 普通变量引用类型&val 和 channel的比较类型
   引用类型变量存储的是某个变量的内存地址。所以引用类型变量的比较，判断的是这两个引用类型存储的是不是同一个变量

2. channel就是引用类型，所以channel比较规则和普通变量的引用类型&val一样

3. slice这种引用类型的比较
   slice不能比较，只能与零值nil做比较

4. map类型的比较

   map不能比较，只能和nil做比较



## 四、interface{}类型变量的比较

两个接口变量知否相等时，要注意接口变量所表示的具体类型和值均相等时才会相等

```
https://cloud.tencent.com/developer/article/1813182
```



## 五、函数类型的比较

golang的func作为一等公民，也是一种类型，而且不可比较



## 六、slice和map的特殊比较

#### 1，[]byte类型的变量，使用工具包byte提供的函数就可以做比较

```go
s1 := []byte{'f', 'o', 'o'}
s2 := []byte{'f', 'o', 'o'}
fmt.Println(bytes.Equal(s1, s2)) // true
s2 = []byte{'b', 'a', 'r'}
fmt.Println(bytes.Equal(s1, s2)) // false
```

#### 2，使用反射

reflect.DeepEqual函数可以用来比较两个任意类型的变量

```
func DeepEqual(x, y interface{})
```

### 3.使用谷歌提供的cmp包





### 总结：

- 1，复合类型，只有每个元素(成员)可比较，而且类型和值都相等时，两个复合元素才相等
- 2，slice，map不可比较，但是可以用reflect或者cmp包来比较
- 3，func作为golnag的一等公民，也是一个类型，也不能比较。
- 4，引用类型的比较是看指向的是不是同一个变量
- 5，类型再定义(type A string)不可比较，是两种不同的类型
- 6，类型别名(type A = string)可比较，是同一种类型。

```
https://studygolang.com/articles/29701
```

