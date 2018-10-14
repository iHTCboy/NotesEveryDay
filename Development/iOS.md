

### iOS证书&签名
- [iOS App 签名的原理 « bang’s blog](http://blog.cnbang.net/tech/3386/)
- [iOS开发者证书以及代码签名学习笔记 | Enki's Notes](http://www.enkichen.com/2016/01/15/ios-certification-and-code-sign-note/)
- [漫谈iOS程序的证书和签名机制](https://segmentfault.com/a/1190000004144556)


### 从App里用代码读取证书信息

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


### Xcode10 打SDK库失败
解决方法，在脚本增加 -UseModernBuildSystem=NO ，原因是Xcode10使用新build系统，导致 xcodebuild 只会编译一个
相似的反馈：https://github.com/facebook/react-native/issues/19573

好像新build系统速度提升很好，了解更多新build系统：
https://medium.com/xcblog/xcode-new-build-system-for-speedy-swift-builds-c39ea6596e17




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

### Xcode10：library not found for -lstdc++.6.0.9 临时解决 

Xcode 10中将libstdc++.6.0.9库文件删除，SDK依赖 libstdc++.6.0.9 的会在Xcode 10无法运行，解决方案：

https://blog.csdn.net/ZuoWeiXiaoDuZuoZuo/article/details/82756116?utm_source=copy 

### 真机运行库

在终端输入以下命令打开Xcode的lib库目录（此目录位安装的默认目录）

```
open /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/usr/lib
```

把刚刚下载的zip文件解压获取到的 真机的 libstdc++.6.0.9.tbd 文件，扔进去


#### 模拟器运行库

在终端输入以下命令打开Xcode的lib库目录（此目录位安装的默认目录）

```
open  /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk/usr/lib
```

把刚刚下载的zip文件解压获取到的 模拟器的 libstdc++.6.0.9.tbd 文件，扔进去

#### 下一步

重启Xcode


### 在UILabel的NSAttributedText中创建可点击的“链接”？

- [How to Create Multiple Tappable Links in a UILabel](https://samwize.com/2016/03/04/how-to-create-multiple-tappable-links-in-a-uilabel/)
- [ios - Create tap-able "links" in the NSAttributedString of a UILabel? - Stack Overflow](http://stackoverflow.com/questions/1256887/create-tap-able-links-in-the-nsattributedtext-of-a-uilabel)