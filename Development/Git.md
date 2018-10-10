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


### 一步提交git变更

```git
function lazygit() {
    git add .
    git commit -a -m "$1"
    git push
}
```
- [git add, commit and push commands in one? - Stack Overflow](https://stackoverflow.com/questions/19595067/git-add-commit-and-push-commands-in-one)