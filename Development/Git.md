### Git 默认不区分文件名大小写的坑

配置 Git 使其对文件名大小写敏感
```
git config core.ignorecase false
```
本地大小写敏感，但是远端并不是，会造成远端有大写和小定的2个文件，详见：

- [解决 Git 默认不区分文件名大小写的问题 - 简书](https://www.jianshu.com/p/df0b0e8bcf9b)


