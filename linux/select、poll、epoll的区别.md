## 概述

select、poll、epoll是一种**io多路复用**的机制，让一个进程可以监听多个**文件描述符**。



## 一个进程可以监听多少个文件描述符

#### 1、端口号

调用系统调用创建一个socket并返回一个文件描述符(一个整型数字)

建立一个 TCP 连接，需要将通信两端的套接字（socket）进行绑定

#### 2、文件描述符的数量

​	**系统级**：当前系统可打开的最大数量，通过 cat /proc/sys/fs/file-max 查看

​	**用户级**：指定用户可打开的最大数量，通过 cat /etc/security/limits.conf 查看

​	**进程级**：单个进程可打开的最大数量，通过 cat /proc/sys/fs/nr_open 查看

#### 3、内存的消耗

​	每个TCP连接本身，以及这个连接所用到的缓冲区，都是需要占用一定内存的

## 缓存 IO

`缓存 IO 又被称作标准 IO，大多数文件系统的默认 IO 操作都是缓存 IO`。在 Linux 的缓存 IO 机制中，操作系统会将 IO 的数据缓存在文件系统的页缓存（ page cache ）中，也就是说，`数据会先被拷贝到操作系统内核的缓冲区中，然后才会从操作系统内核的缓冲区拷贝到应用程序的地址空间`。





## IO多路复用

socket的文件read的过程：

<img src="/Users/wangfusheng/Documents/notes/linux/.assets/640" alt="图片" style="zoom:67%;" /> 

为每个客户端创建一个线程，服务器端的线程资源很容易被耗光。

我们可以每 accept 一个客户端连接后，将这个文件描述符（connfd）放到一个数组里

然后弄一个新的线程去不断遍历这个数组，调用每一个元素的非阻塞 read 方法。

但是会浪费read系统调用



#### select

select 是操作系统提供的系统调用函数，通过它，我们可以把一个文件描述符的数组发给操作系统， 让操作系统去遍历

<img src="/Users/wangfusheng/Documents/notes/linux/640.png" alt="图片" style="zoom:67%;" /> 

用户依然需要遍历刚刚提交给操作系统的 list，但是不会毫无意义调用系统调用



总结:

+ select 调用需要传入 fd 数组，需要拷贝一份到内核。减少了系统调用
+ select 在内核层仍然是通过遍历的方式检查文件描述符的就绪状态，是个同步过程，只不过无系统调用切换上下文的开销
+ select 仅仅返回可读文件描述符的个数，具体哪个可读还是要用户自己遍历



## poll

它和 select 的主要区别就是，去掉了 select 只能监听 1024 个文件描述符的限制。

是基于链表实现的。



## epoll

​	 内核中保存一份文件描述符集合，无需用户每次都重新传入，只需告诉内核修改的部分即可。

​	 内核不再通过轮询的方式找到就绪的文件描述符，而是通过异步 IO 事件唤醒。

​	 内核仅会将有 IO 事件的文件描述符返回给用户，用户也无需遍历整个文件描述符集合。

​	

```go
//第一步，创建一个 epoll 句柄
int epoll_create(int size);

//第二步，向内核添加、修改或删除要监控的文件描述符。
int epoll_ctl(
  int epfd, int op, int fd, struct epoll_event *event);
//第三步，类似发起了 select() 调用
int epoll_wait(
  int epfd, struct epoll_event *events, int max events, int timeout);
```

<img src="/Users/wangfusheng/Documents/notes/linux/.assets/640-20220120113600940.gif" alt="图片" style="zoom:67%;" /> 

一切的开始，都起源于这个 read 函数是操作系统提供的，而且是阻塞的，我们叫它 **阻塞 IO**。

为了破这个局，程序员在用户态通过多线程来防止主线程卡死。

后来操作系统发现这个需求比较大，于是在操作系统层面提供了非阻塞的 read 函数，这样程序员就可以在一个线程内完成多个文件描述符的读取，这就是 **非阻塞 IO**。

但多个文件描述符的读取就需要遍历，当高并发场景越来越多时，用户态遍历的文件描述符也越来越多，相当于在 while 循环里进行了越来越多的系统调用。

后来操作系统又发现这个场景需求量较大，于是又在操作系统层面提供了这样的遍历文件描述符的机制，这就是 **IO 多路复用**。

多路复用有三个函数，最开始是 select，然后又发明了 poll 解决了 select 文件描述符的限制，然后又发明了 epoll 解决 select 的三个不足。

```
https://mp.weixin.qq.com/s?__biz=MzAxODI5ODMwOA==&mid=2666555795&idx=1&sn=c412269d17238660f0da71e5370d11a6&chksm=80dcad38b7ab242e5a2cbc95ff2c8a92fc1ed568baeb5de3985a9ce087b8202f56b79b14bb11&scene=21#wechat_redirect

<<<<<<< HEAD
=======
https://mp.weixin.qq.com/s?__biz=MzAxODI5ODMwOA==&mid=2666555795&idx=1&sn=c412269d17238660f0da71e5370d11a6&chksm=80dcad38b7ab242e5a2cbc95ff2c8a92fc1ed568baeb5de3985a9ce087b8202f56b79b14bb11&scene=21#wechat_redirect

>>>>>>> d6d9666
https://mp.weixin.qq.com/s/LDvXp6TafXF6nvaF2W3D-g

https://mp.weixin.qq.com/s/HyrcOnlt2Fk5GVkAXlNcig
```

