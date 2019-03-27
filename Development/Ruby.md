[TOC]

### 入门

[更容易入门的Rails 教程](https://legacy.gitbook.com/book/sg552/happy_book_rails/details)


#### gem install cocoapods

error：

```bash
ERROR:  Could not find a valid gem 'cocoapods' (>= 0), here is why:
          Unable to download data from https://gems.ruby-china.org/ - bad response Not Found 404 (https://gems.ruby-china.org/specs.4.8.gz)
```

> 因域名备案问题，.org 域名无法继续提供 RubyGems 镜像服务，我们提供 .com 代替 .org 的域名，其他一切不变！！
> 
> 详情访问 https://gems.ruby-china.com


更新方法：

```bash
gem sources --add https://gems.ruby-china.com/ --remove https://rubygems.org/ --remove https://gems.ruby-china.org/
```

查看本地镜像：
```
gem sources -l  
```