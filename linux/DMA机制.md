**DMA，全称Direct Memory Access，即**直接内存访问。DMA方式在数据传送过程中，没有保存现场、[恢复现场](https://baike.baidu.com/item/恢复现场)之类的工作。由于CPU根本不参加传送操作，因此就省去了CPU取指令、取数、送数等操作。[内存地址](https://baike.baidu.com/item/内存地址/7354236)修改、传送字 个数的计数等等，也不是由软件实现，而是用硬件线路直接实现的。所以DMA方式能满足高速[I/O设备](https://baike.baidu.com/item/I%2FO设备/9688581)的要求，也有利于CPU效率的发挥。（百度百科）

一个设备接口试图通过总线直接向另一个设备发送数据(一般是大批量的数据)，它会先向[CPU](https://baike.baidu.com/item/CPU)发送DMA请求信号。外设通过DMA的一种专门接口电路――[DMA控制器](https://baike.baidu.com/item/DMA控制器/921346)（DMAC），向CPU提出接管总线控制权的总线请求，CPU收到该信号后，在当前的[总线周期](https://baike.baidu.com/item/总线周期)结束后，会按DMA信号的优先级和提出DMA请求的先后顺序响应DMA信号。CPU对某个设备接口响应DMA请求时，会让出总线控制权。于是在DMA控制器的管理下，外设和[存储器](https://baike.baidu.com/item/存储器)直接进行数据交换，而不需CPU干预。[数据传送](https://baike.baidu.com/item/数据传送)完毕后，设备接口会向CPU发送DMA结束信号，交还总线控制权。

### 基本操作

实现DMA传送的基本操作如下：

1、外设可通过[DMA控制器](https://baike.baidu.com/item/DMA控制器/921346)向CPU发出DMA请求；

2、CPU响应DMA请求，系统转变为DMA工作方式，并把总线控制权交给DMA控制器；

3、由DMA控制器发送[存储器地址](https://baike.baidu.com/item/存储器地址)，并决定传送[数据块](https://baike.baidu.com/item/数据块)的长度；

4、执行DMA传送；

5、DMA操作结束，并把总线控制权交还CPU。

### 用途

DMA方式主要适用于一些高速的[I/O设备](https://baike.baidu.com/item/I%2FO设备)。这些设备传输字节或字的速度非常快。对于这类高速I/O设备，如果用输入输出指令或采用中断的方法来传输字节信息，会大量占用CPU的时间，同时也容易造成数据的丢失。而DMA方式能使I/O设备直接和[存储器](https://baike.baidu.com/item/存储器)进行成批数据的快速传送。

[DMA控制器](https://baike.baidu.com/item/DMA控制器/921346)或接口一般包括四个[寄存器](https://baike.baidu.com/item/寄存器)：

1：状态控制寄存器、

2：[数据寄存器](https://baike.baidu.com/item/数据寄存器)、

3：[地址寄存器](https://baike.baidu.com/item/地址寄存器)、

4：字节计数器。

这些寄存器在信息传送之前需要进行初始化设置。即在输入输出程序中用[汇编语言](https://baike.baidu.com/item/汇编语言)指令对各个寄存器写入初始化控制字。