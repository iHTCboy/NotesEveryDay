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

#### PyCharm创建.py自动添加文件头注释
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

### macOS Setting

#### mac安全来源

允许任何来源：`sudo spctl --master-disable`
禁止任何来源：`sudo spctl --master-enable`

---



