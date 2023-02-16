## AMQP

AMQP, 即Advanced Message Queuing Protocol， 消息队列协议，应用层协议。

#### 工作过程：

+ 消息(message)被发布者(publisher)发送给交换机(exchange)。
+ 交换机将收到的消息根据路由规则分发给绑定的队列(queue)。
+ AMQP代理会将消息投递给订阅了此队列的消费者，或者消费者按照需求自行获取



## 交换机类型

交换机是用来发送消息的AMQP实体。交换机拿到一个消息之后将它路由给一个或零个队列

| Name（交换机类型）            | Default pre-declared names（预声明的默认名称） |
| ----------------------------- | ---------------------------------------------- |
| Direct exchange（直连交换机） | (Empty string) and amq.direct                  |
| Fanout exchange（扇型交换机） | amq.fanout                                     |
| Topic exchange（主题交换机）  | amq.topic                                      |
| Headers exchange（头交换机）  | amq.match (and amq.headers in RabbitMQ)        |

还有几个比较重要的属性：

- Name
- Durability （消息代理重启后，交换机是否还存在）
- Auto-delete （当所有与之绑定的消息队列都完成了对此交换机的使用后，删掉它）
- Arguments（依赖代理本身）

交换机可以有两个状态：持久（durable）、暂存（transient）。持久化的交换机会在消息代理（broker）重启后依旧存在，而暂存的交换机则不会



#### 默认交换机

一个由消息代理预先声明好的名字为空直连交换机（direct exchange）。每个新建队列（queue）都会自动绑定到默认交换机上，绑定的路由键（routing key）名称与队列名称相同。



###  直连交换机

根据消息携带的路由键（routing key）将消息投递给对应队列的。

直连交换机经常用来循环分发任务给多个工作者（workers）



#### 扇型交换机

消息路由给绑定到它身上的所有队列，而不理会绑定的路由键。如果N个队列绑定到某个扇型交换机上，当有消息发送给此扇型交换机时，交换机会将消息的拷贝分别发送给这所有的N个队列。扇型用来交换机处理消息的广播路由（broadcast routing）。

- 大规模多用户在线（MMO）游戏可以使用它来处理排行榜更新等全局事件
- 体育新闻网站可以用它来近乎实时地将比分更新分发给移动客户端
- 分发系统使用它来广播各种状态和配置更新
- 在群聊的时候，它被用来分发消息给参与群聊的用户。（AMQP没有内置presence的概念，因此XMPP可能会是个更好的选择）

#### 主题交换机

对消息的路由键和队列到交换机的绑定模式之间的匹配，将消息路由给一个或多个队列



#### 头交换机

有时消息的路由操作会涉及到多个属性，此时使用消息头就比用路由键更容易表达。



#### 队列(queue)

它们存储着即将被应用消费掉的消息。

队列在声明（declare）后才能被使用。

队列的名字可以由应用（application）来取，也可以让消息代理（broker）直接生成一个。队列的名字可以是最多255字节的一个utf-8字符串。

持久化队列（Durable queues）会被存储在磁盘上，当消息代理（broker）重启的时候，它依旧存在。没有被持久化的队列称作暂存队列



#### 绑定

绑定（Binding）是交换机（exchange）将消息（message）路由给队列（queue）所需遵循的规则



## 消费者

消费两种方式：

+ 将消息投递给应用 ("push API")
+ 应用根据需要主动获取消息 ("pull API")

#### 消息确认

什么时候删除消息？

+ 当消息代理（broker）将消息发送给应用后立即删除
+ 待应用（application）发送一个确认回执（acknowledgement）后再删除消息

### 消息拒绝

当一个消费者接收到某条消息后，处理过程有可能成功，有可能失败。应用可以向消息代理表明，本条消息由于“拒绝消息（Rejecting Messages）”的原因处理失败了（或者未能在此时完成）。当拒绝某条消息时，应用可以告诉消息代理如何处理这条消息——销毁它或者重新放入队列



##  消息属性和有效载荷（消息主体）

- Content type（内容类型）
- Content encoding（内容编码）
- Routing key（路由键）
- Delivery mode (persistent or not)
  投递模式（持久化 或 非持久化）
- Message priority（消息优先权）
- Message publishing timestamp（消息发布的时间戳）
- Expiration period（消息有效期）
- Publisher application id（发布应用的ID



### 连接

AMQP连接通常是长连接。AMQP是一个使用TCP提供可靠投递的应用层协议。AMQP使用认证机制并且提供TLS（SSL）保护。当一个应用不再需要连接到AMQP代理的时候，需要优雅的释放掉AMQP连接，而不是直接将TCP连接关闭



#### 通道

AMQP 0-9-1提供了通道（channels）来处理多连接，可以把通道理解成共享一个TCP连接的多个轻量化连接。

多线程/进程的应用中，为每个线程/进程开启一个通道（channel）是很常见的，并且这些通道不能被线程/进程共享



### 虚拟主机

为了在一个单独的代理上实现多个隔离的环境（用户、用户组、交换机、队列 等），AMQP提供了一个虚拟主机（virtual hosts - vhosts）的概念

