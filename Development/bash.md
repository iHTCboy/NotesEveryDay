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

### vim

#### 撤销和恢复撤销快捷键

`u` 是撤销刚才做的动作
`ctrl+r` 是恢复刚才撤销的动作
