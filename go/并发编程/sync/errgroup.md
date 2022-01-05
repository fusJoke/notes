waitGroup仍然存在一些问题，不能返回错误信息，或者只要一个 goroutine 出错我们就不再等其他 goroutine 了

```go
type Group struct {
	cancel func()

	wg sync.WaitGroup

	errOnce sync.Once
	err     error
}
```

```go
func WithContext(ctx context.Context) (*Group, context.Context) {
	ctx, cancel := context.WithCancel(ctx)
	return &Group{cancel: cancel}, ctx
}
```

```go
func (g *Group) Wait() error {
	g.wg.Wait()
	if g.cancel != nil {
		g.cancel()
	}
	return g.err
}
```

```go
func (g *Group) Go(f func() error) {
	g.wg.Add(1)

	go func() {
		defer g.wg.Done()

		if err := f(); err != nil {
			g.errOnce.Do(func() {
				g.err = err
				if g.cancel != nil {
					g.cancel()
				}
			})
		}
	}()
}
```

```
1.waitGroup

​	https://lailin.xyz/post/go-training-week3-waitgroup.html
​	https://draveness.me/golang/docs/part3-runtime/ch06-concurrency/golang-sync-primitives/

2.errgroup
	https://lailin.xyz/post/go-training-week3-errgroup.html
```

