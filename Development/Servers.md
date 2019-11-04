### nginx

#### nginx location if 的匹配规则

**cation匹配命令**

`~`     #波浪线表示执行一个正则匹配，区分大小写
`~*`    #表示执行一个正则匹配，不区分大小写
`^~`    #^~表示普通字符匹配，不是正则匹配。如果该选项匹配，只匹配该选项，不匹配别的选项，一般用来匹配目录
`=`     #进行普通字符精确匹配
`@`     #"@" 定义一个命名的 location，使用在内部定向时，例如 error_page, try_files


**location 优先级**

1. Directives with the = prefix that match the query exactly. If found, searching stops.
2. All remaining directives with conventional strings, longest match first. If this match used the ^~ prefix, searching stops.
3. Regular expressions, in order of definition in the configuration file.
4. If #3 yielded a match, that result is used. Else the match from #2 is used.

1. =前缀的指令严格匹配这个查询。如果找到，停止搜索。
2. 所有剩下的常规字符串，最长的匹配。如果这个匹配使用^前缀，搜索停止。
3. 正则表达式，在配置文件中定义的顺序。
4. 如果第3条规则产生匹配的话，结果被使用。否则，如同从第2条规则被使用。


顺序 no优先级： 
(location =) > (location 完整路径)  >  (location ^~ 路径 最长匹配的意思) > (location ~,~* 正则顺序) > (location 部分起始路径) > (/)

- [Nginx配置location、if以及return、rewrite和 try_files 指令 | | Bruce's Blog](https://www.xiebruce.top/710.html)
- [Nginx配置文件nginx.conf详解 - 雪剑无影 - 博客园](https://www.cnblogs.com/xuey/p/7631690.html)
- [nginx配置location总结及rewrite规则写法 - Sean's Notes - SegmentFault 思否](https://segmentfault.com/a/1190000002797606)
- [nginx配置location总结及rewrite规则写法 | Sean's Notes](http://seanlook.com/2015/05/17/nginx-location-rewrite/)


#### Nginx常用配置

配置文件说明

```
1、全局配置文件：/etc/nginx/nginx.conf
2、默认配置文件：/etc/nginx/conf.d/default.conf
```

新增配置目录

```
#1、新增配置文件夹
sudo mkdir /etc/nginx/server
#2、修改默认配置（加载该文件夹下的配置）
sudo vi /etc/nginx/nginx.conf
#3、在http属性下增加：
include /etc/nginx/server/*.conf;
```

1、反向代理配置

```
#1、新建/修改配置文件
sudo vi /etc/nginx/server/default.conf

#2、配置示例
server {
    listen       80;        #监听80端口
    server_name  ken.io.local; #监听的域名
    location / {            #转发或处理
        proxy_pass https://ken.io; 
    }
    error_page   500 502 503 504  /50x.html;#错误页
    location = /50x.html {
        root   /usr/share/nginx/html;
    }
}

```

2、负载均衡配置
```
upstream serverswitch {
    server 127.0.0.1:80;
    server 127.0.0.1:81;
}
server {
    listen       80;        #监听80端口
    server_name   ken.io.local; #监听的域名
    location / {            #转发或处理
        proxy_pass https://serverswitch; 
    }
    error_page   500 502 503 504  /50x.html;#错误页
    location = /50x.html {
        root   /usr/share/nginx/html;
    }
}
```


#### nginx 相关命令

设置为开机启动
```
#设置nginx开机启动
sudo systemctl enable nginx
```

启动 nginx 服务
```
#方法一
nginx
#方法二
systemctl start nginx.service
#（如果启动失败，可能是Apache等服务占用了80端口，关掉相应服务/修改端口即可）
```

查看所有启动的nginx进程
```
ps aux | grep nginx
```

停止Nginx服务
```
#方法一
nginx  -s stop
#方法二
nginx -s quit
#方法三
killall nginx
```

检查nginx配置是否正常
```
nginx -t
```

重启nginx服务
```
sudo nginx -s reload
```


开放端口
```
#开放80端口（nginx默认监听80端口）
firewall-cmd --add-port=80/tcp --permanent

#重载防火墙规则
firewall-cmd --reload
```

防火墙服务
```
#1、停止防火墙服务：
systemctl stop firewalld
#2、设置开机不启动：
systemctl disable firewalld
#1、开启防火墙服务：
systemctl start firewalld
```

### 防火墙操作
```
#1、安装
sudo apt-get install ufw
#2、启用|关闭
sudo ufw enable | disbale
#2、查看状态
sudo ufw status
#3、开放端口
sudo ufw allow 80
sudo ufw allow 20000:20010/tcp
#4、关闭端口
sudo ufw delete allow 80
sudo ufw delete allow 20000:20010/tcp
#5、指定IP开发所有端口
sudo ufw allow from 192.168.1.1 
#6、开放/关闭SMTP
sudo ufw allow | deny smtp

## 使用systemctl命令开放防火墙服务不代表防火墙功能开启。
## 所以建议统一使用ufw enable | disbale来开关防火墙
```

### linux命令后台运行
   有两种方式：
   1. command & ： 后台运行，你关掉终端会停止运行
   2. nohup command & ： 后台运行，你关掉终端也会继续运行

`nohup`：父进程是当前终端shell的进程，而一旦父进程退出，则会发送hangup信号给所有子进程，子进程收到hangup以后也会退出。如果我们要在退出shell的时候继续运行进程，则需要使用nohup忽略hangup信号，或者setsid将将父进程设为init进程(进程号为1)。nohup就是不挂起的意思(no hang up)

遇到问题
```
nohup python flush.py &
```
这样运行，生成了nohup.out文件，但是内容始终是空的，试了半天也不行。浪费了不少时间。

原因
python的输出又缓冲，导致out.log并不能够马上看到输出。
-u 参数，使得python不启用缓冲。

解决
```
nohup python -u flush.py > flush.log 2>&1 &
```

- [python nohup linux 后台运行输出 - SoWhat1412 - CSDN博客](https://blog.csdn.net/qq_31821675/article/details/78246808)
   
   ### systemctl命令


```
#开机运行服务：
systemctl enable *.service 
#取消开机运行
systemctl disable *.service 
#启动服务
systemctl start *.service 
#停止服务
systemctl stop *.service 
#重启服务
systemctl restart *.service 
#重新加载服务配置文件
systemctl reload *.service 
#查询服务运行状态
systemctl status *.service 
#显示启动失败的服务
systemctl --failed
```

### 网络相关命令
```
# ifconfig               # 查看所有网络接口的属性
# iptables -L            # 查看防火墙设置
# route -n               # 查看路由表
# netstat -lntp          # 查看所有监听端口
# netstat -antp          # 查看所有已经建立的连接
# netstat -s             # 查看网络统计信息
```


80端口使用情况
```
netstat -anp |grep 80
```

端口占用情况：
```
netstat -ntpl
```

删除 80 端口占用
```
sudo fuser -k 80/tcp
```


### 进程
```
# ps -ef                 # 查看所有进程
# top                    # 实时显示进程状态
```
###  用户
```
# w                      # 查看活动用户
# id <用户名>            # 查看指定用户信息
# last                   # 查看用户登录日志
# cut -d: -f1 /etc/passwd   # 查看系统所有用户
# cut -d: -f1 /etc/group    # 查看系统所有组
# crontab -l             # 查看当前用户的计划任务
```

### 系统
```
# uname -a               # 查看内核/操作系统/CPU信息
# head -n 1 /etc/issue   # 查看操作系统版本
# cat /proc/cpuinfo      # 查看CPU信息
# hostname               # 查看计算机名
# lspci -tv              # 列出所有PCI设备
# lsusb -tv              # 列出所有USB设备
# lsmod                  # 列出加载的内核模块
# env                    # 查看环境变量

```

### 资源
```
# free -m                # 查看内存使用量和交换区使用量
# df -h                  # 查看各分区使用情况
# du -sh <目录名>        # 查看指定目录的大小
# grep MemTotal /proc/meminfo   # 查看内存总量
# grep MemFree /proc/meminfo    # 查看空闲内存量
# uptime                 # 查看系统运行时间、用户数、负载
# cat /proc/loadavg      # 查看系统负载
```

### 磁盘和分区
```
# mount | column -t      # 查看挂接的分区状态
# fdisk -l               # 查看所有分区
# swapon -s              # 查看所有交换分区
# hdparm -i /dev/hda     # 查看磁盘参数(仅适用于IDE设备)
# dmesg | grep IDE       # 查看启动时IDE设备检测状况
```
