```go
1.读写nil管道均会阻塞。关闭的管道可以读取数据，向关闭的管道写数据会触发panic
2.内置函数len()和cap()分别用于查询管道的缓存数据的个数以及缓存的大小
3.只有一个缓冲区的管道，写入数据类似于加锁，读出数据类似于释放锁

总结
内置函数len()和cap作用于管道，查询缓存区个数和缓存区大小

协程读取管道时，阻塞的条件
    管道是无缓冲
    缓存区中无数据
    管道的值为nil

协程写入管道时，阻塞的条件
    管道是无缓冲
    缓存区中数据已经满了
    管道的值为nil
```



### 实现原理

chan的数据结构

```go
type hchan struct {
	qcount   uint           // total data in the queue 队列剩余元素个数
	dataqsiz uint           // size of the circular queue	//环形队列长度
	buf      unsafe.Pointer // points to an array of dataqsiz elements //指针
	elemsize uint16	//每个元素的大小
	closed   uint32	//标识关闭
	elemtype *_type // element type	//元素类型
	sendx    uint   // send index
	recvx    uint   // receive index
	recvq    waitq  // list of recv waiters
	sendq    waitq  // list of send waiters
	lock mutex
}
```



1. 环形队列

   缓存区是一个环形队列，创建chan时指定

2. 等待队列

   读管道时，缓冲区数据为空或没有缓冲区，协程会被阻塞，并且加入recvq接收等待队列。

   写管道时，缓存区数据满了，或没有缓冲区，协程会被阻塞，并且加入sendq发送等待队列

3. 管道数据类型

   管道只能传输一种类型的值。

4. 互斥锁

   一个管道同时仅允许被一个协程读写。

5. 关闭管道

   关闭管道时会把recq队列的协程全部唤醒，这些协程读取都是对应类型的零值。

   senq队列的协程全部唤醒，全部panic

   关闭值为nil的管道

   关闭已经关闭的管道

总结：

​	管道的实现是，由一个环形队列当缓存区。一个接收队列用来存读协程。一个发送队列用来存写协程。一个互斥锁防止并发写和并发读。



### 单向管道

1.只读管道、只写管道、可读写管道

```
	func ChanParamRW(ch chan int)
	func ChanParamR(ch <-chan int)
	func ChanParamW(ch chan<- int)
```

2. select

   select可以监控多个管道

   ```
   for {
   		select {
   		case e := <- chan1:
   			fmt.Printf("get elemn from chan1: %d\n",e)
   		case e:= <- chan2:
   			fmt.Printf("get elemnt from chane2: %d\n",e)
   		default:
   			fmt.Printf("No element in chan1 and chan2. \n")
   			time.Sleep( 1 * time.Second)
   		}
   }
   ```

   

3. for range

   持续从管道中读取数据

   ```
   func chanRange(chanName chan int){
   	for e := range chanName {
   		fmt.Printf("get element form chan: %d\n", e)
   	}
   }
   ```

   

​	