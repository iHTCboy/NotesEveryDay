[TOC]

### Github 上传超过100M的大文件
官方示例：
```git
Homebrew: brew install git-lfs

git lfs install

git lfs track "*.psd"

git add .gitattributes
```

There is no step three. Just commit and push to GitHub as you normally would.

使用示例：
```git
git add file.psd
git commit -m "Add design file"
git push origin master
```

注：`.gitattributes`文件是 git lfs用于记录那些文件要通过lfs上传的配置文件。

另：

```git
This repository is over its data quota. Purchase more data packs to restore access.
```
意思就是"仓库超出限额，需要配置更多的额度"，这个可以在自己GitHub个人设置里查看，默认只有1G的空间，更多空间需要按月收费。。。

- [Git Large File Storage](https://git-lfs.github.com)

### Git 默认不区分文件名大小写的坑

配置 Git 使其对文件名大小写敏感

```git
git config core.ignorecase false
```

本地大小写敏感，但是远端并不是，会造成远端有大写和小定的2个文件，详见：

- [解决 Git 默认不区分文件名大小写的问题 - 简书](https://www.jianshu.com/p/df0b0e8bcf9b)


### git 撤销本地所有未提交的更改

```git
git checkout .
```

后面有.点，表示全部文件撤销

### git 撤销本地已提交(commit)，或已推送远端(push)的更改

如果你只想为之前的commit增加更多的改动，或者改变之前的提交信息，你应该使用：
```git
git reset --soft HEAD~
```
会将你的改动保留在暂存区内(只是改变了HEAD的指向，本地代码不会变化)。或使用

```git
git reset HEAD~
```

回退上一次提交前，并且强制清除修改的内容：
```git
git reset --hard HEAD^
```

如果已经提交到远程，就需要用本地覆盖远程，通过：

```git
git push origin master --force
```
强制提交当前版本号，以达到撤销版本号的目的。必须添加参数force进行强制提交，否则会提交失败，并报错（原因：本地项目版本号低于远端仓库版本号。）。

- [[译] 在Git中如何撤销上一次的commit(s)？ - 简书](https://www.jianshu.com/p/9f11d398111f)

### 一步提交git变更

```git
function lazygit() {
    git add .
    git commit -a -m "$1"
    git push
}
```
- [git add, commit and push commands in one? - Stack Overflow](https://stackoverflow.com/questions/19595067/git-add-commit-and-push-commands-in-one)


### Git仓库完整迁移（含历史记录log）

1). 从原地址克隆一份裸版本库。

```git
git clone --bare git://github.com/username/project.git
```

2). 然后到新的 Git 服务器上创建一个新项目。

3). 以镜像推送的方式上传代码到新的 Git 服务器上。

```git
cd project.git

git push --mirror git@gitcafe.com/username/newproject.git

```
4). 删除本地代码

```
cd ..

rm -rf project.git
```

5). 到新服务器上找到 Clone 地址，直接 Clone 到本地就可以了。

```git
git clone git@gitcafe.com/username/newproject.git
```

这种方式可以保留原版本库中的所有内容。

第二种切换remote_url的方法更直接，直接更改.git/conf配置文件里的ip地址就行。但是需要一个一个分支push。

- [Git仓库迁移而不丢失log的方法 - fantaxy的空间_前庭 - ITeye博客](https://fantaxy025025.iteye.com/blog/1966627)


### Sourcetree 更新git账号密码
删除Sourcetree 缓存文件(只需要删密码文件)，文件位置： 
```bash
Mac： 
~/Library/Application Support/SourceTree 

Windows： 
C:\Users\USERNAME\AppData\Local\Atlassian\SourceTree
```

删除对应账号的文件后，重启Sourcetree，然后push或者pull代码的时候，就会自动弹框让重新输入账号和密码

- [Sourcetree 更新git账号密码 - u011562187的专栏 - CSDN博客](https://blog.csdn.net/u011562187/article/details/79288468)

### git flow
- install
```git
macOS: brew install git-flow-avh
linux: apt-get install git-flow
```

- init
```git
git flow init
```

- feature
```git
git flow feature help
git flow feature start xxx
git flow feature finish xxx
git flow feature publish xxx
git flow feature pull origin xxx
```

- releases
```git
git flow release start 1.1.5
git flow release finish 1.1.5
git flow release publish 1.1.5
git flow release pull origin 1.1.5
```

- hotfix
```git
git flow hotfix start xxx
git flow hotfix finish xxx
```

- [git-flow 备忘清单](https://danielkummer.github.io/git-flow-cheatsheet/index.zh_CN.html)
- [git-flow 的工作流程](https://www.git-tower.com/learn/git/ebook/cn/command-line/advanced-topics/git-flow)

### Alpha、Beta、RC、GA 版本的区别

- Alpha：Alpha是内部测试版，一般不向外部发布，会有很多Bug，一般只有测试人员使用。除非你也是测试人员，否则不建议使用。alpha 是希腊字母的第一位，表示最初级的版本，alpha 就是`α`，beta 就是`β`，alpha 版就是比 beta 还早的测试版，一般都是内部测试的版本。

- Beta：也是测试版，这个阶段的版本会一直加入新的功能。在Alpha版之后推出，该版本相对于`α`版已有了很大的改进，消除了严重的错误，但还是存在着一些缺陷，需要经过多次测试来进一步修复。

- RC：`Release　Candidate` 顾名思义! `Candidate`是候选人的意思，用在软件上就是候选版本。RC 就是发行候选版本。和Beta版最大的差别在于，Beta阶段会一直加入新的功能，但是到了RC版本，几乎就不会加入新的功能了，而主要着重于除错！RC版本是最终发放给用户的最接近正式版的版本，发行后改正bug就是正式版了，就是正式版之前的最后一个测试版。

- GA：`General Availability`（一般可用性）正式发布的版本，在国外都是用GA来说明release 版本的。比如：`Apache Struts 2 GA` 就是 Apache Struts 2 首次发行稳定的版本，也就是官方开始推荐广泛使用的版本。

- Release: 该版本意味“最终版本”，在前面版本的一系列测试版之后，终归会有一个正式版本，是最终交付用户使用的一个版本。该版本有时也称为标准版。一般情况下，Release不会以单词形式出现在软件封面上，取而代之的是符号(R)。

- RTM：`Release to Manufacture` 是给工厂大量压片的版本，内容跟正式版是一样的，不过 RTM 版也有出限制、评估版的。但是和正式版本的主要程序代码都是一样的。

- OEM：是给计算机厂商随着计算机贩卖的，也就是随机版。只能随机器出货，不能零售。只能全新安装，不能从旧有操作系统升级。包装不像零售版精美，通常只有一面CD和说明书(授权书)。 

- RVL：号称是正式版，其实RVL根本不是版本的名称。它是中文版/英文版文档破解出来的。 

- EVAL：而流通在网络上的EVAL版，与“评估版”类似，功能上和零售版没有区别。 

- RTL：`Retail`(零售版) 是真正的正式版，正式上架零售版。在安装盘的i386文件夹里有一个eula.txt，最后有一行EULAID，就是你的版本。比如简体中文正式版是EULAID:WX.4_PRO_RTL_CN，繁体中文正式版是WX.4_PRO_RTL_TW。其中：如果是WX.开头是正式版，WB.开头是测试版。_PRE，代表家庭版；_PRO，代表专业版。

α、β、λ常用来表示软件测试过程中的三个阶段，α是第一阶段，一般只供内部测试使用；β是第二个阶段，已经消除了软件中大部分的不完善之处，但仍有可能还存在缺陷和漏洞，一般只提供给特定的用户群来测试使用；λ是第三个阶段，此时产品已经相当成熟，只需在个别地方再做进一步的优化处理即可上市发行。
                  
- [Alpha、Beta、RC、GA版本的区别 - Rex - BlogJava](http://www.blogjava.net/RomulusW/archive/2008/05/04/197985.html)
- [关于BETA、RC、ALPHA、Release、GA等版本号的意义 - 我的人生不甘于平庸！ - ITeye博客](https://zwustudy.iteye.com/blog/1711763)

### git cherry-pick 使用

选择某一个分支中的一个或几个commit(s)来进行操作。

```git
git cherry-pick <commit id>:单独合并一个提交
git cherry-pick  -x <commit id>：同上，不同点：保留原提交者信息。

Git从1.7.2版本开始支持批量cherry-pick，就是一次可以cherry-pick一个区间的commit。

git cherry-pick <start-commit-id>..<end-commit-id>
git cherry-pick <start-commit-id>^..<end-commit-id>
```

- [git cherry-pick 使用指南 - 简书](https://www.jianshu.com/p/08c3f1804b36)

### Adding an SSH key to your GitLab account

- Generate ssh key
use RSA:
```sh
ssh-keygen -o -t rsa -b 4096 -C "email@example.com"
```

注：此命令会提示您输入存储密钥的位置和文件名。只需按enter使用默认值就可以。

成功后：
```
The key's randomart image is:
+---[RSA 4096]----+
| .o+             |
|. +.o            |
| + = .           |
|o + *            |
|+. + o .S        |
|.+ o  o.o        |
|  * *.oo .       |
| o %oO .o        |
|..*+%*E=         |
+----[SHA256]-----+
```

- Copy ssh public key
macOS:
```sh
pbcopy < ~/.ssh/id_rsa.pub
```

WSL / GNU/Linux (requires the xclip package):
```sh
xclip -sel clip < ~/.ssh/id_rsa.pub
```

Git Bash on Windows:
```sh
cat ~/.ssh/id_rsa.pub | clip
```

- Q&A
拉取代码时，报错：
```sh
Cloning into 'htcproject'...
/Users/iHTCboy/.ssh/config line 4: garbage at end of line; "Enterprise".
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.
```

原因是 `config` 中包含非法的字符，可能是之前配置或者多个账号配置，Sourcetree生成等，可以直接清空内容或者删除文件即可。


```sh
➜ git clone git@172.16.1.88:ios/iHTCboy/ftproject.git
Cloning into 'ftproject'...
The authenticity of host '172.16.1.88 (172.16.1.88)' can't be established.
RSA key fingerprint is SHA256:aRCcbTE77qYN9jWV9vns6BG1yUs.
Are you sure you want to continue connecting (yes/no)?
```
在第一次使用 SSH 连接 GitLab 的时候会有一个RSA密码指纹确认，输入yes接受即可，以后再连接也不会出现确认提示了。


### .gitignore 规则

```git
#               表示此为注释,将被Git忽略
*.a             表示忽略所有 .a 结尾的文件
!lib.a          表示但lib.a除外
/TODO           表示仅仅忽略项目根目录下的 TODO 文件，不包括 subdir/TODO
build/          表示忽略 build/目录下的所有文件，过滤整个build文件夹；
doc/*.txt       表示会忽略doc/notes.txt但不包括 doc/server/arch.txt
 
bin/:           表示忽略当前路径下的bin文件夹，该文件夹下的所有内容都会被忽略，不忽略 bin 文件
/bin:           表示忽略根目录下的bin文件
/*.c:           表示忽略cat.c，不忽略 build/cat.c
debug/*.obj:    表示忽略debug/io.obj，不忽略 debug/common/io.obj和tools/debug/io.obj
**/foo:         表示忽略/foo,a/foo,a/b/foo等
a/**/b:         表示忽略a/b, a/x/b,a/x/y/b等
!/bin/run.sh    表示不忽略bin目录下的run.sh文件
*.log:          表示忽略所有 .log 文件
config.php:     表示忽略当前路径的 config.php 文件
 
/mtk/           表示过滤整个文件夹
*.zip           表示过滤所有.zip文件
/mtk/do.c       表示过滤某个具体文件
 
被过滤掉的文件就不会出现在git仓库中（gitlab或github）了，当然本地库中还有，只是push的时候不会上传。
 
需要注意的是，gitignore还可以指定要将哪些文件添加到版本管理中，如下：
!*.zip
!/mtk/one.txt
 
唯一的区别就是规则开头多了一个感叹号，Git会将满足这类规则的文件添加到版本管理中。为什么要有两种规则呢？
想象一个场景：假如我们只需要管理/mtk/目录中的one.txt文件，这个目录中的其他文件都不需要管理，那么.gitignore规则应写为：：
/mtk/*
!/mtk/one.txt
 
假设我们只有过滤规则，而没有添加规则，那么我们就需要把/mtk/目录下除了one.txt以外的所有文件都写出来！
注意上面的/mtk/*不能写为/mtk/，否则父目录被前面的规则排除掉了，one.txt文件虽然加了!过滤规则，也不会生效！
 
----------------------------------------------------------------------------------
还有一些规则如下：
fd1/*
说明：忽略目录 fd1 下的全部内容；注意，不管是根目录下的 /fd1/ 目录，还是某个子目录 /child/fd1/ 目录，都会被忽略；
 
/fd1/*
说明：忽略根目录下的 /fd1/ 目录的全部内容；
 
/*
!.gitignore
!/fw/ 
/fw/*
!/fw/bin/
!/fw/sf/
说明：忽略全部内容，但是不忽略 .gitignore 文件、根目录下的 /fw/bin/ 和 /fw/sf/ 目录；注意要先对bin/的父目录使用!规则，使其不被排除。
```


### git子模块

* 添加子模块
```git
$ git submodule add https://github.com/ihtcboy/submodule.git submodule
```

* 查看子模块
```git
$ git submodule (status)
```

* 更新项目内子模块到最新版本
```git
$ git submodule update
```

* 更新子模块为远程项目的最新版本
```
$ git submodule update --remote
```

* 克隆包含子模块的项目
```shell
//初始化子模块
$ git submodule init

//更新子模块
$ git submodule update
```

* 递归克隆整个项目
* 
```git
git clone https://github.com/ihtcboy/submodule.git submodule --recursive 
```

* 删除子模块

删除子模块文件夹：
```git
$ git rm --cached submodule
$ rm -rf submodule
```

删除.gitmodules文件中相关子模块信息：
```
[submodule "submodule"]
  path = submodule
  url = https://github.com/ihtcboy/submodule.git
```

删除.git/config中的相关子模块信息：
```
[submodule "submodule"]：
  url = https://github.com/ihtcboy/submodule.git
```

删除.git文件夹中的相关子模块文件：
```git
$ rm -rf .git/modules/submodule
```

#### fork后如何同步源的新更新内容？


```git
1. 首先将别人的仓库添加到你的上游远程，通常命名为upstream.
 
git remote add upstream url(表示原作者仓库)
 
 
2. 用 git remote -v 可以看到一个origin是自己的，另外一个upstream原作者。
 
 
1. 更新代码：
git fetch upstream //去拉去原作者的仓库更新
git checkout master //切换到自己的master
git merge upstream/master //merge或者rebase到你的master
```