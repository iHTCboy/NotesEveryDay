[TOC]

## RE（Reverse Engineering，逆向工程）
逆向工程，原名Reverse Engineering，简称RE。

> 维基百科：
> 逆向工程，又称反向工程，是一种技术过程，即对一项目标产品进行逆向分析及研究，从而演绎并得出该产品的处理流程、组织结构、功能性能规格等设计要素，以制作出功能相近，但又不完全一样的产品。逆向工程源于商业及军事领域中的硬件分析。其主要目的是，在无法轻易获得必要的生产信息下，直接从成品的分析，推导产品的设计原理。

* [逆向工程 - 维基百科，自由的百科全书](https://zh.wikipedia.org/wiki/%E9%80%86%E5%90%91%E5%B7%A5%E7%A8%8B)
* [漫谈逆向工程 - PansLabyrinth](https://evilpan.com/2020/03/08/reverse-engineering/)



### 越狱（Jailbreak）
**越狱不等于盗版安装APP**
越狱是要获得设备的完全控制权，拿到所有文件的最高管理权限。在美国越狱苹果设备是合法的，其原因是承认用户对设备拥有完全的所有权。 


**越狱工具：**

- [unc0ver](https://unc0ver.dev/)： iOS 11.0 - 14.8
- [checkra1n](https://checkra.in/)：iOS 12.0 - 13.7 and 14.0
- [Chimera](https://chimera.sh/): iOS 12 - 12.5.5

查看支持的系统版本：
* [Can I Jailbreak? - Home](https://canijailbreak.com/)
* [iOS系统设备越狱](https://yueyu.cydiami.com/)


#### 越狱原理

* [iPhone 史诗级漏洞 checkm8 攻击原理浅析](https://paper.seebug.org/1065/)
* [Technical analysis of the checkm8 exploit / Digital Security / Habr](https://m.habr.com/en/company/dsec/blog/472762/)

#### 越狱的保持（Jailbreak Persistence） 
依赖越狱使用的漏洞，越狱的效果可能长期的，也可能在设备关机再开启后消失。为了描述两种不同的越狱，越狱社区把这两种方式叫做 完美越狱（`tethered jailbreak`）和非完美越狱（`untethered jailbreak`）。 

##### 1、非完美越狱（Tethered Jailbreaks） 
非完美越狱是设备重启后就消失的越狱。越狱后的设备每次重启后需要某种方式的重新越狱。通常意味着每次关机再重新开机时需要重新连接到电脑上。由于这个过程中需要USB线缆连接，这就是tethered的意思。这个词tethered也用于不需要USB连接，但需要访问特定网站或执行特定应用程序的重新越狱，如果漏洞是某些提权代码，一个非完美越狱能只由单个漏洞组成。一个例子是limera1n的bootrom漏洞，被目前的大部分iOS4和iOS5越狱使用。另一个例子是iOS的USB内核驱动程序的漏洞。然而，目前没有类似的公开漏洞。 

如果没有类似的漏洞可用，进入设备的初始入口可以通过一个应用程序的漏洞来获得很少的权限，如MobileSafari浏览器。然而，单独的这样一个漏洞不能认为是越狱，因为没有附加的内核漏洞，不能禁止所有的安全特性。 所以一个非完美越狱由一个提权代码漏洞组成，或一个非提权代码漏洞结合其他权限提升漏洞。 

##### 2、完美越狱（Untethered Jailbreaks） 
完美越狱是利用一个设备重启后不会消失的持久漏洞来完成的，完美（untethered）因为设备每次重新启动后不需要重新越狱，所以它是更好的越狱方式。 
由于完美越狱需要启动环节的非常特殊地方的漏洞，自然更难完成。过去由于在设备硬件里发现了非常强有力的漏洞，允许在设备的启动环节的早期进行破解，使完美越狱可能实现。 但这些漏洞现在已经消失了，而同样品质的漏洞没有出现。 

由于以上原因，完美越狱通常由某种非完美越狱结合附加的允许在设备上保持的漏洞组成。利用开始的非完美越狱来在设备的根目录文件系统上安装附加漏洞。由于首先专有未签名代码必须执行，其次权限要提升以便能对内核打补丁，所以至少需要2个附加的漏洞。 

#### 漏洞类型(Exploit Type) 
漏洞的存在位置影响你对设备的存取级别。一些允许低级别的硬件存取。另一些受限于沙盒内的许可权限。 

##### 1、Bootrom级别 
从越狱者的角度看，Bootrom级别的漏洞是最有力的。bootrom在iPhone的硬件内部，它的漏洞不能通过软件更新推送来修复。相反，只能在下一代的硬件版本里修复。在存在limera1n漏洞的情况下，苹果没有发布iPad1或iPhone4的新产品，直到A5处理器的设备，iPad2和iPhone4S发布前，这个漏洞长期存在并为人所知。 
Bootrom级别的漏洞不能修复，并且允许对整个启动环节的每个部分进行替换或打补丁（包括内核的启动参数），是最有力的漏洞。由于漏洞在启动环节发生的很早，而且漏洞Payload拥有对硬件的全部读取权限。 如它可以利用AES硬件引擎的GID密码来解密IMG3文件，而IMG3文件允许解密新的iOS更新。 

##### 2、iBoot级别 
当iBoot里的漏洞达到能提供的特性时，几乎和bootrom里的漏洞一样有力。这些漏洞效果下降是由于iBoot没有固化入硬件，能通过简单的软件升级来修复。 
除了这点，iBoot漏洞在启动环节任然很早，能提供给内核启动参数，对内核打补丁，或对硬件直接进行GID密码的AES操作。 

##### 3、Userland级别 
用户层面级别的越狱是完全基于用户层面进程的漏洞的，像JBME3(http://jailbreakme.com)。这些进程如果是系统进程，就拥有超级用户root权限，如果是用户应用程序，就拥有稍低级别的如mobile用户的权限。不管哪种情况，越狱设备至少需要2个漏洞。第一个漏洞用来完成专有代码执行，第二个漏洞用来使内核的安全措施失效，进行权限提升。 
在以前的iOS版本里，只要破解的进程以root超级用户权限运行，代码签名功能就会失效。现在，内核内存崩溃或执行内核代码需要禁止强制代码签名。 

和bootrom、iBoot级别漏洞相比，用户层面的漏洞更弱一些。因为即使内核代码执行已经可能了，如GID密码的AES引擎的硬件特性依然不能读取。所以苹果公司对用户层面的漏洞更容易修补；并由于远程用户层面的漏洞能用于iPhone恶意软件的注入，所以苹果公司对这些漏洞经常很快进行修补。

* [iOS越狱原理详解 - CSDN博客](https://blog.csdn.net/IDOshi201109/article/details/51008336)

### Cydia
Cydia可以理解为越狱之后的AppStore，在Cydia里面可以通过添加源的方式，来获得软件、插件、补丁、皮肤、字体等等。

而Cydia中提供的大部分内容，都是不被苹果官方商店所承认的。而Cydia中也存在收费与免费软件一说。总之我们可以简单理解为，专为越狱用户提供的越狱商店。
 
Cydia 之父 Jay Freeman（Saurik），起初，Cydia 只是 iPhone OS 1.1 上 Installer.app 的一个开源选择，但在 2008 年 7 月带有 App Store 的 iPhone OS 2.0 推出后，它一跃成为最流行的软件包管理器。

2010 年 9 月，Saurik 的公司宣布收购 Rock Your Phone，即此前仅次于 Cydia 的包管理器软件 Rock.app 的开发商。自此，Cydia Store 成为越狱设备最大的第三方应用提供商。

2018 年 7月，Electra 团队推出了 Cydia 的最后一个版本：Cydia 1.1.30-2。

**Cydia Store != Cydia**

Cydia Store 指代的仅是后端支付系统，“允许用户从 Cydia 的默认存储库购买付费越狱调整，例如BigBoss，MacCiti和ModMyi。它与 Cydia Installer 不同，Cydia Installer 是用户每天与之交互的Cydia应用程序”。

2018年12月14日，Cydia 之父 Jay Freeman（Saurik）于 Reddit 发帖称，考虑在今年年底全面关闭 Cydia Store。早在2017年11月，Cydia 上的两大软件合作来源 ZodTTD&MacCiti 和 ModMyi 相继宣布关闭，Cydia 三大源仅余 BigBoss 一支。
 
 
#### “AFC2”补丁
> 如果你需要在电脑端访问您设备的根文件系统，则需要安装afc2补丁，对于iOS 7.1 以下越狱设备，请安装Afc2add补丁，对于iOS 7.1 ~iOS 10.3.3 的越狱设备，请安装Apple File Conduit"2"补丁。

* [越狱设备如何安装“AFC2”补丁？_越狱教程_爱思助手](https://www.i4.cn/news_detail_1623.html)


#### Cydia 软件源及插件

| 名字 | 源地址  | 备注 |
|---|---|---|
| 雷锋源  | http://apt.abcydia.com |   |
| 蚂蚁源  | http://apt.cydia.love  |   |
| A Sileo 蜜蜂源™  |  https://apt.cydiami.com |   |
| 嗨客中文源  | http://apt.hackcn.net  | （汉化包大部分出自他手）  |
| Acreson’s | https://repo.acreson.cn |   |
| 小苹果 | http://apt.cydiabc.top  | 国内小苹果源，未爆出过安全问题   |
| 贴吧  | http://apt.cydiaba.cn  |   |
| Netskao  | http://repo.netskao.com |   |
| Appsync Unified 插件官方源  | https://cydia.akemi.ai/  |   |
| iCleaner Pro官方源  | https://ib-soft.net/cydia/beta/  | 此地址为beta版本发布源，目前7.8.0~beta1 已经正式支持 iOS13  |
| Liberity Lite | https://ryleyangus.com/repo/  | Liberity Lite越狱检测屏蔽插件官方源  |
| FlyJB  | http://xsf1re.github.io/repo/  | FlyJB 越狱检测屏蔽插件官方源  |
| 国外知名插件破解网站  | https://repo.hackyouriphone.org  |  国外知名插件破解网站，一些收费插件可以在这找破解版 |
| P佬源  | http://pulandres.me/repo/  |  P佬源，同为国外知名破解资源集散地 |
| HackYouriPhone  | http://repo.hackyouriphone.org  |   |
| kiiimo  | http://cydia.kiiimo.org/  |   |
| frida  | https://build.frida.re  | Frida 砸壳应用  |
| CrackerXI  | http://apt.wxhbts.com/  | CrackerXI App脱壳工具  |
| 按键精灵  | https://apt.mobileanjian.com/  | 按键精灵官方源  |


#### Flex
Flex是John Coates的作品，从推出就被大家视为越狱iOS必装插件之一，至今已经更新到Flex3，支持至最新的系统。通过此插件，你无需太多编程知识，也可以很容易地“操作”系统或App函数，以此来达到修改UI界面和程序功能的目的。

在Flex中你几乎可以修改任何app和自带的系统软件。比如可以修改微信步数、系统UI颜色、修改游戏金币等等。不过免费版的Flex每天只能下载他人分享的脚本两次。

#### AppSync Unified
安装无签名软件，装修改版软件必备神器。

#### adv-cmds
用于执行 ps 命令。ps命令是 process status的缩写，使用ps命令可以列出系统当前的进程。


### OpenSSH
`OpenSSH` 是 `SSH` (Secure Shell) 协议的免费开源的实现。SSH 协议可以用来远程控制或者在计算机之间来传送文件。

* SSH 是一种网络协议，目的是用于计算机之间的加密登录，由芬兰学者设计SSH协议，将登录信息全部加密，成为了互联网安全的一个基本解决方案，目前成为了Linux的标准配置。
* OpenSSH 是一款软件，应用也是非常广泛。

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

#### 免密登录

- [iOS逆向-设备ssh免密登录 | 继刚的博客](https://madordie.github.io/post/reverse-ios-ssh/)


#### 通过USB连接

**usbmuxd**

usbmuxd 是苹果的一个服务，这个服务主要用于在USB协议上实现多路TCP连接，将USB通信抽象为TCP通信。苹果的iTunes、Xcode，都直接或间接地用到了这个服务

##### 方法一
1、通过brew来安装usbmuxd：

```shell
brew install usbmuxd
```

2、端口映射：
把 iPhone 的22端口(即SSH端口)映射到 Mac 的10086端口

```
iproxy 10086 22
```

3、连接Mac本地的10086端口：


```
ssh -p 10086 root@127.0.0.1
```

或者：

```
ssh -p 10086 root@localhost
```

第一次会要求输入密码，出现 `~ root#` 就代表连接成功了

- [mac连接ios设备的方式 | iKiwi](https://wangdetong.github.io/2016/06/21/20160621mac%E8%BF%9E%E6%8E%A5ios%E8%AE%BE%E5%A4%87%E7%9A%84%E6%96%B9%E5%BC%8F/)

##### 方法二
**下载 usbmuxd 1.0.8版本**

> 一定要下载这个 1.0.8 版本，新版本已经不包含这个文件。

在 [usbmuxd - A socket daemon to multiplex connections from and to iOS devices](https://cgit.sukimashita.com/usbmuxd.git/) 下载1.0.8 版本：

- [usbmuxd-1.0.8.tar.gz](https://cgit.sukimashita.com/usbmuxd.git/snapshot/usbmuxd-1.0.8.tar.gz)

解压文件后，有一个 `python-client` 文件夹，可以通过 python 来执行映射：

```
python tcprelay.py -t 22:10086
```

然后就可以 ssh 链接：

```
ssh root@localhost -p 10086
```

- [通过USB连接线ssh到iOS中 - iOSRE](https://iosre.com/t/usb-ssh-ios/193)
- [iOS逆向 | 如何通过usbmuxd实现SSH登录](https://juejin.cn/post/6844904185733840904)
- [对 usbmuxd 的一点研究 · Farlanki](https://reetyo.github.io/2019/04/09/2019-04-09/)
- [使用usbmuxd服务，通过USB连接与PC端、Mac端实现通信，Peertalk的使用 - 简书](https://www.jianshu.com/p/eba133891ec6)


##### 常见错误

使用SSH连接设备时，可能会出现“Host key verification failed.”的提示，是因为之前链接过其它设备导致的，需要删除原来的链接信息。

```
ssh-keygen -f /Users/iHTCboy/.ssh/known_hosts -R 127.0.0.1
``` 

或整个文件删除：

```
rm /Users/iHTCboy/.ssh/known_hosts
```

### 使用scp传输文件
scp 是 `secure copy` 的简写，用于在Linux下进行远程拷贝文件的命令，和它类似的命令有cp，不过cp只是在本机进行拷贝不能跨服务器，而且scp传输是加密的，所以速度稍微慢点。

1. 我们需要获得远程服务器上的某个文件，远程服务器既没有配置ftp服务器，没有开启web服务器，也没有做共享，无法通过常规途径获得文件时，只需要通过scp命令便可轻松的达到目的。
2. 我们需要将本机上的文件上传到远程服务器上，远程服务器没有开启ftp服务器或共享，无法通过常规途径上传是，只需要通过scp命令便可以轻松的达到目的。


#### scp 命令使用示例
从 iOS 复制到 macOS:

```
scp -P10086 root@localhost:/var/mobile/Documents/CrackerXI/xxx.ipa ~/Desktop/
```

> 注：-P 一定要大写字母P，不然就报错 `SSH protocol v.1 is no longer supported` 。

从 macOS 复制到 iOS:

```
scp -P10086 ~/Desktop/xxx.jpg root@localhost:/var/mobile/Documents/
```

**可能有用的几个参数:**

1. `-r`: 复制目录。
2. `-v`: 和大多数 linux 命令中的 -v 意思一样, 用来显示进度。可以用来查看连接，认证，或是配置错误等。
3. `-C`: 使能压缩选项。
4. `-4`: 强行使用 IPV4 地址。
5. `-6`: 强行使用 IPV6 地址。


### 加壳与脱壳
iOS端App在上线之前会由苹果商店进行FairPlayDRM数字版权加密保护（称为“加壳”）。要对应用进行分析，就必须先解密（称为“脱壳”），从而得到原始未加密的二进制文件。

#### 检测是否加壳
用`otool`可以看到二进制文件的信息里有一个`cryptid`字段，`cryptid=1`表示**已加壳**，`cryptid=0` 表示**未加壳**。

```
otool -l MachO | grep crypt
```

方法2：
用查看 MachO 文件格式的软件打开。在“Load Commands”节点，找到“LC_ENCRYPTION_INFO_64” ，可以看到 “Crypt ID” 的值内容判断。

#### 脱壳工具
脱壳原理：从内存中已解密的数据dump。

1. CrackerXI：一款全自动脱壳工具，傻瓜式App，支持 iOS 11～iOS 14+，添加 http://cydia.iphonecake.com/ 源或者Cydia搜索名称来下载。
2. [Frida-ios-dump](https://github.com/AloneMonkey/frida-ios-dump)：基于[Frida](http://www.frida.re/)（一个跨平台的轻量级Hook框架）提供的强大功能，通过注入JS实现内存dump，然后利用Python自动复制到macOS生成最终的ipa文件。
3. [Clutch](https://github.com/KJCracks/Clutch)：一款全自动脱壳工具，其原理是把应用运行时的内存数据按照一定格式导出，并重新打包为ipa文件。
4. [dumpdecrypted](https://github.com/stefanesser/dumpdecrypted)：开源的，需要先编译、签名，再将其复制到iOS设备中。但非常灵活，效果也很不错。
5. [bfinject](https://github.com/BishopFox/bfinject)：支持iOS 11～iOS 11.4.1。

### 分析工具

1. [class-dump](https://github.com/nygard/class-dump)：一个命令行工具，它利用Objective-C语言的运行时特性将二进制文件中的类、方法及属性等信息导出为头文件。
2. [Reveal](https://github.com/zidaneno5/Reveal2Loader)：一款强大的UI调试工具，可以调试iOS应用和tvOS应用。它可以在运行时查看App的界面层级关系，还可以实时修改程序界面，不用重新运行程序就可以看到修改之后的效果，免去了每次修改代码后又重新启动的过程。逆向工程里面通常用Reveal来快速定位感兴趣的控件，进而找到控制器，再用Cycript进行事件分析。
3. [Cycript](http://www.cycript.org/)：由Cydia创始人Saurik推出的一款脚本语言，它混合了Objective-C与JavaScript语法解释器，能够探测和修改运行中的应用程序。Cycript主要用于注入目标进程来实现运行时调试，它的优点是重启程序后所有的修改都会失效，对原生程序或代码完全无副作用。越狱环境下，直接在Cydia中搜索“Cycript”安装即可。
4. [FLEXible](https://github.com/FLEXTool/FLEX)：FLEX(Flipboard Explorer)是一个iOS应用的内部调试工具。当它加载时，会向目标程序上方添加一个悬浮的工具栏，通过这个工具栏，可以查看和修改视图的层次结构、动态修改类的属性、动态调用实例和方法、动态查看类和框架以及动态修改UI等。与其他调试工具不同，FLEX完全在应用程序内部运行，因此不需要连接到LLDB、Xcode或其他远程调试器，也不需要太多编程知识，仅需手动点几下就能查看很多细节，是一款非常强大的分析工具。FLEXible 是对FLEX的封装，支持iOS 8+ 以上，只需要在Cydia中搜索FLEXible插件即可安装。
5. [Frida](https://frida.re)：一个跨平台的轻量级Hook框架，支持所有主流操作系统，它可以帮助逆向研究人员对指定的进程进行分析。它主要提供了精简的Python接口和功能丰富的JS接口，除了使用自身的控制台交互以外，还可以利用Python将JS脚本库注入目标进程。使用Frida可以获取进程详细信息、拦截和调用指定函数、注入代码、修改参数、从iOS应用程序中dump类和类方法信息等。Frida源代码托管在[GitHub](https://github.com/frida)。



#### Reveal

Cydia 安装插件 Reveal2Loader，支持 iOS 14+。


* [Reveal2Loader · Cydia](http://cydia.saurik.com/package/com.zidaneno5.reveal2loader/)
* [GitHub - zidaneno5/Reveal2Loader](https://github.com/zidaneno5/reveal2loader)


但是链接到 Mac 调试时，会提示：

 ```
 The operation couldn’t be completed. The app is link against an older version of the Reveal library. You may need to update the Reveal library in your app.
 ```

说明当前 macOS Reveal 的 `RevealServer.framework` 与手机上的 `RevealServer.framework` 版本不相同，需要更新手机的 `RevealServer.framework` 才能正常通讯。

**解决办法：**

用 macOS Reveal 中的  RevealServer.framework 替换 `/Library/Frameworks` 目录下的 RevealServer.framework。

> 需要注意的是 Reveal v33 使用的是 `RevealServer.xcframework`，对应的 iOS 目录是：`~/Library/Application\ Support/Reveal/RevealServer/RevealServer.xcframework/ios-arm64_armv7/RevealServer.framework/`。

所以，可以用 macOS 访问设备的 `/Library/Frameworks` 目录替换，或者用 `scp` 进行覆盖。


```
scp -r ~/Library/Application\ Support/Reveal/RevealServer/RevealServer.xcframework/ios-arm64_armv7/RevealServer.framework/ root@localhost/Library/Frameworks
```



#### Cycript 实战

```
cycript -p 进程名称
```

或：
```
cycript -p 进程ID
```

注：

1. 取消输入：Ctrl + C
2. 退出：Ctrl + D
3. 取消输入：Command + R


**分析视图层次结构**
苹果系统中的私有函数在正向开发中是不能使用的，但在逆向分析中可以发挥很大的用途，其中有一个`recursiveDescription`函数可以用来递归打印任意视图层次结构，再使用`.toString()`就能输出清晰的格式。

```objc
[[UIApp keyWindow] recursiveDescription].toString()
```

在UIWindow里有一个名为 `_autolayoutTrace` 的私有函数，该函数的返回值是一个字符串，这个字符串则包含了UIWindow中整个视图的层次结构。
```objc
[[UIApp keyWindow] _autolayoutTrace].toString()
```

1. nextResponder
2. allTargets
3. allControlEvents
4. actionsForTarget: forControlEvent:
5. choose(xxx)
6. dismissViewControllerAnimated: completion:
7. NSHomeDirectory()
8. NSTemporaryDirectory()

- [Cycript Manual](http://www.cycript.org/manual/)


**iOS文件目录**

- app目录：`/var/containers/Bundle/Application/`
- 沙盒目录：`/var/mobile/Containers/Data/Application/`


获取苹果内购收据：
```
[[NSString alloc] initWithData:[[NSData dataWithContentsOfURL:[[NSBundle mainBundle] appStoreReceiptURL]] base64EncodedDataWithOptions:0] encoding:NSUTF8StringEncoding];
```

#### Frida 实战
**被控端（iOS端）**

在 Cydia 添加软件源：`https://build.frida.re/`，搜索 “Frida” 进行安装，注意的是下载分为三个插件，for 32-bit/ for A12+ / for
 pre-A12。安装后，重启SpringBoard，在iOS端看到“frida-server”后台程序，说明安装成功，如下所示：
  
```
iHTC:~ root# ps -ax | grep frida
25780 ??         0:00.05 /usr/sbin/frida-server
```

**控制端（macOS端）**

推荐使用 python3 安装:
```
pip3 install frida-tools
```

> 注：在 macOS 10.15 以上可能会报错，请自行搜索。
> 1、[brew installation of Python 3.6.1: SSL: CERTIFICATE_VERIFY_FAILED certificate verify failed](https://stackoverflow.com/questions/44649449/brew-installation-of-python-3-6-1-ssl-certificate-verify-failed-certificate)
> 2、[Scraping: SSL: CERTIFICATE_VERIFY_FAILED error for http://en.wikipedia.org](https://stackoverflow.com/questions/50236117/scraping-ssl-certificate-verify-failed-error-for-http-en-wikipedia-org)


**Frida 实践**

除了主命令 `frida` 以外，frida-tools 里面还提供了五个实用工具：

1. `frida-ls-devices`：用于获取可用设备列表
2. `frida-ps`：frida-ps与ps命令的功能类似，用于获取进程列表信息
3. `frida-kill`：用来结束设备上的某个进程
4. `frida-trace`：用于跟踪函数或方法的调用
5. `frida-discover`：用于发现程序中内部函数的工具，然后可以使用frida-trace对其进行跟踪。


注：如果这5个命令执行时提示 `command not found:`，可以用 `which frida` 查看 frida 所在目录，然后软链接到 `ln /xxx/xxx/frida /usr/local/bin/`。

公共参数：
`-U`：连接到USB设备。
`-D`：如果有多个USB设备，可以用该选项指定设备的UDID。
`-R`/`-H`：连接到远程frida-server，主要用于远程调试。


frida-ls-devices 示例：：
```
➜  ~ frida-ls-devices
Id                                        Type    Name
----------------------------------------  ------  ------------
local                                     local   Local System
16b060488c562bfd169d77356bbfeeeb3234e1f4  usb     iPhone
19a32eb9495810d5e98825ebd0da0010473e0554  usb     iPhone
socket                                    remote  Local Socket
```

frida-ps 示例：
```
➜  ~ frida-ps -U -a
  PID  Name        Identifier
-----  ----------  -----------------------------
36205  CrackerXI+  com.ipc.crackerxi
39573  Cydia       com.saurik.Cydia
```

```
# Connect Frida to an iPad over USB and list running processes
$ frida-ps -U

# List running applications
$ frida-ps -Ua

# List installed applications
$ frida-ps -Uai

# Connect Frida to the specific device
$ frida-ps -D 0216027d1d6d3a03
```

frida-kill 示例：
```
$ frida-kill -D <DEVICE-ID> <PID>

# List active applications
$ frida-ps -D 1d07b5f6a7a72552aca8ab0e6b706f3f3958f63e  -a

# Connect Frida to the device and kill running process
$ frida-kill -D 1d07b5f6a7a72552aca8ab0e6b706f3f3958f63e 5029

# Check if process has been killed
$ frida-ps -D 1d07b5f6a7a72552aca8ab0e6b706f3f3958f63e  -a
```


frida-trace 示例：
```
# Trace recv* and send* APIs in Safari, insert library names
# in logging
$ frida-trace --decorate -i "recv*" -i "send*" Safari

# Trace ObjC method calls in Safari
$ frida-trace -m "-[NSView drawRect:]" Safari

# Launch SnapChat on your iPhone and trace crypto API calls
$ frida-trace \
    -U \
    -f com.toyopagroup.picaboo \
    -I "libcommonCrypto*"

# Launch YouTube on your Android device and trace Java methods
# with “certificate” in their signature (s), ignoring case (i)
# and only searching in user-defined classes (u)
$ frida-trace
    -U \
    -f com.google.android.youtube \
    --runtime=v8 \
    -j '*!*certificate*/isu'

# Trace all JNI functions in Samsung FaceService app on Android
$ frida-trace -U -i "Java_*" com.samsung.faceservice

# Trace a Windows process's calls to "mem*" functions in msvcrt.dll
$ frida-trace -p 1372 -i "msvcrt.dll!*mem*"

# Trace all functions matching "*open*" in the process except
# in msvcrt.dll
$ frida-trace -p 1372 -i "*open*" -x "msvcrt.dll!*open*"

# Trace an unexported function in libjpeg.so
$ frida-trace -p 1372 -a "libjpeg.so!0x4793c"
```

- [frida-ls-devices | Frida](https://frida.re/docs/frida-ls-devices/)
- [frida-ps | Frida](https://frida.re/docs/frida-ps/)
- [frida-kill | Frida](https://frida.re/docs/frida-kill/)
- [frida-trace | Frida](https://frida.re/docs/frida-trace/)


**Python交互**

* attach()：附加目标进程
* spawn()：启动进程，此时进程处于挂起状态，需要配合resume()才能唤醒。
* resume()：唤醒进程
* detach()：脱离进程
* create_script()：创建一个脚本对象
* load()：方法将脚本载入


获取设备信息：
```python
import frida

# 获取当前 USB 链接的设备
print(frida.get_usb_device())

#输出
>>> Device(id="19a32eb9495810d5e98825ebd0da0010473e0554", name="iPhone", type='usb')
```


启动 Safari浏览器并打开网站：
```
import frida

device = frida.get_usb_device()
device.spawn("com.apple.mobilesafari", url="https://iHTCboy.com")
```


详细API文档：
- [JavaScript API | Frida](https://frida.re/docs/javascript-api/)
- [Frida CodeShare](https://codeshare.frida.re/browse)





### Theos 和 Tweak
Theos 是越狱开发的一个工具包, 可以创建Tweak项目，动态的hook第三方程序。

* [theos/theos: A cross-platform suite of tools for building and deploying software for iOS and other platforms.](https://github.com/theos/theos)
* [Theos](https://theos.dev/)

#### Tweak及工作原理
`Cydia Substrate` 是越狱后cydia插件/软件(指theos开发的tweak)运行的基础依赖库。它提供了软件运行公开库，用于动态替换内存的代码。所以首先要安装好 Cydia Substrate。

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

### 破解

#### 绕过 Apple ID

* [忘记 Apple ID 后如何绕过 iOS 激活锁？_越狱教程_爱思助手](https://www.i4.cn/news_detail_39267.html)

### 外挂

#### yacd (Yet Another Code Decrypter)
利用 Psychic Paper 漏洞，可以在 iOS 13.4.1 以下的“未越狱”设备上砸壳并 AirDrop 到 Mac 上。

- [GitHub - DerekSelander/yacd: Decrypts FairPlay applications on iOS 13.4.1 and lower, no jb required](https://github.com/DerekSelander/yacd)


### iOS

#### 降级

**ECID**
ECID：`Exclusive Chip ID`，唯一芯片 ID。

每一台 iPhone 或 iPad 等 iOS 设备，都会有专属独一无二的 16 位芯片唯一识别码，用来验证设备。

**SHSH**

SHSH：`Signed Hash`，签名散列。

1024 位的 RSA 签名，由苹果根据设备的 ECID 和固件的 Apnonce 随机数（Apnonce 值每次刷机都会变化）生成。在允许执行映像之前，由引导加载程序验证。通常 SHSH 指带有签名的备份文件（“SHSH blobs”）。恢复特定的 iOS 版本需要此签名文件，Apple 仅针对当前可用的 iOS 版本发放签名，不允许安装旧版 iOS。所以，为旧版 iOS 保存 SHSH 文件，就可以使用重播攻击来恢复该旧版本系统。SHSH2 是 iOS9.0 以后的版本。当你刷机的时候，Apple 会连上服务器来验证当前你的刷机版本和 ECID 所产生的 SHSH 和服务器上的是否匹配，如果不匹配，则不能刷机。

**SEP**
SEP：`Secure Enclave Processor`，安全隔区处理器。

安全隔区处理器为安全隔区提供了主要的计算能力。它有独立的运行系统，每次刷机都会对SEP系统也进行更新，系统与服务器会进行核对，如果降级的 iOS 系统与当前的 SEP 不兼容，那么降级刷机被禁止。


* [TSS Saver - SHSH Blobs Saver](https://tsssaver.1conan.com/v2/)
* [安全隔区 - Apple 支持](https://support.apple.com/zh-cn/guide/security/sec59b0b31ff/web)

#### iOS安全体系结构

```
 +————————————————————————————————+
 | +————————————————————————————+ |
 | | +————————————————————————+ | |
 | | | +————————————————————+ | | |
 | | | |   Data Protection  | | | |
 | | | |       Class        | | | | <———— encrypted by per-file key 
 | | | +————————————————————+ | | |
 | | |       App Sanbox       | | | <———— permission/MAC/entitlement
 | | +————————————————————————+ | |
 | | User Partition (Encrypted) | | <———— encrypted by file system key
 | +————————————————————————————+ |
 | +————————————————————————————+ |
 | |        OS Partition        | | <———— mounted as read-only
 | +————————————————————————————+ |
 |          File system           |
 +————————————————————————————————+  
              Software 
                 |       
        Hardware and Firmware               
 +————————————————————————————————+  
 |             Kernel             | <———— trusted, enforcing security measures
 | +———————————————+  +—————————+ |
 | |    Secure     |  |  Secure | | <——   coprocessor for crypto operations
 | |    Enclave    |  | Element | |   <—— Java Card platform for payment
 | +———————————————+  +—————————+ |   
 +————————————————————————————————+
 +————————————————————————————————+  
 |          Crypto Engine         | <———— hardware AES engine
 +————————————————————————————————+ 
 +————————————————————————————————+  
 |     Device Key,  Group Key     | <———— secret keys for device
 |     Apple Root Certificate     | <———— root public key from Apple
 +————————————————————————————————+
```

- [Security-Course/ios-security.md - Security-Course](https://github.com/lizhi16/Security-Course/blob/master/system-security/ios-security.md)


### macOS

| 名词 | 解析 | 备注 |
| --- | --- | --- |
| `SIP` | System Integrity Protection，系统完整性保护 | OS X El Capitan（2015年9月16日）中引入的Apple macOS操作系统的一项安全功能。它包含许多由内核执行的机制。核心是保护系统拥有的文件和目录，以防止没有特定“权限”的进程修改，即使由root用户或具有root特权的用户执行也是如此。 |
| `AMFI` | Apple Mobile File Integration，苹果手机文件完整性 | 起源于iOS，它阻止了任何运行未签名代码的尝试。AMFI是内核扩展，最初在iOS中引入。在macOS 10.10 添加到macOS中。就像沙盒一样，它扩展了 MACF（强制性访问控制框架），并且在执行SIP和代码签名方面起着关键作用。 |
| `MACF` | MAC (Mandatory Access Control) Framework，强制访问控制架构 | 在 Mac OS X 10.5 Leopard（2007年10月26日） 的 SDK 中苹果“错误的”为大家引入了一种新的监控机制 —— Mandatory Access Control Policy Framework。很快苹果公司纠正了这一错误，彻底将这一接口私有化。在文档 [QA1574](https://developer.apple.com/library/content/qa/qa1574/_index.html) 中苹果明确的指出第三方不应该使用 MAC 机制，它不属于 KPI 的一部分。MACF 是苹果从 TrustedBSD 引入的一项强大的安全特性。用户态的视角非常有局限性，只有内核才能可靠地实施这种安全性。当XNU 调用MAC层验证一个操作时，MAC层调用策略模块，然后策略模块负责进行验证。 |
| `PIC` / `PIE` | Position Independent Code，地址无关代码。又称 `PIE`， Position Independent Executables，地址无关可执行文件 | 在计算机领域中，地址无关代码，又称地址无关可执行文件，是指可在主存储器中任意位置正确地运行，而不受其绝对地址影响的一种机器码。PIC广泛使用于共享库，使得同一个库中的代码能够被加载到不同进程的地址空间中。PIC还用于缺少内存管理单元的计算机系统中， 使得操作系统能够在单一的地址空间中将不同的运行程序隔离开来。 |
| `ASLR` | Address Space Layout Randomization，地址空间布局随机化 | 这项技术是在 OS X Mountain Lion（2012年7月25日） 引入的。现在已经成为操作系统想要阻止黑客和恶意软件视图注入代码攻击的必备技术。防御代码注入的主要方法是数据执行阻止(Data Execution Prevention，DEP，在Intel 中也称为W^X或XD，在ARM中也称为XN)，DEP能使得黑客注入代码的企图更加困难。|
| `W^X` | Write XOR execute | 苹果芯片会强制内存页面的属性要么可以写，要么可以执行，但不能同时为可以写可执行。特别是像JS那种带有JIT功能语言，经常会分配可写可执行的内存页面，苹果因此提供了一个专门的API（pthread_jit_write_protect_np()）用于JIT来做RW和RX内存页面之间的转换。 |
| `KPP` | Kernel Patch Protection 内核完整性保护 | 与iOS9一起推出的内核完整性保护又称为“KPP”，防止运行时内核被篡改。当内核载入内存以后，苹果芯片会保护内核的内存页面，以防止其被篡改。 |
| `PAC` | 指针验证 | 指针验证是利用arm架构的特性，在PC进行跳转的时候对指针进行验证，从而可以有效地防止像ROP（返回导向编程）这样的攻击。苹果在iPhone XS和XR中首次部署了这个机制。目前苹果只是对macOS的内核和系统服务做了PAC的防护，我们自己在Mac上编写的app并没有PAC的防护。 |
| `Device isolation` | 设备内存隔离 | 在intel架构的Mac上，系统上的设备和驱动的内存空间是共享的，但是在arm64架构的Mac上，不同设备和驱动之间的内存是相互隔离的。 |
| `Secure boot` | 安全启动 | 新架构的macOS的启动使用了iOS的安全启动模式，苹果芯片会验证每一步加载的固件的签名，以保证其完整性和安全性。同时，在系统安装的时候，用户可以选择是`full security`（完整安全）模式还是 `reduce security`（低安全）模式。苹果默认会采用完整安全模式，在完整安全模式下，可以认为这台mac和一台iPhone一样，比如无法降级，无法加载第三方的内核扩展。在低安全模式下，用户可以安装任意版本的macOS以及加载内核扩展，关闭SIP（系统完整性保护）等。 |
| `AFC` | Apple File Conduit，苹果文件连接 | 运行在iOS设备上的文件传送服务，它允许你通过USB连线存取iPhone的 `/var/mobile/Media` 的目录里的文件。AFC 服务由 `lockdownd` 守护进程提供，被命名为 `com.apple.afc`。 |


- [Disabling and Enabling System Integrity Protection | Apple Developer Documentation](https://developer.apple.com/documentation/security/disabling_and_enabling_system_integrity_protection)
- [macOS 开启或关闭 SIP - 少数派](https://sspai.com/post/55066)
- [在 macOS 10.15.4 上解锁 Sidecar 需要进行额外步骤 - 知乎](https://zhuanlan.zhihu.com/p/116475208)
- [深入解析Mac OS X & iOS 操作系统 学习笔记（十五） - 简书](https://www.jianshu.com/p/96837976c1f8)
- [下一个十年的安全机遇之一：基于Apple Silicon的Mac电脑对安全来说意味着什么？ - 知乎](https://zhuanlan.zhihu.com/p/152126496)


#### AMFI
Apple Mobile File Integrity（AMFI）起源于iOS，它阻止了任何运行未签名代码的尝试。它似乎已迁移到 macOS Sierra 或更早的版本，可能是因为 Gatekeeper 和2012年的代码签名发生了变化。

它由两个组件组成：守护程序或服务 amfid，从 `/usr/libexec/amfid` 运行。它很小，只有 51KB 左右，由 `/System/Library/LaunchDaemons/com.apple.MobileFileIntegrity.plist` 作为根启动守护程序运行。它通常在loginwindow 和 sandbox（相对）之后，syspolicyd 和 trust（依赖它）之前开始。

它的客户端是AppleMobileFileIntegrity扩展名（在 `/System/Library/Extensions` 中），该扩展名更大，可执行代码为 151 KB。当前版本是1.0.5。

- [AMFI: checking file integrity on your Mac – The Eclectic Light Company](https://eclecticlight.co/2018/12/29/amfi-checking-file-integrity-on-your-mac/)

AppleMobileFileIntegrity（.kext），可以使用全名com.apple.driver.AppleMobileFileIntegrity，它是iOS内核扩展，是iOS代码权利模型的基石。它是 Sandbox（com.apple.security.sandbox）的依赖项之一，以及com.apple.kext.AppleMatch（与OS X一样，它负责解析Sandbox语言规则）。

- [AppleMobileFileIntegrity - The iPhone Wiki](https://www.theiphonewiki.com/wiki/AppleMobileFileIntegrity)

### Linux/Unix
#### ELF

> 维基百科：
> `ELF` 全称是 `Executable and Linkable Format` 可执行与可链接格式。常被称为 ELF格式，在计算机科学中，是一种用于可执行文件、目标文件、共享库和核心转储的标准文件格式。 1999年，被86open项目选为x86架构上的类Unix操作系统的二进制文件格式标准，用来取代COFF。因其可扩展性与灵活性，也可应用在其它处理器、计算机系统架构的操作系统上。


- [Executable and Linkable Format - Wikipedia](https://en.wikipedia.org/wiki/Executable_and_Linkable_Format)
- [深入浅出ELF - PansLabyrinth](https://evilpan.com/2020/08/09/elf-inside-out/)
- [深入浅出MachO - PansLabyrinth](https://evilpan.com/2020/09/06/macho-inside-out/)


### Python
#### Python 反汇编

Python 是一种解释型语言，而 Python 字节码（Python ByteCode）是一种平台无关的中间代码，由 Python 虚拟机动态(PVM)解释执行，这也是 Python 程序可以跨平台的原因。

开源的 pyc 还原工具:

* [uncompyle6](https://github.com/rocky/python-uncompyle6)
* [pycdc](https://github.com/zrax/pycdc)


- [如何破解一个Python虚拟机壳并拿走12300元ETH - PansLabyrinth](https://evilpan.com/2020/10/11/protected-python/)
- [dis — Disassembler for Python bytecode — Python 3.9.0 documentation](https://docs.python.org/3/library/dis.html)


### 软件

#### 010 Editor
010 Editor 是一款功能强大的跨平台十六进制编辑工具，同时支持Windows、Linux及macOS操作系统，它最大的特点是二进制模板技术，能够方便地分析任何二进制文件格式。

- [010 Editor - Pro Text/Hex Editor | Edit 160+ Formats](https://www.sweetscape.com/)
- [010 Editor - Binary Template Repository - Download Binary Templates](https://www.sweetscape.com/010editor/repository/templates/index.php?sort=)
