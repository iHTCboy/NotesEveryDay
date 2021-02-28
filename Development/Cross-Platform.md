[TOC]

### Flutter 
- [Flutter - Beautiful native apps in record time](https://flutter.dev/)
- [Flutter 中文社区](https://flutter.cn/)

#### 安装
- [Install - Flutter](https://flutter.dev/docs/get-started/install)

**macOS install**

```
git clone https://github.com/flutter/flutter.git
```

根据需要切换选择分支，比如用下面的参数获得稳定版本：
```
git clone https://github.com/flutter/flutter.git -b stable --depth 1
```

配置 flutter 的 PATH 环境变量：
> 修改 .bash_profile (如果安装了oh-my-zsh就添加到 .zshrc)
```
export PATH=[克隆项目的目录]/flutter/bin:$PATH
```

> 注：验证 flutter 命令是否可用，可以执行下面的命令检测：`which flutter`


开发二进制文件预下载（`可选操作`）:
> flutter 命令行工具会下载不同平台的开发二进制文件，如果需要一个封闭式的构建环境，或在网络可用性不稳定的情况下使用等情况，你可能需要通过下面这个命令预先下载 iOS 和 Android 的开发二进制文件：

```
flutter precache
```

> 注：或者只预下载某个平台 `flutter precache --ios`，更多使用方式，请使用 `flutter help precache` 命令查看。


运行Flutter的环境检查：
> 查看当前环境是否需要安装其他的依赖（如果想查看更详细的输出，增加一个 -v 参数即可）：
```
flutter doctor
```

Android 环境：
1、下载并安装 [Android Studio](https://developer.android.google.cn/studio)。
2、运行 Android Studio，并进入 `Android Studio Setup Wizard`(Android Studio 设置向导)，这会安装最新的 Android SDK， Android SDK Platform-Tools 以及 Android SDK Build-Tools，这些都是在开发 Android Flutter 应用时所需要的。

```bash
brew cask install android-platform-tools
```


**注意：**
> flutter 工具使用了 Google Analytics 来对基本使用情况和**崩溃报告**进行匿名的统计。这些数据用来帮助改善 Flutter 工具。
>  
> 在第一次运行或者任何涉及到 flutter config 的信息都不会进行发送，所以你可以在发送分析数据之前选择禁止分析数据的统计。要禁用这一功能，只需要输入 `flutter config --no-analytics` 即可，想要查看当前设置使用命令 `flutter config`。如果你禁用了统计信息发送，这次的禁用行为会被记录发送，其他任何信息，以及未来都不会再有任何数据会被记录。
>  
> 自 1.19.0 dev 版开始，dart 命令就直接包含在 Flutter SDK 里了，这样可以更轻松的运行 Dart 命令行应用。

在 macOS、Linux 和 chromeOS 的命令可以帮助你查看你的 flutter 和 dart 命令是否位于同一目录以确保兼容。部分 Windows 系统也支持类似 where 的命令：

```bash
$ which flutter dart
  /path-to-flutter-sdk/bin/flutter
  /path-to-flutter-sdk/bin/dart
```
注：了解更多关于 dart 命令的内容，可以在命令行运行 `dart -h`，或者在 Dart 文档查看 [dart tool](https://dart.cn/tools/dart-vm) 了解更多。


#### 更新
- [Upgrading Flutter - Flutter](https://flutter.dev/docs/development/tools/sdk/upgrading)
- [升级你的 Flutter 版本](https://flutter.cn/docs/development/tools/sdk/upgrading)

```
flutter upgrade
```

#### Create a Flutter app
```
flutter create myApp
```

#### 运行
```
flutter run
```

**Release:**
```
flutter run --release
```

#### 其它命令
切换到官方master开发主分支：
```
flutter channel master
```

#### 发布


- [打包并发布 Android 应用 - Flutter 中文文档](https://flutter.cn/docs/deployment/android)
- [发布应用 | Android 开发者](https://developer.android.google.cn/studio/publish)


#### 常见问题
**键盘弹起时遮挡输入框**


1、在TextFiled外面加Padding
MediaQuery.of(context).viewInsets.bottom是键盘弹起时、获取到的键盘高度：

```flutter
Padding(
  padding: EdgeInsets.only(
    bottom: MediaQuery.of(context).viewInsets.bottom
  ),
  child: TextField(
    controller: _controller,
  )
)
```

2、在 main widget 外加 SingleChildScrollView 及其属性 reverse: true
body 和 SingleChildScrollView 之间的代码作用是：键盘弹出时，点击页面空白部分、键盘会收起：

```flutter
body: GestureDetector(
    behavior: HitTestBehavior.translucent,
    onTap: () {
      FocusScope.of(context).requestFocus(FocusNode());
    },
    child: SingleChildScrollView(
      reverse: true,
      child: ......
    )
)
```

3、在Scaffold 里添加属性 resizeToAvoidBottomInset: false

```flutter
return Scaffold(
    resizeToAvoidBottomInset: false,
    .....
)
```

#### 常见错误

**问题： Dart Error: Can't load Kernel binary: Invalid kernel binary format version.**

原因: flutter 和 engine 版本不一致

解决方案: 
  1. 删除 flutter 目录下的 `bin/cache` 文件夹
  2. 然后运行 `flutter doctor` 或 `flutter upgrade` 运行后在重启

**问题：cp: flutter/bin/cache/artifacts/engine/ios/Flutter.podspec: No such file or directory**

解决方案：`flutter build ios`

**问题：Android Studio 运行flutter卡在: Running Gradle task 'assembleDebug'...**

原因: Gradle的Maven仓库在国外，下载更新速度非常慢

解决方案：使用阿里云的镜像地址

1. flutter项目中的 `android/build.gradle` 文件：

```
buildscript {  
    ext.kotlin_version = '1.3.50'  
    repositories {  
        // 这里做了修改，使用国内阿里的代理  
        // google()  
        // jcenter()  
        maven { url 'https://maven.aliyun.com/repository/google' }  
        maven { url 'https://maven.aliyun.com/repository/jcenter' }  
        maven { url 'http://maven.aliyun.com/nexus/content/groups/public' }  
    }  
    dependencies {  
        classpath 'com.android.tools.build:gradle:4.1.0'
        classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version"  
  }  
}  
  
allprojects {  
    repositories {  
        //修改的地方  
        //google()  
        //jcenter()  
        maven { url 'https://maven.aliyun.com/repository/google' }  
        maven { url 'https://maven.aliyun.com/repository/jcenter' }  
        maven { url 'http://maven.aliyun.com/nexus/content/groups/public' }  
    }
}
```

2. 修改本地flutter安装目录中的flutter.gradle文件 `flutter\packages\flutter_tools\gradle\flutter.gradle` ：

```
buildscript {
    repositories {
        // 这里做了修改，使用国内阿里的代理
        // google()
        // jcenter()
        maven { url 'https://maven.aliyun.com/repository/google' }
        maven { url 'https://maven.aliyun.com/repository/jcenter' }
        maven { url 'http://maven.aliyun.com/nexus/content/groups/public' }
    }
    dependencies {
        classpath 'com.android.tools.build:gradle:4.1.0'
    }
}
```

**问题：Exception in thread "main" java.lang.NoClassDefFoundError: javax/xml/bind/annotation/XmlSchema**

解决方案：执行 `flutter doctor --android-licenses` 时报错。更改为 `sudo flutter doctor --android-licenses` 即可。



#### 进阶资料

* [flutter/samples: A collection of Flutter examples and demos.](https://github.com/flutter/samples)
* [flutter/gallery: Flutter Gallery is a resource to help developers evaluate and use Flutter](https://github.com/flutter/gallery)
* [iOS Developer Learning Flutter](https://ithelp.ithome.com.tw/articles/10237645)
* [Flutter实战 | 杜文](https://book.flutterchina.club/)
* [Flutter实战入门 | 老孟](http://laomengit.com/guide/introduction/mobile_system.html)


### Dart

- [Dart programming language | Dart](https://dart.dev/)
- [Dart 中文文档 | Dart](https://dart.cn/)
- [Dart packages](https://pub.dev/)



### React Native（RN）


### 资源
#### Font（字体）

- [Fonts - Google Fonts](https://fonts.google.com)
- [Iconfont - 阿里巴巴矢量图标库](https://www.iconfont.cn/)