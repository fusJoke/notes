1. 初始化管道

   ```go
   //1.声明变量
   var ch chan int
   //2.使用内置函数make
   ch := make(chan int)	//无缓冲
   ch := make(chan int, 5) //有缓冲
   ```

2. 管道符的操作

   ```go
   func main(){
   	ch := make(chan int,10)
   	ChanParamRW(ch)
   	ChanParamW(ch)
   	ChanParamR(ch)
   }
   //双向管道
   func ChanParamRW(ch chan int) {
   	ch <- 1
   	d := <-ch
   	fmt.Println(d)
   }
   //单向管道只允许读
   func ChanParamR(ch <-chan int) {
   	d := <-ch
   	fmt.Println(d)
   }
   //单向管道只允许写
   func ChanParamW(ch chan<- int) {
   	ch <- 1
   }
   
   ```

3. 管道的数据读写

   ```go
   //管道无缓存区是，冲管道读取数据会阻塞。直到有协程向管道写入数据。写入数据也会阻塞
   func recv(c chan int) {
       ret := <-c
       fmt.Println("接收成功", ret)
   }
   //管道读取表达式是最多两个变量赋值
   func main(){
     ch := make(chan int,3)
     ch <- 1
     ch <- 2
     v1 := <- ch
     v2, ok := <- ch //第二个变量值表示是否成功读取到了数据
     fmt.Println(v1, v2, ok) //1,2,true
   }
   
   ```

4. len()和cap(),查询缓冲区中的数据个数和缓冲区的大小

   ```go
   func main(){
   	ch := make(chan int,5)
   	ch <-1
   	ch <-2
   	len := len(ch)
   	cap := cap(ch)
   	fmt.Println(len, cap) //2 5
   }
   ```

5. range读取值

   ```go
   func main(){
   	ch1 := make(chan int)
   	ch2 := make(chan int)
   
   	go func (){
   		for i := 0; i < 100; i++ {
   			ch1 <- i
   		}
   		close(ch1)
   	}()
   
   	go func(){
   		for {
   			i, ok := <-ch1
   			if !ok {
   				break
   			}
   			ch2 <- i * i
   		}
   	}()
   
   	for i := range ch2 {
   		fmt.Println(i)
   	}
   
   }
   ```

6. select读取

   ```go
   func main() {
   	ch := make(chan int, 1)
   	for i := 0; i < 10; i++ {
   		select {
   		case x := <-ch:
   			fmt.Println(x)
   		case ch <- i:
   		}
   	}
   }
   //打印结果0，2，4，6，8
   ```

7. Channel关闭了能不能在读取
   close()关闭一个的管道后，该管道可读但不能写，管道可读的值被取完之后就会返回0值。不能关掉一个已经关掉的管道

   