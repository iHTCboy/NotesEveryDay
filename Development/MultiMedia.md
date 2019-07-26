#### 什么是 m3u8

说到 m3u8 就要先说说 HLS（HTTP Live Streaming）。HLS 是 Apple 公司针对 iPhone、iPod、iTouch 等移动设备，而研发的基于 HTTP 协议的流媒体解决方案。在 HLS 技术中，Web 服务器可以向客户端提供接近实时的音视频流，但是它又是使用的标准的 HTTP 协议。所以基本上，比较大型的点播直播类服务，都是基于 HLS 的。

而该技术的原理，就是将视频文件或者视频流，进行切片（ts文件），并建立索引文件（m3u8），它支持的视频流编码为 H.264，音频流编码为 AAC。

 简单来说，基于 HLS 的视频流，会将完整的视频，切割成一个个比较小的视频片段（ts 文件），然后根据协议组合成一个 m3u8 文件。这些比较小的 ts 文件，是可以单独播放的。而视频播放器，拿到 m3u8 文件之后，根据对其内 ts 片段的索引，连续播放不同的视频片段，来达到流畅的播放效果。
 
 - [论如何下载一个在线的m3u8文件到本地成为一个mp4! - 51CTO.COM](http://zhuanlan.51cto.com/art/201711/558658.htm)
 - [FFMPEG mp4 from http live streaming m3u8 file? [closed]](https://stackoverflow.com/questions/32528595/ffmpeg-mp4-from-http-live-streaming-m3u8-file)
 - [解密HLS中的AES加密 - newnewfeng的专栏 - CSDN博客](https://blog.csdn.net/newnewfeng/article/details/52275650)