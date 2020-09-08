[TOC]

### Cydia
Cydia可以理解为越狱之后的AppStore，在Cydia里面可以通过添加源的方式，来获得软件、插件、补丁、皮肤、字体等等。

而Cydia中提供的大部分内容，都是不被苹果官方商店所承认的。而Cydia中也存在收费与免费软件一说。总之我们可以简单理解为，专为越狱用户提供的越狱商店。
 
 
 
#### “AFC2”补丁
> 如果你需要在电脑端访问您设备的根文件系统，则需要安装afc2补丁，对于iOS 7.1 以下越狱设备， 请安装Afc2add补丁，对于iOS 7.1 ~iOS 10.3.3 的越狱设备， 请安装Apple File Conduit"2"补丁。


* [越狱设备如何安装“AFC2”补丁？_越狱教程_爱思助手](https://www.i4.cn/news_detail_1623.html)


#### Cydia 软件源及插件
* 雷锋源：http://apt.abcydia.com
* 蚂蚁源：http://apt.cydia.love
* A Sileo蜜蜂源™：https://apt.cydiami.com/
* 嗨客中文源（汉化包大部分出自他手）：http://apt.hackcn.net
* Acreson’s：https://repo.acreson.cn/
* 小苹果：http://apt.cydiabc.top/
* 贴吧：http://apt.cydiaba.cn/
* Netskao：http://repo.netskao.com/


* https://cydia.akemi.ai/ （Appsync Unified插件官方源）
* https://ib-soft.net/cydia/beta/（iCleaner Pro官方源，此地址为beta版本发布源，目前7.8.0~beta1已经正式支持iOS13）
* https://ryleyangus.com/repo/ （Liberity Lite越狱检测屏蔽插件官方源）
* http://xsf1re.github.io/repo/ (FlyJB 越狱检测屏蔽插件官方源)
* https://repo.hackyouriphone.org （国外知名插件破解网站，一些收费插件可以在这找破解版）
* http://pulandres.me/repo/ （P佬源，同为国外知名破解资源集散地）
* http://apt.cydiabc.top/ （国内小苹果源，未爆出过安全问题，使用放心）
* HackYouriPhone http://repo.hackyouriphone.org
* kiiimo http://cydia.kiiimo.org/

#### Flex
Flex是John Coates的作品，从推出就被大家视为越狱iOS必装插件之一，至今已经更新到Flex3，支持至最新的系统。通过此插件，你无需太多编程知识，也可以很容易地“操作”系统或App函数，以此来达到修改UI界面和程序功能的目的。

在Flex中你几乎可以修改任何app和自带的系统软件。比如可以修改微信步数、系统UI颜色、修改游戏金币等等。不过免费版的Flex每天只能下载他人分享的脚本两次。

#### AppSync Unified
安装无签名软件，装修改版软件必备神器。


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


### 外挂

