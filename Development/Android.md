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


#### 项目结构
Project模式下目录：

**.gradle 和 .idea**
主要放置的都是 Android studio 自动生成的一些文件。

**app**
项目的代码资源等内容都在这个目录

**gradle**
包含 gradle wrapper 的配置文件

**.gitignore**
用来将指定的目录或文件排除在版本控制之外的

**build.gradle**
这是项目全局的 gradle 构建脚本。

**gradle.properties**
这个文件是全局的gradle的配置文件，在这里配置的属性将会影响到项目中所有的gradle编译脚本。

**gradlew 和 gradlew.bat**
这两个文件是用来在命令行中执行 gradle 命令的，其中 gradlew 是在 Linux 和 macOS 系统中使用，而 gradlew.bat 是在Windows 系统中使用。

**local.properties**
用来指定本机中的 Android sdk 路径，通常内容都是自动生成，我们并不需要修改。

**settings.gradle**
用于指定项目中所有引入的模块，通常情况下模块的引入都是自动完成的,需要我们手动去修改的这个文件的场景可能比较少。

**.iml**
.iml文件是所有 IntelliJ IDEA 项目都会自动生成的一个文件，用于标识这是一个IntelliJ IDEA项目，我们不需要修改这个文件中的任何内容。



App目录下的结构：

**build**
主要是包含了一些在编译中自动生成的文件。

**libs**
如果你的项目中使用了第三方jar包,就需要把这些jar包都放在libs目录下,放在这个目录下的jar包都会被自动添加到构建路径里去。


src子目录:

**androidTest**
用来编写 Android Test 测试用例的，可以对项目进行一些自动化测试。

**java**
放置java代码的地方

**res**
为 resource 的缩写，界面 UI 相关资源，也就是非程序代码的资源，如 layout、图像与文本。


**AndroidManifest.xml**
整个 Android 项目的配置文件，在程序中自定义的所有四大组件都需要在这个文件里注册，另外还可以在这个文件中给应用程序添加权限声明。

**test**
用来编写 Unit Test测试用例的，是对项目进行自动化测试的另一种方式。


**.gitignore**
用来将指定的目录或文件排除在版本控制之外的。


**build.gradle**
这是app模块的gradle构建脚本，这个文件中会指定很多项目构建相关的配置。

**proguard-rules.pro**
这个文件用于指定项目代码的混淆规则，当代码开发完成后打开安装包文件，如果不希望代码被别人破解，通常会将代码进行混淆，从而让破解者难以阅读。



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