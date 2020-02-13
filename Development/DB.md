
### mysql

#### macOS 终端执行 mysql 命令时，提示 command not found
由于 macOS 默认只能识别处在 `/usr/local/bin` 路径中的mysql命令。而安装的 mysql 在 macOS 安装的mysql的命令路径是在 `/usr/local/mysql/bin/` 里面，所以 mysql 相关的命令，默认只能在 `/usr/local/mysql/bin/` 路径下生效。

如果直接使用连接mysql数据库的命令 `mysql -u root -p`，就会报： `mysql: command not found`的错误；或者想直接使用导出数据库的命令 `mysqldump xxx`的话，就会报`mysqldump: command not found` 的错误。

- 解决：

使用 `ln -fs` 软链接命令，将连接mysql数据库的路径映射到 `/usr/local/bin` 中：

```shell
sudo ln -fs /usr/local/mysql/bin/mysql /usr/local/bin
```


```shell
sudo ln -fs /usr/local/mysql/bin/mysqldump /usr/local/bin
```

当然，如果不想全局链接，`/usr/local/mysql/bin/mysql -u root -p` 直接执行也可以，就是麻烦吧了。

- [使用ln -fs命令，解决mac终端命令行 操作mysql时，提示command not found的问题 - 简书](https://www.jianshu.com/p/8808d7f06ad0)

### SQLite

#### 修改 sqlite 表的某个列名
```
ALTER TABLE "MyTable" RENAME COLUMN "OldColumn" TO "NewColumn";
```

- [How do I rename a column in a SQLite database table? - Stack Overflow](https://stackoverflow.com/questions/805363/how-do-i-rename-a-column-in-a-sqlite-database-table)


#### 常用语法

1.修改表名称
```
ALTER TABLE 旧表名 RENAME TO 新表名 
```

2.添加字段
```
ALTER TABLE 表名 ADD COLUMN 列名 数据类型 
```

3.查询表结构
```
PRAGMA TABLE_INFO (表名)
```

4.更新列值
```
UPDATE "表名" SET "列名" = "新值";
```

5.设置类型


```
VARCHAR(500);

// 没有Bool值，用 INT 0 和 表示
INTEGER DEFAULT 0
```

- [Sqlite的使用 - 简书](https://www.jianshu.com/p/f1b60943dfb7)



### redis
#### mac上安装使用redis
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


