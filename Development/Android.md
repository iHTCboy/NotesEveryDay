[TOC]

### Android Studio
#### Android Studio 真机测试
- 第一步：打开手机USB调试 
  首先，打开手机”设置->>我的设备->>全部参数->>MIUI版本”，连续点击7次，进入开发者模式。 
  其次，”设置->>更多设置->>开发者选项”，打开“USB调试”和“USB安装”.

- 第二步：设置Android studio 
  打开Android studio工程，”Run->>Edit configurations”如下图位置，选择“Open Select Deployment Target Dialog”,这个是每次在调试时弹出设备选择框。注意：如果直接选择“USB Device”的话，可能调试时会找到不到手机设备. 


- [(Mac)Android studio真机测试](https://www.jianshu.com/p/beb10cba514c)

---------------------


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


#### AVD（Android Virtual Device）

安装 apk 时报错：
```
The APK failed to install.
Error: INSTALL_FAILED_NO_MATCHING_ABIS
```

```
The APK failed to install.
Error: Could not parse error string
```

产生原因：
为了让AVD获取最佳运行速度，AS在安装AVD时往往会建议使用与你的pc机相同的cpu架构，即默认为x86架构，而apk使用的是ARM架构，这就造成了不兼容。

解决方法：
1. 在AS中安装一个ARM架构的AVD。
2. 编译成apk时，可以在选项中将程序修改为x86。


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

### Android 开发

#### Android 保持屏幕常亮

Java:
```java
getWindow().addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
```

Kotlin:
```kotlin
window.addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)
```

- [使设备保持唤醒状态  | Android Developers](https://developer.android.com/training/scheduling/wakelock?hl=zh-cn)

#### Android获取和设置屏幕亮度
在Androidmanifast.xml中添加如下权限：

```xml
<uses-permission android:name="android.permission.WRITE_SETTINGS"/>
```

获取屏幕亮度的 Kotlin 代码：

```kotlin
var screenBrightness: Float = window.attributes.screenBrightness
```

设置屏幕亮度的 Kotlin 代码：
```kotlin
private fun changeSystemBrightness(brightness: Float) {
        if (hasPermissionsToWriteSettings(this)) {
            //已获取权限
            val lp = window.attributes
            lp.screenBrightness = brightness
            window.attributes = lp
        } else {
            //拒绝了权限
            val intent = with(Intent(Settings.ACTION_MANAGE_WRITE_SETTINGS)) {
                   data = Uri.parse("package:$packageName")
                   this
            }
            startActivityForResult(intent, 100)
        }
    }

    private fun hasPermissionsToWriteSettings(context: Activity): Boolean {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            Settings.System.canWrite(context)
        } else {
            ContextCompat.checkSelfPermission(context, Manifest.permission.WRITE_SETTINGS) == PackageManager.PERMISSION_GRANTED
        }
    }
```


#### 安卓角标数字

安卓应用的角标是由Launcher支持的，而原生的Android系统Launcher并没有提供角标支持，所以各大手机厂商只能自己定制Launcher来实现，然后提供接口给外部使用。

Android 8.0 及之后的版本Google官方API支持通过发送系统通知的方式设置应用角标，但是不支持显示数量，而是一个小圆点。

- [安卓应用角标那些事儿 - 简书](https://www.jianshu.com/p/f429777f798d)
- [2020年android 最新的角标适配方案_炭烤葫芦娃的博客-CSDN博客_android 角标适配](https://blog.csdn.net/qq_35501560/article/details/107281489)
- [leolin310148/ShortcutBadger: An Android library supports badge notification](https://github.com/leolin310148/ShortcutBadger)


#### Android 获取手机厂商、系统版本等信息


```kotlin
    private fun getAppVersionCode(): Long {
        val versionCodde: Long =
                // avoid huge version numbers and you will be ok
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
                    packageManager.getPackageInfo(packageName, 0).longVersionCode
                } else {
                    packageManager.getPackageInfo(packageName, 0).versionCode.toLong()
                }
        return versionCodde
    }
```

获取手机名称:
```java
  String phoneName = android.os.Build.MODEL;
```

获取系统SDK版本号:
```
 int phoneSDK = Build.VERSION.SDK_INT;
```

获取手机系统版本号:
```
String phoneVersion = android.os.Build.VERSION.RELEASE;
```

```android
android.os.Build.BOARD：获取设备基板名称
android.os.Build.BOOTLOADER：获取设备引导程序版本号
android.os.Build.BRAND：获取设备品牌

android.os.Build.CPU_ABI：获取设备指令集名称（CPU的类型）

android.os.Build.CPU_ABI2：获取第二个指令集名称

android.os.Build.DEVICE：获取设备驱动名称
android.os.Build.DISPLAY：获取设备显示的版本包（在系统设置中显示为版本号）和ID一样
android.os.Build.FINGERPRINT：设备的唯一标识。由设备的多个信息拼接合成。

android.os.Build.HARDWARE：设备硬件名称,一般和基板名称一样（BOARD）

android.os.Build.HOST：设备主机地址
android.os.Build.ID：设备版本号。

android.os.Build.MODEL ：获取手机的型号 设备名称。
android.os.Build.MANUFACTURER：获取设备制造商
android:os.Build.PRODUCT：整个产品的名称

android:os.Build.RADIO：无线电固件版本号，通常是不可用的 显示unknown
android.os.Build.TAGS：设备标签。如release-keys 或测试的 test-keys 

android.os.Build.TIME：时间

android.os.Build.TYPE：设备版本类型  主要为"user" 或"eng".

android.os.Build.USER：设备用户名 基本上都为android-build

android.os.Build.VERSION.RELEASE：获取系统版本字符串。如4.1.2 或2.2 或2.3等

android.os.Build.VERSION.CODENAME：设备当前的系统开发代号，一般使用REL代替
android.os.Build.VERSION.INCREMENTAL：系统源代码控制值，一个数字或者git hash值

android.os.Build.VERSION.SDK：(已弃用)系统的API级别，请使用 SDK_INT 来查看
android.os.Build.VERSION.SDK_INT：系统的API级别 数字表示
```


#### 隐藏Android模拟器的虚拟按键

**原理**
修改system下的build.prop文件内的参数

**修改方法**

1.找到指定的AVD模拟器的配置文件，一般路径如下：
[用户根目录]/.android/avd/ [模拟器名字].avd/config.ini
2.将下面两个属性改为yes即可
```
hw.dPad = yes
hw.mainKeys = yes
```

- [隐藏导航栏  | Android Developers](https://developer.android.google.cn/training/system-ui/navigation?hl=zh-cn)

#### 安卓App上架

| 市场 | 开放平台官网 | 审核条款 | 审核要求 | 费用要求 |
|---|---|---|--|--|
| App Store	| https://developer.apple.com |  [App Store 审核指南 - Apple Developer](https://developer.apple.com/cn/app-store/review/guidelines/)  |  不需要《计算机软件著作权》 | 每年年费￥688元 |
| Google Play	| https://play.google.com/apps/publish/?hl=zh-CN | [政策中心 - Play 管理中心帮助](https://support.google.com/googleplay/android-developer/topic/9858052?hl=zh-Hans)  |  不需要《计算机软件著作权》 | 一次性支付 25 美元的注册费 |
| 应用宝	| http://open.qq.com/ | [应用上架规则 - 腾讯开放平台](https://wiki.open.qq.com/wiki/%E5%BA%94%E7%94%A8%E4%B8%8A%E6%9E%B6%E8%A7%84%E5%88%99)  | 必须《计算机软件著作权》 | 无 |
| 百度手机助手 | http://app.baidu.com/ | [审核规范 - 百度移动应用平台](http://app.baidu.com/docs?id=18&frompos=401009)  | 注册不成功，原因：网站bug | 无 |
| 360 手机助手 | http://dev.360.cn/ | [应用发布规则 - 360移动开放平台](http://dev.360.cn/wiki/index/id/18) | 未知 | 未知 |
| vivo 应用商店	| https://dev.vivo.com.cn/ | - | 不接受个人开发者注册 | 未知 |
| OPPO 软件商店（一加）| http://open.oppomobile.com/ |  [OPPO开放平台](https://open.oppomobile.com/wiki/doc#id=10071) | 不接受个人开发者发布应用 | 未知 |
| 小米应用商店	| https://dev.mi.com/ | [应用审核规范](https://dev.mi.com/console/doc/detail?pId=879) | 不需要《计算机软件著作权》。但应用不得是简单的网站页面打包或套用模板、内容聚合或罗列链接，参考[小米应用商店审核规范](https://dev.mi.com/console/doc/detail?pId=879) | 无 |
| 华为应用市场	| http://developer.huawei.com/consumer/cn/ | [华为应用市场审核指南](https://developer.huawei.com/consumer/cn/doc/50104) |不需要《计算机软件著作权》 | 无 |
| 阿里应用分发平台（豌豆荚）| http://open.uc.cn/ | - | 当前市场已存在大量相似的此类应用，如需收录，请补充提交《计算机软件著作权》。 | 无 |
| 搜狗手机助手 | http://zhushou.sogou.com/open/ | - | 未知 | 未知 |
| 锤子应用商店 | http://dev.smartisan.com/ | - | 未知 | 无 |
| 魅族应用商店 | http://open.flyme.cn/ | [审核规范 - 魅族开放平台](http://open-wiki.flyme.cn/doc-wiki/index#id?110) | 不需要《计算机软件著作权》 | 无 |
| 金立软件商店 | http://open.appgionee.com/ | - | 未知 | 无 |
| 安智市场 | http://dev.anzhi.com/ | - | 2020年2月起，安智市场不再免费收录软件（包括新软件/下架重新上架），软件必须付费上架或CPD推广且软件需要符合上架审核标准。 | 无 |
| 酷安市场 | https://developer.coolapk.com | - | 不需要《计算机软件著作权》 | 无 |
| 联想乐商店 | http://open.lenovo.com/ | - | 未知 | 未知 |
| 三星应用开发者平台 | http://support-cn.samsung.com/App/DeveloperChina/Home/Index | - | 未知 | 未知 |

注：不得不佩服国内的安卓市场，除了华为应用市场被拒后能回复和申诉，其它市场就是一个消息通知，真的一言难尽！


#### apk签名

用指定的 keystore 签名apk：

```
jarsigner -verbose -keystore xxx.jks -signedjar xxx_signed.apk xxx.apk alias_key
```

注：最后一个参数是 keyalias，也就是该签名文件的别名。