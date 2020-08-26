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

注：更多使用方式，请使用 `flutter help precache` 命令查看。

运行Flutter的环境检查：
> 查看当前环境是否需要安装其他的依赖（如果想查看更详细的输出，增加一个 -v 参数即可）：
```
 flutter doctor
```

Android 环境：
1、下载并安装 [Android Studio](https://developer.android.google.cn/studio)。
2、运行 Android Studio，并进入 `Android Studio Setup Wizard`，这会安装最新的 Android SDK， Android SDK Platform-Tools 以及 Android SDK Build-Tools，这些都是在开发 Android Flutter 应用时所需要的。

```
brew cask install android-platform-tools
```



**注意：**
> flutter 工具使用了 Google Analytics 来对基本使用情况和 崩溃报告 进行匿名的统计。这些数据用来帮助改善 Flutter 工具。
>  
> 在第一次运行或者任何涉及到 flutter config 的信息都不会进行发送，所以你可以在发送分析数据之前选择禁止分析数据的统计。要禁用这一功能，只需要输入 flutter config --no-analytics 即可，想要查看当前设置使用命令 flutter config。如果你禁用了统计信息发送，这次的禁用行为会被记录发送，其他任何信息，以及未来都不会再有任何数据会被记录。
>  
> 自 1.19.0 dev 版开始，dart 命令就直接包含在 Flutter SDK 里了，这样可以更轻松的运行 Dart 命令行应用。

在 macOS、Linux 和 chromeOS 的命令可以帮助你查看你的 flutter 和 dart 命令是否位于同一目录以确保兼容。部分 Windows 系统也支持类似 where 的命令：

```
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

### Dart


### React Native（RN）

