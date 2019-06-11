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

### git 撤销本地已提交(commit)但没有提交(push)的更改

如果你只想为之前的commit增加更多的改动，或者改变之前的提交信息，你应该使用：
```git
git reset --soft HEAD~
```
会将你的改动保留在暂存区内。或类似

```git
git rest HEAD~
```

销毁了一个commit，但最后发现仍然需要它？

```git
git reflog
```

[](https://www.jianshu.com/p/9f11d398111f)

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


```git
git cherry-pick <commit id>:单独合并一个提交
git cherry-pick  -x <commit id>：同上，不同点：保留原提交者信息。

Git从1.7.2版本开始支持批量cherry-pick，就是一次可以cherry-pick一个区间的commit。

git cherry-pick <start-commit-id>..<end-commit-id>
git cherry-pick <start-commit-id>^..<end-commit-id>
```

- [git cherry-pick 使用指南 - 简书](https://www.jianshu.com/p/08c3f1804b36)