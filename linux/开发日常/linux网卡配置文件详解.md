```shell
DEVICE=eth0 # 网卡代号，必须与ifcfg-eth0相对于  
HWADDR=00:0c:29:58:5f:4b # MAC 地址， 如果只有一个网卡，可以省略  
TYPE=Ethernet # 网络接口格式 这里是以太网格式  
UUID=371ea884-5bb7-4e03-9913-127fd7e787ae # nmcli con 可得到 未知什么意思  
ONBOOT=yes # 开机启动  
NM_CONTROLLED=yes # controlled by NetworkManager  
BOOTPROTO=static # static 和 none 功能相同，表示手动配置， dhcp表示动态获取IP  
IPADDR=192.168.1.211 # IP 地址  
NETMASK=255.255.255.0 # 子网掩码  
GATEWAY=192.168.1.1 # 默认网关，如果有多个网卡配置文件 只须配置一个即可  
USERCTL=no # 是否允许非root用户控制该设备  
PEERDNS=yes # yes表示由DHCP来获取DNS， no表示 /etc/resolv.conf 来控制  
IPV6INIT=no # 是否允许IPV6  
```

#### 重启网卡

```shell
nmcli con reload
```

