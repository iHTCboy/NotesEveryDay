[TOC]

## Security（安全）

### 计算机安全（Computer Security）

也称为网络空间安全（cybersecurity）或IT安全，保护信息系统中软件、硬件、信息及服务。

* 信息安全（InfoSec）：保护信息的机密性，完整性，可用性，不可抵赖等等
* 网络安全（Network security）：计算机网络及网络可访问资源的安全
* 网络战（Cyberwarfare）：一国入侵另一国计算机或网络
* 互联网安全（Internet security）：互联网相关安全，包括浏览器安全以及网络安全等等
* 移动安全（Mobile security）：移动计算安全，特别是智能手机


- [Computer security - Wikipedia](https://en.wikipedia.org/wiki/Computer_security)


#### 典型漏洞与攻击
* 后门（Backdoor）
* 拒绝服务（DoS）
* 直接访问（Direct-access）
* 窃听（Eavesdropping）
* 伪装欺骗（Spoofing）
* 篡改（Tampering）
* 特权提升（Privilege escalation）
* 钓鱼（Phishing）
* 点击劫持（Clickjacking）
* 社交工程（Social engineering）
* 木马（Trojan）
* 僵尸网络（Zombie/botnet）
* 病毒/蠕虫/恶意软件（virus/worm/malware）
* 高级持续性威胁（Advanced Persistent Threat）

#### 典型安全机制
* 认证（Authentication）
* 授权（Authorization）
* 访问控制（Access Control）
* 防火墙（Firewall）
* 反病毒（Antivirus）
* 入侵检测/阻止系统（Intrusion detection/prevention system）
* 移动安全网关（Mobile secure gateway）
* 沙箱（Sandboxing）
* 纵深防御（Defense in depth）
* 设计出安全（Security by design）


#### 安全概念

- **安全**：在敌手出现时实现目标，或者说在敌手出现时，系统可正常工作
- 安全思维：
	- Policy（策略）：欲达成的目标，例如CIA：机密性（Confidentiality），完整性（Integrity），可用性（Availability）
	- Threat model（威胁模型）：关于敌手能力的假设
	- Mechianism（机制）：系统中用于实现政策的组件
	- Resulting goal（结果目标）：在**威胁模型**下，攻击者无法违反**策略**
- 安全是一个**否定**目标（保证不存在攻击）
	- 难以考虑到攻击者所有可能的攻击方式
	- 真实的威胁模型是开放的
- 若无法做到**完美安全**，为什么还要做安全？
	- 了解系统的安全边界
	- 每个系统可能都有可利用弱点，理解系统能做的和不能做的
	- 管理安全风险 vs. 收益

- [Security-Course/introduction.md](https://github.com/lizhi16/Security-Course/blob/master/introduction.md)

### 认证

- [JSON Web Token 入门教程 - 阮一峰的网络日志](http://www.ruanyifeng.com/blog/2018/07/json_web_token-tutorial.html)


### 数字签名



### 加解密 

#### RSA

openssl方式生成加密长度1024位密钥:
```
生成私钥：openssl genrsa -out rsaprivatekey.pem 1024

生成公钥：openssl rsa -in rsaprivatekey.pem -out rsapublickey.pem -pubout

转换格式：openssl pkcs8 -topk8 -in rsaprivatekey.pem -out pkcs8rsaprivate_key.pem -nocrypt
```

- [两种方式生成RSA 公钥私钥_[| 小人物，大世界-CSDN博客_生产rsa](https://blog.csdn.net/li396864285/article/details/79865806)

##### RSA 可以用于加解密，也可以用于消息签名。

RSA 使用一对不同的密钥：公钥和私钥。公钥是公开的，你知道，别人也知道，别人也需要知道；私钥是只能持有者知道，不能泄露了，不然很麻烦。

##### 加解密

A 和 B 通信，A 使用 B 的公钥和 RSA 加密算法对消息进行加密，得到密文，密文扔出去后，只有 B 使用自己的私钥才能解。
B 回复 A，B 使用 A 的公钥和 RSA 加密算法对响应数据进行加密，加密后的密文只有 A 能够解。这就保证了，数据不会被第三方获取。

当然这里面还有一些其他的问题，比如怎样获取对方的公钥，怎样确定获取到的公钥就是对方的公钥而不是中间人伪造的公钥。可以了解下 https 握手的过程，https 主要通过对称加密（比如 AES 等）方式通信，但是对称加密密钥是通过 RSA 加密传输的。

##### 签名验签

RSA 可以用于消息签名，用于消息接收方确认消息发送方身份，防止伪造的消息。
A 将原始数据使用 A 的私钥进行 RSA 签名得到 Sign，原始数据附带签名一起发送给消息接收方，消息接收方 B 使用 A 的公钥、原始数据、Sign 三个要素进行验签过程，也就是使用 A 的公钥和 RSA 算发对 Sign 进行处理，用处理的结果与原始数据进行对比，如果一致，说明是 A 发送的，而且只能是 A 发送的，除非 A 的私钥泄露了。

由于 RSA 算法比较慢，而且原始数据的大小不确定，消息签名的计算和传输可能会造成很大的 cpu 和网络开销，消息签名一般是对原始数据的摘要进行签名，比如 MD5 消息摘要算法（ MD5 长度固定，且不同消息 MD5 冲突的可能性很小），对应的，验签的时候对比的不不是原始数据，而是消息摘要。使用指定的消息摘要进行签名时，签名过程计算较快，而且签名结果长度也相对固定。

总之，加解密和消息签名使用 RSA 时，目的不同，一个是为了防止明文消息被第三方获取（私密性），一个是为了方便消息接收方确认消息没有被篡改（完整性）。

- [RSA 可以做私钥加密，公钥解密吗？解密的结果还是加密之前的明文吗？ - V2EX](https://v2ex.com/t/542814)

##### 总结

**公钥**和**私钥**是对等的，并且可以互换。

用**公钥**加密的数据必须用**私钥**解密；用**私钥**加密的数据必须用**公钥**解密。

常见的数据加密过程，就是拿**事实公钥**对数据进行加密，稍后可以用**事实私钥**进行解密。

常见的数据签名过程，就是拿**事实私钥**对数据的摘要进行加密，稍后可以用**事实公钥**进行解密并验证完整性。

**私钥文件**和**公钥文件**不是对等的，不能互换。**私钥文件**中含有额外的参数，可以计算得到**公钥**，而**公钥文件**中没有，也无法计算得到**私钥**。

通常为了兼容性和计算方便，我们使用**常见参数密钥**，即**事实公钥**中的密文e为一特定值，通常为`65537`。这样使得使用了常见参数的**事实公钥**无法作为**事实私钥**使用，因为密文e不是安全的。

- [RSA加密算法中公钥和私钥的一些解惑](https://blog.x86.men/blog/rsa-faq)

##### 其它参考

- [The Illustrated TLS Connection: Every Byte Explained](https://tls.ulfheim.net/)
- [RSA的公钥和私钥到底哪个才是用来加密和哪个用来解密？ - 知乎](https://www.zhihu.com/question/25912483)
- [Java使用RSA加密解密签名及校验 - CSDN博客](https://blog.csdn.net/wangqiuyun/article/details/42143957)


#### CA

CA（Certificate Authority，证书授权中心、证书授权机构） 机构给网站颁发证书，浏览器则会通过一些加密、哈希算法验证证书是否有效。

证书一般分成三类： DV、OV 、和 EV ，加密效果都是一样的，区别在于：

DV（Domain Validation），面向个体用户，安全体系相对较弱，验证方式就是向 whois 信息中的邮箱发送邮件，按照邮件内容进行验证即可通过；

OV（Organization Validation），面向企业用户，证书在 DV 证书验证的基础上，还需要公司的授权，CA 通过拨打信息库中公司的电话来确认；

EV（Extended Validation），URL 地址栏展示了注册公司的信息，这类证书的申请除了以上两个确认外，需要公司提供金融机构的开户许可证，要求十分严格。

- [CA 机构是如何保护自己私钥的？ - 知乎](https://www.zhihu.com/question/22260090)
- [certificates - How do certification authorities store their private root keys? - Information Security Stack Exchange](https://security.stackexchange.com/questions/24896/how-do-certification-authorities-store-their-private-root-keys)
- [美国联邦政府为加密模组制定了一份69页的技术标准 FIPS 140-2](https://nvlpubs.nist.gov/nistpubs/FIPS/NIST.FIPS.140-2.pdf)
- [揭秘 | 巨头怼巨头，谷歌封杀赛门铁克证书背后的恩怨情仇](https://mp.weixin.qq.com/s/MC0q7ipXQ-TjXpaYaGoH1w)



### 漏洞攻击
#### UAF (Use After Free) 漏洞
`uaf` 漏洞全称是 `use after free`，free是指函数是在堆上动态分配空间后不再使用该数据从而被回收。但是由于程序的一些不适当的操作或逻辑，会导致攻击者能够操控已经被释放的区域，从而执行一些 byte codes。

- [逆向安全系列：Use After Free漏洞浅析 - 安全客，安全资讯平台](https://www.anquanke.com/post/id/85281)
- [uaf漏洞原理浅析 - Weizhou的博客](https://hack-big.tech/2019/01/24/uaf%E6%BC%8F%E6%B4%9E%E5%8E%9F%E7%90%86%E5%AE%9E%E4%BE%8B%E6%B5%85%E6%9E%90/)

#### 0day（zero-day vulnerability、0-day vulnerability，零日漏洞或零时差漏洞）
`0day`：“零日漏洞”(zero-day)又叫零时差攻击，是指被发现后立即被恶意利用的安全漏洞。 通俗地讲，即安全补丁与瑕疵曝光的同一日内，相关的恶意程序就出现。 这种攻击往往具有很大的突发性与破坏性。

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



### 实践

#### 网易云音乐ncm格式分析

- [anonymous5l/ncmdump: netease cloud music copyright protection file dump](https://github.com/anonymous5l/ncmdump)
- [网易云音乐ncm格式分析以及ncm与mp3格式转换 - chuyaoxin - 博客园](https://www.cnblogs.com/cyx-b/p/13443003.html)
- [网易云音乐ncm编解码探究记录 - 简书](https://www.jianshu.com/p/ec5977ef383a)
- [网易云音乐ncm文件格式解析 | 文章 | BEWINDOWEB](http://www.bewindoweb.com/228.html)

#### CAPTCHA（验证码）

- [AI时代验证码的攻与防](https://juejin.cn/post/6844903860788527118)
- [验证码的前世今生（今生篇）](https://www.freebuf.com/articles/web/102276.html)


### 安全问题的事件

- 以下内容引用来源： [Security-Course/introduction.md](https://github.com/lizhi16/Security-Course/blob/master/introduction.md)


#### 安全问题1：违背政策

##### Sarah Palin的email账号破解

2008年9月，美国共和党副总统候选人莎拉·佩林的雅虎私人电子邮箱遭黑客入侵。黑客可能是一名田纳西州民主党议员正在念大学的儿子戴维·克内尔。[[相关报道]](https://en.wikipedia.org/wiki/Sarah_Palin_email_hack)

攻击者利用雅虎密码遗忘提示功能和网络搜索引擎：佩林的邮箱密码提示问题包括她的生日，以及她和丈夫托德在何处相识。为副总统候选人的佩林已无太多隐私可言，可在谷歌上轻松找到答案。

FBI发现了攻击者在代理服务器上的踪迹。

**政策违背：真正用户需要知道用户名与口令 --> 知道密码提示问题答案**

##### Mat Honan的Apple和Amazon账号破解
2012年一位网站主编Mat Honan的Google，Twitter, Apple账号都被破解。攻击者用这些账号发表种族言论，并删除了其iPhone等设备上数据。[[相关报道]](https://www.wired.com/2012/08/apple-amazon-mat-honan-hacking/all/)


- Twitter账号：采用Gmail邮箱
- Gmail密码重置：发送一个验证链接到备份邮箱。Mat的备份邮箱是Apple的me.com账号
- Apple密码重置：需要账单地址（个人住址可以查到），信用卡末4位（未知）
- Amazon密码重置：提供用户的任意一张信用卡账号（以及用户名，账单地址等）。在一个账号上添加信用卡，不需要密码（电话服务）。登录后，Amazon会显示所有信用卡末4位。

**政策违背：邮箱安全-->备份邮箱-->账单地址+信用卡末4位-->Amazon密码-->任意信用卡**

##### Twitter上 @N 账号劫持

2014年，Twitter上的 @N 账号（有人出价$50000）被劫持。账号所有者（受害者）Naoki Hiroshima在尝试夺回账号失败后，将用户名改为@N\_is\_stolen。Naoki通过与攻击者的邮件交流了解了其攻击过程。[[相关报道]](https://medium.com/@N/how-i-lost-my-50-000-twitter-username-24eb09e026dd#.d7lhyudko)

- @N 账号邮箱是受害者在GoDaddy上个人域名
- 个人域名被劫持，因而邮件服务器被更改，账号邮箱也就被劫持
- GoDaddy账号恢复需要提供信用卡末6位
- 攻击者打电话给PayPal，获得了信用卡末4位
- 攻击者打电话给GoDaddy，说信用卡丢了，但记得末4位；GoDaddy让攻击者来回忆前2位，可以一直猜，直到猜对（攻击者只猜了两次就蒙对了）

**政策违背：账号安全-->邮箱安全-->域名安全-->信用卡末6位-->信用卡末4位**

##### 2003年Linux后门事件
2003年时，Linux采用代码维护系统BitKeeper，提交代码需经过审查。部分开发者为了方便另建立了一个CVS来维护源代码。攻击者在CVS所维护源码中插入如下代码，将无效调用`wait4()`的进程赋予root权限。

```c
if ((options == (__WCLONE|__WALL)) && (current->uid = 0))                  
			retval = -EINVAL;        
```
不过，由于这个修改未经过审批流程，随后被发现。[[相关报道]](https://freedom-to-tinker.com/2013/10/09/the-linux-backdoor-attempt-of-2003/)

**政策违背：BitKeeper --> CVS**

---

#### 安全问题2：违背威胁模型/假设

##### 未考虑人的因素

- 通过邮件/电话的电信诈骗
- 攻击者通过致电客服来重置密码
- 胶皮管密码分析

2016年3月，希拉里竞选主席[波德斯塔（Podesta）电子邮件泄露](https://en.wikipedia.org/wiki/Podesta_emails)。攻击者俄罗斯黑客组织Fancy Bear（奇幻熊）采用鱼叉式网络钓鱼攻击，向波德斯塔发送一封伪造的Gmail警告邮件，其中包含一个链接指向一个伪造的登录页面。同年10月，[维基解密公开了泄露的邮件](https://wikileaks.org/podesta-emails/)。


##### 1983年图灵演说

[Reflections on Trusting Trust by Ken Thompson](http://www.ece.cmu.edu/~ganger/712.fall02/papers/p761-thompson.pdf)
> To what extent should one trust a statement that a program is free of Trojan horses? Perhaps it is more important to trust the people who wrote the software.

- 在发明C语言过程中，有一个“鸡生蛋，蛋生鸡”问题，即如何用C语言来实现C语言的编译器。
- 原理上，需要一个程序，能够复制自己，并在每次复制时‘学习’一点新特性，逐渐演化成一个“产生编译器的程序”。
- Ken在该程序中植入了一个木马，能够用特定密码来‘通过’`Login`函数检查。
- 即使有人发现了木马并更改了代码，但若用有木马的编译器编译，则新编译器中仍有木马！

##### 随时间变化的计算假设

- 自80年代中期，MIT Kerberos系统使用56比特DES密钥
- 但目前2^56已经不够大了，1天之内就能破解

##### 所有SSL证书CA都可信？

- 连接SSL支持的站点（HTTPS）需要验证CA办法的证书（身份和公钥的数字签名）
- 多数浏览器相信上百个CA，任何一个CA被攻破，可伪造任何站点证书
- 2011年，两个CA，[DigiNotar](http://en.wikipedia.org/wiki/DigiNotar)和[Comodo](http://en.wikipedia.org/wiki/Comodo_Group)，发布了包括google, yahoo等的假证书
- 2012年，一个CA，[Trustwave](http://www.h-online.com/security/news/item/Trustwave-issued-a-man-in-the-middle-certificate-1429982.html)发布了一个对任意网站都有效的根证书
- 2015年，埃及MSC Holding使用CNNIC签发的中级证书签发gmail假证书，导致Chrome和Firefox移除的CNNIC根证书 [[相关报道]](https://en.wikipedia.org/wiki/China_Internet_Network_Information_Center)
- 后面会介绍 [CA增强方案](https://github.com/lizhi16/Security-Course/blob/master/web-security/tls.md)

##### 假设硬件是可信的

- 若NSA要干坏事，则该假设很可能不成立。NSA下属的网络攻击部门TAO(Office of Tailored Access Operations，定制接入行动办公室)掌握大量硬件攻击手段，详见[NSA ANT目录](https://en.wikipedia.org/wiki/NSA_ANT_catalog)
- 2016年9月，Cisco在一个关于路由器故障报告中提到宇宙辐射可能是原因之一。这类故障称为[“Single event upset (单粒子翻转)”](https://en.wikipedia.org/wiki/Single_event_upset)。[[英文报道]](http://www.networkworld.com/article/3122864/hardware/cisco-says-router-bug-could-be-result-of-cosmic-radiation-seriously.html)，与[[中文报道]](http://www.leiphone.com/news/201609/AtW1F5zt6GS1ru9Y.html)

##### 假设密码学中充分的随机性

- 由于产生密钥或签名时熵不足，研究者发现0.75%的TLS证书共享密钥，获得0.5%的TLS主机和0.03%的SSH主机的RSA私钥，1.03%的SSH主机的DSA私钥，详见[Mining Your Ps and Qs: Detection of Widespread Weak Keys in Network Devices (USENIX Security 2012)](https://factorable.net/weakkeys12.extended.pdf)

##### 认为自主开发软件/系统更安全

- [XcodeGhost](https://en.wikipedia.org/wiki/XcodeGhost)在Apple的Xcode开发环境中注入恶意代码，并感染超过4000个应用，包括微博和网易云音乐。这些应用开发者从百度云和迅雷下载Xcode。尽管软件是自主开发的，但开发系统不是。

##### 不上网/隔离就安全了？

- 攻击伊朗核设施的[震网蠕虫（Stuxnet）](https://en.wikipedia.org/wiki/Stuxnet)通过U盘传播 -> Windows感染 -> Siemens PCS 7 SCADA工控软件 -> Siemens设备控制器

##### 没有电就安全了？

- [金唇 (The Thing，the Great Seal bug)](https://en.wikipedia.org/wiki/The_Thing_(listening_device))：1945年前苏联在赠送给美国大使馆的一个国徽礼物中安装了窃听器，该窃听器利用外部电磁波来获取能量，并将窃听到的信息发送出去（一种射频技术，是RFID的前身）

---

#### 安全问题3：机制问题（bug）

##### Apple iCloud 口令猜测速率限制 

- 人们通常采用弱密码，可以通过1K-1M次猜测得到
- iCloud有速率限制功能，但iCloud有许多API，其中“Find my iPhone”服务中的API忘了实现速率限制 [[详情]](https://github.com/hackappcom/ibrute)

##### 在花旗集团信用卡站点缺失访问控制检查 

- 花旗集团允许信用卡用户来在线访问其信用卡账户（用户名+口令）
- 账户信息页的URL中包括一些数字，这些数字与账号有关，而服务器不检查用户是否真的已经登录
- 攻击者尝试不同的数字，来获得不同人的账户信息
- 错误威胁模型？
	- 若攻击者通过浏览器访问站点，则系统是安全的
	- 若攻击者自己构造新的URL，则系统不安全
- 很难说是错误威胁模型，还是bug [[详情]](https://bitcoin.org/en/alert/2013-08-11-android)

##### 安卓Java SecureRandom弱点导致比特币盗窃

- 在安卓中许多比特币钱包应用使用Java的SecureRandom API
- 系统有时忘记给PRNG设定种子
- 导致用户私钥容易被猜中，攻击者将用户的比特币转给自己 [[详情]](https://bitcoin.org/en/alert/2013-08-11-android)


##### 心脏出血（Heartbleed）

- TLS的心跳扩展中，一方（客户端）发送心跳请求，包含一个负载+负载长度，另一方（服务器）用相同内容做应答
- CVE-2014-0160: 服务器未检查长度是否正确，过长的长度会导致服务器内存中数据被当做负载传递给客户端 [[详情]](https://en.wikipedia.org/wiki/Heartbleed)

##### Shellshock

- 2014年9月24日公开的Bash shell中一系列安全漏洞，利用处理环境变量中函数定义之后的命令，攻击者可执行任意代码 [[详情]](https://en.wikipedia.org/wiki/Shellshock_(software_bug))
- CVE-2014-6271: 环境变量声明中，函数之后命令会被执行
	- `env x='() { :;}; echo vulnerable' bash -c "echo test"`
	- 有漏洞Bash会输出`vulnerable`；否则，输出`test`

##### 缓冲区溢出（buffer overflow）

- [缓冲区溢出](https://github.com/lizhi16/Security-Course/blob/master/buffer-overflow/buffer-overflow-1.md)

