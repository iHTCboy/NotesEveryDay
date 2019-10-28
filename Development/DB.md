### mac上安装使用redis
通过homebrew安装redis:
```
$ brew install redis
``` 

redis默认的配置文件redis.conf位于：
```
/usr/local/etc
```

通过以下命令启动redis：

```
$ redis-server /usr/local/etc/redis.conf
```

检测redis服务器是否启动：

```
$ redis-cli ping

pong #说明服务器运作正常。
```

关闭redis：

* 方法1
```
$ redis-cli ping
Could not connect to Redis at 127.0.0.1:6379: Connection refused
#说明确实已关闭
```

* 方法2
```
$ redis-cli shutdown
```

### mysql

