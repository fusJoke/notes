## 基础

1. 初始化

   ```
   //字面量
    m := map[string]int{
    	"apple":2
    	"banana":3
    }
    
   //make初始化
   m := make(map[string]int, 10)
   m["apple"] = 2
   m["bannaca"] = 3
   ```

2. 增删改查

   ```
   m :=make(map[string]string, 10)
   m["apple"] = "red"     //新增
   m["apple"] = "green"   //修改
   delete(m,"apple")      //删除
   v, exist := m["apple"] //查询
   ```

​	

map的操作不是原子性的。

空map的操作

未初始化的map是nil，在向值为nil的map添加元素会触发panic



## 底层实现

1. 数据结构

使用hash表作为底层实现。一个hash表有多个bucket。一个bucket保持一个或一组键值对

hmap表示map的数据结构，bmap表示桶的数据结构

```go
type hmap struct{
	count int
	buckets unsafe.Pointer
	oldbuckers unsafe.Pointer
	...
}

type bmap struct {
	tophash [8]uint8
	data []byte
	overflow *bmap 下一个桶的地址
}

```



2. hash冲突

   冲突链解决：链表的方式把桶连接起来

