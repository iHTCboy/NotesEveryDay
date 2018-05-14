### Github 上传超过100M的大文件
```
Homebrew: brew install git-lfs

git lfs install

git lfs track "*.psd"

git add .gitattributes
```

There is no step three. Just commit and push to GitHub as you normally would.

```
git add file.psd
git commit -m "Add design file"
git push origin master
```
- [Git Large File Storage](https://git-lfs.github.com)

### Git 默认不区分文件名大小写的坑

配置 Git 使其对文件名大小写敏感

```
git config core.ignorecase false
```

本地大小写敏感，但是远端并不是，会造成远端有大写和小定的2个文件，详见：

- [解决 Git 默认不区分文件名大小写的问题 - 简书](https://www.jianshu.com/p/df0b0e8bcf9b)


