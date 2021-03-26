### SQL (Structured Query Language，结构化查询语言)

#### ACID

> ACID，是指数据库管理系统在写入或更新资料的过程中，为保证事务是正确可靠的，所必须具备的四个特性：原子性、一致性、隔离性、持久性。 在数据库系统中，一个事务是指：由一系列数据库操作组成的一个完整的逻辑过程。 [维基百科](https://zh.wikipedia.org/wiki/ACID)

例如银行转帐，从原账户扣除金额，以及向目标账户添加金额，这两个数据库操作的总和，构成一个完整的逻辑过程，不可拆分。这个过程被称为一个事务，具有ACID特性。

* **Atomicity**（原子性）：一个事务（transaction）中的所有操作，或者全部完成，或者全部不完成，不会结束在中间某个环节。事务在执行过程中发生错误，会被回滚（Rollback）到事务开始前的状态，就像这个事务从来没有执行过一样。即，事务不可分割、不可约简。
* **Consistency**（一致性）：在事务开始之前和事务结束以后，数据库的完整性没有被破坏。这表示写入的资料必须完全符合所有的预设约束、触发器、级联回滚等。
* **Isolation**（隔离性）：数据库允许多个并发事务同时对其数据进行读写和修改的能力，隔离性可以防止多个事务并发执行时由于交叉执行而导致数据的不一致。事务隔离分为不同级别，包括未提交读（Read uncommitted）、提交读（read committed）、可重复读（repeatable read）和串行化（Serializable）。
* **Durability**（持久性）：事务处理结束后，对数据的修改就是永久的，即便系统故障也不会丢失。


#### 什么是WAL？

> "In computer science, **Write-ahead logging** (WAL) is a family of techniques for providing atomicity and durability (two of the ACID properties) in database systems." —— [维基百科](https://zh.wikipedia.org/wiki/预写式日志)
> 在计算机领域，WAL（Write-ahead logging，预写式日志）是数据库系统提供原子性和持久化的一系列技术。

[维基百科](https://zh.wikipedia.org/wiki/预写式日志)：在计算机科学中，预写式日志是关系数据库系统中用于提供原子性和持久性的一系列技术。在使用WAL的系统中，所有的修改在提交之前都要先写入log文件中。 log文件中通常包括redo和undo信息。这样做的目的可以通过一个例子来说明，假设一个程序在执行某些操作的过程中机器掉电了。**那么在机器掉电重启之后系统需要知道操作是成功了**，还是只有部分成功或者是失败了（为了恢复状态）。如果使用了WAL，程序就可以检查log文件，并对突然掉电时计划执行的操作内容跟实际上执行的操作内容进行比较。在这个比较的基础上，程序就可以决定是撤销已做的操作还是继续完成已做的操作，或者是保持原样。

* `redo log` 称为重做日志，每当有操作时，在数据变更之前将操作写入redo log，这样当发生掉电之类的情况时系统可以在重启后继续操作。
* `undo log` 称为撤销日志，当一些变更执行到一半无法完成时，可以根据撤销日志恢复到变更之间的状态。


### MySQL
> MySQL 原本是一个开放源码的关系数据库管理系统，原开发者为瑞典的MySQL AB公司，该公司于2008年被Sun收购。2009年，甲骨文公司收购Sun公司，MySQL成为Oracle旗下产品。 [维基百科](https://zh.wikipedia.org/wiki/MySQL)

- [MySQL Home Page](https://www.mysql.com/)


#### macOS 终端执行 MySQL 命令时，提示 command not found
由于 macOS 默认只能识别处在 `/usr/local/bin` 路径中的mysql命令。而安装的 mysql 在 macOS 安装的mysql的命令路径是在 `/usr/local/mysql/bin/` 里面（可以使用命令查看某个命令所在路径，例如：`which mysql`），所以 mysql 相关的命令，默认只能在 `/usr/local/mysql/bin/` 路径下生效。

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

> SQLite 是遵守ACID的关系数据库管理系统，它包含在一个相对小的C程序库中。与许多其它数据库管理系统不同，SQLite不是一个客户端/服务器结构的数据库引擎，而是被集成在用户程序中。 SQLite遵守ACID，实现了大多数SQL标准。它使用动态的、弱类型的SQL语法。 [维基百科](https://zh.wikipedia.org/wiki/SQLite)

* [SQLite Home Page](https://sqlite.org/index.html)
* [漫谈 SQLite | 张不坏的博客](https://zhangbuhuai.com/post/sqlite.html)


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



### Redis

> Redis是一个使用ANSI C编写的开源、支持网络、基于内存、分布式、可选持久性的键值对存储数据库。从2015年6月开始，Redis的开发由Redis Labs赞助，而2013年5月至2015年6月期间，其开发由Pivotal赞助。在2013年5月之前，其开发由VMware赞助。 [维基百科](https://zh.wikipedia.org/wiki/Redis)

- [Redis Home Page](https://redis.io/)

#### mac上安装使用 Redis
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


