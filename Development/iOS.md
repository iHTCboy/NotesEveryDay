
[TOC]


### CocoaPods

#### Cocoapods 报错问题

```shell
- ERROR | [iOS] unknown: Encountered an unknown error (Could not find a `ios` simulator (valid values: ). Ensure that Xcode -> Window -> Devices has at least one `ios` simulator listed or otherwise add one.) during validation.
```

需要在Xcode中创建模板器


#### Cocoapods 配置问题

- [Xcode 编辑器之关于Other Linker Flags相关问题 - 梁飞宇 - 博客园](https://www.cnblogs.com/lxlx1798/p/11219101.html)
- [细聊 Cocoapods 与 Xcode 工程配置](https://bestswifter.com/cocoapods/)

### SDWebImage

#### SDWebImage 占位图是GIF处理

```obj-c
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

```
open /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/usr/lib
```

把刚刚下载的zip文件解压获取到的 真机的 libstdc++.6.0.9.tbd 文件，扔进去


##### 模拟器运行库

在终端输入以下命令打开Xcode的lib库目录（此目录位安装的默认目录）

```
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
```bash
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

```obj-c
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

```obj-c
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

```
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
```ios
NSLocalizedString(@"key", @"My comment")

/* My comment */
"key" = "value";
```

扫描当前文件夹下所有.m文件的宏，生成Localizable.strings文件并放到en.lproj文件夹下:

```bash
$ find . -name \*.m | xargs genstrings -o en.lproj 
```

指定的输出目录下生成 `TableName.strings` 文件，然后添加记录和注释:
```bash
NSLocalizedStringFromTable(@"key", @"TableName", @"My comment")
```

下面三句的作用是一样的，都是读取苹果指定名字为 `Localizable.strings` 的内容，其中第三种简化后就是苹果对 `NSLocalizedString` 宏的定义：

```bash
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


### 黑科技

#### 虚拟定位功能
- [苹果iPhone不越狱虚拟定位（多种方式，驱动更新至13.0） – Aneeo Blog](https://aneeo.com/1525.html)
- [iOS实现虚拟定位的多种玩法 - 掘金](https://juejin.im/post/5dae99306fb9a04e366a4889)
- [iOS虚拟定位：无需越狱，支持iPhone XS Max，支持12.2 - Flyzy's Blog](https://flyzyblog.com/ios-fake-gps/)

#### 黄金比例，黄金螺旋线(即斐波那契螺旋线)

- [iOS 7 的圆角图标是怎样一个图形？ - 知乎](https://www.zhihu.com/question/21191767)
- [黄金比例在设计中的运用 | 设计驱动力](http://www.wenliku.com/sheji/25086.html)
- [苹果产品设计中的黄金比例运用 - Anzhongliu - 博客园](https://www.cnblogs.com/Anzhongliu/p/6091814.html)