
---


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


### macOS Setting

#### mac安全来源

允许任何来源：`sudo spctl --master-disable`
禁止任何来源：`sudo spctl --master-enable`

---


### QuickTime Player

#### 使用 QuickTime 链接iPhone时, 提示 "这项操作无法完成".
似乎是在录制 iPhone 时强行拔出数据线导致的，重启 iPhone 就可以啦



### Sublime Text3

#### 安装install package
- ctrl + ` 快捷键 或者 ```View``` -> ```Show Console``` 菜单打开控制台

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


### epub文件

编辑epub： 
- [calibre - E-book management](https://calibre-ebook.com/)

Chrome插件：
- [EpubPress - Read the web offline](https://epub.press/)
- [GitHub - alexadam/save-as-ebook: Save a web page/selection as an eBook (.epub format) - a Chrome/Firefox/Opera Web Extension](https://github.com/alexadam/save-as-ebook)

