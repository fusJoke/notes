cgroups的全称control groups，为每种可以控制的资源定义了一个子系统。

+ cpu子系统，主要限制进程的cpu使用率。
+ cpuacct子系统，可以统计cgroups中进程cpu使用报告。
+ cpuset子系统，可以为cgroups中的进程分配cpu节点或者内存节点
+ memory子系统，限制进memory使用率
+ blkio子系统，限制进程的块设备io
+ devices子系统，可以控制进程能够访问某些设备
+ net_cls子系统，可以标记 cgroups 中进程的网络数据包，然后可以使用 tc 模块（traffic control）对数据包进行控制。
+ freezer子系统，可以挂起或者恢复 cgroups 中的进程
+ ns子系统，可以使不同 cgroups 下面的进程使用不同的 namespace

#### cgroups 层级结构（Hierarchy）

​	在每一个 cgroups 层级结构中，每一个节点（cgroup 结构体）可以设置对资源不同的限制权重。比如上图中 cgrp1 组中的进程可以使用60%的 cpu 时间片，而 cgrp2 组中的进程可以使用20%的 cpu 时间片。

​	

