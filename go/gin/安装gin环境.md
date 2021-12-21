# 安装gin失败

1. 无法翻墙导致依赖的包下载失败

   ```
   unrecognized import path "google.golang.org/protobuf/encoding/prototext": https fetch: Get "https://google.golang.org/protobuf/encoding/prototext?go-get=1": dial tcp 216.239.37.1:443: i/o timeout
   ```

   google.golang.org、golang.org都需要翻墙，它们有的包，在github.com上面都会有同样的包。直接从git上拉下来放在对应的位置。

   注意：如果直接把包下载下来，因为没有进git版本管理，会报错

   ```
   package github.com/go-playground/validator/v10: directory "/Users/wangfusheng/go/src/github.com/go-playground/validator/v10" is not using a known version control system
   ```

   google.golang.org/protobuf 对应的git地址是https://github.com/protocolbuffers/protobuf-go.git

2. 安装

   1. 设置代理并下载gin

   ```shell
   go env -w GO111MODULE=on
   go env -w GOPROXY=https://goproxy.cn,direct
   go get -u github.com/gin-gonic/gin
   ```

   2.引入gin

   ```
   import "github.com/gin-gonic/gin"
   ```

   3.使用go modules 管理项目

   ```
   //新建项目
   mkdir -p /User/xx/gin-example
   //初始化go mod
   cd /User/xx/gin-example
   go mod init gin-example
   ```

   4.开始

   ```
   touch main.go
   ```

   在main.go写如下代码：

   ```go
   package main
   
   import (
   	"github.com/gin-gonic/gin"
   )
   
   func main(){
   	r := gin.Default()
   	r.GET("ping", func(c *gin.Context) {
   		c.JSON(200, gin.H{
   			"message":"pong",
   		})
   	})
   	r.Run()
   }
   ```

   整理依赖

   ```sh
   go mod tidy
   ```

   运行

   ```
   go run main.go
   ```

   <img src="/Users/wangfusheng/Library/Application Support/typora-user-images/image-20210106100343930.png" alt="image-20210106100343930" style="zoom:50%;" />

   访问**localhost:8080**

   <img src="/Users/wangfusheng/Library/Application Support/typora-user-images/image-20210106100608959.png" alt="image-20210106100608959" style="zoom:50%;" />

3. gin中文文档

   https://learnku.com/docs/gin-gonic/2019/quickstart/6151

4. 推荐入门文档
   https://www.jishuchi.com/read/gin-practice/3885

