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
$ su  root 
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
$：是普通用户的意思（若是root用户就显示＃）

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

#### 命令操作

killall -9 nginx   #停止nginx
killall -9 uwsgi   #停止uwsgi
uwsgi --ini /data/www/script/uwsgi9090.ini  #启动uwsgi脚本
/usr/local/nginx-1.5.6/sbin/nginx #启动nginx

/etc/init.d/nginx start
/etc/init.d/nginx stop

service nginx start
service nginx stop

启动、停止和重启
$ nginx
$ nginx -s stop
$ nginx -s reload


#### 错误处理
创建软链接。

ln -s /usr/local/python3/bin/python3 /usr/bin/python

第二个参数是目标地址，链到该地址上

如果遇到下面的bug

ln: failed to create symbolic link '/usr/bin/python': File exists


说明已经有链接链到 /usr/bin/python上了，删除即可，使用命令

rm -rf /usr/bin/python


测试 uwsgi 是否正常 ，在终端执行uwsgi --http :8001 --wsgi-file /data/test.py#### 执行报错，报错内容如下
```bash
uwsgi: option '--http' is ambiguous; possibilities: '--http-socket' '--https-socket-modifier2' '--https-socket-modifier1' '--https-socket' '--http11-socket' '--http-socket-modifier2' '--http-socket-modifier1'getopt_long() error
```查看uwsgi安装位置,终端执行 ：
```
whereis uwsgi
```执行结果为：
```
uwsgi: /usr/sbin/uwsgi /usr/lib64/uwsgi /etc/uwsgi.d /etc/uwsgi.ini
```定位原因为：上面两个uwsgi文件均缺失plugin插件,所以需要自行安装plugin插件：`uwsgi-plugin-python`安装 uwsgi-plugin-python提示：安装之前需要先安装 uwsgi-plugin-common 安装步骤如下：
```
apt install uwsgi-plugin-common
```再次执行`uwsgi --http :8001 --wsgi-file test.py` 依旧报同样错误修改命令为：`uwsgi --http-socket :8001 --wsgi-file test.py`执行结果如下：
```bash
uwsgi: unrecognized option ‘–wsgi-file’getopt_long() error
```
这是因为： 需要在上面那些未识别选项前加上 `--plugin python` 来告诉 uWSGI 我在使用 python 插件，对于后面那些选项你要用python 插件去解析再次修改命令为：`uwsgi --http-socket :8001 --plugin python --wsgi-file test.py`

执行成功！

#### 部署指令

##### 基于uWSGI和nginx部署Django

1.原理

the web client <-> the web server(nginx) <-> the socket <-> uwsgi <-> Django

2.部署

不安装这个，后面的命令安装可能会失败。（Debian 及衍生系统，如 Ubuntu，需要先安装 python-dev 或 python3-dev。否则不能正常安装 uwsgi。）
```
sudo apt-get install python-dev
```

安装pip：
```
sudo apt-get install python-pip 
```

安装uwsgi：
```
sudo pip install uwsgi --upgrade
```

验证安装是否成功：
```
uwsgi --http :8000 --wsgi-file /python/test.py 
```

参数含义:
http :8000: 使用http协议，8000端口
wsgi-file test.py: 加载指定文件 test.py

在浏览器访问ip: 8000（例如192.168.199.202:8001），可以看到浏览器输出"Hello World"。至此，uwsgi安装完成。

配置uwsgi： 每次都运行上面命令拉起 django application 实在麻烦，使用.ini文件能简化工作。所以可以创建ini配置文件来保存启动命令。在你喜欢的位置创建ini文件。我是在 `/python/uwsgi.ini.d` 下创建的 `uwsgi9001.ini`，内容如下：

```
# /python/uwsgi.ini.d/uwsgi9001.ini
[uwsgi]
socket = 127.0.0.1:9001
master = true #主进程
vhosts = true #多站模式
no-site = true #多站模式时不设置入口模块和文件
workers = 2 #子进程数
reload-mercy = 10
vacuum = true #退出、重启时清理文件
max-requests = 1000  #respawn processes after serving 1000 requests
limit-as = 512 # limit the project to 512 MB
buffer-size = 30000
//用来启动停止进程
pidfile = /var/run/uwsgi9001.pid
//用来记录启动日志 
daemonize = /python/uwsgi.ini.d/uwsgi9001.log
//python的包环境
pythonpath = /usr/local/lib/python2.7/dist-packages
```

**注意：**如果端口被占用，可以使用uwsgi配置文件中设置的pidfile来进行停止

```
uwsgi --stop /var/run/uwsgi9001.pid  
```
或者杀死全部uwsgi进程

```
killall -9 uwsgi 
```

安装Nginx： 我使用Ubuntu的软件包管理器进行安装，安装完毕之后Nginx的配置文件在`/etc/nginx/nginx.conf`。

```
apt-get install nginx 
```

验证安装是否成功：
在浏览器访问当前ip: 例如 192.168.199.202，可以看到浏览器显示"Welcome to nginx!"。至此，Nginx安装完成。


配置Nginx： 打开nginx的配置文件 `/etc/nginx/nginx.conf`，查阅http{}模块，很容易发现服务器配置文件应写在 `/etc/nginx/conf.d` 下，以.conf为后缀：

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
sudo ln mysite.conf /etc/nginx/conf.d/mysite.conf
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
`server_name` 是你的服务器ip（实际生产环境中是域名），
`uwsgi_pass` 是nginx接收请求后转交给uwsgi处理经过的端口，需要与 `uwsgi.ini.d` 内设置的端口一致，
`UWSGI_CHDIR` 是项目的根目录，
`UWSGI_SCRIPT` 是项目入口文件相对于项目的路径（'.'表示一个层级）。设置完成之后，在

终端重启nginx以及运行uwsgi：
```
service nginx reload & uwsgi --ini /python/uwsgi.ini.d/uwsgi9001.ini
```

扩展：
nginx.conf 也可能这样的形式：
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

也可以用 `UNIX socket` 取代 `TCP port`，对 nginx.conf 做如下修改：
```
server unix:///path/to/your/mysite/mysite.sock; # for a file socket
# server 127.0.0.1:8001; # for a web port socket (we'll use this first)
```

重启nginx，并在此运行uWSGI
```
uwsgi --socket mysite.sock --wsgi-file test.py
```

- 注： nginx error log(/var/log/nginx/error.log)。如果错误可以查看`cat /var/log/nginx/error.log`


3. 如果是 python3 则，需要做一些操作

部署static文件:

在django的setting文件中，添加下面一行内容：
```
STATIC_ROOT = os.path.join(BASE_DIR, "static/")
```

然后运行：
```
python manage.py collectstatic
```

