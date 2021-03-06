[TOC]

### sh

#### 生成可执行文件

在终端为文件添加可执行权限：
`chmod +x file_sh` 


#### Shell遍历目录及其子目录中的所有文件
新建一个shell文件

```bash
$ vi traveDir.sh
```

输入以下代码

```bash
#! /bin/bash
function read_dir(){
    for file in `ls $1`       #注意此处这是两个反引号，表示运行系统命令
    do
        if [ -d $1"/"$file ]  #注意此处之间一定要加上空格，否则会报错
        then
            read_dir $1"/"$file
        else
            #在此处处理文件即可
            file_path="$1/$file"
            echo ${file_path}
        fi
    done
}   
#读取第一个参数
read_dir $1
```
执行指令
```bash
$ sh traveDir.sh DIR_NAME
```

#### 获得当前目录，上级目录，文件夹名

```base
#当前目录，或用 `pwd`
$PWD   

#上级目录
dname=$(dirname "$PWD")

#当前文件(夹)名
basename '$PWD'  
```

#### 循环计算2-100的偶数和
- 使用for循环和 let

```bash
#!/bin/sh 
SUM=0
for (( i=0; i<=100; i++  ))
do
     if test $((i%2)) -eq 0 ; then
        let SUM=SUM+i
     fi
done
echo $SUM

```
注意:使用let命令可以执行一个或者多个算术表达式，其中的变量名无需使用$符号。如果表达式中含有空格或者其他特殊字符，则必须将其引用起来。

- 使用for循环和 $((…))运算

```bash
#!/bin/sh 
SUM=0
for (( i=0; i<=100; i++  ))
do
     if test $((i%2)) -eq 0 ; then  
        SUM=$(( $SUM + i ))
     fi
done
echo $SUM
```

注意:使用$((…))这种形式进行算术写法比较自由，无需对运算符和括号进行转义处理，可以使用松散或者紧凑的格式来书写。

- 使用带有步长的for循环

```bash
#!/bin/sh 
SUM=0
for i in {0..100..2}
do
   SUM=$(( $SUM + i ))  
done
echo $SUM 
```


- 使用while循环

```bash
#!/bin/sh 
#定义初始化变量
SUM=0
i=0
# 开始while循环
while [[ "$i" -le 100  ]]
do
   SUM=$(( $SUM + i ))
   i=$((i+2))
done
echo $SUM
```
- [Shell脚本计算2-100的偶数和 - Learning - CSDN博客](https://blog.csdn.net/zbw18297786698/article/details/77456588)

#### 判断文件后缀

```bash
file_suffix=${file_path##*.} 

if [ ${file_suffix} = 'gif' ]
then
	echo 'gif'
else
	echo 'other'
fi
```

---

#### cmd命令里的路径包含空格的解决方法
解决方法很简单：将路径加上双引号

`"/user/iHTC boy/bash/"`

---

#### 在一行执行多条命令

分三种情况：

1、&&

举例：
```bash
lpr /tmp/t2 && rm /tmp/t2
```
第2条命令只有在第1条命令成功执行之后才执行。当 `&&` 前的命令 `lpr /tmp/t2` 成功执行后 `rm /tmp/t2` 才执行，根据命令产生的退出码判断是否执行成功（0成功，非0失败）。

2、||

举例：
```bash
cp /tmp/t2 /tmp/t2.bak || rm /tmp/t2
```
只有`||`前的命令`cp /tmp/t2 /tmp/t2.bak`执行不成功（产生了一个非0的退出码）时，才执行后面的命令。

3、;

举例：
```bash
cp /tmp/t2 /tmp/t2.bak; echo "hello world"
```
顺序执行多条命令，当`;`号前的命令执行完（不管是否执行成功），才执行`;`后的命令。

[shell学习笔记（1）Linux下在一行执行多条命令 - KoreaSeal - 博客园](https://www.cnblogs.com/koreaseal/archive/2012/05/28/2522178.html)


#### 使用sed替换字符串中的多个字符

```bsdh
// 管道：
sed 's/a/A/g' test.txt | sed 's/1/23/g' > test2.txt 
// -e选项:
sed -e 's/a/A/g' -e 's/l/23/g' test.txt > test2.txt 
// ;分号：
sed 's/a/A/g; s/1/23/g' test.txt > test2.txt 
```

如果想在原文件直接替换字符，则需要用 `-i` 参数辅助：

```basdh
sed -i '' 's/a/A/g; s/1/23/g' test.txt > test2.txt 
```
#### 将命令的结果作为下一个命令的参数

1. 符号：````

* 名称：反引号，上分隔符
* 位置：反引号（`）这个字符一般在键盘的左上角，数字1的左边，不要将其同单引号（’）混淆
* 作用：反引号括起来的字符串被shell解释为命令行，在执行时，shell首先执行该命令行，并以它的标准输出结果取代整个反引号（包括两个反引号）部分

* 使用：可以用于把结果作为多个参数之一的需求
* 举例：
```bash
$ echo `date` 
2019年10月18日 星期五 18时04分08秒 CST
```

2. $() 
效果同:  ````


3. 命令：xargs
`xargs` 是给命令传递参数的一个过滤器，也是组合多个命令的一个工具。它把一个数据流分割为一些足够小的块，以方便过滤器和命令进行处理。通常情况下，xargs从管道或者stdin中读取数据，但是它也能够从文件的输出中读取数据。
xargs的默认命令是echo，这意味着通过管道传递给xargs的输入将会包含换行和空白，不过通过xargs的处理，换行和空白将被空格取代。


```bash
$ date | xargs echo
Thu Mar 7 21:47:12 CST 2013
```

管道与xargs的区别：

管道是实现“将前面的标准输出作为后面的标准输入”
xargs是实现“将标准输入作为命令的参数”

4. find命令的 -exec 参数
* xargs：通过缓冲方式并以前面命令行的输出作为参数，随后的命令调用该参数
若忽略 xargs 的 options 来看的话,
`cm1 | xargs cm2`
可以单纯看成:  cm2 `cm1`

因此, find .... | xargs rm 也可作 rm `find ...` 来处理.
然而, 若 find 的结果太多, 可能会超过rm 可能接受的最大argument数量而失败.

* xargs优点：由于是批处理的，所以执行效率比较高（通过缓冲方式）
* xargs缺点：有可能由于参数数量过多（成千上万），导致后面的命令执行失败

若换成 find .... -exec   rm {} \; 的话, 
因为rm 是" 逐个 " item 去处理的, 则无此忧虑

- [将Linux命令的结果作为下一个命令的参数 - permike的专栏 - CSDN博客](https://blog.csdn.net/permike/article/details/51957003)

#### find 命令使用技巧

利用 find 命令找到当前目录下所有`.m`文件，并且把文件名作为参数，使用`genstrings`生成本地化语言内容
```
find . -name \*.m | xargs genstrings -o en.lproj
```

查找`/Users/iHTCboy/Documents`目录下所有 `.md` 文件内容含有 `https://ihtcboy.com` 的文件输出文件的全路径：

```
find /Users/iHTCboy/Documents -type f -name "*.md" -exec grep -l "https://ihtcboy.com" {}  \;
```

因为单行命令中-exec参数中无法使用多个命令，以下方法可以实现在-exec之后接受多条命令
`-exec ./text.sh {} \;`


当然，也可以用 xargs 命令并接：

```
find /Users/iHTCboy/Documents -type f -name "*.md" | xargs grep -l "https://ihtcboy.com"
```


搜索文件夹下文件并替换字符串：
```
find /Users/iHTCboy/Documents -type f -name "*.md" -exec sed -i '' 's/htc/iHTCboy/g; s/ihtc.cc/iHTCboy.com/g' {}  \;
```

注：sed 替换如果含反斜杠（/），可以改为冒号（:）是分隔符，而不是使用默认的反斜杠（/）。示例：`'s:htc:iHTCboy:g; s:ihtc.cc:iHTCboy.com:g' `

- [find命令_Linux find 命令用法详解：在指定目录下查找文件](https://man.linuxde.net/find)

#### SSH 连接、远程上传下载文件

* 安装 SSH(Secure Shell) 服务以提供远程管理服务：
```bash
sudo apt-get install ssh
```

* SSH 远程登入 Ubuntu 机 ：
```bash
$ssh username@192.168.0.1
```

* 将 文件/文件夹 从远程 Ubuntu 机拷至本地(scp) ：

```bash
scp <用户名>@<ssh服务器地址>:<文件路径> <本地文件名> 
```

```bash
$scp root@127.0.0.1:~/test.txt ~/Desktop/test.txt
```

* 将 文件/文件夹 从本地拷至远程 Ubuntu 机(scp) ：

```bash
scp <本地文件名> <用户名>@<ssh服务器地址>:<上传保存路径即文件名> 
```

```bash
$scp -r localfile.txt username@192.168.0.1:/home/username/
```

注：文件夹操作 
上传/下载文件夹操作与文件操作类似，只需加入参数 `-r`。

- [使用SSH传输文件/文件夹 - bedisdover的博客 - CSDN博客](https://blog.csdn.net/bedisdover/article/details/51622133)


#### 脚本遍历文件夹把md转成html

```
#!/bin/bash
  
function show()
{
    cd $1
  
    for i in `ls`
    do
        if [ -d "$i" ]
        then
            show "$1/$i"
        else
            filename=$(basename "$1/$i") #文件全名
            extension="${filename##*.}" #文件的后缀
            filename1="${filename%.*}" #不带后缀的文件名
            if [ "$extension" = "md" ]
            then
                mv "$1/$i" "$1/${filename1}.md"
            fi
        fi
    done
  
    cd ..
}
  
show $1
  
exit 0
```

- [linux shell脚本遍历文件夹把md转成html - zergling9999 - 博客园](https://www.cnblogs.com/zergling9999/p/6027563.html)


`find` 命令：

```bash
IFS=$'\n'
for n in `find . -name "*.md" -o -name "*.css" -o -name "*.css" -o -name "*.js"`; do

   something

done
```

#### 遍历带空格的文件名
shell的域分隔符即(IFS)，默认是空格回车和tab，所以这里需要指定IFS，并在循环执行前解析

- 方法1：
```
IFS=$'\n'
```


```bash
OLDIFS="$IFS"
IFS=$'\n'

something

IFS="$OLDIFS"
```
- 方法2：
使用read命令
```bash
find "$path" -type f -name "*.html" | while read i
do
	echo "$i"
done
```

- 方法3：
替换空格执行后，在还原空格：
```bash
for f in `ls ./ | tr " " "\?"`
```

在变量里面了可以直接替换回来
```
f=`tr "\?" " " <<<$f`
```

- [Linux shell脚本 遍历带空格的文件名 - google4y - 博客园](https://www.cnblogs.com/google4y/archive/2013/03/12/2956086.html)
- [嵌套for in循环组合cat方式文件中包含空格问题 - 陈浩然201 - 博客园](https://www.cnblogs.com/irockcode/p/7587310.html)


#### 判断文件后缀名

如果文件是 .css文件 或 .js文件，则进行处理：
```
file=$1

if [ "${file##*.}"x = "css"x ]||[ "${file##*.}"x = "js"x ];then
    do something
fi
```

注意：

1> 提取文件后缀名： `${file##*.}`，`##`是贪婪操作符，从左至右匹配，匹配到最右边的.号，移除包含.号的左边内容。
2> 是=，而且其两边有空格，如果没有空格，会报错
3> 多加了x，是为了防止字符串为空时报错。

- [shell提取文件后缀名，并判断其是否为特定字符串 - Hellovictoria的专栏](https://blog.csdn.net/hellovictoria/article/details/40378907)

#### shell获取时间字符串

In bash (<4.2):
```bash
# put current date as yyyy-mm-dd in $date
date=$(date '+%Y-%m-%d')

# put current date as yyyy-mm-dd HH:MM:SS in $date
date=$(date '+%Y-%m-%d %H:%M:%S')

# print current date directly
echo $(date '+%Y-%m-%d')
```

- [bash - YYYY-MM-DD format date in shell script - Stack Overflow](https://stackoverflow.com/questions/1401482/yyyy-mm-dd-format-date-in-shell-script)

#### EOF 的用法
EOF是（END Of File）的缩写，表示自定义终止符。既然自定义，那么EOF就不是固定的，可以随意设置别名。

用法：
```bash
<<EOF       #开始

....        #输入内容

EOF         #结束
```

几个特殊符号:

* `<` ：输入重定向
* `>` ：输出重定向
* `>>` ：输出重定向,进行追加,不会覆盖之前内容
* `<<` ：标准输入来自命令行的一对分隔号的中间内容


macOS 终端：
```bash
➜  ~ cat << EOF #开始输入
heredoc> test
heredoc> hello
heredoc> EOF
test
hello
```

`<< EOF EOF` 的作用是在命令执行过程中用户自定义输入，它类似于起到一个临时文件的作用，只是比使用文件更方便灵活。

<<EOF 与 <<-EOF 的区别

<<EOF：如果结束分解符EOF前有制表符或者空格，则EOF不会被当做结束分界符，只会继续被当做stdin来输入。
<<-EOF：分界符（EOF）所在行的开头部分的制表符（Tab）都将被去除。这可以解决由于脚本中的自然缩进产生的制表符。

示例：
```bash
#!/bin/bash

cat <<-EOF

Hello，EOF！

      EOF
```


- [shell基础之EOF的用法_weixin_30666943的博客-CSDN博客_警告:立即文档在第 3 行被文件结束符分隔 (需要 `-eof](https://blog.csdn.net/weixin_30666943/article/details/101436966)

#### tee 命令
tee命令用于将数据重定向到文件，另一方面还可以提供一份重定向数据的副本作为后续命令的stdin。简单的说就是把数据重定向到给定文件和屏幕上。

```
tee (选项)(参数)

-a：向文件中重定向时使用追加模式；
-i：忽略中断（interrupt）信号。
```

注：存在缓存机制，每1024个字节将输出一次。若从管道接收输入数据，应该是缓冲区满，才将数据转存到指定的文件中。若文件内容不到1024个字节，则接收完从标准输入设备读入的数据后，将刷新一次缓冲区，并转存数据到指定文件。

示例：
```
# ls | tee out.txt | cat -n
     1  1.sh
     2  1.txt
     3  2.txt
```

#### grep 和 find 忽略大小写

`grep` 使用 -i 参数来忽略大小写
```bash
grep -i 'xxxXXX' filePath
```

`find` 使用 -iname参数来忽略大小写：

```bash
find filesPath -iname 'xxxXXX' 
```


#### grep 命令

从文件内容查找匹配指定字符串的行： 
```
$ grep "查找的字符串" 文件名 
```

从文件内容查找与正则表达式匹配的行：
```
$ grep –e "正则表达式" 文件名
```

查找时不区分大小写： 
```
$ grep –i "查找的字符串" 文件名
```

查找匹配的行数： 
```
$ grep -c "查找的字符串" 文件名
```

从文件内容查找不匹配指定字符串的行： 
```
$ grep –v "查找的字符串" 文件名
```

查找所有扩展名为.md的文本文件，并找出包含"iHTCboy"的行 
```
find / -type f -name "*.md" | xargs grep "iHTCboy" 
```

#### terminal 终端删除历史命令记录

```
$history -c

$rm ~/.bash_history
```


### curl
#### 获取请求链接的 code
获取 header：

```bash
# -I, --head          Show document info only
curl -I https://www.iHTCboy.com

# -i, --include       Include protocol response headers in the output
curl -i https://www.iHTCboy.com
```

示例：

```bash
➜  ~ curl -I https://www.iHTCboy.com
HTTP/2 301
server: GitHub.com
content-type: text/html
location: https://ihtcboy.com/
x-github-request-id: 3DC6:4F98:13138DC:178B238:5F1AB9DF
accept-ranges: bytes
date: Fri, 24 Jul 2020 10:37:38 GMT
via: 1.1 varnish
age: 19
x-served-by: cache-hkg17929-HKG
x-cache: HIT
x-cache-hits: 1
x-timer: S1595587059.754877,VS0,VE0
vary: Accept-Encoding
x-fastly-request-id: a08a1f5dfc941ccebbe9e3fe05497c34d91470c0
content-length: 162
```

只获取 code：
```bash
#  -L, --location      Follow redirects

curl -s -o /dev/null -LI -w "%{http_code}\n" http://www.iHTCboy.com

curl -LI http://www.iHTCboy.com -o /dev/null -w '%{http_code}\n' -s
```

示例：

```bash
➜  ~ curl -s -o /dev/null -LI -w "%{http_code}\n" http://www.iHTCboy.com
200
```

- [Getting curl to output HTTP status code? - Super User](https://superuser.com/questions/272265/getting-curl-to-output-http-status-code)

* -I
-I参数向服务器发出 HEAD 请求，然会将服务器返回的 HTTP 标头打印出来。

* -L
-L参数会让 HTTP 请求跟随服务器的重定向。curl 默认不跟随重定向。

* -o
-o参数将服务器的回应保存成文件，等同于wget命令。

* -s
-s参数将不输出错误和进度信息。

- [curl 的用法指南 - 阮一峰的网络日志](https://www.ruanyifeng.com/blog/2019/09/curl-reference.html)

#### curl 获取网页内容

```bash
curl -sL http://www.iHTCboy.com 2>&1 | grep -Eoi '<title>(.+?)</title>'
```

- [How to grep the output of cURL?](https://unix.stackexchange.com/questions/166359/how-to-grep-the-output-of-curl)


### vim

#### 撤销和恢复撤销快捷键

`u` 是撤销刚才做的动作
`ctrl+r` 是恢复刚才撤销的动作



### figlet


```
brew instal figlet
```

or

```
npm install -g figlet-cli
```

- [FIGlet初识 | Aotu.io「凹凸实验室」](https://aotu.io/notes/2016/11/22/figlet/index.html)
