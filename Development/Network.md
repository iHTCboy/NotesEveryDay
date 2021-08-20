[TOC]

### OSI
> 开放式系统互联模型（英语：Open System Interconnection Model，缩写：OSI；简称为OSI模型）是一种概念模型，由国际标准化组织提出，一个试图使各种计算机在世界范围内互连为网络的标准框架。定义于ISO/IEC 7498-1。


#### 第7层 应用层
**应用层**（Application Layer）提供为应用软件而设的接口，以设置与另一应用软件之间的通信。例如: HTTP、HTTPS、FTP、TELNET、SSH、SMTP、POP3、HTML等。

#### 第6层 表达层
**表达层（**Presentation Layer）把数据转换为能与接收者的系统格式兼容并适合传输的格式。

#### 第5层 会话层
**会话层**（Session Layer）负责在数据传输中设置和维护计算机网络中两台计算机之间的通信连接。

#### 第4层 传输层
**传输层**（Transport Layer）把传输表头（TH，Transport Header）加至数据以形成数据包。传输表头包含了所使用的协议等发送信息。例如:传输控制协议（TCP）等。

#### 第3层 网络层
**网络层**（Network Layer）决定数据的路径选择和转寄，将网络表头（NH）加至数据包，以形成报文。网络表头包含了网络数据。例如:互联网协议（IP）等。

#### 第2层 数据链接层
**数据链路层**（Data Link Layer）负责网络寻址、错误侦测和改错。当表头和表尾被加至数据包时，会形成信息框（Data Frame）。数据链表头（DLH）是包含了物理地址和错误侦测及改错的方法。数据链表尾（DLT）是一串指示数据包末端的字符串。例如以太网、无线局域网（Wi-Fi）和通用分组无线服务（GPRS）等。

分为两个子层：逻辑链路控制（logical link control，LLC）子层和介质访问控制（Media access control，MAC）子层。

#### 第1层 物理层
**物理层**（Physical Layer）在局部局域网上传送数据帧（Data Frame），它负责管理电脑通信设备和网络媒体之间的互通。包括了针脚、电压、线缆规范、集线器、中继器、网卡、主机接口卡等。

- [OSI模型 - 维基百科](https://zh.wikipedia.org/wiki/OSI%E6%A8%A1%E5%9E%8B)

### TCP/IP
> TCP/IP（Transmission Control Protocol/Internet Protocol，传输控制协议/网际协议）是一个网络通信模型，以及一整个网络传输协议家族，为网际网络的基础通信架构。

### HTTP/HTTPS

HTTP 请求分为三个部分：

* 请求行
* 请求头
* 消息主体

```html
<method> <request-URL> <version>
<headers>

<entity-body>
```

HTTP 请求方法:
 
*  GET
*  POST
*  HEAD
*  OPTIONS
*  PUT
*  DELETE
*  TRACE
*  CONNECT

Content-Type:

* application/x-www-form-urlencoded
* multipart/form-data
* application/json
* text/xml
* text/html
* text/plain


- [四种常见的 POST 提交数据方式 | JerryQu 的小站](https://imququ.com/post/four-ways-to-post-data-in-http.html)


#### Accept-Language 的 q=0.9 q=0.8 是什么意思？

```
Accept-Language：zh-CN,zh;q=0.9,en;q=0.8
```
表示：“我更喜欢简体中文，但会接受中文(繁体)和其他类型的英语。

这被称为相对品质因子。它从0到1的范围指定用户喜欢的语言，每个语言可以被赋予一个相关的质量值，该质量值表示用户对该范围指定的语言的偏好的估计。质量值的默认为“q=1”。

- [HTTP/1.1: Header Field Definitions](https://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.4)


### SSL/TLS
SSL与TLS在传输层与应用层之间对网络连接进行加密。

* SSL：安全套接字协议(Secure Sockets Layer)，及其继任者传输层安全（Transport Layer Security，TLS）是为网络通信提供安全及数据完整性的一种安全协议。
* TLS：传输层安全性协议(Transport Layer Security)，用于在两个通信应用程序之间提供保密性和数据完整性。


#### SSL 证书
SSL 证书分为三大类，他们的安全性是递增的，当然价格和安全系数成正比。

1. DV（Domain Validation Certificate）：DV证书适合个人网站使用，申请证书时，CA 只验证域名信息。几分钟之内就能签发。
2. OV（ Organization Validation Certificate）：OV证书需要认证公司的信息。1-2天签发。
3. EV（ Extended Validation Certificate）：EV证书的认证最为严格，一般会要求提供纸质材料。签发时间也较久。


### VPN
> VPN （Virtual Private Network, 虚拟专用网）发展至今已经不在是一个单纯的经过加密的访问隧道，它已经融合了访问控制、传输管理、加密、路由选择、可用性管理等多种功能，并在全球的信息安全体系中发挥着重要的作用。

主流的VPN协议有 PPTP、L2TP、IPSec、OpenVPN 和 SSTP 等。

- [PPTP、L2TP、IPSec、OpenVPN和SSTP的区别](https://qiaodahai.com/pptp-l2tp-ipsec-openvpn-sstp.html)

