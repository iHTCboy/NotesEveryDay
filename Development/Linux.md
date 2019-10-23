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