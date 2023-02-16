## 基础知识

1. 声明

   ```go
   var s []int
   
   s1 := []int{}
   s2 := []int{1,2,3}
   
   s1 := make([]int,10,12)
   
   ```

2. 截取

   ```
   //从数组中截取
   array := [5]int{1,2,3,4,5}
   s1 := array[0:2]
   
   //从切片中截取
   s2 := s1[0:1]
   ```

3. 切片操作

   ```go
   //追加
   s = append(s, 1)
   s = append(s , 2, 3, 4)
   s = append(s, []int{5,6}...)
   ```

4. 读取

   ```
   	data := [...]int{1,2,3,4,5,6,7,8}
   
   	s := data[0:4]
   	s[0] = 100
   	s[1] = 200
   	fmt.Println(data)
   	fmt.Println(s)
   ```

   

## 实现原理

```
type slice struct {
	array unsafe.Pointer
	len int
	cap int
}
```

使用make()创建slice时，长度和容量，创建时底层会分配一个数组

len就是slice的长度

cap是slice容量



总结：

```
每个切片都指向一个底层数组
slice只是一个数据结构，传递切片的时候，只是拷贝slice这个数据结构
append可能会触发扩容

不要多个切片操作同一个数组，以防止读写冲突
```

