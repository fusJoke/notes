1. 安装

2. 配置基础信息

   ```shell
   git config --global user.name 'fus'
   git config --global user.email 'fusjoke@163.com'
   ```

   git的作用域

   ```
   git config --local  //只针对当前的某个仓库
   git config --global	//当前用户所有仓库有效
   git config --system	//系统所有登录的用户有效
   ```

   显示config的配置，加 --list

   ```git
   git config --list --local
   git config --list --global
   git config --list --system
   ```

   

