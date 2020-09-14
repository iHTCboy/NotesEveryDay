#### 什么是 m3u8

说到 m3u8 就要先说说 HLS（HTTP Live Streaming）。HLS 是 Apple 公司针对 iPhone、iPod、iTouch 等移动设备，而研发的基于 HTTP 协议的流媒体解决方案。在 HLS 技术中，Web 服务器可以向客户端提供接近实时的音视频流，但是它又是使用的标准的 HTTP 协议。所以基本上，比较大型的点播直播类服务，都是基于 HLS 的。

而该技术的原理，就是将视频文件或者视频流，进行切片（ts文件），并建立索引文件（m3u8），它支持的视频流编码为 H.264，音频流编码为 AAC。

简单来说，基于 HLS 的视频流，会将完整的视频，切割成一个个比较小的视频片段（ts 文件），然后根据协议组合成一个 m3u8 文件。这些比较小的 ts 文件，是可以单独播放的。而视频播放器，拿到 m3u8 文件之后，根据对其内 ts 片段的索引，连续播放不同的视频片段，来达到流畅的播放效果。
 
 - [论如何下载一个在线的m3u8文件到本地成为一个mp4! - 51CTO.COM](http://zhuanlan.51cto.com/art/201711/558658.htm)
 - [FFMPEG mp4 from http live streaming m3u8 file?](https://stackoverflow.com/questions/32528595/ffmpeg-mp4-from-http-live-streaming-m3u8-file)
 - [解密HLS中的AES加密 - newnewfeng的专栏 - CSDN博客](https://blog.csdn.net/newnewfeng/article/details/52275650)

 
#### 什么是 epub
 
`epub` 全称为 `Electronic Publication` 的缩写，意为：电子出版，epub于2007年9月成为国际数位出版论坛（IDPF）的正式标准，以取代旧的开放Open eBook电子书标准。一个 EPUB 就是一个简单 ZIP 格式文件（使用 .epub 扩展名），其中包括按照预先定义的方式排列的文件。

##### epub电子书的内部结构
epub格式电子书遵循IDPF推出的OCF规范，OCF规范遵循ZIP压缩技术，即epub电子书本身就是一个ZIP文件，我们将epub格式电子书的后缀.epub修改为.zip后，可以通过解压缩软件进行浏览或解压处理。所以这种格式的电子书开放性非常好， 我们可以更改它的源代码。一个未经加密处理的epub电子书以三个部分组成，其文件结构：

* 1、文件：mimetype
* 2、目录：META-INF
* 3、目录：OEBPS

1、文件：mimetype
每一本epub电子书均包含一个名为mimetype的文件，且内容不变，用以说明epub的文件格式。文件内容如下：
```
application/epub+zip 
```

2、目录：META-INF
依据OCF规范，META-INF用于存放容器信息，默认情况下（即加密处理），该目录包含一个文件，即container.xml,文件内容如下：

```xml
<?xml version="1.0"?> 
<container version="1.0" xmlns="urn:oasis:names:tc:opendocument:xmlns:container"> 
<rootfiles> 
<rootfile full-path="OPS/content.opf" media-type="application/oebps-package+xml"/>
</rootfiles> 
</container> 
```
 
container.xml的主要功能用于告诉阅读器，电子书的根文件（rootfile）的路径和打开放式，一般来讲，该container.xml文件也不需要作任何修改，除非你改变了根文件的路径和文件名称。

除container.xml文件之外，OCF还规定了以下几个文件：
* 1、[manifest.xml]，文件列表
* 2、[metadata.xml]，元数据
* 3、[signatures.xml]，数字签名
* 4、[encryption.xml]，加密
* 5、[rights.xml]，权限管理对于epub电子书而言，这些文件都是可选的。


3、目录：OEBPS
OEBPS目录用于存放OPS文档、OPF文档、CSS文档、NCX文档， OEBPS这个名字是可变的，可以根据containter.xml进行配置。

OPF文档是epub电子书的核心文件，且是一个标准的XML文件，依据OPF规范，主要由五个部分组成：

* 1、<metadata>,元数据信息的组成有两种 (1)dc-metadata和 (2)x-metadata
* 2、<menifest>，文件列表，由于列出OEBPS文档及相关的文档，有一个子元素构成，
* <item id="" href="" media-type="">，该元素由三个属性构成。
* 3、<spine toc="ncx">，脊骨，其主要功能是提供书籍的线性阅读次序。由一个子元素构成：<itemref idref="">,由一个属性构成：idref:即参照menifest列出的ID。
* 4、<guide>,指南,依次列出电子书的特定页面, 例如封面、目录、序言等, 属性值指向文件保存地址。一般情况下，epub电子书可以不用该元素。
* 5、<tour>,导读。可以根据不同的读者水平或者阅读目的, 按一定次序, 选择电子书中的部分页面组成导读。一般情况下，epub电子书可以不用该元素。

- [epub电子书 -- 目录结构介绍 - 方方和圆圆](https://www.cnblogs.com/diligenceday/p/4999315.html)
- [书籍解析器sdk设计（epub） - 简书](https://www.jianshu.com/p/23f027ef32f6)



#### 常见文件格式的文件头

| 文件格式 | 文件头(十六进制) |
|---|---|
| JPEG (jpg) | FFD8FF |
| PNG (png) | 89504E47 |
| GIF (gif) | 47494638 |
| TIFF (tif) | 49492A00 |
| Windows Bitmap (bmp) | 424D |
| 16色位图(bmp) | 424D228C010000000000 |
| 24色位图(bmp) | 424D8240090000000000 |
| 256色位图(bmp) | 424D8e1B030000000000 |
| CAD (dwg) | 41433130 |
| Adobe Photoshop (psd) | 38425053000100000000 |
| Rich Text Format (rtf) | 7B5C727466 |
| XML (xml) | 3C3F786D6C |
| HTML (html) | 68746D6C3E |
| HTML (html) | 3C21444F435459504520 |
| HTM (htm) | 3C21646F637479706520 |
| css | 48544D4C207b0D0A0942 |
| js | 696B2E71623D696B2E71 |
| Email (eml) | 44656C69766572792D646174653A |
| Outlook Express (dbx) | CFAD12FEC5FD746F |
| Outlook (pst) | 2142444E |
| MS Word/Excel (xls.or.doc) | D0CF11E0 |
| MS Word(.docx) | 504b0304140006000800 |
| MS Access (mdb) | 5374616E64617264204A |
| WordPerfect (wpd) | FF575043 |
| Postscript (eps.or.ps) | 252150532D41646F6265 |
| Adobe Acrobat (pdf) | 255044462D312E |
| Quicken (qdf) | AC9EBD8F |
| Windows Password (pwl) | E3828596 |
| ZIP Archive (zip) | 504B0304 |
| RAR Archive (rar) | 52617221 |
| Wave (wav) | 57415645 |
| AVI (avi) | 41564920 |
| Real Audio (ram) | 2E7261FD |
| Real Media (rm) | 2E524D46 |
| MPEG (mpg) | 000001BA |
| MPEG (mpg) | 000001B3 |
| Quicktime (mov) | 6D6F6F76 |
| Windows Media (asf) | 3026B2758E66CF11 |
| MIDI (mid) | 4D546864 |
| wps | D0CF11E0A1B11AE10000 |
