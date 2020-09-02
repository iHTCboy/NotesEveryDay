[TOC]


### MySQL 安装与配置
**安装**
> MariaDB is shipped in the CentOS repo as of CentOS 7 instead of mysql.
> if you still want to install mysql you need to add mysql rpm dependency into your yum repo.


```
sudo yum -y install mariadb-server mariadb-devel mariadb
sudo systemctl start mariadb.service
sudo systemctl enable mariadb.service
```

**配置**

登录
```
mysql -u root -p
```

创建用户
```
CREATE USER ocean_monitor IDENTIFIED BY 'ocean_monitor_pwd';
```

上面建立的用户可以在任何地方登陆。如果要限制在固定地址登陆，比如 localhost 登陆：
CREATE USER ocean_monitor@localhost IDENTIFIED BY 'ocean_monitor_pwd';

创建数据库
```
# 使用utf8编码，否则中文会有问题
CREATE DATABASE ocean_monitor character set utf8;
```

授权 ocean_monitor 用户拥有 ocean_monitor 数据库的所有权限
```
grant all on ocean_monitor.* to ocean_monitor identified by 'ocean_monitor_pwd';
```

如果是限制在 localhost 登录的，则使用
```
grant all on ocean_monitor.* to ocean_monitor@localhost identified by 'ocean_monitor_pwd';
```

### Redis

todo

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

#### Nginx 开启 debug 模式

开启debug模式
```
 vim /etc/nginx/nginx.conf
```
 
注释掉原来的 error_log /var/log/nginx/error.log;，新增下面的配置：
```
 # error_log /var/log/nginx/error.log;
 error_log /var/log/nginx/error.log debug;
```
 
实时监控错误日志
```
 clear && tail -f /var/log/nginx/error.log
```

### Linux 命令
#### 防火墙操作
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

#### linux命令后台运行
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
   

#### systemctl命令

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

#### 网络相关命令
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


#### 进程
```
# ps -ef                 # 查看所有进程
# top                    # 实时显示进程状态
```


```
ps aux
```
a = 显示所有用户的进程
u = 显示进程的用户和拥有者
x = 也显示不依附于终端的进程

- 结束进程

kill - 通过进程 ID 来结束进程
killall - 通过进程名字来结束进程

注意！结束进程 != 杀死进程

所以，`kill SIGNAL PID(s)`， `SIGNAL` 参数可以通过命令 `kill -l` 查看所有信号的列表，不指定型号将发送` SIGTERM（15）` 终止指定进程。

常用结束进程的信号是：

| Signal Name | Single Value | Effect |
|---|---|---|
| SIGHUP |	1 | 挂起 |
| SIGINT	 | 2 | 键盘的中断信号（同 Ctrl + C） |
| SIGKILL | 9 | 发出杀死信号 |
| SIGTERM | 15 | 发出终止信号 |
| SIGSTOP | 17, 19, 23 | 停止进程（同 Ctrl + Z） |

杀进程
``` 
kill -9 PID
```

pgrep 的p表明了这个命令是专门用于进程查询的grep
```
$ pgrep firefox
1827
```

"pkill"命令允许使用扩展的正则表达式和其它匹配方式。
pkill＝pgrep+kill。

```
pkill -f uwsgi
```

killall同样使用进程名替代PID，并且它会kill掉所有的同名进程。
```
killall firefox
```

匹配模式：
```
kill -9 $(ps aux | grep 'process' | grep -v 'grep' | awk '{print $2}')
```

- [怎样在 Linux 命令行下杀死一个进程](https://linux.cn/article-8541-1.html)
- [精通Linux的“kill”命令](https://linux.cn/article-2116-1.html)

####  用户
```
# w                      # 查看活动用户
# id <用户名>            # 查看指定用户信息
# last                   # 查看用户登录日志
# cut -d: -f1 /etc/passwd   # 查看系统所有用户
# cut -d: -f1 /etc/group    # 查看系统所有组
# crontab -l             # 查看当前用户的计划任务
```

#### 系统
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

#### 资源
```
# free -m                # 查看内存使用量和交换区使用量
# df -h                  # 查看各分区使用情况
# du -sh <目录名>        # 查看指定目录的大小
# grep MemTotal /proc/meminfo   # 查看内存总量
# grep MemFree /proc/meminfo    # 查看空闲内存量
# uptime                 # 查看系统运行时间、用户数、负载
# cat /proc/loadavg      # 查看系统负载
```

#### 磁盘和分区
```
# mount | column -t      # 查看挂接的分区状态
# fdisk -l               # 查看所有分区
# swapon -s              # 查看所有交换分区
# hdparm -i /dev/hda     # 查看磁盘参数(仅适用于IDE设备)
# dmesg | grep IDE       # 查看启动时IDE设备检测状况
```

#### 查看文件内容(cat/head/tail/more/less/sed/grep)

* cat（是一次性显示整个文件的内容）、head（查看前几行）、tail（查看末尾几行）

`cat filename`：打印文件所有内容
`tail -n 1000`：显示最后1000行
`tail -n +1000`：从1000行开始显示，显示1000行以后的
`head -n 1000`：显示前面1000行

结合使用示例：
```
查看/etc/profile的前10行内容：
# head -n 10 /etc/profile

查看/etc/profile的最后5行内容：
# tail  -n 5 /etc/profile

查看最后1000行的内容：:
# cat filename | tail -n 1000

从第3000行开始，显示1000行。即显示3000~3999行内容：
# cat filename | tail -n +3000 | head -n 1000

显示1000行到3000行内容：
# cat filename| head -n 3000 | tail -n +1000 
```

注：如果想显示行号，用 `-n` 参数


* more、less命令
`more` 命令和cat的功能一样都是查看文件里的内容，但有所不同的是 more 可以按页来查看文件的内容， 会以一页一页的显示方便使用者逐页阅读，还支持直接跳转行等功能。

`less` 与 more 类似，但使用 less 可以随意浏览文件，而 more 仅能向前移动，却不能向后移动，而且 less 在查看之前不会加载整个文件。

注：如果想显示行号，用 `-num` 参数


* 用sed命令
```
显示1000到300行的内容：
# sed -n '1000,3000p' filename
```
 
* 用grep命令
```
grep -C 5 foo file 显示file文件里匹配foo字串那行以及上下5行
grep -B 5 foo file 显示foo及前5行
grep -A 5 foo file 显示foo及后5行
```

以上命令，更新使用说明，请使用 `h`、`--help` 命令了解更多。

#### 文件解压缩

压缩：
```
tar -zcvf archive-name.tar.gz directory-name

#多个目录合并压缩
tar -zcvf my-compressed.tar.gz /path/to/dir1/ /path/to/dir2/

# 使用bzip2压缩：
tar -jcvf my-compressed.tar.bz2 /path/to/dir1/
```

解压：
```
#当前目录解压
 tar -zxvf prog-1-jan-2005.tar.gz
 
 #指定目录
 tar -zxvf prog-1-jan-2005.tar.gz -C /tmp
```

1. 更改档案拥有者
命令 : chown [-cfhvR] [--help] [--version] user[:group] file...
功能 : 更改文件或者文件夹的拥有者
参数格式 :
　　    user : 新的档案拥有者的使用者 IDgroup : 新的档案拥有者的使用者群体(group)
　　       -c : 若该档案拥有者确实已经更改，才显示其更改动作
　　       -f : 若该档案拥有者无法被更改也不要显示错误讯息
　　       -h : 只对于连结(link)进行变更，而非该 link 真正指向的档案
　　       -v : 显示拥有者变更的详细资料
　       　-R : 对目前目录下的所有档案与子目录进行相同的拥有者变更(即以递回的方式逐个变更)

例如：chown -R oracle:oinstall /oracle/u01/app/oracle 
      更改目录拥有者为oracle

2. 修改权限
    命令：`chmod (change mode)`
    功能：改变文件的读写和执行权限。有符号法和八进制数字法。

选项：(1)符号法：
```
  命令格式：chmod {u|g|o|a}{+|-|=}{r|w|x} filename
          u (user)   表示用户本人。
          g (group)  表示同组用户。
          o (oher)   表示其他用户。
          a (all)    表示所有用户。
          +          用于给予指定用户的许可权限。
          -          用于取消指定用户的许可权限。
          =          将所许可的权限赋给文件。
          r (read)   读许可，表示可以拷贝该文件或目录的内容。
          w (write)  写许可，表示可以修改该文件或目录的内容。
          x (execute)执行许可，表示可以执行该文件或进入目录。
```
 
          (2)八进制数字法：  
  命令格式：chmod abc file
  其中a,b,c各为一个八进制数字，分别表示User、Group、及Other的权限。
          4 (100)    表示可读。
          2 (010)    表示可写。
          1 (001)    表示可执行。
  若要rwx属性则4+2+1=7；
  若要rw-属性则4+2=6；
  若要r-x属性则4+1=5。

    例如：# chmod a+rx filename
            让所有用户可以读和执行文件filename。
          # chmod go-rx filename
            取消同组和其他用户的读和执行文件filename的权限。
          # chmod 741 filename
            让本人可读写执行、同组用户可读、其他用户可执行文件filename。
  # chmod -R 755 /home/oracle
    递归更改目录权限，本人可读写执行、同组用户可读可执行、其他用户可读可执行

3. 修改文件日期
    命令：touch
    格式：touch filenae
    功能：改变文件的日期，不对文件的内容做改动，若文件不存在则建立新文件。
    例如：% touch file

4. 链接文件
    命令：ln (link)
    格式：ln [option] filename linkname
          ln [option] directory pathname
    功能：为文件或目录建立一个链。其中，filename和directory是源文件名和
          源目录名；linkname和pathname分别表示与源文件或源目录名相链接的
          文件或目录。
    选项：-s  为文件或目录建立符号链接。不加-s表示为文件或目录建立硬链接
    注释：链接的目地在于，对一个文件或目录赋予两个以上的名字，使其可以出
          现在不同的目录中，既可以使文件或目录共享，又可以节省磁盘空间。
    例如：% ln -s filename linkname

5. 显示日期
    命令：date
    例如：% date

6. 显示日历
    命令：cal (calendar)
    格式：cal [month] year
    功能：显示某年内指定的日历
    例如：% cal 1998 

7. 显示文件头部
    命令：head
    格式：head [option] filename
    功能：显示文件的头部
    选项：缺省  显示文件的头10行。
          -i    显示文件的开始 i行。
    例如：% head filename

8. 显示文件尾部
    命令：tail
    格式：tail [option] filename
    功能：显示文件的尾部
    选项：缺省  显示文件的末10行。
          -i    显示文件最后 i行。
          +i    从文件的第i行开始显示。
    例如：% tail filename

9. 显示用户标识
    命令：id
    格式：id [option] [user]
    功能：显示用户标识及用户所属的所有组。
    选项：-a 显示用户名、用户标识及用户所属的所有组
    注释：
    例如：% id username

10. 查看当前登录的用户
    命令：users

11. 显示都谁登录到机器上
    命令：who
    格式：who
    功能：显示当前正在系统中的所有用户名字，使用终端设备号，注册时间。
    例如：% who

12. 显示当前终端上的用户名
    命令：whoami
    格式：whoami
    功能：显示出当前终端上使用的用户。
    例如：% whoami

13. 寻找文件
    命令：find
    格式：find pathname [option] expression
    功能：在所给的路经名下寻找符合表达式相匹配的文件。
    选项：-name     表示文件名
          -user     用户名，选取该用户所属的文件
          -size     按大小查找，以block为单位，一个block是512B
          -mtime n  按最后一次修改时间查找，选取n天内被修改的文件
  -perm     按权限查找
          -type     按文件类型查找
  -atime    按最后一次访问时间查找

    例如：% find ./ -name '*abc*' -print

14. 搜索文件中匹配符
    命令：grep
    格式：grep [option] pattern filenames
    功能：逐行搜索所指定的文件或标准输入，并显示匹配模式的每一行。
    选项：-i    匹配时忽略大小写
  -v 找出模式失配的行

    例如：% grep -i 'java*' ./test/run.sh

15. 统计文件字数
    命令：wc [option] filename
    功能：统计文件中的文件行数、字数和字符数。
    选项：-l 统计文件的行数
-w 统计文件的单词数
-c 统计文件的字符数
    注释：若缺省文件名则指标准输入
    例如：% wc -c ./test/run.sh

16. 显示磁盘空间
    命令：df (disk free)
    格式：df [option]
    功能：显示磁盘空间的使用情况，包括文件系统安装的目录名、块设备名、总
          字节数、已用字节数、剩余字节数占用百分比。
    选项：
-a：显示全部的档案系统和各分割区的磁盘使用情形
-i：显示i -nodes的使用量
-k：大小用k来表示 (默认值)
-t：显示某一个档案系统的所有分割区磁盘使用量
-x：显示不是某一个档案系统的所有分割区磁盘使用量
-T：显示每个分割区所属的档案系统名称
-h: 表示使用「Human-readable」的输出，也就是在档案系统大小使用 GB、MB 等易读的格式。
    注释：
    例如：% df -hi

17. 查询档案或目录的磁盘使用空间
    命令：du (disk usage)
    格式：du [option] [filename]
    功能：以指定的目录下的子目录为单位，显示每个目录内所有档案所占用的磁盘空间大小
    选项：
-a：显示全部目录和其次目录下的每个档案所占的磁盘空间
-b：大小用bytes来表示 (默认值为k bytes)
-c：最后再加上总计 (默认值)
-s：只显示各档案大小的总合
-x：只计算同属同一个档案系统的档案
-L：计算所有的档案大小
-h: 表示档案系统大小使用 GB、MB 等易读的格式。
    例如：% du -a
% du -sh /etc 只显示该目录的总合
% du /etc | sort -nr | more 统计结果用sort 指令进行排序，
sort 的参数 -nr 表示要以数字排序法进行反向排序。

18. 显示进程
    命令：ps
    格式：ps [option]
    功能：显示系统中进程的信息。包括进程ID、控制进程终端、执行时间和命令。
    选项：
  -a 显示所有进程信息
  -U uidlist 列出这个用户的所有进程
          -e 显示当前运行的每一个进程信息
          -f 显示一个完整的列表
  -x 显示包括没有终端控制的进程状况 。
    注释：
    例如：% ps -ef
  % ps -aux 然后再利用一个管道符号导向到grep去查找特定的进程,然后再对特定的进程进行操作。

19. 终止进程
    命令：kill
    格式：kill [option] pid
    功能：向指定的进程送信号或终止进程。kill指令的用途是送一个signal给某一个process，
    因为大部份送的都是用来杀掉 process 的 SIGKILL 或 SIGHUP ，因此称为 kill 
    选项：-9  强行终止进程
    注释：pid标示进程号，可由ps命令得到。
    例如：% kill -9 pid
    你也可以用 kill -l 来察看可代替 signal 号码的数目字。kill 的详细情形请参阅 man kill。

20. 查看自己的IP地址
    命令：ifconfig
    格式：ifconfig -a
  
21. 查看路由表
    命令：netstat
    格式：netstat -rn

22. 远程登录
    命令：telnet
    格式：telnet hostname

23. 文件传输
    命令：ftp (file transfer program)
    格式：ftp hostname
    功能：网络文件传输及远程操作。
    选项：ftp命令：
 
```
          cd [dirname]  进入远程机的目录
           lcd [dirname] 设置本地机的目录
           dir/ls        显示远程的目录文件
           bin           以二进制方式进行传输
   asc           以文本文件方式进行传输
           get/mget      从远程机取一个或多个文件
           put/mput      向远程机送一个或多个文件
           prompt        打开或关闭多个文件传送时的交互提示
           close         关闭与远程机的连接
           quit          退出ftp
```
   !/exit ftp登陆状态下，!表示暂时退出ftp状态回到本地目录，exit表示返回ftp状态
    注释：
    例如：% ftp hostname

24. 查看自己的电子邮件
    命令：mailx
    格式：mailx
    选项：

```
    delete  删除
    next    下一个
    quit    退出
    reply   回复  
``` 

25. 回忆命令
    命令：history
    格式：history
    功能：帮助用户回忆执行过的命令。
    选项：
    注释：
    例如：% history

26. 网上对话
    命令：talk
    格式：talk username
    功能：在网上与另一用户进行对话。
    选项：
    注释：对话时系统把终端分为上下两部分，上半部显示自己键入信息，下半部
          显示对方用户键入的信息。键入delete或Ctrl+C则结束对话。
    例如：% talk username

27. 允许或拒绝接受信息
    命令：mesg (message)
    格式：mesg [n/y]
    功能：允许或拒绝其它用户向自己所用的终端发送信息。
    选项：n 拒绝其它用户向自己所用的终端写信息
          y 允许其它用户向自己所用的终端写信息（缺省值）
    注释：
    例如：% mesg n

28. 给其他用户写信息
    命令：write
    格式：write username [ttyname]
    功能：给其他用户的终端写信息。
    选项：
    注释：若对方没有拒绝，两用户可进行交谈，键入EOF或Ctrl+C则结束对话。
    例如：write username

29. 创建、修改、删除用户和群组
    a. 创建群组：
例如： groupadd oinstall    创建群组名为oinstall的组
groupadd -g 344 dba 
创建组号是344的组，此时在/etc/passwd文件中产生一个组ID（GID）是344的项目。
    
    b. 修改群组：
groupmod: 该命令用于改变用户组帐号的属性
groupmod –g 新的GID 用户组帐号名
groupmod –n 新组名 原组名：此命令由于改变用户组的名称

    c. 删除群组：
groupdel 组名：该命令用于删除指定的组帐号

    d. 新建用户：
命令： `useradd [－d home] [－s shell] [－c comment] [－m [－k template]]
[－f inactive] [－e expire ] [－p passwd] [－r] name`

主要参数：
```
-c：加上备注文字，备注文字保存在passwd的备注栏中。　
-d：指定用户登入时的启始目录。
-D：变更预设值。
-e：指定账号的有效期限，缺省表示永久有效。
-f：指定在密码过期后多少天即关闭该账号。
-g：指定用户所属的群组。
-G：指定用户所属的附加群组。
-m：自动建立用户的登入目录。
-M：不要自动建立用户的登入目录。
-n：取消建立以用户名称为名的群组。
-r：建立系统账号。
-s：指定用户登入后所使用的shell。
-u：指定用户ID号。
```
举例： # useradd -g oinstall -G dba oracle  创建Oracle用户
   
    e. 删除用户
命令： `userdel 用户名`
删除指定的用户帐号
```
userdel –r 用户名(userdel 用户名;rm 用户名)：删除指定的用户帐号及宿主目录
```
例：#useradd -g root kkk //把kkk用户加入root组里

    f. 修改用户
命令： `usermod`
修改已有用户的信息

```
usermod –l 旧用户名 新用户名： 修改用户名
usermod –L 用户名： 用于锁定指定用户账号，使其不能登陆系统
usermod –U 用户名： 对锁定的用户帐号进行解锁
passwd –d 用户名： 使帐号无口令，即用户不需要口令就能登录系统
```

例：#usermod -l user2 user1 //把用户user2改名为user1

30. 启动、关闭防火墙

```
永久打开或则关闭
chkconfig iptables on
chkconfig iptables off
即时生效：重启后还原
service iptables start
service iptables stop

或者：
/etc/init.d/iptables start
/etc/init.d/iptables stop
```

1. 启动VSFTP服务
```
即时启动： /etc/init.d/vsftpd start
即时停止： /etc/init.d/vsftpd stop
```

开机默认VSFTP服务自动启动:
方法一:(常用\方便)
```
[root@localhost etc]# chkconfig --list|grep vsftpd ( 查看情况)
vsftpd          0:off   1:off   2:off   3:off   4:off   5:off   6:off
[root@localhost etc]# chkconfig vsftpd on  (执行ON设置)
```

方法二:
修改文件 /etc/rc.local , 把行/usr/local/sbin/vsftpd & 插入文件中，以实现开机自动启动。

32. vi技巧

a. 进入输入模式
**新增 (append)**
a ：从光标所在位置後面开始新增资料，光标後的资料随新增资料向後移动。
A：从光标所在列最後面的地方开始新增资料。

**插入 (insert)**
i：从光标所在位置前面开始插入资料，光标後的资料随新增资料向後移动。
I ：从光标所在列的第一个非空白字元前面开始插入资料。

**开始 (open)**
o ：在光标所在列下新增一列并进入输入模式。
O: 在光标所在列上方新增一列并进入输入模式。

b. 退出vi
在指令模式下键入:q,:q!,:wq或:x(注意:号），就会退出vi。其中:wq和:x是存盘退出，而:q是直接退出，如果文件已有新的变化，vi会提示你保存文件而:q命令也会失效，这时你可以用:w命令保存文件后再用:q 退出，或用:wq或:x命令退出，如果你不想保存改变后的文件，你就需要用:q!命令，这个命令将不保存文件而直接退出vi。

c. 删除与修改文件的命令：
x：删除光标所在字符。
dd ：删除光标所在的列。
r ：修改光标所在字元，r 後接著要修正的字符。
R：进入取替换状态，新增文字会覆盖原先文字，直到按 [ESC] 回到指令模式下为止。
s：删除光标所在字元，并进入输入模式。
S：删除光标所在的列，并进入输入模式。

d. 屏幕翻滚类命令
Ctrl+u: 向文件首翻半屏
Ctrl+d: 向文件尾翻半屏
Ctrl+f: 向文件尾翻一屏
Ctrl＋b: 向文件首翻一屏
nz: 将第n行滚至屏幕顶部，不指定n时将当前行滚至屏幕顶部。

e. 删除命令
ndw或ndW: 删除光标处开始及其后的n-1个字
do: 删至行首
d$: 删至行尾
ndd: 删除当前行及其后n-1行
x或X: 删除一个字符，x删除光标后的，而X删除光标前的
Ctrl+u: 删除输入方式下所输入的文本

f. 搜索及替换命令

```
/pattern: 从光标开始处向文件尾搜索pattern
?pattern: 从光标开始处向文件首搜索pattern
n: 在同一方向重复上一次搜索命令
N: 在反方向上重复上一次搜索命令
:s/p1/p2/g: 将当前行中所有p1均用p2替代
:n1,n2s/p1/p2/g: 将第n1至n2行中所有p1均用p2替代
:g/p1/s//p2/g: 将文件中所有p1均用p2替换
```

g. 复制，黏贴
(1) 选定文本块，使用v进入可视模式；移动光标键选定内容
(2) 复制选定块到缓冲区，用y；复制整行，用yy
(3) 剪切选定块到缓冲区，用d；剪切整行用dd
(4) 粘贴缓冲区中的内容，用p

h. 其他
在同一编辑窗打开第二个文件，用:sp [filename]
在多个编辑文件之间切换，用Ctrl+w


[Linux如何查看进程、杀死进程、启动进程等常用命令 - wojiaopanpan - CSDN博客](https://blog.csdn.net/wojiaopanpan/article/details/7286430)


#### 查看 .gz 文件

```
zcat logfile.gz
zcat -f logfile.gz //强制查看

zcat logfile.gz | less
zcat logfile.gz | more

zless logfile.gz
zmore logfile.gz

zgrep -i keyword_search logfile.gz


zdiff logfile1.gz logfile2.gz﻿
```

- [How To Read And Work On Gzip Compressed Log Files In Linux - It's FOSS](https://itsfoss.com/read-compressed-log-files-linux/)


### Linux 知识点
#### GMT、UTC、CST、DST 时间
* UTC
整个地球分为二十四时区，每个时区都有自己的本地时间。在国际无线电通信场合，为了统一起见，使用一个统一的时间，称为通用协调时（UTC, Universal Time Coordinated）。

* GMT
格林威治标准时间（Greenwich Mean Time）指位于英国伦敦郊区的皇家格林尼治天文台的标准时间，因为本初子午线被定义在通过那里的经线。(UTC与GMT时间基本相同)

* CST
中国标准时间（China Standard Time）
```
GMT + 8 = UTC + 8 = CST
```

* DST
夏令时（Daylight Saving Time）指在夏天太阳升起的比较早时，将时间拨快一小时，以提早日光的使用。（中国不使用）

- [centos7之关于时间和日期以及时间同步的应用 - Charles.L - 博客园](https://www.cnblogs.com/lei0213/p/8723106.html)

### Jenkins

### 阿里云（Aliyun）
#### 阿里云CentOS安装了Nginx但是外网访问不到问题处理方法

安装nginx

```
首先更新系统软件
# yum update
安装nginx
1.安装nginx源
 
# yum localinstall http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm
2.安装nginx
 
# yum install nginx
3.启动nginx
 
# service nginx start
Redirecting to /bin/systemctl start  nginx.service
 
4.访问http://你的ip/
```


```
第一步。在服务器上面看一下nginx的状态
/bin/systemctl status  nginx.service
结果状态正常。
 
第二步。curl在服务器上面 尝试你的访问
curl 127.0.0.1  #正常
curl localhost  #正常
curl 本机外网IP  #不正常（防火墙等等都关闭）  
 
第三步。查阅文档，去阿里云后台查看，原来是新购的服务器都加入和实例安全组。
（OMG）立即去配置。加入你的80端口，立即就能开启了。
```

- [安全组应用案例_安全组_安全_云服务器 ECS-阿里云](https://help.aliyun.com/document_detail/25475.html?spm=5176.2020520101.121.1.1eab540fge5K2W)