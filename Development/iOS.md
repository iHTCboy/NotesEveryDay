[TOC]


### CocoaPods

#### Cocoapods 报错问题

```console
- ERROR | [iOS] unknown: Encountered an unknown error (Could not find a `ios` simulator (valid values: ). Ensure that Xcode -> Window -> Devices has at least one `ios` simulator listed or otherwise add one.) during validation.
```

需要在Xcode中创建模板器


#### Cocoapods 配置问题

- [Xcode 编辑器之关于Other Linker Flags相关问题 - 梁飞宇 - 博客园](https://www.cnblogs.com/lxlx1798/p/11219101.html)
- [细聊 Cocoapods 与 Xcode 工程配置](https://bestswifter.com/cocoapods/)

### SDWebImage

#### SDWebImage 占位图是GIF处理

```objc
[cell.ImageView sd_setImageWithURL:[NSURL URLWithString:ImageUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image == nil) {
            UIImage *img = [UIImage sd_animatedGIFNamed:@"xxx.gif"];
            cell.goodImgV.image = img;
        }
    }];
```

---

### Xcode

#### Xcode10 打SDK库失败
解决方法，在脚本增加 -UseModernBuildSystem=NO ，原因是Xcode10使用新build系统，导致 xcodebuild 只会编译一个
相似的反馈：https://github.com/facebook/react-native/issues/19573

好像新build系统速度提升很好，了解更多新build系统：
https://medium.com/xcblog/xcode-new-build-system-for-speedy-swift-builds-c39ea6596e17


#### Xcode10：library not found for -lstdc++.6.0.9 临时解决 

Xcode 10中将libstdc++.6.0.9库文件删除，SDK依赖 libstdc++.6.0.9 的会在Xcode 10无法运行，解决方案：

https://blog.csdn.net/ZuoWeiXiaoDuZuoZuo/article/details/82756116?utm_source=copy 

#### 真机运行库

在终端输入以下命令打开Xcode的lib库目录（此目录位安装的默认目录）

```console
open /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/usr/lib
```

把刚刚下载的zip文件解压获取到的 真机的 libstdc++.6.0.9.tbd 文件，扔进去


##### 模拟器运行库

在终端输入以下命令打开Xcode的lib库目录（此目录位安装的默认目录）

```console
open  /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk/usr/lib
```

把刚刚下载的zip文件解压获取到的 模拟器的 libstdc++.6.0.9.tbd 文件，扔进去

##### 下一步

重启Xcode

---

#### 在UILabel的NSAttributedText中创建可点击的“链接”？

- [How to Create Multiple Tappable Links in a UILabel](https://samwize.com/2016/03/04/how-to-create-multiple-tappable-links-in-a-uilabel/)
- [ios - Create tap-able "links" in the NSAttributedString of a UILabel? - Stack Overflow](http://stackoverflow.com/questions/1256887/create-tap-able-links-in-the-nsattributedtext-of-a-uilabel)


####  Link With Standard Libraries > YES
默认是YES，编译器在链接时会自动使用标准库的链接器；
看官方的文档，如果设置为NO，需要配置 Other Linker Flags 来指定链接器。

- [Xcode Build System Guide - Apple Developer](https://developer.apple.com/library/archive/documentation/DeveloperTools/Reference/XcodeBuildSettingRef/1-Build_Setting_Reference/build_setting_ref.html#//apple_ref/doc/uid/TP40003931-CH3-DontLinkElementID_217)


#### Xcode 自定义快捷键
复制文件：
```console
/Applications/Xcode.app/Contents/Frameworks/IDEKit.framework/Versions/A/Resources/IDETextKeyBindingSet.plist
```
增加自定义配置：
```json
        <key>Customized</key>
        <dict>
            <key>HTC Duplicate Current Line</key>
            <string>selectLine:, copy:, moveToEndOfLine:, insertNewline:, paste:, deleteBackward:</string>
            <key>HTC Delete Current Line</key>
            <string>moveToEndOfLine:, deleteToBeginningOfLine:, deleteBackward:, moveDown:, moveToEndOfLine:</string>
            <key>HTC Move Current Line Up</key>
            <string>selectLine:, cut:, moveUp:, moveToBeginningOfLine:, insertNewLine:, paste:, moveBackward:</string>
            <key>HTC Move Current Line Down</key>
            <string>selectLine:, cut:, moveDown:, moveToBeginningOfLine:, insertNewLine:, paste:, moveBackward:</string>
            <key>HTC Insert Line Above</key>
            <string>moveUp:, moveToEndOfLine:, insertNewline:</string>
            <key>HTC Insert Line Below</key>
            <string>moveToEndOfLine:, insertNewline:</string>
        </dict>
```

替换原来文件，重新打开Xcode，就可以搜索查看和定义快捷键

- [Xcode 自定义快捷键 - 简书](https://www.jianshu.com/p/65299ebe77d4)


#### LLDB

LLDB 通用结构的形式如下：

```console
<command> [<subcommand> [<subcommand>...]] <action> [-options [option-value]] [argument [argument...]]
```

| 指令  | 全称  | 作用 |
|---|---|---|
| | apropos | 帮助命令，通过 apropos + xxx 命令可以找到xxx所有相关的命令信息。 |
| p | print  | 输出原生类型（boolean、integer、float、etc）的信息  |
| po | print object | 输出objective-c中对象（objects）的信息. (为 `e -o` 的别名) |
| e | expression | 可以执行表达式。expression 其实就是 p/print/call、`expression -o` 就是 po 。|
|   |   |   |
| b | breakpoint | 设置断点. (可在运行过程中添加) |
| br li | breakpoint list | 列出所有断点 |
|   | breakpoint delete | 删除所有断点（可跟组号删除指定组） |
|   | breakpoint disable/enable | 禁用、启用指定断点 |
|   | breakpoint set -r some | 遍历整个项目中包含 some 这个字符的所有方法并设置断点 |
|   |   |   |
| c | continue |  单步调试 |
| n | thread step-over/next | 当前线程下一步（以一个完整子函数为一步） |
| ni | thread step-inst-over | 当前线程下一步（以一个汇编函数为一步） |
| s | thread step-in/step | 当前线程下一步（遇到子函数就进入并且继续单步执行）|
| si | thread step-inst-over | 当前线程下一步（遇到汇编函数就进入并且继续单步执行汇编指令） |
| finish | thread step-out | 退出当前帧栈 |
|   |   |   |
|   | image | 可用于寻址，有多个组合命令。常用于寻找栈地址对应的代码位置, 用于查错(能定位出错误代码行数)。 |
|   | image lookup | `image lookup --address 0x1af8`：在可执行文件或任何共享库中查找原始地址信息。<br> `image lookup -v --address 0x1af8`：查找完整的源代码行信息。<br> `image lookup --type NSString`：根据名称查找对应（NSString）类型的信息。 |
|   |   |   |
|   | register read | 显示当前线程的通用寄存器。 |
|   | register write | `register write rax 123`：将一个新的十进制值“123”写入当前线程寄存器“rax”。|
|   | memory read | `memory read --size 4 --format x --count 4 0xbffff3c0`：从地址0xbffff3c0读取内存，并显示4个十六进制uint32_t值。 |
|   |   |   |
| bt | thread backtrace | 打印调用堆栈 |
|   | thread backtrace all | 列出所有线程的堆栈 |
|   | thread list | 列出所有线程 |
|   | thread return | 可用来控制程序流程, 伪造返回值 |
|   | frame variable | 获取全部变量值 |
|   | watchpoint | 监听某个实例的变化. (等同于在Xcode调试变量窗口—>右键某个变量—>Watch xx) 注意: watchpoint是分类型的，包括read，write或者read_write类型. 通过Xcode右键添加的只能是write类型. |
|   |   |   |


- [GDB to LLDB command map — The LLDB Debugger](https://lldb.llvm.org/use/map.html)
- [Tutorial — The LLDB Debugger](https://lldb.llvm.org/use/tutorial.html)
- [LLDB 知多少 - 掘金](https://juejin.im/post/6844903805398548493)

### iOS

#### iOS 处理器指令集架构 

2018 A12芯片arm64e ： iphone XS、 iphone XS Max、 iphoneXR
2017 A11芯片arm64： iPhone 8, iPhone 8 Plus, and iPhone X
2016 A10芯片arm64：iPhone 7 , 7 Plus, iPad (2018)
2015 A9芯片arm64： iPhone 6S , 6S Plus 
2014 A8芯片arm64： iPhone 6 , iPhone 6 Plus
2013 A7芯片arm64： iPhone 5S
armv7s：iPhone5｜iPhone5C｜iPad4(iPad with Retina Display)
armv7：iPhone4｜iPhone4S｜iPad｜iPad2｜iPad3(The New iPad)｜iPad mini｜iPod Touch 3G｜iPod Touch4 | iPod Touch5
ARMv6：iPhone, iPhone 3G, iPod 1G/2G

模拟器32位处理器测试需要i386架构，
模拟器64位处理器测试需要x86_64架构，
真机32位处理器需要armv7,或者armv7s架构，
真机64位处理器需要arm64架构。


- [iPhone CPU架构 - 掘金](https://juejin.im/post/5c1234cde51d4524a923f83e)
- [iOS 指令集架构 armv6、armv7、armv7s、arm64、arm64e、x86_64、i386 - Belinda_sl - 博客园](https://www.cnblogs.com/lulushen/p/8135269.html)
- [关于Xcode “Build Setting”中的Architectures详解 - 崩月姐姐之家](http://bengyuejiejie.github.io/blog/2015/03/09/first-blog/)
- [ios - Xcode arm64 Vs arm64e - Stack Overflow](https://stackoverflow.com/questions/52624308/xcode-arm64-vs-arm64e)
- [Armv8-A: 2016 additions - Processors blog - Processors - Arm Community](https://community.arm.com/developer/ip-products/processors/b/processors-ip-blog/posts/armv8-a-architecture-2016-additions)

#### WKWebView如何清除缓存

```objc
- (void)deleteWebCache {
    //allWebsiteDataTypes清除所有缓存
    if (@available(iOS 9.0, *)) {
        NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
        NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
                NSLog(@"[Web log]: deleteWebCache completion~");
        }];
    }
}
```


#### Home Indicator 问题

- [iPhoneX适配之Home-Indicator | 凌云的博客](http://lingyuncxb.com/2018/01/28/iPhoneX%E9%80%82%E9%85%8D%E4%B9%8BHome-Indicator/)
- [关于iPhone X下Home键的隐藏和延迟响应 - 掘金](https://juejin.im/post/5a7c1a66f265da4e9b590126)

---

#### iOS证书&签名

- [iOS App 签名的原理 « bang’s blog](http://blog.cnbang.net/tech/3386/)
- [iOS开发者证书以及代码签名学习笔记 | Enki's Notes](http://www.enkichen.com/2016/01/15/ios-certification-and-code-sign-note/)
- [漫谈iOS程序的证书和签名机制](https://segmentfault.com/a/1190000004144556)

---

#### 从App里用代码读取证书信息

```objc
//取出embedded.mobileprovision这个描述文件的内容进行判断
    NSString *mobileProvisionPath = [[NSBundle mainBundle] pathForResource:@"embedded" ofType:@"mobileprovision"];
    NSData *rawData = [NSData dataWithContentsOfFile:mobileProvisionPath];
    NSString *rawDataString = [[NSString alloc] initWithData:rawData encoding:NSASCIIStringEncoding];
    NSRange plistStartRange = [rawDataString rangeOfString:@"<plist"];
    NSRange plistEndRange = [rawDataString rangeOfString:@"</plist>"];
    if (plistStartRange.location != NSNotFound && plistEndRange.location != NSNotFound) {
        NSString *tempPlistString = [rawDataString substringWithRange:NSMakeRange(plistStartRange.location, NSMaxRange(plistEndRange))];
        NSData *tempPlistData = [tempPlistString dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *plistDic =  [NSPropertyListSerialization propertyListWithData:tempPlistData options:NSPropertyListImmutable format:nil error:nil];
        NSLog(@"plistDic: %@", plistDic);
    }
```

- [iOS-如何判断安装的APP被第三方企业证书重新签名](https://www.jianshu.com/p/b1cf329e1ca8)
- [iOS重签名了解一下](https://www.jianshu.com/p/ad5e3a2ec6d9)

---


#### 通过Safari获取iOS设备真实UDID

- [Configuration Profile Examples](https://developer.apple.com/library/archive/documentation/NetworkingInternet/Conceptual/iPhoneOTAConfiguration/ConfigurationProfileExamples/ConfigurationProfileExamples.html)
- [通过Safari浏览器获取iOS设备UDID(设备唯一标识符) - FengHongSeXiaoXiang的博客 - CSDN博客](https://blog.csdn.net/FengHongSeXiaoXiang/article/details/82825046)
- [shaojiankui/iOS-UDID-Safari: iOS-UDID-Safari,（不能上架Appstore！！！）通过Safari获取iOS设备真实UDID，use safari and mobileconfig get ios device real udid](https://github.com/shaojiankui/iOS-UDID-Safari)

---

#### 自定义 iOS Web Clip 图标

- [使用 Apple Configurator 2 自定义 iOS Web Clip 图标 - 少数派](https://sspai.com/post/43352)


---

#### genstrings命令与字符串本地化

```objc
#define NSLocalizedString(key, comment) \
	    [NSBundle.mainBundle localizedStringForKey:(key) value:@"" table:nil]

#define NSLocalizedStringFromTable(key, tbl, comment) \
	    [NSBundle.mainBundle localizedStringForKey:(key) value:@"" table:(tbl)]

#define NSLocalizedStringFromTableInBundle(key, tbl, bundle, comment) \
	    [bundle localizedStringForKey:(key) value:@"" table:(tbl)]

#define NSLocalizedStringWithDefaultValue(key, tbl, bundle, val, comment) \
	    [bundle localizedStringForKey:(key) value:(val) table:(tbl)]
```

方法:
```objc
NSLocalizedString(@"key", @"My comment")

/* My comment */
"key" = "value";
```

扫描当前文件夹下所有.m文件的宏，生成Localizable.strings文件并放到en.lproj文件夹下:

```console
$ find . -name \*.m | xargs genstrings -o en.lproj 
```

指定的输出目录下生成 `TableName.strings` 文件，然后添加记录和注释:
```objc
NSLocalizedStringFromTable(@"key", @"TableName", @"My comment")
```

下面三句的作用是一样的，都是读取苹果指定名字为 `Localizable.strings` 的内容，其中第三种简化后就是苹果对 `NSLocalizedString` 宏的定义：

```objc
NSLocalizedString(@"key", @"My comment");
NSLocalizedStringFromTable(@"key", @"Localizable", @"My comment");
NSLocalizedStringFromTable(@"key", nil, @"My comment");
```

#### Deferred Deep Linking in iOS
- [iOS Deferred Deep Link 延遲深度連結實作(Swift) - ZRealm Dev. - Medium](https://medium.com/zrealm-ios-dev/ios-deferred-deep-link-%E5%BB%B6%E9%81%B2%E6%B7%B1%E5%BA%A6%E9%80%A3%E7%B5%90%E5%AF%A6%E4%BD%9C-swift-b08ef940c196)
- [iOS App与浏览器深度链接 - 简书](https://www.jianshu.com/p/fa48387d56ea)
- [Deferred Deep Linking in iOS Swift 3.0 with Universal Link | InnovationM Blog](http://blogs.innovationm.com/deferred-deep-linking-in-ios-with-universal-link/)
- [Deferred Deep Linking in iOS](https://stackoverflow.com/questions/25855618/deferred-deep-linking-in-ios)
- [Promoting Apps with Smart App Banners](https://developer.apple.com/library/archive/documentation/AppleApplications/Reference/SafariWebContent/PromotingAppswithAppBanners/PromotingAppswithAppBanners.html)
- [iOS10 SFSafariViewController not working when alpha is set to 0](https://stackoverflow.com/questions/39019352/ios10-sfsafariviewcontroller-not-working-when-alpha-is-set-to-0)

#### App Groups 和 Keychain Access Groups
- [在多个app之间共享钥匙串项（Sharing Access to Keychain Items Among a Collection of Apps）](https://www.heminghui.top/fanyi/45.html)

#### copy 和 mutableCopy 返回的对象是执行的深拷贝还是浅拷贝呢？

* 系统的非容器类对象，如: NSString、NSMutableString、NSNumber 等。
* 系统的容器类对象，如: NSArray、NSMutableArray、NSDictionary、NSMutableDictionary 等。

1. 对于系统的非容器类对象，如果对一不可变对象(如 NSString)复制，copy 是指针复制(浅拷贝)和 mutableCopy 就是对象复制(深拷贝); 如果是对可变对象(如 NSMutableString)复制，copy 和 mutableCopy 都是深拷贝，但是 copy 返回的对象是不可变的。
2. 对于系统的容器类对象，对不可变对象(如 NSArray)进行复制，copy 是指针复制(浅拷贝)， mutableCopy 是对象复制(深拷贝), 但是不管是 copy 还是 mutableCopy, 且不论容器内对象是可变还是不可变，返回的容器内对象都是指针复制(浅拷贝)。
3. 对于系统的容器类对象，对可变对象(如 NSMutableArray)进行复制时，copy 和 mutableCopy 都是对象复制(深拷贝)，但是不管是 copy 还是 mutableCopy，且不论容器内对象是可变还是不可变，返回的容器内对象都是指针复制(浅拷贝)。

- [iOS理解NSCopying协议 - 刘茂华的博客](http://liumh.com/2015/12/12/ios-understand-copy/)

#### “const”和“static” 符号区别与联系

```ObjC
static NSString const * kUserName = @"iHTCboy";
static const NSString * kUserName = @"iHTCboy";
static NSString * const kUserName = @"iHTCboy";
```

const 修饰的是他右边的部分，也就是说：

```ObjC
static NSString const * kUserName = static NSString const (* kUserName )

static NSString * const kUserName = static NSString * const (kUserName)
```

当const修饰的是(userName)的时候，不可变的是userName；星号在C语言中表示
指针指向符，也就是说这个时候userName指向的内存块地址不可变，而内存保存的内容是可变的。

**一定要同时使用static和const来定义你的变量**
上面已经说了const是用来定义一个常量。而static在C语言中（OC中延用）则表明此变量只在改变量的输出文件中可用(.m文件)，如果你不加“static”符号，那么编译器就会对该变量创建一个“外部符号”，后果是什么呢？

两个目标文件(.0文件是.m文件编译后的输出文件)有一个重复的符号。(OC中没有类似C++中的名字空间的概念)，所以当你在你自己的.m文件中需要声明一个只有你自己可见的局部变量(k开头)的变量的时候一定要同时使用“static”和“const”两个符号。

**定义工程中的全局变量**

在”constants.h”文件中，声明常量：

```ObjC
extern NSString *const XUserName;
```

然后在“constants.m”中定义他：

```ObjC
NSString *const XUserName = @"iHTCboy";
```

这样做的优势是保持常量绝对不会被修改，并且一定初始化还带有类型信息。

- [iOS 不要用宏来定义你的常量 - 简书](https://www.jianshu.com/p/038b268d1518)
- [ios - static NSString usage vs. inline NSString constants - Stack Overflow](https://stackoverflow.com/questions/1937685/static-nsstring-usage-vs-inline-nsstring-constants)


#### 获取 iOS 设备上安装的应用列表(非越狱)

- [私有API的使用 | Mark Miao](https://markmiao.com/2016/12/28/%E7%A7%81%E6%9C%89API%E7%9A%84%E4%BD%BF%E7%94%A8/)
- [获取 iOS 设备上安装的应用列表 - Octree](http://octree.me/2016/08/01/get-installed-apps/)
- [Retriever: 在未越狱的 iOS 设备上查看 app 的 InfoPlist - 知乎](https://zhuanlan.zhihu.com/p/23880229)
- [IOS 获取安装的app_骑着蜗牛找马儿-CSDN博客](https://blog.csdn.net/skylin19840101/article/details/41805995?depth_1-utm_source=distribute.pc_relevant.none-task&utm_source=distribute.pc_relevant.none-task)
- [iOS11/iOS12上通过LSApplicationWorkspace获取应用列表(只能获取带有 plugin 的app) - Blog | 干货分享 - iOSRE](http://iosre.com/t/ios11-ios12-lsapplicationworkspace-plugin-app/13534)

#### Umbrella Framework

- [Introduction to Framework Programming Guide](https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/BPFrameworks/Frameworks.html#//apple_ref/doc/uid/10000183-SW1)
- [iOS - Umbrella Header在framework中的应用 | Startry Blog](http://blog.startry.com/2015/08/25/Renaming-umbrella-header-for-iOS-framework/)
- [OC和Swift混编Frameowork优雅指南 - 简书](https://www.jianshu.com/p/0258462f5c80)
- [用.modulemap实现模块化 - 简书](https://www.jianshu.com/p/12a9565241e8)

#### CFAbsoluteTimeGetCurrent() 和 CACurrentMediaTime() 区别

```objc
#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

		CFTimeInterval currentTime = CACurrentMediaTime();
		CFAbsoluteTime absoluteTime = CFAbsoluteTimeGetCurrent();
		
		NSLog(@"currentTime: %f, absoluteTime: %f", currentTime, absoluteTime);
```

```
currentTime: 697112.258945, absoluteTime: 612415143.769868
```

* `CACurrentMediaTime()` 方法是QuartzCore框架里的，相对来说比较原子量，比较精确，可以用来测量程序的时间效率。获取到的时间是手机开机后的秒数，在模拟器上运行数值不必计较，算时间差就好。
* `CACurrentMediaTime()` 方法是 CoreFoundation框架中的，是获取2001年1月1日 00:00开始的秒数。相当于上面的NSDate方法 `[NSDate timeIntervalSinceReferenceDate]` 一样。

#### 宏定义

- [宏定义的黑魔法 - 宏菜鸟起飞手册](https://onevcat.com/2014/01/black-magic-in-macro/)
- 

#### 逻辑分辨率和物理分辨率（Physical Resolution vs Logical Resolution）
**分辨率（Resolution）**
> 分辨率又称显示分辨率、屏幕分率。确定手机屏幕上显示多少信息的设置，以水平和垂直像素（pixel）来衡量。

**inch（英寸）**
> 1 inch= 2.54cm = 25.4mm

**屏幕尺寸**
> 屏幕大小的物理尺寸，以屏幕对角线的长度（diagonal）来衡量

**PPI（像素密度，Pixels Per Inch）**
> 表示沿着设备的对角线，每英寸所拥有的像素（pixel）数目，PPI的数值越高，代表显示屏能够以越高的密度显示图像，即通常所说的分辨率越高，颗粒感越弱，图像更清晰。
> 一个像素一个格子，“每英寸像素”，表示一英寸的长度有几个格子。

**PPI的计算值**
以 iPhone 8 为例，屏幕分辨率：750px X 1334px，屏幕尺寸：4.7 英寸

$$ PPI = \frac{\sqrt{750^{2}+1334^{2}}}{4.7} = 325.6 ≈ 326 $$

**DPI（每英寸点数，Dots Per Inch）**
用于打印机，“每英寸墨点”。


**为什么不用宽高（width/height）各能容纳下多少颗像素？**
因为用每英寸能容纳下多少颗像素，就可以在不同尺寸的屏幕用 PPI 来比较了。

13寸的屏幕，屏幕的分辨率是1280\*720，如果物理分辨率改成了2560\*1440的分辨率，相当于每个像素点的尺寸减少了4倍，原来在1280\*720的一个像素内容，在2560\*1440上则填充了4个像素，因此虽然内容显示还是一样多，但是屏幕精细度高了2倍，像素倍率是2，这下再也看不出颗粒感了

**一粒像素有多大？**
**像素在脱离了屏幕尺寸之后是没有大小可言的**
你可以将 1920 * 1080 颗像素放到一台 40 寸的电视里面，也可以将同样多的像素全部塞到一台 5.5 寸的 iPhone7 Plus 手机里面去，那么对于 40 寸的电视而言，每个像素颗粒当然会大于 5.5 寸的手机的像素。

所以光看屏幕的分辨率对于设计师来说是不具备多少实际意义的，通过分辨率计算得出的像素密度（PPI）才是设计师要关心的问题，我们通过屏幕分辨率和屏幕尺寸就能计算出屏幕的像素密度的。

**Scale Factor（缩放因子）**
为了方便开发人员开发，iOS 中统一使用点（Point）对界面元素的大小进行描述。
早期的iPhone3GS的屏幕屏幕分辨率是320 * 480,iOS绘制图形（CGPoint/CGSize/CGRect）均已point为单位。

`1 point = scale*pixel`
注：在iPhone4~6中，缩放因子scale=2；在iPhone6 plus中，缩放因子scale=3


- [Designer's guide to DPI](https://www.sebastien-gabriel.com/designers-guide-to-dpi/)
- [The Ultimate Guide To iPhone Resolutions](https://www.paintcodeapp.com/news/ultimate-guide-to-iphone-resolutions)
- [iPhone 6 Screens Demystified](https://www.paintcodeapp.com/news/iphone-6-screens-demystified)
- [逻辑分辨率和物理分辨率到底是什么呀？ - 知乎](https://www.zhihu.com/question/40506180)
- [DPI 和 PPI 的区别是什么？ - 知乎](https://www.zhihu.com/question/23770739)
- [iOS UI设计 - 分辨率 屏幕尺寸 与 像素密度](https://blog.csdn.net/jiaxin_1105/article/details/71603601)
- [iPhone屏幕尺寸、分辨率及适配](https://blog.csdn.net/phunxm/article/details/42174937)
- [iOS 屏幕尺寸、逻辑分辨率、物理分辨率之间的相互关系](https://blog.csdn.net/Tongseng/article/details/52788598)

#### SDK 库相关命令

查看.a库文件所包含的架构库命令:
```console
lipo -info XXXXX.a
```

合并多个架构：
```console
lipo -create 真机路径 模拟器路径 -output 真机路径
```

从fat文件里面分离出来各个架构的库：
```console
lipo -thin armv7 XXXXX.a -output XXXXX-armv7.a
```

查看库中所包含的文件列表：
```console
ar -t armv7.a
```

从每个架构的.a文件中删除与其他sdk冲突的.o文件：
```console
ar -d -sv XXXXX-armv7.a XXXX.o
```
> 注意：把每个架构的.a文件单独放一个文件夹进行解压命令,因为同一个sdk的不同架构库解压出来的.o文件同名会覆盖掉

目录下所有.o文件(用*.o)打包成.a文件：
```console
ar -r *.o libxxx.a
```


使用 Xcode libtool 合并多个静态库:
```console
xcrun -r libtool -no_warning_for_no_symbols -static -o output.a 1.a 2.a 3.a 4.a
```

* -no_warning_for_no_symbols    不输出 has no symbols 的警告
* -static    链接的类型为静态库
* -o    指定合并后的文件路径

`xcrun -r libtool`： 使用 Xcode Toolchain 里的 libtool，直接运行 libtool 会使用 $PATH 的路径的


#### DFU 和 Recovery 模式

**Recovery模式**
恢复模式，也称 iBoot 模式，常用的使用场景就是手机需要刷机或者升降级的情况。操作该模式时，手机上会显示iTunes连接数据线的图标。

**DFU模式**
全称是 Device Firmware Upgrade，意思为固件的强制升降级模式，也叫开发者模式。

DFU模式一般是在手机无法使用Recovery模式（例如无法正常开机或者iTunes无法正常识别）的情况下使用，常见的场景就是我们在升级iOS系统手机出现白苹果或者黑屏的情况。

**进入Recovery模式**
* 方法一：直接连接iTunes，点击iTunes页面上的更新（升级最新版系统）或者【恢复iPhone】（刷机）；
* 方法二：给手机进行升降级，刷入已下载的iOS 固件版本：连接iTunes，在电脑上按住【shift】键，同时点击iTunes上的【更新】，然后选择提前下载好的iOS 固件版本进行升降级；

**进入DFU模式**
1. 把手机接到电脑上。
2. 把手机关机。
3. 按住电源键3秒。
4. 不松开电源键，按住Home键10秒。（无实体 Home 键的用音量减小键）
5. 松开电源键但保持按住Home键。（无实体 Home 键的用音量减小键）
6. 5秒钟后松开松开Home键，直到屏幕保持黑屏。（如果屏幕显示“请连接iTunes”，说明你按的时间太长了，需要重新做一遍）

**退出模式**
同时按住电源键和 Home键（音量减小键），将设备重启即可退出恢复模式或者DFU模式。

> 注意：操作时，建议将手机数据提前进行备份哦！

- [如果您无法更新或恢复 iPhone、iPad 或 iPod touch - Apple 支持](https://support.apple.com/zh-cn/HT201263)

### 黑科技

#### 刷单、苹果36技术
- [蘋果充值常見的刷單手段和防范方法 - 开发者知识库](https://www.itdaan.com/tw/d5f0ba2de17b3d14b5f5b1fc33d2f728)
- [苹果支付漏洞纵容“免费”充值？-新华网](http://www.xinhuanet.com/tech/2017-02/20/c_1120494989.htm)

#### 虚拟定位功能
- [苹果iPhone不越狱虚拟定位（多种方式，驱动更新至13.0） – Aneeo Blog](https://aneeo.com/1525.html)
- [iOS实现虚拟定位的多种玩法 - 掘金](https://juejin.im/post/5dae99306fb9a04e366a4889)
- [iOS虚拟定位：无需越狱，支持iPhone XS Max，支持12.2 - Flyzy's Blog](https://flyzyblog.com/ios-fake-gps/)

#### 黄金比例，黄金螺旋线(即斐波那契螺旋线)

- [iOS 7 的圆角图标是怎样一个图形？ - 知乎](https://www.zhihu.com/question/21191767)
- [黄金比例在设计中的运用 | 设计驱动力](http://www.wenliku.com/sheji/25086.html)
- [苹果产品设计中的黄金比例运用 - Anzhongliu - 博客园](https://www.cnblogs.com/Anzhongliu/p/6091814.html)