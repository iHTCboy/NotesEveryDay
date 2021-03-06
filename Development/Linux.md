[TOC]

#### crontab时间


```
# .---------------- minute (0 - 59) 
# |  .------------- hour (0 - 23)
# |  |  .---------- day of month (1 - 31)
# |  |  |  .------- month (1 - 12) OR jan,feb,mar,apr ... 
# |  |  |  |  .---- day of week (0 - 6) Sunday=0 or 7)  OR sun,mon,tue,wed,thu,fri,sat 
# |  |  |  |  |
# *  *  *  *  *  command to be executed
``` 

- minute：代表一小时内的第几分，范围 0-59。
- hour：代表一天中的第几小时，范围 0-23。
- mday：代表一个月中的第几天，范围 1-31。
- month：代表一年中第几个月，范围 1-12。
- wday：代表星期几，范围 0-7 (0及7都是星期天)。
- who：要使用什么身份执行该指令，当您使用 crontab -e 时，不必加此字段。
- command：所要执行的指令。

- [Linux之crontab定时任务 - 简书](https://www.jianshu.com/p/838db0269fd0)

#### 开启SSH服务远程登录

Linux 默认只安装ssh-client服务，查看当前的ubuntu是否安装了ssh-server服务。

```bash
dpkg -l | grep ssh
```

安装ssh-server服务:

```bash
sudo apt-get install openssh-server 
```

确认ssh-server是否启动了：

```bash
ps -e | grep ssh
```

如果没有开启，可以执行：

```
sudo service ssh start
```

用 `ifconfig` 查看本机 ip 地址，如果提示无此命令，需要安装 `net-tools`：
```bash
sudo apt-get install net-tools
```

连接：
```bash
ssh username@ip
```

错误：

```
The fingerprint for the ECDSA key sent by the remote host is
SHA256:xxxx.
Please contact your system administrator.
Add correct host key in /Users/iHTCboy/.ssh/known_hosts to get rid of this message.
Offending ECDSA key in /Users/iHTCboy/.ssh/known_hosts:4
ECDSA host key for 172.16.0.1 has changed and you have requested strict checking.
Host key verification failed.
```

说明本地`/Users/iHTCboy/.ssh/known_hosts`文件已经保存了远程主机 ECDSA key 值不相同导致，删除重新连接就可以。


- [ubuntu开启SSH服务远程登录 - jackghq的博客 - CSDN博客](https://blog.csdn.net/jackghq/article/details/54974141)

#### linux账号用户切换
##### 1.sudo 命令

```
$ sudo
```
输入当前用户密码就可以得到超级用户的权限。但默认的情况下5分钟root权限就失效了。

##### 2. sudo -i

```
$ sudo -i
```
通过这种方法输入当前用户密码就可以进到root用户。

##### 3.使用root用户

如果你是第一次使用root账户，那我们首先要重设置root用户的密码：

```
$  sudo passwd root
```

之后系统会让你输入两遍root账户的密码，确认后密码即设置完毕，接下来就可以切换到root用户了。切换用户的命令是su，su是(switch user)切换用户的缩写。

```
$ su
```

或者

```
$ su root 
```

或者

```
$ su - root 
```

区别：
- su 只能切换到管理员用户权限,不使用管理员的登陆脚本和搜索路径
- su - 不但能切换到管理员权限而且使用管理员登陆脚本和搜索路径

##### 4.退出root 用户

```
# exit
```

##### 5.一些说明
比如当前路径：
```
root@htc:~#
```

root：代表的当前用户的用户名
htc：是主机的名称（这个也是可以改的）
～：代表当前目录
$：是普通用户的意思
＃：root用户

#### linux修改用户名
假设旧用户名为 parallers，想要修改为新用户名 ihtcboy

1.进入终端，输入：su -回车，接着输入密码，获取root权限
2.输入：usermod -l ihtcboy -d /home/ihtcboy -m test 回车。
3.输入：groupmod -n ihtcboy test 回车。
4.重启电脑，用户名已经修改完成。
5.终端输入：`id ihtcboy`，查看当前用户信息


#### Systemd 命令

`systemctl enable` 命令用于在上面两个目录之间，建立符号链接关系。

```bash
$ sudo systemctl enable clamd@scan.service
    # 等同于
$ sudo ln -s '/usr/lib/systemd/system/clamd@scan.service' '/etc/systemd/system/multi-user.target.wants/clamd@scan.service'
```

`systemctl enable` 命令相当于激活开机启动。
与之对应的，`systemctl disable` 命令用于在两个目录之间，撤销符号链接关系，相当于撤销开机启动。

```bash
$ sudo systemctl disable clamd@scan.service
```

注：配置文件的后缀名，就是该 Unit 的种类，比如sshd.socket。如果省略，Systemd 默认后缀名为`.service`，所以sshd会被理解成sshd.service。

`systemctl cat` 命令可以查看配置文件的内容。



- [Systemd 入门教程：命令篇 - 阮一峰的网络日志](http://www.ruanyifeng.com/blog/2016/03/systemd-tutorial-commands.html)

#### 服务器命令操作
##### 常用命令
基本命令
```
//进入网站根目录
cd /data/wwwroot/default  

//重启服务器
reboot 

//下载url对应的文件
wget url  

//解压xx.zip文件到当前目录
unzip xx.zip
```

修改文件权限
```
//LAMP环境下修改用户和用户组
chown -R apache.apache /data/wwwroot/default

//分别修改文件和文件夹的读、写、执行权限
find /data/wwwroot/default -type f -exec chmod 640 {} \;
find /data/wwwroot/default -type d -exec chmod 750 {} \;
```

Web服务启停
修改环境后，需要运行如下命令进行服务重启后方可生效
Apache：
```
systemctl restart httpd
```

Nginx：
```
systemctl restart nginx //重启nginx
systemctl restart php-fpm //重启php-fpm
```

升级
```
~# yum update -y //升级所有包同时也升级软件和系统内核,-y当安装过程提示选择全部为"yes"
~# yum upgrade -y //只升级所有包，不升级软件和系统内核,-y当安装过程提示选择全部为"yes"
```

ctrl + z
可以将一个正在前台执行的命令放到后台，并且处于暂停状态。

ctrl+c
  终止前台命令。

##### 进程相关
查看运行的后台进程
（1）jobs -l
jobs命令只看当前终端生效的，关闭终端后，在另一个终端jobs已经无法看到后台跑得程序了，此时利用ps（进程查看命令）

（2）ps -ef 或 ps -aux
 a:显示所有程序 
 u:以用户为主的格式来显示 
 x:显示所有程序，不以终端机来区分

注：
　　用ps -def | grep 查找进程很方便，最后一行总是会grep自己
　　用grep -v参数可以将grep命令排除掉
　```　
    ps -aux|grep chat.js| grep -v grep
    ```
    
再用awk提取一下进程ID　
```
ps -aux|grep chat.js| grep -v grep | awk '{print $2}'
```

如果某个进程起不来，可能是某个端口被占用
查看使用某端口的进程
```
lsof -i:8090
```

netstat -ap|grep 8090
查看到进程id之后，使用netstat命令查看其占用的端口
```
netstat -nap|grep 7779
```

终止后台运行的进程
使用kill杀掉进程
```
kill -9  进程号
```

- [nohup和&后台运行，进程查看及终止 - jenyzhang的专栏 - CSDN博客](https://blog.csdn.net/jenyzhang/article/details/76210920)

##### nginx 命令

启动、停止和重启
```
service nginx start
service nginx stop
service nginx restart
```

或
```
$ nginx
$ nginx -s stop
$ nginx -s reload
```

init.d目录包含许多系统各种服务的启动和停止脚本：
```
sudo /etc/init.d/nginx start
sudo /etc/init.d/nginx stop
sudo /etc/init.d/nginx restart
```

killall -9 nginx   #停止nginx
killall -9 uwsgi   #停止uwsgi

uwsgi --ini /data/www/script/uwsgi9090.ini  #启动uwsgi脚本





#### 部署指令

##### 基于uWSGI和nginx部署Django

1、原理
```
Web Client <===> Web Server(nginx) <===> The Socket <===> uWSGI <===> Django
```

2、安装环境&部署

不安装下面的库，后面的一些安装命令可能会失败。（Debian 及衍生系统，如 Ubuntu，需要先安装 python-dev 或 python3-dev。否则不能正常安装 uwsgi。原因：`uWSGI` 是一个(巨大的) C 应用，所以你需要一个 C 编译器(比如 gcc 或者 clang)和 Python 开发版头文件。）
```
sudo apt-get install python-dev
```

注：CentOS 使用 `yum`命令：
```
yum install gcc python-devel 
yum groupinstall "Development Tools"
yum install uwsgi-plugin-python #yum安装的uwsgi，缺少python的plugin
```


安装python3：
``` 
sudo apt-get install python3
```

安装pip：
```
#python2
sudo apt-get install python-pip 

#python3
sudo apt-get install python3-pip
```

安装虚拟环境：
```
pip3 install virtualenv
```

安装 Django：
```
pip3 install django
```

注：
1. 非必需安装，可以在虚拟环境中再安装
2. 如果安装后找不到` django admin`命令，可以安装：`apt install python-django-common`
3. 部署static文件: 在django的setting文件中，添加下面一行内容，然后运行`python manage.py collectstatic`：
    ```
    STATIC_ROOT = os.path.join(BASE_DIR, "static/")
    ```

**如果是 python3 作为主环境**
创建python3软连接:
```
sudo ln -s /usr/bin/python3 /usr/bin/python
```

注：由于执行CentOS 7的yum命令需要使用自带的python2的版本，所以将`/usr/bin/yum` 和 `/usr/libexec/urlgrabber-ext-down` 文件的` #! /usr/bin/python` 修改为 `#! /usr/bin/python2`
```
vim /usr/bin/yum
```

3、安装uwsgi
```
sudo pip3 install uwsgi --upgrade
```

验证安装是否成功：
```
uwsgi --http :8000 --wsgi-file /python/test.py 
```

参数含义:
* http :8000: 使用http协议，8000端口
* wsgi-file test.py: 加载指定文件 test.py

在浏览器访问ip: 8000（本机 ip + 端口:8000），可以看到浏览器输出"Hello World"。至此，uwsgi安装完成。

test.py：
```
# test.py
def application(env, start_response):
    start_response('200 OK', [('Content-Type','text/html')])
    #return ["Hello World"] # python2
    return [b"Hello World"] # python3
```

配置uwsgi： 
如果每次都运行上面命令拉起 django application 确实是麻烦，并且` uwsgi`有很多参数选项，一条命令就可以很长，例如`uwsgi --http 127.0.0.1:8000 --chdir /path/to/project/ --wsgi-file /path/to/wsgi.py --processes 4 --threads 2 --stats 127.0.0.1:8080`。所以方法是使用.ini文件能简化工作。创建xxx.ini配置文件来保存启动命令。在你喜欢的位置创建ini文件。我是在 `/python/uwsgi.ini.d` 下创建的 `uwsgi9001.ini`，内容如下：

```
# /python/uwsgi.ini.d/uwsgi9001.ini
[uwsgi]
socket = 127.0.0.1:9001
master = true #主进程
vhosts = true #多站模式
workers = 2 #子进程数
reload-mercy = 10
vacuum = true #退出、重启时清理文件和环境
max-requests = 1000  #respawn processes after serving 1000 requests
limit-as = 512 # limit the project to 512 MB
buffer-size = 30000
pidfile = /var/run/uwsgi9001.pid #用来启动/停止进程
daemonize = /python/uwsgi.ini.d/uwsgi9001.log #进程后台运行并将日志输到文件
pythonpath = /usr/local/lib/python2.7/dist-packages #python的包环境
stats = 127.0.0.1:9191 #在指定的地址上启用统计信息服务器
```

参数说明:
- `master = true`：除了配置中设置的进程数，还将另外启动一个 master 进程，用来管理其他进程。kill master 进程的 pid，master 将自动重启；kill uWSGI 的其他进程，master 将自动重新启动一个进程。
- `daemonize`：使进程在后台运行，并将日志打到指定的日志文件或者udp服务器。而`logto` 将日志打到一个指定的文件或者udp服务器。
- `pythonpath`：可用命令查看路径`pip show django | grep -i location`。1.4 以下 Django 才需要设置。但是使用 python2 环境测试时报错`Internal Server Error`，需要添加路径才能识别Django（v1.11.25）的正确路径。

最新的最简方式：
```
[uwsgi]
socket = 127.0.0.1:9001 #如果是直接访问此 ip 测试，改为 `http`
chdir = /var/www/myapp  #项目目录,即Django程序目录
wsgi-file = myapp/wsgi.py # wsgi.py目录
env = DJANGO_SETTINGS_MODULE=myapp.settings # python虚拟环境目录
processes = 4 #指定数目的worker/进程
threads = 2 #指定数目的线程
```

**注意：**
1.考虑到安全性，[uWSGI 文档](http://uwsgi-docs-cn.readthedocs.io/zh_CN/latest/WSGIquickstart.html#id2)中提到，不要使用 root 权限来运行 uWSGI，添加 uid 和 gid 选项指定用户和组来降低权限。

2.如果端口被占用，可以使用uwsgi配置文件中设置的pidfile来进行停止
```
sudo uwsgi --stop /var/run/uwsgi9001.pid  
```

重启 uWSGI：
```
sudo uwsgi --reload /var/run/uwsgi9001.pid  
```

或者杀死全部uwsgi进程：
```
sudo killall -9 uwsgi 
```
或
```
pkill -f uwsgi
```

3.配置后的#注释，在使用中记得去掉，否则报错！！`No such file or directory`


4、安装 Nginx
```
apt-get install nginx 
```
使用Ubuntu的软件包管理器进行安装，安装完毕之后Nginx的配置文件在`/etc/nginx/nginx.conf`。

验证安装是否成功：
在浏览器访问当前ip: 例如 192.168.199.202，可以看到浏览器显示"Welcome to nginx!"。至此，Nginx安装完成。

配置Nginx： 
打开nginx的配置文件 `/etc/nginx/nginx.conf`，查阅http{}模块，很容易发现服务器配置文件应写在 `/etc/nginx/conf.d` 下，以.conf为后缀：
```
http {
    ##
    # Virtual Host Configs
    ##
    include /etc/nginx/conf.d/*.conf;
    include /etc/nginx/sites-enabled/*;
}
```

于是我们在`/etc/nginx/conf.d`创建一个 mysite.conf 文件，写入如下内容：
也可以用软链接到 `/etc/nginx/conf.d`：
```
sudo i
```

注：`/etc/nginx/conf.d/` 和 `/etc/nginx/sites-enabled/` 都可以

```
#mysite.conf
server {
        listen      80;
        server_name 192.168.199.202;
        location / {
            include uwsgi_params;
            uwsgi_pass 127.0.0.1:9001;
            uwsgi_param UWSGI_CHDIR /python/mysite;
            uwsgi_param UWSGI_SCRIPT mysite.wsgi;
            index index.html index.htm;
            client_max_body_size 35m;
        }
} 
```

其中：
* `server_name` 是你的服务器ip（实际生产环境中是域名）
* `uwsgi_params` 文件在 `/etc/nginx/` 目录中。如果没有，可以从 [GitHub](https://github.com/nginx/nginx/blob/master/conf/uwsgi_params) 获取，是 nginx 传递给 uwsgi 的对应参数转换。
* `uwsgi_pass` 是nginx接收请求后转交给uwsgi处理经过的端口（nginx把每个请求传递到服务器绑定的端口 9001，并且使用 uwsgi 协议通信。），需要与 `uwsgi.ini.d` 内设置的端口一致。
* `UWSGI_CHDIR` 是项目的根目录，就是项目所在的全路径目录
* `UWSGI_SCRIPT` 是项目入口文件相对于项目的路径（'.'表示一个层级）。设置完成之后，在
* `client_max_body_size` 最大上传大小。

终端重启nginx以及运行uwsgi：
```
sudo service nginx reload & uwsgi --ini /python/uwsgi.ini.d/uwsgi9001.ini
```

扩展：
1.nginx.conf 也可能这样的完整形式：
```
# mysite_nginx.conf

# the upstream component nginx needs to connect to
upstream django {
    # server unix:///path/to/your/mysite/mysite.sock; # for a file socket
    server 127.0.0.1:8001; # for a web port socket (we'll use this first)
}
# configuration of the server
server {
    # the port your site will be served on
    listen      8000;
    # the domain name it will serve for
    server_name .example.com; # substitute your machine's IP address or FQDN
    charset     utf-8;

    access_log /var/log/nginx/www.test.com.access.log;
    error_log /var/log/nginx/www.test.com.error.log;
    
    # max upload size
    client_max_body_size 75M;   # adjust to taste

    # Django media
    location /media  {
        alias /path/to/your/mysite/media;  # your Django project's media files - amend as required
    }

    location /static {
        alias /path/to/your/mysite/static; # your Django project's static files - amend as required
    }

    # Finally, send all non-media requests to the Django server.
    location / {
        uwsgi_pass  django;
        include     /path/to/your/mysite/uwsgi_params; # the uwsgi_params file you installed
    }
}
```
相当于本来直接设置 `uwsgi_pass` 的值，现在改成了先把值赋给变量 `django`，再把变量 `django` 设置到 `uwsgi_pass` 上。`upstream` 常用于需要做负载均衡的场景，一个 upstream 里可以配置多个 server。


2.可以用 `UNIX socket` 取代 `TCP port`， Nginx 中需要使用 `proxy_pass` 对 uWSGI 这个地址进行反向代理，是使用 TCP Socket 的运行方式。使用 Unix Sockets 的方式好处是**开销低，效率高**。

对 nginx.conf 做如下修改：
```
server unix:///path/to/your/mysite/mysite.sock; # for a file socket
# server 127.0.0.1:8001; # for a web port socket (we'll use this first)
```
注：注意，有三条斜线，由 `unix://` 和 `/path/to/sock.sock` 两部分组成。

对 uwsgi.ini 修改：

```
[uwsgi]
socket = /path/to/sock.sock
chmod-socket = 666
...
```
注：生成的 sock 文件可能会缺少执行权限，可以通过设置 `chmod-socket = 666` 解决。

重启nginx，并在次运行uWSGI：
```
uwsgi --socket mysite.sock --wsgi-file test.py
```


3.查看 nginx 错误日志文件，默认的错误日志目录： nginx error log(/var/log/nginx/error.log)。如果错误可以查看`cat /var/log/nginx/error.log`
也可以指定日志文件：
```
    access_log /var/log/nginx/www.test.com.access.log;
    error_log /var/log/nginx/www.test.com.error.log;
```

4.配置 SSL 证书
如果要配置 SSL 证书，只要修改 Nginx 的配置即可：
```
server{
  ssl_certificate      crt;
  ssl_certificate_key  key;
  ...
}
```

更详细的配置可以参考 [StackOverflow](https://stackoverflow.com/questions/29827299/django-uwsgi-nginx-ssl-request-for-working-configuration-emphasis-on-ss)。可以使用 Let's Encrypt 生成免费的 SSL 证书。欲知使用方法点击这篇文章：[《你的网站还没用上 HTTPS 吗》](https://juejin.im/post/5c910884f265da60f771bdfa)。


5.每次 uWSGI 是不会在系统启动时自动启动的，所以可以添加自定义系统服务启动。
方法有很多种：

- `rc.local`

编辑文件`/etc/rc.local`, 添加下面内容到这行代码之前exit 0:

```
uwsgi --ini /python/uwsgi.ini.d/uwsgi9001.ini
```

注：ubuntu 16.x 不再使用 `inited` 管理系统服务，所以去掉了 `/etc/rc.local`，改用 `systemd` 

- `systemd`

（1）创建一个自己的系统服务（`rc-local.service` 或 `uwsgi.service`都可以）
```
sudo vim /etc/systemd/system/rc-local.service
```

填写内容：
```
[Unit]
Description=/etc/rc.local Compatibility
ConditionPathExists=/etc/rc.local
After=network.target

[Service]
Type=forking
ExecStart=/etc/rc.local start
TimeoutSec=0
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
```

说明
- `ConditionPathExists`：为服务启动时执行的命令，不能用相对路径， 一定要全路径。也可以将命令写到任意的.sh文件。

（2）创建`rc.local`文件(如果没有的话)：
```
sudo touch /etc/rc.local
sudo vim /etc/rc.local
```

首先第一次添加`#!/bin/bash`，添加需要启动执行的代码：
```
uwsgi --ini /python/uwsgi.ini.d/uwsgi9001.ini
```

最后，然后添加执行权限：`sudo chmod +x /etc/rc.local`

（3）启动和关闭服务
启用：
```
sudo systemctl enable rc-local.service
```
启动服务：
```
sudo systemctl start rc-local.service
```
可以查看进程，确认一下服务是否启动：
```
ps aux|grep rc-local
```

最后，可以试试重启服务器看看是不是真生效:`sudo reboot`

注意：也可以通过 `systemctl status rc-local.service` and `journalctl -xe` 查看详细日志


- 其它，如 进程监控`Supervisor`、`crontab`等

```
sudo apt-get install supervisor
```
配置Supervisor。

转到Supervisor的配置文件目录：
```
cd /etc/supervisor/conf.d/
```

新建并打开一个名为blog.conf的配置文件：
```
touch blog.conf
vim blog.conf
```

配置内容：

```
# 进程的名字，取一个以后自己一眼知道是什么的名字。
[program:blog] 
# 定义命令。你只要注意后面的目录对就行。特别注意「run:app」的run，这个名字是你网站应用的文件名。我的是run.py，就写run。
command=/home/www/blog/venv/bin/gunicorn run:app -c /home/www/blog/gunicorn.conf
# 网站目录
directory=/home/www/blog
# 进程所属用户。之前为博客建立过一个小号www，你还记得？
user=www
# 自动重启设置。
autostart=true
autorestart=true
# 日志存放位置。

stdout_logfile=/home/www/blog/logs/gunicorn_supervisor.log 
# 设置环境变量。这里这行的意思是：设置环境变量MODE的值为UAT。请根据自己的需要配置，如没有需要这行可以删除。

environment = MODE="UAT"
```

简单配置：

```
[program:blog]
command=vapor run --env=production
directory=/root/blog        # 修改vapor项目目录
autorestart=true
user=root                      # vapor项目所属用户用户名
stdout_logfile=/var/log/supervisor/%(program_name)-stdout.log
stderr_logfile=/var/log/supervisor/%(program_name)-stderr.log
```

加载并生效Supervisor配置：
```
sudo supervisorctl reread
sudo supervisorctl update  或  sudo supervisorctl add blog
sudo supervisorctl start blog
```

重启Supervisor：
```
sudo service supervisor stop
sudo service supervisor start
```



#### 错误处理
创建软链接：
```
ln -s /usr/local/python3/bin/python3 /usr/bin/python
```
第二个参数是目标地址，链到该地址上

如果遇到下面的报错：
```
ln: failed to create symbolic link '/usr/bin/python': File exists
```

说明已经有链接链到 /usr/bin/python上了，删除即可，使用命令
```
rm -rf /usr/bin/python
```

测试 uwsgi 是否正常 ，在终端执行
```
uwsgi --http :8001 --wsgi-file /data/test.py
```##### uwsgi 执行报错，报错内容如下
```bash
uwsgi: option '--http' is ambiguous; possibilities: '--http-socket' '--https-socket-modifier2' '--https-socket-modifier1' '--https-socket' '--http11-socket' '--http-socket-modifier2' '--http-socket-modifier1'getopt_long() error
```查看uwsgi安装位置,终端执行 ：
```
whereis uwsgi
```执行结果为：
```
uwsgi: /usr/sbin/uwsgi /usr/lib64/uwsgi /etc/uwsgi.d /etc/uwsgi.ini
```定位原因为：上面两个uwsgi文件均缺失plugin插件，所以需要自行安装plugin插件：`uwsgi-plugin-python`安装 uwsgi-plugin-python提示：安装之前需要先安装 uwsgi-plugin-common 安装步骤如下：
```
apt install uwsgi-plugin-common
```centos安装，需要先搜索 `yum search vim uwsgi-plugin-python`
找到对应版本的 uwsgi-plugin-python，然后在 yum install 一下：
```
yum install -y uwsgi-plugin-pythonXXX
```再次执行`uwsgi --http :8001 --wsgi-file test.py` 依旧报同样错误修改命令为：`uwsgi --http-socket :8001 --wsgi-file test.py`执行结果如下：
```bash
uwsgi: unrecognized option ‘–wsgi-file’getopt_long() error
```
这是因为： 需要在上面那些未识别选项前加上 `--plugin python` 来告诉 uWSGI 在使用 python 插件，对于后面那些选项要用 python 插件去解析再次修改命令为：`uwsgi --http-socket :8001 --plugin python --wsgi-file test.py`

执行成功！


2、运行 `uwsgi --ini xxx`时报错：
```
chdir() to /var/www/EfunForum_Python/EfunForumSite  #项目目录,即Django程序目录
chdir(): No such file or directory [core/uwsgi.c line 2623]
```

把 `#项目目录，即Django程序` 这个注释去掉就可以了！！！

3、uwsgi -- unavailable modifier requested: 0 --
说明是uwsgi出了问题，启动文件需要增加一个配置项，`python36`表示当前安装的 python 版本为 3.6：
```
plugins = python36
```
如果是命令行，则用：
```
--plugin python36
```

4、uwsgi: unrecognized option '--wsgi-file'
```
open("/usr/lib64/uwsgi/python_plugin.so"): No such file or directory [core/utils.c line 3721]
!!! UNABLE to load uWSGI plugin: /usr/lib64/uwsgi/python_plugin.so: cannot open shared object file: No such file or directory !!!
uwsgi: unrecognized option '--wsgi-file'
```
说明 python 插件路径错误！确认 `yum install -y uwsgi-plugin-pythonXXX` 指定的 python 版本，需要明确当前使用的 python 版本，比如 `--plugin python36`


5、Could not get lock /var/lib/dpkg/lock 解决
```
E: Could not get lock /var/lib/dpkg/lock-frontend - open (11: Resource temporarily unavailable)
E: Unable to acquire the dpkg frontend lock (/var/lib/dpkg/lock-frontend), is another process using it?
```
出现这个问题可能是有另外一个程序正在运行，导致资源被锁不可用。而导致资源被锁的原因可能是上次运行安装或更新时没有正常完成，进而出现此状况，解决的办法其实很简单：

在终端中执行：
```
sudo rm /var/cache/apt/archives/lock

sudo rm /var/lib/dpkg/lock
```

#### linux 文件夹作用

|  目录  |  说明 |
|---|---|
|  /bin |  二进制可执行命令   |
|  /dev |  设备特殊文件   |
|  /etc |  系统管理和配置文件   |
|  /etc/rc.d |  启动的配置文件和脚本  | 
|  /home |  用户主目录的基点，比如用户user的主目录就是/home/user，可以用~user表示   |
|  /lib |  标准程序设计库，又叫动态链接共享库，作用类似windows里的.dll文件   |
|  /sbin |  系统管理命令，这里存放的是系统管理员使用的管理程序   |
|  /tmp |  公用的临时文件存储点   |
|  /root |  系统管理员的主目录（呵呵，特权阶级）   |
|  /mnt |  系统提供这个目录是让用户临时挂载其他的文件系统。   |
|  /lost+found |  这个目录平时是空的，系统非正常关机而留下“无家可归”的文件（windows下叫什么.chk）就在这里   |
|  /proc |  虚拟的目录，是系统内存的映射。可直接访问这个目录来获取系统信息。   |
|  /var |  某些大文件的溢出区，比方说各种服务的日志文件   |
|  /usr |  最庞大的目录，要用到的应用程序和文件几乎都在这个目录。其中包含以下子目录：   |
|  /usr/x11r6 |  存放x window的目录   |
|  /usr/bin |  众多的应用程序   |  |
|  /usr/sbin |  超级用户的一些管理程序   |
|  /usr/doc |  linux文档   |
|  /usr/include |  linux下开发和编译应用程序所需要的头文件   |
|  /usr/lib |  常用的动态链接库和软件包的配置文件   |
|  /usr/man |  帮助文档   |
|  /usr/src |  源代码，linux内核的源代码就放在/usr/src/linux里   |
|  /usr/local/bin |  本地增加的命令   |
|  /usr/local/lib |  本地增加的库  |


1. /bin目录 
`/bin`目录包含了引导启动所需的命令或普通用户可能用的命令(可能在引导启动后)。这些 
命令都是二进制文件的可执行程序(bin是 binary —— 二进制的简称)，多是系统中重要的系统文件。 
2. /sbin目录 
`/sbin`目录类似 /bin，也用于存储二进制文件。因为其中的大部分文件多是系统管理员使 
用的基本的系统程序，所以虽然普通用户必要且允许时可以使用，但一般不给普通用户使用。 
3. /etc目录 
`/etc`目录存放着各种系统配置文件，其中包括了用户信息文件 /etc/passwd，系统初始化文 
件 /etc/rc 等。linux 正是这些文件才得以正常地运行。 
4. /root目录 
`/root` 目录是超级用户的目录。 
5. /lib目录 
`/lib` 目录是根文件系统上的程序所需的共享库，存放了根文件系统程序运行所需的共享文 
件。这些文件包含了可被许多程序共享的代码，以避免每个程序都包含有相同的子程序的副 
本，故可以使得可执行文件变得更小，节省空间。 
6. /lib/modules 目录 
`/lib/modules` 目录包含系统核心可加载各种模块，尤其是那些在恢复损坏的系统时重新引 
导系统所需的模块(例如网络和文件系统驱动)。 
7. /dev目录 
`/dev` 目录存放了设备文件，即设备驱动程序，用户通过这些文件访问外部设备。比如，用 
户可以通过访问 /dev/mouse 来访问鼠标的输入，就像访问其他文件一样。 
8. /tmp目录 
`/tmp` 目录存放程序在运行时产生的信息和数据。但在引导启动后，运行的程序最好使用 
 /var/tmp 来代替 /tmp ，因为前者可能拥有一个更大的磁盘空间。 
9. /boot目录 
`/boot` 目录存放引导加载器(bootstrap loader)使用的文件，如 lilo，核心映像也经常放在这里，而不是放在根目录中。但是如果有许多核心映像，这个目录就可能变得很大，这时使用单独的文件系统会更好一些。还有一点要注意的是，要确保核心映像必须在ide硬盘的前1024柱面内。 
10. /mnt目录 
`/mnt` 目录是系统管理员临时安装(mount)文件系统的安装点。程序并不自动支持安装到 /mnt。/mnt 下面可以分为许多子目录，例如 /mnt/dosa 可能是使用msdos文件系统的软驱， 
而 /mnt/exta 可能是使用ext2文件系统的软驱，/mnt/cdrom 光驱等等。 
