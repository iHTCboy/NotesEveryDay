

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