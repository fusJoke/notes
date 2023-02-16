**非统一内存访问（NUMA）**是一种用于多处理器的[电脑](https://baike.baidu.com/item/电脑)内存体设计，内存访问时间取决于处理器的内存位置。 在NUMA下，处理器访问它自己的本地存储器的速度比非本地存储器（存储器的地方到另一个处理器之间共享的处理器或存储器）快一些。NUMA架构在逻辑上遵循[对称多处理](https://baike.baidu.com/item/对称多处理)（SMP）架构



对称多处理(symmetrical Multi-processing)，简称SMP，在这种架构中，一台电脑不再由单个[CPU](https://baike.baidu.com/item/CPU)组成，而同时由多个处理器运行[操作系统](https://baike.baidu.com/item/操作系统)的单一复本，并共享[内存](https://baike.baidu.com/item/内存)和一台计算机的其他资源。虽然同时使用多个CPU，但是从管理的角度来看，它们的表现就像一台单机一样。系统将任务队列对称地分布于多个CPU之上，从而极大地提高了整个系统的数据处理能力。所有的处理器都可以平等地访问[内存](https://baike.baidu.com/item/内存)、[I/O](https://baike.baidu.com/item/I%2FO)和[外部中断](https://baike.baidu.com/item/外部中断)。在对称多处理系统中，[系统资源](https://baike.baidu.com/item/系统资源)被系统中所有CPU共享，工作负载能够均匀地分配到所有可用处理器之上。