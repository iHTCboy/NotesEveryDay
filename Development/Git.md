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
