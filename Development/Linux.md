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

查看当前的ubuntu是否安装了ssh-server服务。默认只安装ssh-client服务。

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

用 `ifconfig` 查看本机 ip 地址，如果提示无此命令，需要安装 `net-tools`：
```bash
sudo apt-get install net-tools
```

连接：
```bash
ssh username@ip
```

- [ubuntu开启SSH服务远程登录 - jackghq的博客 - CSDN博客](https://blog.csdn.net/jackghq/article/details/54974141)


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

