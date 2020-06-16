### Cydia

#### “AFC2”补丁
> 如果你需要在电脑端访问您设备的根文件系统，则需要安装afc2补丁，对于iOS 7.1 以下越狱设备， 请安装Afc2add补丁，对于iOS 7.1 ~iOS 10.3.3 的越狱设备， 请安装Apple File Conduit"2"补丁。


* [越狱设备如何安装“AFC2”补丁？_越狱教程_爱思助手](https://www.i4.cn/news_detail_1623.html)


### OpenSSH

#### 连接
```
ssh root@[insert IP Address]
```

默认密码：`alpine`

```bash
iPhone-HTC:~ root# passwd
Changing password for root.
New password:
```

```bash
iPhone-HTC:~ root# passwd mobile
Changing password for mobile.
New password:
```

* [OpenSSH · Cydia](https://cydia.saurik.com/openssh.html)
* [Password · Cydia](https://cydia.saurik.com/password.html)

#### 忘记密码

iPhone 的账号密码存储目录：

```bash
/private/etc/master.password
```

对应 root 和 mobile 账号的密码：

```
root:xxxxxxxxxxxxx:0:0::0:0:System Administrator:/var/root:/bin/sh
mobile:xxxxxxxxxxxxx:501:501::0:0:Mobile User:/var/mobile:/bin/sh
```

如果想改回 `alpine`：`smx7MYTQIi2M`，即：
```
root:/smx7MYTQIi2M:0:0::0:0:System Administrator:/var/root:/bin/sh
mobile:/smx7MYTQIi2M:501:501::0:0:Mobile User:/var/mobile:/bin/sh
```

如果想改密码为 `111111` 就可以用 `baGYjKhff2jlo`。

* [iOS ssh密码忘记解决办法 - 简书](https://www.jianshu.com/p/10c3e7f7acef)
* [iOS 越狱机重置ssh密码 - 知乎](https://zhuanlan.zhihu.com/p/60709753)



### 破解

#### 绕过 Apple ID

* [忘记 Apple ID 后如何绕过 iOS 激活锁？_越狱教程_爱思助手](https://www.i4.cn/news_detail_39267.html)