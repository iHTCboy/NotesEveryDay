### sh

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
            echo $1"/"$file   #在此处处理文件即可
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

### vim

#### 撤销和恢复撤销快捷键

`u` 是撤销刚才做的动作
`ctrl+r` 是恢复刚才撤销的动作
