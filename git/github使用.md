不同人修改不同文件

```
git fetch 
git merge 分支名
```

两个人修改相同文件的不同区域

```
git fetch
git merge
```

git pull 其实就是**git pull** 其实就是 **git fetch** 和 **git merge FETCH_HEAD** 的简写

两个人修改相同文件的相同区域

```
git pull
解决冲突后在提交一个commit然后push到远程分支
```

两个同时修改文件名

```
会留下三个文件原来的，我修改以及其他人修改的，
git rm 其中两个文件；
git add 要保留的；
git commit 
```

githua高级搜索功能

```
In:readme 在readme里面搜索
stars:>3000 点赞大于3000 
```

