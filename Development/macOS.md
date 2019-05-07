[TOC]

### iTerm2技巧 
https://skyline75489.github.io/post/2014-7-10_iterm-usage.html

---

### Pycharm

#### pycharm for mac 代码编辑区设置自动换行

Editor区域：
Perferences -> Editor -> General -> Soft Wraps -> Use soft wraps in editor

Console区域：
Perferences -> Editor -> General -> Console -> Use soft wraps in console

---

#### PyCharm 创建.py自动添加文件头注释
设置位置：
**Windows and Linux**：File -> Settings -> Editor -> File and Code Templates
**macOS**：PyCharm -> Preferences -> Editor -> File and Code Templates 

参考Xcode的模板，写出最终：

```
#!/usr/bin/env python
#coding=utf-8
'''
${NAME}.py
${PROJECT_NAME}

Created by IHTCBOY@QQ.COM at ${DATE}
Copyright © ${YEAR} iHTCboy. All rights reserved.
'''


if __name__ == '__main__':
    pass
```

官方文档：
https://www.jetbrains.com/help/pycharm/2018.1/settings-file-and-code-templates.html?utm_content=2018.1&utm_medium=link&utm_source=product&utm_campaign=PY

---

#### PyCharm for mac 代码区域设置隐藏分隔线
Preferences -> Editor -> General -> Appearance

口 Show hard wrap guide  (configured in Code Style options)

---

#### PyCharm 批量查找及替换 
macOS:
Common + R 替换
Common + Shift + F 全局查找
Common + Shift + R 全局替换

Windows：
Ctrl + R 替换
Ctrl + Shift + F 全局查找
Ctrl + Shift + R 全局替换

---

### macOS Setting

#### mac安全来源

允许任何来源：`sudo spctl --master-disable`
禁止任何来源：`sudo spctl --master-enable`

---


### QuickTime Player

#### 使用 QuickTime 链接iPhone时, 提示 "这项操作无法完成".
似乎是在录制 iPhone 时强行拔出数据线导致的，重启 iPhone 就可以啦


---

### Sublime Text3

#### 安装install package
-  **ctrl +  快捷键 \`** 或者 ```View``` -> ```Show Console``` 菜单打开控制台

输入:
```python
import urllib.request,os; pf = 'Package Control.sublime-package'; ipp = sublime.installed_packages_path(); urllib.request.install_opener( urllib.request.build_opener( urllib.request.ProxyHandler()) ); open(os.path.join(ipp, pf), 'wb').write(urllib.request.urlopen( 'http://sublime.wbond.net/' + pf.replace(' ','%20')).read())
```


#### sublime text3格式化json
- 方法1
打开 Sublime，`command + shift + p` -> `Install package`(简写`pci`也可以)
搜索 `Pretty JSON`，回车安装

- 方法2：

```git
cd ~/Library/Application\ Support/Sublime\ Text\ 3/Packages

git clone https://github.com/dzhibas/SublimePrettyJson.git
```

- 格式化快捷键 :
macOS: `command + ctrl + j`
Windows: `ctrl + alt + j`

 - [dzhibas/SublimePrettyJson](https://github.com/dzhibas/SublimePrettyJson)

 
注：安装`HTML-CSS-JS Prettify`也不错！

---

### epub文件

编辑epub： 
- [calibre - E-book management](https://calibre-ebook.com/)

Chrome插件：
- [EpubPress - Read the web offline](https://epub.press/)
- [GitHub - alexadam/save-as-ebook: Save a web page/selection as an eBook (.epub format) - a Chrome/Firefox/Opera Web Extension](https://github.com/alexadam/save-as-ebook)

---

### PopClip

插件目录：

```bash
~/Library/Application Support/PopClip/Extensions/
```

PopClip Extensions：

https://pilotmoon.com/popclip/extensions/

---

### Finder

#### 在 Finder 标题栏显示完整路径

```bash
defaults write com.apple.finder _FXShowPosixPathInTitle -bool YES;killall Finder
```

- 还原

```bash
defaults delete com.apple.finder _FXShowPosixPathInTitle;killall Finder
```

---

### Apple Configurator 2

所有设备->选中当前iPhone->添加->应用，找到您想要ipa的那个应用->添加

```
command+shift+G
```

```
~/Library/Group Containers/K36BKF7T3D.group.com.apple.configurator/Library/Caches/Assets/TemporaryItems/MobileApps/
```

- [iOS获取App ipa包以及资源文件 - 简书](https://www.jianshu.com/p/fdb50d303ad6)

---

### macOS 检查MP3，m4a，音频和视频文件的比特率

```shell
afinfo xxx.mp4
```

示例：
```shell
➜  ~ afinfo /Users/HTC/Downloads/1920x886.mp4
File:           /Users/HTC/Downloads/1920x886.mp4
File type ID:   mp4f
Num Tracks:     1
----
Data format:     2 ch,  44100 Hz, 'aac ' (0x00000000) 0 bits/channel, 0 bytes/packet, 1024 frames/packet, 0 bytes/frame
                no channel layout.
estimated duration: 28.025034 sec
audio bytes: 889871
audio packets: 1209
bit rate: 253588 bits per second
packet size upper bound: 1019
maximum packet size: 1019
audio data file offset: 294288
optimized
audio 1235904 valid frames + 2112 priming + 0 remainder = 1238016
format list:
[ 0] format:	  2 ch,  44100 Hz, 'aac ' (0x00000000) 0 bits/channel, 0 bytes/packet, 1024 frames/packet, 0 bytes/frame
Channel layout: Stereo (L R)
```

[如何从Mac OS X的命令行检查MP3，m4a，音频文件的比特率 | MOS86](http://mos86.com/24284.html)

---