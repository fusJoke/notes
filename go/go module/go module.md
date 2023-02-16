#### 开启go module

```shell
//打开Go module
go env -w GO111MODULE=on
//设置 GOPROXY
go env -w GOPROXY=https://goproxy.cn,direct
//在你项目的根目录下执行 
go mod init <OPTIONAL_MODULE_PATH> 以生成 go.mod 文件
```



#### 开启国内代理

```
go env -w GOPROXY=https://goproxy.cn,direct
```

#### GOSUMDB

​		它的值是一个 Go checksum database，用于在拉取模块版本时（无论是从源站拉取还是通过 Go module proxy 拉取）保证拉取到  的模块版本数据未经过篡改，若发现不一致，也就是可能存在篡改，将会立即中止。

GOSUMDB的默认值为：`sum.golang.org`，在国内也是无法访问的，但是 GOSUMDB 可以被 Go 模块代理所代理（详见：Proxying a Checksum Database）。

因此我们可以通过设置 GOPROXY 来解决，而先前我们所设置的模块代理 `goproxy.cn` 就能支持代理 `sum.golang.org`，所以这一个问题在设置 GOPROXY 后，你可以不需要过度关心。

#### GONOPROXY/GONOSUMDB/GOPRIVATE

这三个环境变量都是用在当前项目依赖了私有模块，例如像是你公司的私有 git 仓库，又或是 github 中的私有库，都是属于私有模块，都是要进行设置的，否则会拉取失败。
一般建议直接设置 GOPRIVATE，它的值将作为 GONOPROXY 和 GONOSUMDB 的默认值，所以建议的最佳姿势是直接使用 GOPRIVATE。

```
go env -w GOPRIVATE="git.example.com,github.com/eddycjy/mquote"
```



## 常用的命令
