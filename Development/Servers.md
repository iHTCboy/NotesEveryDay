### nginx

#### nginx location if 的匹配规则

cation匹配命令

~      #波浪线表示执行一个正则匹配，区分大小写
~*    #表示执行一个正则匹配，不区分大小写
^~    #^~表示普通字符匹配，不是正则匹配。如果该选项匹配，只匹配该选项，不匹配别的选项，一般用来匹配目录
=      #进行普通字符精确匹配
@     #"@" 定义一个命名的 location，使用在内部定向时，例如 error_page, try_files


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
   