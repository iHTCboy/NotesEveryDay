
### mysql


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


