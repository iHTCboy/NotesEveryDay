[TOC]

### 越狱

**越狱工具：**

- [checkra1n](https://checkra.in/)：iOS 12.3-13.5
- [unc0ver](https://unc0ver.dev/)： iOS 11.0 - 13.5
- [Chimera](https://chimera.sh/): iOS 12 — 12.2 and 12.4

* [iOS系统设备越狱](https://yueyu.cydiami.com/)


### Cydia
Cydia可以理解为越狱之后的AppStore，在Cydia里面可以通过添加源的方式，来获得软件、插件、补丁、皮肤、字体等等。

而Cydia中提供的大部分内容，都是不被苹果官方商店所承认的。而Cydia中也存在收费与免费软件一说。总之我们可以简单理解为，专为越狱用户提供的越狱商店。
 
 
 
#### “AFC2”补丁
> 如果你需要在电脑端访问您设备的根文件系统，则需要安装afc2补丁，对于iOS 7.1 以下越狱设备， 请安装Afc2add补丁，对于iOS 7.1 ~iOS 10.3.3 的越狱设备， 请安装Apple File Conduit"2"补丁。


* [越狱设备如何安装“AFC2”补丁？_越狱教程_爱思助手](https://www.i4.cn/news_detail_1623.html)


#### Cydia 软件源及插件

| 名字 | 源地址  | 备注 |
|---|---|---|
| 雷锋源  | http://apt.abcydia.com |   |
| 蚂蚁源  | http://apt.cydia.love  |   |
| A Sileo 蜜蜂源™  |  https://apt.cydiami.com |   |
| 嗨客中文源  | http://apt.hackcn.net  | （汉化包大部分出自他手）  |
| Acreson’s | https://repo.acreson.cn |   |
| 小苹果 | http://apt.cydiabc.top  |   |
| 贴吧  | http://apt.cydiaba.cn  |   |
| Netskao  | http://repo.netskao.com |   |
| Appsync Unified 插件官方源  | https://cydia.akemi.ai/  |   |
| iCleaner Pro官方源  | https://ib-soft.net/cydia/beta/  | 此地址为beta版本发布源，目前7.8.0~beta1 已经正式支持 iOS13  |
| Liberity Lite | https://ryleyangus.com/repo/  | Liberity Lite越狱检测屏蔽插件官方源  |
| FlyJB  | http://xsf1re.github.io/repo/  | FlyJB 越狱检测屏蔽插件官方源  |
| 国外知名插件破解网站  | https://repo.hackyouriphone.org  |  国外知名插件破解网站，一些收费插件可以在这找破解版 |
| P佬源  | http://pulandres.me/repo/  |  P佬源，同为国外知名破解资源集散地 |
| 国内小苹果源  | http://apt.cydiabc.top/  | 国内小苹果源，未爆出过安全问题  |
| HackYouriPhone  | http://repo.hackyouriphone.org  |   |
| kiiimo  | http://cydia.kiiimo.org/  |   |
| frida  | https://build.frida.re  | Frida 砸壳应用  |
| CrackerXI  | http://apt.wxhbts.com/  | CrackerXI App脱壳工具  |


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

更改 root 账号的密码，就终端输入 `passwd` ：
```bash
iPhone-HTC:~ root# passwd
Changing password for root.
New password:
```

更改 mobile 账号的密码，就终端输入 `passwd mobile` ：
```bash
iPhone-HTC:~ root# passwd mobile
Changing password for mobile.
New password:
```

* [OpenSSH · Cydia](https://cydia.saurik.com/openssh.html)
* [Password · Cydia](https://cydia.saurik.com/password.html)

#### 忘记密码

iOS 的账号密码存储目录：

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

注：可以在电脑上通过助手工具修改，或者直接用越狱的文件管理app 打开 `/private/etc/master.password` 文件直接修改。

* [iOS ssh密码忘记解决办法 - 简书](https://www.jianshu.com/p/10c3e7f7acef)
* [iOS 越狱机重置ssh密码 - 知乎](https://zhuanlan.zhihu.com/p/60709753)



### 破解

#### 绕过 Apple ID

* [忘记 Apple ID 后如何绕过 iOS 激活锁？_越狱教程_爱思助手](https://www.i4.cn/news_detail_39267.html)

#### Cydia Substrate
Cydia Substrate有3部分组成：
* MobileHooker
* MobileLoader
* safe mode

**MobileHooker**

MobileHooker用来替换系统函数，这个过程也叫Hooking。有如下的API可以使用：

```objc
IMP MSHookMessage(Class class, SEL selector, IMP replacement, const char* prefix); // prefix should be NULL.

void MSHookMessageEx(Class class, SEL selector, IMP replacement, IMP *result);

void MSHookFunction(void* function, void* replacement, void** p_original);
```

* MSHookMessageEx 用来替换 Objective-C的函数
* MSHookFunction 用来替换C/C++函数。

具体用法参见:
* [Cydia Substrate - iPhone Development Wiki](http://iphonedevwiki.net/index.php/Cydia_Substrate)
* [MSHookFunction | Cydia Substrate](http://www.cydiasubstrate.com/api/c/MSHookFunction/)
* [Cydia Substrate](http://www.cydiasubstrate.com/id/264d6581-a762-4343-9605-729ef12ff0af/)



**MobileLoader**

MobileLoader 把第3方补丁程序加载进入运行的程序中。 MobileLoader 首先会通过`DYLD_INSERT_LIBRARIES` 把自己加载进入目标程序，然后它会在 `/Library/MobileSubstrate/DynamicLibraries/` 中找到需要加载的动态链接库并加载它们，控制是否加载到目标程序，是通过一个plist文件来控制的。如果需要被加载的动态库的名称叫做foo.dylib，那么这个plist文件就叫做 foo.plist，这个里面有一个字段叫做 filter，里面写明需要hook进的目标程序的 bundle id。

比如，如果只想要foo.dylib加载进入SpringBoard，那么对应的plist文件中的filter就应该这样写：

```xml
Filter = {
  Bundles = (com.apple.springboard);
};”
```

* 示例：[Simple code injection using DYLD_INSERT_LIBRARIES](https://blog.timac.org/2012/1218-simple-code-injection-using-dyld_insert_libraries/)

**Safe mode**

当编写的扩展导致 SpringBoard crash 的时候，MobileLoader会捕获这个异常，然后让设备进入安全模式。在安全模式中，所有的第3方扩展都会被禁用。
注：这些 signal 会触发安全模式： `SIGTRAP` `SIGABRT` `SIGILL` `SIGBUS` `SIGSEGV` `SIGSYS`


### 外挂

