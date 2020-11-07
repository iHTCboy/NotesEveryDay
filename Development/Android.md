[TOC]

### Android Studio
#### Android Studio 真机测试
- 第一步：打开手机USB调试 
  首先，打开手机”设置->>我的设备->>全部参数->>MIUI版本”，连续点击7次，进入开发者模式。 
  其次，”设置->>更多设置->>开发者选项”，打开“USB调试”和“USB安装”.

- 第二步：设置Android studio 
  打开Android studio工程，”Run->>Edit configurations”如下图位置，选择“Open Select Deployment Target Dialog”,这个是每次在调试时弹出设备选择框。注意：如果直接选择“USB Device”的话，可能调试时会找到不到手机设备. 

---------------------

来自 雨寒sgg 的CSDN 博客 ，全文地址请点击：https://blog.csdn.net/u011389706/article/details/71512563?utm_source=copy 

- [(Mac)Android studio真机测试](https://www.jianshu.com/p/beb10cba514c)



### Android Hook

![](https://pic2.zhimg.com/80/v2-58f3800446ebb35fa8f38de1449a6af5_720w.jpg)

- [盘点Android常用Hook技术 - 知乎](https://zhuanlan.zhihu.com/p/109157321)


### Android Runtime (运行时)
#### JVM
`Java Virtual Machine`，缩写为JVM，Java虚拟机，一种能够运行Java字节码的虚拟机。

#### Dalvik
`Dalvik` 是 Android 移动设备平台的核心组成部分之一。它可以支持已转换为 `.dex`（dex, Dalvik Executable）格式的Java应用程序的运行。`.dex` 格式是专为 Dalvik 设计的一种压缩格式，适合内存和处理器速度有限的系统。

在app安装到手机之后，系统运行dexopt程序对dex进行优化，将dex的依赖库文件和一些辅助数据打包成odex文件。存放在 `cache/dalvik_cache` 目录下。保存格式为 `apk路径 @ apk名 @ classes.dex`。这样以空间换时间大大缩短读取/加载dex文件的过程。

#### ART
Android Runtime（缩写为ART），是一种在 Android 操作系统上的运行环境，由 Google 公司研发，并在2013年作为 Android 4.4 系统中的一项测试功能正式对外发布，在 Android 5.0 及后续Android版本中作为正式的运行时库取代了以往的Dalvik虚拟机。ART能够把应用程序的字节码转换为机器码，是Android所使用的一种新的虚拟机。


- [Android 运行时 | loody's blog](http://loody.github.io/2017/03/30/Dalvik%20vs%20ART/)