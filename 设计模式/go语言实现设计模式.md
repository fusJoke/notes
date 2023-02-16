# go的interface

在Go语言中接口（interface）是一种类型，一种抽象的类型。

interface是一组method的集合，是duck-type programming的一种体现。接口做的事情就像是定义一个协议（规则）。举个例子，你用手机打游戏、用电脑打游戏，用平板打游戏；在你妈眼里都是游戏机。关注行为不关注具体属性。



# 创建型

## 单例模式

### 饿汉式

```go
package singleton

// Singleton 饿汉式单例
type Singleton struct{}

var singleton *Singleton

func init() {
	singleton = &Singleton{}
}

// GetInstance 获取实例
func GetInstance() *Singleton {
	return singleton
}
```

### 懒汉式--双重检测

```go
package singleton

import "sync"

type LazySingleton struct {}

var (
	lazySingleton *LazySingleton
	once = sync.Once{}
)

func GetLazySingleton() *LazySingleton {
	if lazySingleton == nil {
		once.Do(func() {
			lazySingleton = &LazySingleton{}
		})
	}
	return lazySingleton
}
```

## 工厂模式

### 简单工厂

抽象产品、具体产品、核心工厂。

```go
package factory

//抽象产品定义产品共同属性和行为。比如，手机必须会打电话和接电话
type IMobile interface {
  call(string name)
  answer(string name)
}
```

```go
//实现抽象产品的具体产品。比如小米手机
type MiMobile struct {
}

//小手机实现两个接口方法
func (Mi MiMobile) call(string name) {
  fmt.println("mi mobile call %s", name)
}

func (Mi MiMobile) answer(string name) {
  fmt.println("mi mobile answer %s", name)
}

type HuaweiMobile struct {
}

//小手机实现两个接口方法
func (HW HuaweiMobile) call(string name) {
  fmt.println("HuaweiMobile mobile call %s", name)
}

func (HW HuaweiMobile) answer(string name) {
  fmt.println("HuaweiMobile mobile answer %s", name)
}

```

```go
//核心工厂类生成产品
func NewMobile(mobile string) IMobile {
  switch mobile {
    case "MI"
    	return MiMobile{}
    case "Huawei"
    	return HuaweiMobile{}
  }
  return nul
}
//switch 违反了开闭原则，但是产品比较少的时候可以接受
```

### 工厂方法

抽象产品、具体产品、抽象工厂、具体工厂

思想：一个工厂只生产一种品类中的一种产品。比如，小米手机工厂只生产手机，而且只生产小米牌。

```go
package factory

//抽象工厂
type IMobileFactory struct {
  createMobile() IMobile
}

//小米手机工厂
type MiMobileFactory struct {}

func (Mi MIMobileFactory) ccreateMobile() MiMobile {
  return MiMobile{}
}

//华为手机工厂
type HuaweiMobileFactory struct {}

func (HW HuaweiMobileFactory) ccreateMobile() MiMobile {
  return HuaweiMobile{}
}

//NewMobilerFactory 用一个简单工厂封装工厂方法
func NewMobilerFactory(t string) IRuleConfigParserFactory {
	switch t {
	case "Mi":
		return MIMobileFactory{}
	case "Huawei":
		return Huawei{}
	}
	return nil
}

```

总结：一种产品对应一个工厂；新增产品就新增一个工厂；在确定要生产某一种产品的情况，达到了解耦；另外我们又创建一个简单工厂去生产工厂；耦合从核心工厂转移到生产工厂的方法。



### 抽象工厂

思想：一个工厂可以生产多个同品牌的产品。比如小米工厂可以生产小米手机，小米电脑，小米平板；华为同样也可以，这似乎我们对这种互联网厂的观念，换种说法就是标准；

```go
//抽象工厂
type IMobileFactory interface{
  createMobile() Imobile
  createPC() IpersonalComputer
}
```

```go
type IpersonalComputer interface {
	ConnectNet()
}
//小米电脑
type MiComputer struct{}

func (MiPC MIcomputer) ConnectNet() {
  fmt.println("MIcomputer connect success")
}

//华为电脑
type HuaweiComputer struct{}

func (Mipc MIcomputer) ConnectNet() {
  fmt.println("HuaweiComputer connect success")
}

//小米工厂实现抽象工厂，要实现生成小米手机和小米电脑
type MiFactory interface{}
func (MiFac MIcomputer) createMobile() {
  fmt.println("MiFactory  createMobile success")
}
func (MiFac MIcomputer) createPC() {
  fmt.println("MiFac  createPC success")
}

//华为工厂实现抽象工厂，要实现生成华为手机和华为电脑
type HuaweiFactory interface{}
func (HWFac HuaweiFactory) createMobile() {
  fmt.println("HuaweiFactory  createMobile success")
}
func (HWFac HuaweiFactory) createPC() {
  fmt.println("HuaWeiFactory  createPC success")
}
```

总结：现实生活中，比如饿了吗和美团，如果饿了吗推出一项新的服务；很快，美团也会迅速复制；当抽象工厂的方法修改了，子类也要进行修改；如果出现第三家竞争对手叫饿了美，我们可以根据美团和饿了吗的标准进行快速实现各种服务。而不用进行各种服务的可行性探讨。



## 建造者模式

简单理解就是，一个类的构造方法的参数多过(不超过4个)，且参数之间有关联；比如做一顿饭，该不会有人煮完菜在洗菜吧，但是先切菜还是先洗菜影响却不会太大。

这次用资源池连接配置作为举例

```go
package builder

	import "fmt"

  const (
    defaultMaxTotal = 10
    defaultMaxIdle  = 9
    defaultMaxIdle  = 1
  )

  type ResourcePoolConfig struct {
    name string
    maxTotal int
    maxIdle	int
    minIdle	int
  }
  
  type ResourcePoolConfigBuiler struct {
    name string
    maxTotal int
    maxIdle	int
    minIdle	int    
  }

func (b *ResourcePoolConfigBuiler) SetName(name string) error {
  if name == "" {
    return fmt.Errorf("name can not be empty")
  }
  b.name = name
  return nil
}

func (b *ResourcePoolConfigBuiler) SetMinIdle(minIdle int) error {
  if minIdle <0 {
		return fmt.Errorf("max tatal cannot < 0, input: %d", minIdle)
  }
  b.minIdle = minIdle
  return nul
}

// SetMaxIdle SetMaxIdle
func (b *ResourcePoolConfigBuilder) SetMaxIdle(maxIdle int) error {
	if maxIdle < 0 {
		return fmt.Errorf("max tatal cannot < 0, input: %d", maxIdle)
	}
	b.maxIdle = maxIdle
	return nil
}

// SetMaxTotal SetMaxTotal
func (b *ResourcePoolConfigBuilder) SetMaxTotal(maxTotal int) error {
	if maxTotal <= 0 {
		return fmt.Errorf("max tatal cannot <= 0, input: %d", maxTotal)
	}
	b.maxTotal = maxTotal
	return nil
}

func (b *ResourcePoolConfigBuilder) Build() (*ResourcePoolConfig, error) {
	if b.name == "" {
		return nil, fmt.Errorf("name can not be empty")
	}

	// 设置默认值
	if b.minIdle == 0 {
		b.minIdle = defaultMinIdle
	}

	if b.maxIdle == 0 {
		b.maxIdle = defaultMaxIdle
	}

	if b.maxTotal == 0 {
		b.maxTotal = defaultMaxTotal
	}

	if b.maxTotal < b.maxIdle {
		return nil, fmt.Errorf("max total(%d) cannot < max idle(%d)", b.maxTotal, b.maxIdle)
	}

	if b.minIdle > b.maxIdle {
		return nil, fmt.Errorf("max idle(%d) cannot < min idle(%d)", b.maxIdle, b.minIdle)
	}

	return &ResourcePoolConfig{
		name:     b.name,
		maxTotal: b.maxTotal,
		maxIdle:  b.maxIdle,
		minIdle:  b.minIdle,
	}, nil
}
	
```

go一般是这样创建结构体

```go
package builder

import "fmt"

// ResourcePoolConfigOption option
type ResourcePoolConfigOption struct {
	maxTotal int
	maxIdle  int
	minIdle  int
}

// ResourcePoolConfigOptFunc to set option
type ResourcePoolConfigOptFunc func(option *ResourcePoolConfigOption)

// NewResourcePoolConfig NewResourcePoolConfig
func NewResourcePoolConfig(name string, opts ...ResourcePoolConfigOptFunc) (*ResourcePoolConfig, error) {
	if name == "" {
		return nil, fmt.Errorf("name can not be empty")
	}

	option := &ResourcePoolConfigOption{
		maxTotal: 10,
		maxIdle:  9,
		minIdle:  1,
	}

	for _, opt := range opts {
		opt(option)
	}

	if option.maxTotal < 0 || option.maxIdle < 0 || option.minIdle < 0 {
		return nil, fmt.Errorf("args err, option: %v", option)
	}

	if option.maxTotal < option.maxIdle || option.minIdle > option.maxIdle {
		return nil, fmt.Errorf("args err, option: %v", option)
	}

	return &ResourcePoolConfig{
		name:     name,
		maxTotal: option.maxTotal,
		maxIdle:  option.maxIdle,
		minIdle:  option.minIdle,
	}, nil
}
```





## 原型模式

对象创建成本比较大，并且同一个类之间的对象差不不大。对象的数据要经过复杂的计算和排序，或者需求经过网络，rpc和数据库

```go
package prototype

import (
	"encoding/json"
  "time"
)

type Keyword struct{
  word string
  visit int
  UpdateAt *time.Time
}

type Keywords map[string]*Keyword

func (words Keywords) Clone(updateWords []*Keywords) Keywords {
  newKeywords := Keywords{}
  for k, v := range words {
    newKeywords[k] = v
  }
  
  for _, word := range updateWords {
    newKeywords[word.word] = word.Clone()
  }
}
```





# 结构型

## 代理模式

作用：代理模式可以在不修改被代理的基础上，通过扩展代理类；进行一些功能的附加与增加。

和继承对比：假如我只要修改一个类的方法，如果使用继承的话可能把不需要的依赖和方法都继承过来。而代理模式将代理类作为自己的一个成员变量进行复用。

实现：

1. 先确定要增强的方法，即定义接口
2. 代理类的成员对象声明为被代理的对象
3. 代理类继承接口，实现接口

```go
type IUser interface{
  Login(uname, password string) error
}

type User struct{}

func (u *User) Login(username, password string) error {
  return nil
}

type UserProxy struct {
  user *User
}

func NewUserProxy(user *User) *UserProxy{
  return &UserProxy{
    user: user
  }
}

func (p *UserProxy) Login(username, password string) error {
  start := time.Now()
  
  if err := p.user.Login(username, password); err != nil P{
    return err
  }
  
  log.Printf("user login cost time:%s", time.Now().Sub(start))
  
  return nil
}
```



## 桥接模式

桥接模式解决了什么问题？

一个类有两个方向的派生，如果用继承来实现会造成类的数量几何级数增长。举例，形状类shape类有颜色和形状两个派生。颜色有蓝色、红色；形状有方和圆。会派生四种蓝方，蓝圆，红方，红圆。

所以更倾向于用color类的抽象组合进shape类。

```go
type IMsgSender interface {
  Send(msg string) error
}

type EmailMsgSender struct {
  emails []string
}

func NewEmailMsgSender(emails []string) *EmailMsgSender {
  return &EmailsMsgSender{emials: emails}
}

func (s *EmailMsgSender) send(msg string) error{
  return nil
}

type INotification interface {
  NOtify(msg string) error
}

type ErrorNotification struct {
  sender IMsgSender
}

func NewErrorNOtification(sender IMsgSender) *ErrorNOtification {
  return &ErrorNotification{sender: sender}
}

func (n *ErrorNotification) Notify (msg string) error {
  return n.sender.Send(msg)
}

```



## 装饰器模式

装饰圈模式解决了什么问题？

套娃模式，一层套一层。

装饰器和代理模式的区别

代理模式是对自己功能增强；

```go
package decorator

type IDraw interface {
	Draw() string
}

type Square struct{}

func (s Square) Draw() string {
	return "this is a square"
}

type ColorSquare struct {
	square IDraw
	color string
}

func NewColorSquare(square IDraw, color string) ColorSquare {
	return ColorSquare{color: color, square: square}
}

func (c ColorSquare) Draw() string {
	return c.square.Draw() + ", color is " + c.color
}

```



## 适配器模式

作用：兼容不同的接口

实现方式：适配器类同时实现两种接口

```go
package adapter

import "fmt"

type ICreateServer interface {
  CreateServer(cpu, mem float64) error
}

type AWSClient struct{}

func (c *AWSClient) RunInstance(cpu, mem float64) error {
  fmt.Printf("aws client run seccess, cpu: %f, mem: %f", cpu, mem)
}

type AwsClientAdapter struct{
  Client AWSClient
}

func (a *AwsClientAdapter) CreateServer(cpu, mem float64) error {
  a.Client.RunInstance(cpu, mem)
}

// AliyunClient aliyun sdk
type AliyunClient struct{}

// CreateServer 启动实例
func (c *AliyunClient) CreateServer(cpu, mem int) error {
	fmt.Printf("aws client run success, cpu： %d, mem: %d", cpu, mem)
	return nil
}

// AliyunClientAdapter 适配器
type AliyunClientAdapter struct {
	Client AliyunClient
}

// CreateServer 启动实例
func (a *AliyunClientAdapter) CreateServer(cpu, mem float64) error {
	a.Client.CreateServer(int(cpu), int(mem))
	return nil
}

```



## 门面模式

封装复制的实现，向外提供一组接口。

```go
package facede

type IUser interface {
	Login(phone int, code int) (*User, error)
  Register(phone int, code) (*User, error)
}

type IUserFacede interface {
  LoginOrRegister(phone int, code int) error
}

type User struct {
  Name string
}

type UserService struct {}

func (u UserService) Login(phone int, code int) (*User, error) {
  return &User{name:"test login"}, nil
}

func (u UserService) Register(phone int, code int) (*User, error) {
  return &User{Name:"test register"}, nil
}

// LoginOrRegister 登录或注册
func (u UserService)LoginOrRegister(phone int, code int) (*User, error) {
	user, err := u.Login(phone, code)
	if err != nil {
		return nil, err
	}

	if user != nil {
		return user, nil
	}

	return u.Register(phone, code)
}

```



## 组合模式

树形结构的对象

```go
package composite

type IOrganization interface {
	Count() int
}

type Employee struct {
  Name string
}

func (Employee) Count() int {
  return 1
}

type Department Struct {
  Name string
  SubOrganization []IOrganization
}

func (d Department) Count() int {
  c := 0 
  for _, org := range d.SubOrganization { 
    c += org.Count()
  }
  return c
}

func (d *Department) Addsub(org IOrganization) {
  d.SubOrganizations = append(d.SubOrganizations, org)
}

// NewOrganization 构建组织架构 demo
func NewOrganization() IOrganization {
	root := &Department{Name: "root"}
	for i := 0; i < 10; i++ {
		root.AddSub(&Employee{})
		root.AddSub(&Department{Name: "sub", SubOrganizations: []IOrganization{&Employee{}}})
	}
	return root
}

```



## 享元模式

```go
package flyweight

var units = map[int]*ChessPieceUnit{
	1:{
		ID: 1,
		Name: "车",
		Color: "red",
	}
	2: {
		ID: 2,
		Name: "炮",
		Color: "red",
	}
}

type ChessPieceUnit struct {
	ID    uint
	Name  string
	Color string
}

func NewChessPieceUnit(id int) *ChessPieceUnit{
  return units[id]
}

type ChessPiece struct {
  Unit *ChessPieceUnit
  X int
  Y int
}

type ChessBoard struct {
  chessPieces map[int]*ChessPiece
}

func NewChessBoard() *ChessBoard {
  board := &ChessBoard{chessPieces: map[int]*ChessPiece{}}
  for id := range units{
    board.chessPieces[id] = &ChessPiece{
			Unit: NewChessPieceUnit(id),
			X: 0,
			Y: 0,
		}
  }
  return board
}

func (c *ChessBoard) Move(id, x, y int) {
	c.chessPieces[id].X = x
	c.chessPieces[id].Y = y
}
```



# 行为型

## 观察者模式

```go
package observer

import "fmt"

// ISubject subject
type ISubject interface {
	Register(observer IObserver)
	Remove(observer IObserver)
	Notify(msg string)
}

// IObserver 观察者
type IObserver interface {
	Update(msg string)
}

// Subject Subject
type Subject struct {
	observers []IObserver
}

// Register 注册
func (sub *Subject) Register(observer IObserver) {
	sub.observers = append(sub.observers, observer)
}

// Remove 移除观察者
func (sub *Subject) Remove(observer IObserver) {
	for i, ob := range sub.observers {
		if ob == observer {
			sub.observers = append(sub.observers[:i], sub.observers[i+1:]...)
		}
	}
}

// Notify 通知
func (sub *Subject) Notify(msg string) {
	for _, o := range sub.observers {
		o.Update(msg)
	}
}

// Observer1 Observer1
type Observer1 struct{}

// Update 实现观察者接口
func (Observer1) Update(msg string) {
	fmt.Printf("Observer1: %s", msg)
}

// Observer2 Observer2
type Observer2 struct{}

// Update 实现观察者接口
func (Observer2) Update(msg string) {
	fmt.Printf("Observer2: %s", msg)
}
```



## 模板模式

将一个算法转换成多个步骤

实现：

创建抽象基类并声明一个模板方法和代表算法步骤的一系列抽象方法

为每个算法变体新建一个具体子类， 它*必须*实现所有的抽象步骤

<img src="/Users/wangfusheng/Documents/notes/设计模式/.assets/image-20220103134116238.png" alt="image-20220103134116238" style="width:40%;height:40%" /> 

```go
package TemplatePattern
 
import "fmt"
 
type Game interface {
	Initialize()
	StartPlay()
	EndPlay()
	Play()
}
 
type BaseGame struct {
}
 
func (b *BaseGame) Initialize() {
	fmt.Println("base Initialize")
}
func (b *BaseGame) StartPlay() {
	fmt.Println("base StartPlay")
}
func (b *BaseGame) EndPlay() {
	fmt.Println("base EndPlay")
}
func (b *BaseGame) Play() {
	b.Initialize()
	b.StartPlay()
	b.EndPlay()
}

package TemplatePattern
 
import "fmt"
 
type Football struct {
	baseGame BaseGame
}
 
func (f *Football) Initialize() {
	fmt.Println("Football Game Finished!")
}
func (f *Football) StartPlay() {
	f.baseGame.StartPlay()
}
func (f *Football) EndPlay() {
	fmt.Println("Football Game Started. Enjoy the game!")
}
func (f *Football) Play() {
	f.Initialize()
	f.StartPlay()
	f.EndPlay()
}
```

这里用组合模拟继承。baseGame是抽象父类，Football是具体的实现类



## 策略模式

保存文件的时候，由于政策或者其他的原因可能需要选择不同的存储方式，敏感数据我们需要加密存储，不敏感的数据我们可以直接明文保存

```go
package strategy

import (
	"fmt"
	"io/ioutil"
	"os"
)

// StorageStrategy 存储策略
type StorageStrategy interface {
	Save(name string, data []byte) error
}

var strategys = map[string]StorageStrategy{
	"file":         &fileStorage{},
	"encrypt_file": &encryptFileStorage{},
}

// NewStorageStrategy NewStorageStrategy
func NewStorageStrategy(t string) (StorageStrategy, error) {
	s, ok := strategys[t]
	if !ok {
		return nil, fmt.Errorf("not found StorageStrategy: %s", t)
	}

	return s, nil
}

// FileStorage 保存到文件
type fileStorage struct{}

// Save Save
func (s *fileStorage) Save(name string, data []byte) error {
	return ioutil.WriteFile(name, data, os.ModeAppend)
}

// encryptFileStorage 加密保存到文件
type encryptFileStorage struct{}

// Save Save
func (s *encryptFileStorage) Save(name string, data []byte) error {
	// 加密
	data, err := encrypt(data)
	if err != nil {
		return err
	}

	return ioutil.WriteFile(name, data, os.ModeAppend)
}

func encrypt(data []byte) ([]byte, error) {
	// 这里实现加密算法
	return data, nil
}
```



## 职业链

```go
// Package chain 职责链模式
// 假设我们现在有个校园论坛，由于社区规章制度、广告、法律法规的原因需要对用户的发言进行敏感词过滤
// 如果被判定为敏感词，那么这篇帖子将会被封禁
package chain

// SensitiveWordFilter 敏感词过滤器，判定是否是敏感词
type SensitiveWordFilter interface {
	Filter(content string) bool
}

// SensitiveWordFilterChain 职责链
type SensitiveWordFilterChain struct {
	filters []SensitiveWordFilter
}

// AddFilter 添加一个过滤器
func (c *SensitiveWordFilterChain) AddFilter(filter SensitiveWordFilter) {
	c.filters = append(c.filters, filter)
}

// Filter 执行过滤
func (c *SensitiveWordFilterChain) Filter(content string) bool {
	for _, filter := range c.filters {
		// 如果发现敏感直接返回结果
		if filter.Filter(content) {
			return true
		}
	}
	return false
}

// AdSensitiveWordFilter 广告
type AdSensitiveWordFilter struct{}

// Filter 实现过滤算法
func (f *AdSensitiveWordFilter) Filter(content string) bool {
	// TODO: 实现算法
	return false
}

// PoliticalWordFilter 政治敏感
type PoliticalWordFilter struct{}

// Filter 实现过滤算法
func (f *PoliticalWordFilter) Filter(content string) bool {
	// TODO: 实现算法
	return true
}
```



## 状态模式

```go
 package saccount
 
 import "fmt"

type Account struct {
   State       ActionState
   HealthValue int
}
func NewAccount(health int) *Account {
   a := &Account{
      HealthValue: health,
   }
   a.changeState()
   return a
}

func (a *Account)View()  {
   a.State.View()
}

func (a *Account)Comment()  {
   a.State.Comment()
}
func (a *Account)Post()  {
   a.State.Post()
}
type ActionState interface {
   View()
   Comment()
   Post()
}

type CloseState struct {

}

func (c *CloseState)View()  {
   fmt.Println("账号被封，无法看帖")
}

func (c *CloseState)Comment()  {
   fmt.Println("抱歉，你的健康值小于-10，不能评论")
}
func (c *CloseState)Post()  {
   fmt.Println("抱歉，你的健康值小于0，不能发帖")
}

type RestrictedState struct {

}
func (r *RestrictedState)View()  {
   fmt.Println("正常看帖")
}

func (r *RestrictedState)Comment()  {
   fmt.Println("正常评论")
}
func (r *RestrictedState)Post()  {
   fmt.Println("抱歉，你的健康值小于0，不能发帖")
}

type NormalState struct {

}
func (n *NormalState)View()  {
   fmt.Println("正常看帖")
}

func (n *NormalState)Comment()  {
   fmt.Println("正常评论")
}
func (n *NormalState)Post()  {
   fmt.Println("正常发帖")
}
func (a *Account) changeState() {
   if a.HealthValue <= -10 {
   		a.State = &CloseState{}
   } else if a.HealthValue > -10 && a.HealthValue <= 0 {
      a.State = &RestrictedState{}
   } else if a.HealthValue > 0 {
      a.State = &NormalState{}
   }
}

///给账户设定健康值
func (a *Account) SetHealth(value int) {
   a.HealthValue = value
   a.changeState()
}
```



## 迭代器模式

```go
package iterator

// Iterator 迭代器接口
type Iterator interface {
	HasNext() bool
	Next()
	// 获取当前元素，由于 Go 1.15 中还没有泛型，所以我们直接返回 interface{}
	CurrentItem() interface{}
}

// ArrayInt 数组
type ArrayInt []int

// Iterator 返回迭代器
func (a ArrayInt) Iterator() Iterator {
	return &ArrayIntIterator{
		arrayInt: a,
		index:    0,
	}
}

// ArrayIntIterator 数组迭代
type ArrayIntIterator struct {
	arrayInt ArrayInt
	index    int
}

// HasNext 是否有下一个
func (iter *ArrayIntIterator) HasNext() bool {
	return iter.index < len(iter.arrayInt)-1
}

// Next 游标加一
func (iter *ArrayIntIterator) Next() {
	iter.index++
}

// CurrentItem 获取当前元素
func (iter *ArrayIntIterator) CurrentItem() interface{} {
	return iter.arrayInt[iter.index]
}
```



## 备忘录

```go
package memento

type InputText struct{
	content string
}

func(in *InputText) Append(content string) {
	in.content += content
}

func(in *InputText) GetText() string {
	return in.content
}
func(in *InputText) Snapshot() *Snapshot{
	in.content = s.GetText()
}

type Snapshot struct {
	content string
}

func (s *Snapshot) GetText() string {
	return s.content
}
```



## 访问者模式

略



## 命令模式

```go
// Package command 命令模式
// 这是示例一，采用将函数封装为对象的方式实现，
// 示例说明:
// 假设现在有一个游戏服务，我们正在实现一个游戏后端
// 使用一个 goroutine 不断接收来自客户端请求的命令，并且将它放置到一个队列当中
// 然后我们在另外一个 goroutine 中来执行它
package command

import "fmt"

// ICommand 命令
type ICommand interface {
	Execute() error
}

// StartCommand 游戏开始运行
type StartCommand struct{}

// NewStartCommand NewStartCommand
func NewStartCommand( ) *StartCommand {
	return &StartCommand{}
}

// Execute Execute
func (c *StartCommand) Execute() error {
	fmt.Println("game start")
	return nil
}

// ArchiveCommand 游戏存档
type ArchiveCommand struct{}

// NewArchiveCommand NewArchiveCommand
func NewArchiveCommand( /*正常情况下这里会有一些参数*/ ) *ArchiveCommand {
	return &ArchiveCommand{}
}

// Execute Execute
func (c *ArchiveCommand) Execute() error {
	fmt.Println("game archive")
	return nil
}
```

## 解释器模式

```go
// Package interpreter 解释器模式
// 采用原课程的示例, 并且做了一下简化
// 假设我们现在有一个监控系统
// 现在需要实现一个告警模块，可以根据输入的告警规则来决定是否触发告警
// 告警规则支持 &&、>、< 3种运算符
// 其中 >、< 优先级比  && 更高
package interpreter

import (
	"fmt"
	"regexp"
	"strconv"
	"strings"
)

// AlertRule 告警规则
type AlertRule struct {
	expression IExpression
}

// NewAlertRule NewAlertRule
func NewAlertRule(rule string) (*AlertRule, error) {
	exp, err := NewAndExpression(rule)
	return &AlertRule{expression: exp}, err
}

// Interpret 判断告警是否触发
func (r AlertRule) Interpret(stats map[string]float64) bool {
	return r.expression.Interpret(stats)
}

// IExpression 表达式接口
type IExpression interface {
	Interpret(stats map[string]float64) bool
}

// GreaterExpression >
type GreaterExpression struct {
	key   string
	value float64
}

// Interpret Interpret
func (g GreaterExpression) Interpret(stats map[string]float64) bool {
	v, ok := stats[g.key]
	if !ok {
		return false
	}
	return v > g.value
}

// NewGreaterExpression NewGreaterExpression
func NewGreaterExpression(exp string) (*GreaterExpression, error) {
	data := regexp.MustCompile(`\s+`).Split(strings.TrimSpace(exp), -1)
	if len(data) != 3 || data[1] != ">" {
		return nil, fmt.Errorf("exp is invalid: %s", exp)
	}

	val, err := strconv.ParseFloat(data[2], 10)
	if err != nil {
		return nil, fmt.Errorf("exp is invalid: %s", exp)
	}

	return &GreaterExpression{
		key:   data[0],
		value: val,
	}, nil
}

// LessExpression <
type LessExpression struct {
	key   string
	value float64
}

// Interpret Interpret
func (g LessExpression) Interpret(stats map[string]float64) bool {
	v, ok := stats[g.key]
	if !ok {
		return false
	}
	return v < g.value
}

// NewLessExpression NewLessExpression
func NewLessExpression(exp string) (*LessExpression, error) {
	data := regexp.MustCompile(`\s+`).Split(strings.TrimSpace(exp), -1)
	if len(data) != 3 || data[1] != "<" {
		return nil, fmt.Errorf("exp is invalid: %s", exp)
	}

	val, err := strconv.ParseFloat(data[2], 10)
	if err != nil {
		return nil, fmt.Errorf("exp is invalid: %s", exp)
	}

	return &LessExpression{
		key:   data[0],
		value: val,
	}, nil
}

// AndExpression &&
type AndExpression struct {
	expressions []IExpression
}

// Interpret Interpret
func (e AndExpression) Interpret(stats map[string]float64) bool {
	for _, expression := range e.expressions {
		if !expression.Interpret(stats) {
			return false
		}
	}
	return true
}

// NewAndExpression NewAndExpression
func NewAndExpression(exp string) (*AndExpression, error) {
	exps := strings.Split(exp, "&&")
	expressions := make([]IExpression, len(exps))

	for i, e := range exps {
		var expression IExpression
		var err error

		switch {
		case strings.Contains(e, ">"):
			expression, err = NewGreaterExpression(e)
		case strings.Contains(e, "<"):
			expression, err = NewLessExpression(e)
		default:
			err = fmt.Errorf("exp is invalid: %s", exp)
		}

		if err != nil {
			return nil, err
		}

		expressions[i] = expression
	}

	return &AndExpression{expressions: expressions}, nil
}
```



## 中介模式

```go
// Package mediator 中介模式
// 采用原课程的示例，并且做了一些裁剪
// 假设我们现在有一个较为复杂的对话框，里面包括，登录组件，注册组件，以及选择框
// 当选择框选择“登录”时，展示登录相关组件
// 当选择框选择“注册”时，展示注册相关组件
package mediator

import (
	"fmt"
	"reflect"
)

// Input 假设这表示一个输入框
type Input string

// String String
func (i Input) String() string {
	return string(i)
}

// Selection 假设这表示一个选择框
type Selection string

// Selected 当前选中的对象
func (s Selection) Selected() string {
	return string(s)
}

// Button 假设这表示一个按钮
type Button struct {
	onClick func()
}

// SetOnClick 添加点击事件回调
func (b *Button) SetOnClick(f func()) {
	b.onClick = f
}

// IMediator 中介模式接口
type IMediator interface {
	HandleEvent(component interface{})
}

// Dialog 对话框组件
type Dialog struct {
	LoginButton         *Button
	RegButton           *Button
	Selection           *Selection
	UsernameInput       *Input
	PasswordInput       *Input
	RepeatPasswordInput *Input
}

// HandleEvent HandleEvent
func (d *Dialog) HandleEvent(component interface{}) {
	switch {
	case reflect.DeepEqual(component, d.Selection):
		if d.Selection.Selected() == "登录" {
			fmt.Println("select login")
			fmt.Printf("show: %s\n", d.UsernameInput)
			fmt.Printf("show: %s\n", d.PasswordInput)
		} else if d.Selection.Selected() == "注册" {
			fmt.Println("select register")
			fmt.Printf("show: %s\n", d.UsernameInput)
			fmt.Printf("show: %s\n", d.PasswordInput)
			fmt.Printf("show: %s\n", d.RepeatPasswordInput)
		}
		// others, 如果点击了登录按钮，注册按钮
	}
}
```

