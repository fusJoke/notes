```go
type Once struct {
	done uint32
	m    Mutex
}
```

```go
func (o *Once) Do(f func()) {
	if atomic.LoadUint32(&o.done) == 0 {
		// Outlined slow-path to allow inlining of the fast-path.
		o.doSlow(f)
	}
}
```

```go
func (o *Once) doSlow(f func()) {
  //互斥锁保证一致
	o.m.Lock()
	defer o.m.Unlock()
	if o.done == 0 {
		defer atomic.StoreUint32(&o.done, 1)
		f()
	}
}
```

