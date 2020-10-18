[TOC]

## RE（Reverse Engineering，逆向工程）
逆向工程，原名Reverse Engineering，简称RE。

> 维基百科：
> 逆向工程，又称反向工程，是一种技术过程，即对一项目标产品进行逆向分析及研究，从而演绎并得出该产品的处理流程、组织结构、功能性能规格等设计要素，以制作出功能相近，但又不完全一样的产品。逆向工程源于商业及军事领域中的硬件分析。其主要目的是，在无法轻易获得必要的生产信息下，直接从成品的分析，推导产品的设计原理。

* [逆向工程 - 维基百科，自由的百科全书](https://zh.wikipedia.org/wiki/%E9%80%86%E5%90%91%E5%B7%A5%E7%A8%8B)
* [漫谈逆向工程 - PansLabyrinth](https://evilpan.com/2020/03/08/reverse-engineering/)



### 越狱（Jailbreak）

**越狱工具：**

- [checkra1n](https://checkra.in/)：iOS 12.3-13.5
- [unc0ver](https://unc0ver.dev/)： iOS 11.0 - 13.5
- [Chimera](https://chimera.sh/): iOS 12 — 12.2 and 12.4

查看支持的系统版本：
* [iOS系统设备越狱](https://yueyu.cydiami.com/)


#### 越狱原理

* [iPhone 史诗级漏洞 checkm8 攻击原理浅析](https://paper.seebug.org/1065/)
* [Technical analysis of the checkm8 exploit / Digital Security / Habr](https://m.habr.com/en/company/dsec/blog/472762/)
* 



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

### iOS

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
| `Secure boot` | 安全启动 | 新架构的macOS的启动使用了iOS的安全启动模式，苹果芯片会验证每一步加载的固件的签名，以保证其完整性和安全性。同时，在系统安装的时候，用户可以选择是full security（完整安全）模式还是reduce security（低安全）模式。苹果默认会采用完整安全模式，在完整安全模式下，可以认为这台mac和一台iPhone一样，比如无法降级，无法加载第三方的内核扩展。在低安全模式下，用户可以安装任意版本的macOS以及加载内核扩展，关闭SIP（系统完整性保护）等。 |


- [macOS 开启或关闭 SIP - 少数派](https://sspai.com/post/55066)
- [在 macOS 10.15.4 上解锁 Sidecar 需要进行额外步骤 - 知乎](https://zhuanlan.zhihu.com/p/116475208)
- [深入解析Mac OS X & iOS 操作系统 学习笔记（十五） - 简书](https://www.jianshu.com/p/96837976c1f8)
- [下一个十年的安全机遇之一：基于Apple Silicon的Mac电脑对安全来说意味着什么？ - 知乎](https://zhuanlan.zhihu.com/p/152126496)


#### AMFI
Apple Mobile File Integrity（AMFI）起源于iOS，它阻止了任何运行未签名代码的尝试。它似乎已迁移到Sierra或之前的macOS中，可能是因为Gatekeeper和2012年的代码签名发生了变化。

它由两个组件组成：守护程序或服务amfid，从/ usr / libexec / amfid运行。它很小，只有51 KB左右，由/System/Library/LaunchDaemons/com.apple.MobileFileIntegrity.plist作为根启动守护程序运行。它通常在loginwindow和sandbox（相对）之后，syspolicyd和trust（依赖它）之前开始。

它的客户端是AppleMobileFileIntegrity扩展名（在/ System / Library / Extensions中），该扩展名更大，可执行代码为151 KB。当前版本是1.0.5。

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


### 漏洞攻击
#### UAF (Use After Free) 漏洞
`uaf` 漏洞全称是 `use after free`，free是指函数是在堆上动态分配空间后不再使用该数据从而被回收。但是由于程序的一些不适当的操作或逻辑，会导致攻击者能够操控已经被释放的区域，从而执行一些 byte codes。

- [逆向安全系列：Use After Free漏洞浅析 - 安全客，安全资讯平台](https://www.anquanke.com/post/id/85281)
- [uaf漏洞原理浅析 - Weizhou的博客](https://hack-big.tech/2019/01/24/uaf%E6%BC%8F%E6%B4%9E%E5%8E%9F%E7%90%86%E5%AE%9E%E4%BE%8B%E6%B5%85%E6%9E%90/)

#### 0day（zero-day vulnerability、0-day vulnerability，零日漏洞或零时差漏洞）
“零日漏洞”(zero-day)又叫零时差攻击，是指被发现后立即被恶意利用的安全漏洞。 通俗地讲，即安全补丁与瑕疵曝光的同一日内，相关的恶意程序就出现。 这种攻击往往具有很大的突发性与破坏性。

由原软件发行公司提供修补程序，但此法通常较慢，因此软件公司通常会在最新的病毒代码中提供回避已知零时差攻击的功能，但无法彻底解决漏洞本身。

在电脑领域中，零日漏洞或零时差漏洞通常是指还没有补丁的安全漏洞，而零日攻击或零时差攻击则是指利用这种漏洞进行的攻击。提供该漏洞细节或者利用程序的人通常是该漏洞的发现者。零日漏洞的利用程序对网络安全具有巨大威胁，因此零日漏洞不但是黑客的最爱，掌握多少零日漏洞也成为评价黑客技术水平的一个重要参数。

- [零日攻击 - 维基百科，自由的百科全书](https://zh.wikipedia.org/wiki/%E9%9B%B6%E6%97%A5%E6%94%BB%E5%87%BB)

#### HIDS
`HIDS`：Host-based Intrusion Detection System，基于主机的入侵检测系统。是一种入侵检测系统，类似于基于网络的入侵检测系统的运行方式，它能够监视和分析计算系统的内部以及其网络接口上的网络数据包。这是已设计的第一类入侵检测软件，最初的目标系统是很少进行外部交互的大型计算机。

- [Host-based intrusion detection system - Wikipedia](https://en.wikipedia.org/wiki/Host-based_intrusion_detection_system)

#### AFL
`AFL`：American Fuzzy Lop，是由安全研究员 Michał Zalewski（@lcamtuf）开发的一款基于覆盖引导（Coverage-guided）的模糊测试工具，它通过记录输入样本的代码覆盖率，从而调整输入样本以提高覆盖率，增加发现漏洞的概率。是一款免费的软件模糊器，它采用遗传算法来有效地增加测试用例的代码覆盖率。到目前为止，它帮助检测了许多主要的自由软件项目中的重大软件错误，包括X.Org Server，PHP，OpenSSL，pngcrush，bash，Firefox，BIND，Qt和SQLite。

- [american fuzzy lop (fuzzer) - Wikipedia](https://en.wikipedia.org/wiki/American_fuzzy_lop_(fuzzer))
- [AFL漏洞挖掘技术漫谈（一）：用AFL开始你的第一次Fuzzing](https://mp.weixin.qq.com/s/G7l5wBB7oKjXCDGtjuxYTQ)

### Python
#### Python 反汇编

Python 是一种解释型语言，而 Python 字节码（Python ByteCode）是一种平台无关的中间代码，由 Python 虚拟机动态(PVM)解释执行，这也是 Python 程序可以跨平台的原因。

开源的 pyc 还原工具:

* [uncompyle6](https://github.com/rocky/python-uncompyle6)
* [pycdc](https://github.com/zrax/pycdc)


- [如何破解一个Python虚拟机壳并拿走12300元ETH - PansLabyrinth](https://evilpan.com/2020/10/11/protected-python/)
- [dis — Disassembler for Python bytecode — Python 3.9.0 documentation](https://docs.python.org/3/library/dis.html)
