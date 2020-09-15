[TOC]

### Python
#### Python实现Zip文件的暴力破解


```python
#!/usr/bin/python
# coding=utf-8

import zipfile

if __name__ == '__main__':
	z = zipfile.ZipFile('/Users/HTC/Downloads/abc.zip')
	#跑的字典为当前目录下的dictionary.txt
 	for password in range(653060, 100000000) :
		print password
		try:
			z.extractall(path='/Users/HTC/Downloads/', pwd=str(password))
			print 'password is:', password
			break
		except Exception, e:
			print(e)
			pass
```


#### 自动生成和安装requirements.txt依赖
生成requirements.txt文件

```python
    pip freeze > requirements.txt
```

安装requirements.txt依赖

```python
    pip install -r requirements.txt
```


#### python数组list中的字典的某个key排序


```python
from operator import itemgetter

rows = [
    {'fname': 'Brian', 'lname': 'Jones', 'uid': 1003},
    {'fname': 'David', 'lname': 'Beazley', 'uid': 1002},
    {'fname': 'John', 'lname': 'Cleese', 'uid': 1001},
    {'fname': 'Big', 'lname': 'Jones', 'uid': 1004}
]

rows_by_fname = sorted(rows, key=itemgetter('fname'))

#Log
[{'fname': 'Big', 'uid': 1004, 'lname': 'Jones'},
{'fname': 'Brian', 'uid': 1003, 'lname': 'Jones'},
{'fname': 'David', 'uid': 1002, 'lname': 'Beazley'},
{'fname': 'John', 'uid': 1001, 'lname': 'Cleese'}]

```

`itemgetter()`有时候也可以用 `lambda` 表达式代替:


```python
rows_by_fname = sorted(rows, key=lambda r: r['fname'])
```

但是，使用 `itemgetter()` 方式会运行的稍微快点。因此，如果你对性能要求比较高的话就使用 `itemgetter()` 方式。

- [1.13 通过某个关键字排序一个字典列表 — python3-cookbook 3.0.0 文档](https://python3-cookbook.readthedocs.io/zh_CN/latest/c01/p13_sort_list_of_dicts_by_key.html)
- [python字典排序、按照list中的字典的某个key排序 - 一步一步 - CSDN博客](python字典排序、按照list中的字典的某个key排序 - 一步一步 - CSDN博客)


#### python比较时间大小


```Python
a = '2017-10-18 22:17:46'
b = '2017-10-19 22:17:40'
print a > b
# 结果False
```

解释：python中字符串的大小比较，是按照字符顺序，从前往后依次比较字符的ASCII数值，例如‘abc’要小于‘abd’。因此，时间字符串也可以直接比大小。


#### python 时间日期格式化符号

```python
%y 两位数的年份表示（00-99）
%Y 四位数的年份表示（000-9999）
%m 月份（01-12）
%d 月内中的一天（0-31）
%H 24小时制小时数（0-23）
%I 12小时制小时数（01-12） 
%M 分钟数（00=59）
%S 秒（00-59）

%a 本地简化星期名称
%A 本地完整星期名称
%b 本地简化的月份名称
%B 本地完整的月份名称
%c 本地相应的日期表示和时间表示
%j 年内的一天（001-366）
%p 本地A.M.或P.M.的等价符
%U 一年中的星期数（00-53）星期天为星期的开始
%w 星期（0-6），星期天为星期的开始
%W 一年中的星期数（00-53）星期一为星期的开始
%x 本地相应的日期表示
%X 本地相应的时间表示
%Z 当前时区的名称
%% %号本身 
```

#### Python:os.path.join()产生的斜杠在Windows和Linux下的不同表现和解决方法


```python
import os.path
from pathlib import Path

result = os.path.join('a', 'b', 'c')
print(result)

result = Path(result).as_posix()
print(result)

#or
result = result.replace('\\', '/')
print(result)
```

- [Python:os.path.join()产生的斜杠在Windows和Linux下的不同表现和解决方法 - Penguin](https://www.polarxiong.com/archives/Python-os-path-join-产生的斜杠在Windows和Linux下的不同表现和解决方法.html)


#### Python-OpenCV

- [给深度学习入门者的Python快速教程 - 番外篇之Python-OpenCV - 知乎](https://zhuanlan.zhihu.com/p/24425116)
- [opencv python 从摄像头获取视频/从文件获取视频 /保存视频](https://segmentfault.com/a/1190000015575701)
- [基于Python的OpenCV图像处理3](https://zhaoxuhui.top/blog/2017/05/05/基于Python的OpenCV图像处理3.html#捕获视频保存)
- [利用MoviePy將影片加入音訊](https://hardliver.blogspot.com/2017/07/moviepy-moviepy.html)


#### python判断字符串是否纯数字

- 通过抛出异常
```python
def is_num_by_except(num):
    try:
        int(num)
        return True
    except ValueError:
        print("ValueError", num)
```

- 通过isdigit()
```python
string.isdigit()
```

- 通过正则表达式
```python
re.match(r"d+$", a)
```

#### PIL获取PNG图像的alpha值


```python
# refer: https://www.oschina.net/code/snippet_580365_11452
def is_png_alpha(path):
    if os.path.splitext(path)[1] in ['.png', '.PNG']:
        if Image.open(path, 'r').mode == 'RGBA':
            try:
                img = Image.open(path)
                img.load()
            except:
                info = '这不是图片格式: 。' + os.path.basename(path)
                return (False, info)
            alpha = img.split()[3]
            arr = numpy.asarray(alpha)
            count = 0
            for i in range(0, img.size[0] - 1):
                for j in range(0, img.size[1] - 1):
                    if arr[j][i] < 128:
                        count += 1
                        if count > 10:
                            break
            if count > 10:
                info = '有 Alpha 通道，{} 个。'.format(str(count))
                #print(info)
                return (True, info)
            else:
                #这张图片约等于没有alpha通道
                info = '有开启 Alpha 通道，但图片没有 Alpha 通道。'
                return (False, info)
        else:
            info = '图片没有 Alpha 通道。'
            return (False, info)
    else:
        info = '文件 {} 不是 png 格式。'.format(os.path.basename(path))
        return (False, info)
```


```python
# refer: https://www.jianshu.com/p/26f8c106a20d
def is_png_transparent(path):
    if not check_fileMode(path) in ['.png', '.PNG']:
        info = '文件 {} 不是 png 格式。'.format(os.path.basename(path))
        return (False, info)

    # Open file
    im = Image.open(path, 'r')
    # get image scale
    width, height = im.size
    #print('Original image size: %sx%s' % (width, height))
    # for
    for w in range(0, width):
        for h in range(0, height):
            pixel = im.getpixel((w, h))
            if (isinstance(pixel , int)):
                #"It's PNG8
                info = '是一张 PNG8 图片，包含透明区域。'
                return (True, info)
            if (len(pixel) > 3):
                if (pixel[3] != 255):
                   info = '图片包含透明区域。'
                   return (True, info)
            else:
                info = '图片没有透明区域(alpha值)。'
                return (False, info)

    info = '图片没有透明区域。'
    return (False, info)
```

- [查看文件的alpha通道](https://www.oschina.net/code/snippet_580365_11452#)
- [python，使用PIL库对图片进行操作 - 每天1990 - 博客园](https://www.cnblogs.com/meitian/p/3699223.html)
- [PIL 简明教程 - 基本用法 | 始终](https://liam.page/2015/04/22/pil-tutorial-basic-usage/)
- [python – 如何使用PIL获取PNG图像的alpha值？ - 程序园](http://www.voidcn.com/article/p-sbwkywdo-btp.html)

#### Python json
`json.dumps()` 将一个Python数据结构转换为一个JSON编码的字符串
`json.loads()` 将一个JSON编码的字符串转换为一个Python数据结构

json无空格：
```python
dict = {}
json.dumps(dict, separators=(',', ':'))
```

要输出中文需要指定`ensure_ascii`参数为`False`：
```python
dict = {}
json.dumps(dict, ensure_ascii=False)
```

- [Python - json without whitespaces - Stack Overflow](https://stackoverflow.com/questions/16311562/python-json-without-whitespaces)
#### Python json dumps 非标准类型

- [Python 优雅地 dumps 非标准类型 - 掘金](https://juejin.im/post/5a06d4776fb9a04515435afe)


#### Python 解析iOS的 p12、mobileprovision文件内容

- [Python查看ipa UDID和其他基本信息 - 简书](https://www.jianshu.com/p/7b84f95bdf6f)
- [cryptography - Python: reading a pkcs12 certificate with pyOpenSSL.crypto - Stack Overflow](https://stackoverflow.com/questions/6345786/python-reading-a-pkcs12-certificate-with-pyopenssl-crypto/6346268#6346268)
- [Python：用pyOpenSSL.crypto读取pkcs12证书 - 代码日志](https://codeday.me/bug/20181207/432700.html)
- [那些证书相关的玩意儿(SSL,X.509,PEM,DER,CRT,CER,KEY,CSR,P12等) - guogangj - 博客园](https://www.cnblogs.com/guogangj/p/4118605.html)


#### Python异常之后输出异常信息（行号）

python2.x捕获异常语法：

```python
try:
    ...some functions...
except Exception, e:
    print(e)
```

python3.x捕获异常语法：


```python
try:
    ...some functions...
except Exception as e:
    print(e)
```
注意这里 Exception, e 变成了 Exception as e


Untitled.py示例代码：

```python
import traceback
	
try:
	form = None
	form['user'] = 'iHTCboy'
except Exception as e:
	print('str(e):\t', str(e))
	print('repr(e):\t', repr(e))
	print('e.message:\t', e.message)
	print('traceback.print_exc():'); traceback.print_exc()
	print ('traceback.format_exc():\n{}'.format(traceback.format_exc()))
```

1、str(e)
> 返回字符串类型，只给出异常信息，不包括异常信息的类型，如TypeError的异常信息：`'NoneType' object does not support item assignment`

2、repr(e)
> 给出较全的异常信息，包括异常信息的类型，如TypeError的异常信息：`TypeError("'NoneType' object does not support item assignment")`

3、e.message
> `Python2` 获得的信息同str(e)，但 `Python3` 则异常报错：

```python
Traceback (most recent call last):
  File "Untitled.py", line 6, in <module>
    form['user'] = 'iHTCboy'
TypeError: 'NoneType' object does not support item assignment

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "Untitled.py", line 10, in <module>
    print('e.message:\t', e.message)
AttributeError: 'TypeError' object has no attribute 'message'
```

4、采用traceback模块
> 需要导入traceback模块，此时获取的信息最全，与python命令行运行程序出现错误信息一致。使用`traceback.print_exc()`打印异常信息到标准错误，使用`traceback.format_exc()`将同样的输出获取为字符串。你可以向这些函数传递各种各样的参数来限制输出，或者重新打印到像文件类型的对象。

```python
Traceback (most recent call last):
  File "Untitled.py", line 6, in <module>
    form['user'] = 'iHTCboy'
TypeError: 'NoneType' object does not support item assignment
```

#### Python常见的异常类型
1. NameError：尝试访问一个未申明的变量

```python
>>> v
NameError: name 'v' is not defined
```

2. ZeroDivisionError：除数为0

```python
>>> v = 1/0
ZeroDivisionError: int division or modulo by zero
```

3. SyntaxError：语法错误

```python
int int
SyntaxError: invalid syntax (<pyshell#14>, line 1)
```

4. IndexError：索引超出范围

```python
List = [2]
>>> List[3]
Traceback (most recent call last):
  File "<pyshell#18>", line 1, in <module>
    List[3]
IndexError: list index out of range
```

5. KeyError：字典关键字不存在

```python
Dic = {'1':'yes', '2':'no'}
>>> Dic['3']
Traceback (most recent call last):
  File "<pyshell#20>", line 1, in <module>
    Dic['3']
KeyError: '3'
```

6. IOError：输入输出错误

```python
>>> f = open('abc')
IOError: [Errno 2] No such file or directory: 'abc'
```

7. AttributeError：访问未知对象属性

```python
>>> class Worker:
 def Work():
  print("I am working")

>>> w = Worker()
>>> w.a
Traceback (most recent call last):
  File "<pyshell#51>", line 1, in <module>
    w.a
AttributeError: 'Worker' object has no attribute 'a'
```

8.ValueError：数值错误

```python
>>> int('d')
Traceback (most recent call last):
  File "<pyshell#54>", line 1, in <module>
    int('d')
ValueError: invalid literal for int() with base 10: 'd'
```

9. TypeError：类型错误

```python
>>> iStr = '22'
>>> iVal = 22
>>> obj = iStr + iVal;
Traceback (most recent call last):
  File "<pyshell#68>", line 1, in <module>
    obj = iStr + iVal;
TypeError: Can't convert 'int' object to str implicitly
```

10. AssertionError：断言错误

```python
>>> assert 1 != 1
Traceback (most recent call last):
  File "<pyshell#70>", line 1, in <module>
    assert 1 != 1
AssertionError
```

11.MemoryError:内存耗尽异常


12. NotImplementedError：方法没实现引起的异常

```python
class Base(object):
    def __init__(self):
        pass

    def action(self):
        #抛出异常，说明该接口方法未实现
        raise NotImplementedError
```

13. LookupError：键、值不存在引发的异常

> LookupError异常是IndexError、KeyError的基类， 如果你不确定数据类型是字典还是列表时，可以用LookupError捕获此异常

14. StandardError 标准异常

> 除StopIteration, GeneratorExit, KeyboardInterrupt 和SystemExit外，其他异常都是StandarError的子类。

错误检测与异常处理区别在于：错误检测是在正常的程序流中，处理不可预见问题的代码，例如一个调用操作未能成功结束。

- [Python异常处理和异常类型 - Monica的专栏 - CSDN博客](https://blog.csdn.net/TskyFree/article/details/48630817)

#### openpyxl怎么将文本单元格变成超链接？


```python
from openpyxl import load_workbook

wb = load_workbook('/user/HTC/boy.xlsx') 
s = wb.get_sheet_by_name('Sheet') 
s['B4'].hyperlink = 'https://iHTCboy.com' 
s['B4'].style = 'Hyperlink' 
wb.save('trial.xlsx')
```

#### POP3收取邮件
> 用Python的poplib模块收取邮件分两步：第一步是用POP3协议把邮件获取到本地，第二步是用email模块把原始邮件解析为Message对象，然后，用适当的形式把邮件内容展示给用户即可。

- SMTP用于发送邮件，如果要收取邮件呢？
收取邮件就是编写一个MUA作为客户端，从MDA把邮件获取到用户的电脑或者手机上。收取邮件最常用的协议是POP协议，目前版本号是3，俗称POP3。
Python内置一个poplib模块，实现了POP3协议，可以直接用来收邮件。
注意到POP3协议收取的不是一个已经可以阅读的邮件本身，而是邮件的原始文本，这和SMTP协议很像，SMTP发送的也是经过编码后的一大段文本。
要把POP3收取的文本变成可以阅读的邮件，还需要用email模块提供的各种类来解析原始文本，变成可阅读的邮件对象。
所以，收取邮件分两步：
* 第一步：用poplib把邮件的原始文本下载到本地；
* 第二部：用email解析原始文本，还原为邮件对象。

通过POP3下载邮件，POP3协议本身很简单，以下面的代码为例，我们来获取最新的一封邮件内容：

```python3
import poplib

# 输入邮件地址, 口令和POP3服务器地址:
email = input('Email: ')
password = input('Password: ')
pop3_server = input('POP3 server: ')

# 连接到POP3服务器:
server = poplib.POP3(pop3_server)
# 可以打开或关闭调试信息:
server.set_debuglevel(1)
# 可选:打印POP3服务器的欢迎文字:
print(server.getwelcome().decode('utf-8'))

# 身份认证:
server.user(email)
server.pass_(password)

# stat()返回邮件数量和占用空间:
print('Messages: %s. Size: %s' % server.stat())
# list()返回所有邮件的编号:
resp, mails, octets = server.list()
# 可以查看返回的列表类似[b'1 82923', b'2 2184', ...]
print(mails)

# 获取最新一封邮件, 注意索引号从1开始:
index = len(mails)
resp, lines, octets = server.retr(index)

# lines存储了邮件的原始文本的每一行,
# 可以获得整个邮件的原始文本:
msg_content = b'\r\n'.join(lines).decode('utf-8')
# 稍后解析出邮件:
msg = Parser().parsestr(msg_content)

# 可以根据邮件索引号直接从服务器删除邮件:
# server.dele(index)
# 关闭连接:
server.quit()
```

用POP3获取邮件其实很简单，要获取所有邮件，只需要循环使用retr()把每一封邮件内容拿到即可。真正麻烦的是把邮件的原始内容解析为可以阅读的邮件对象。
解析邮件

解析邮件的过程和上一节构造邮件正好相反，因此，先导入必要的模块：

```python
from email.parser import Parser
from email.header import decode_header
from email.utils import parseaddr

import poplib
```

只需要一行代码就可以把邮件内容解析为Message对象：
```python
msg = Parser().parsestr(msg_content)
```

但是这个Message对象本身可能是一个MIMEMultipart对象，即包含嵌套的其他MIMEBase对象，嵌套可能还不止一层。
所以我们要递归地打印出Message对象的层次结构：

```python
# indent用于缩进显示:
def print_info(msg, indent=0):
    if indent == 0:
        for header in ['From', 'To', 'Subject']:
            value = msg.get(header, '')
            if value:
                if header=='Subject':
                    value = decode_str(value)
                else:
                    hdr, addr = parseaddr(value)
                    name = decode_str(hdr)
                    value = u'%s <%s>' % (name, addr)
            print('%s%s: %s' % ('  ' * indent, header, value))
    if (msg.is_multipart()):
        parts = msg.get_payload()
        for n, part in enumerate(parts):
            print('%spart %s' % ('  ' * indent, n))
            print('%s--------------------' % ('  ' * indent))
            print_info(part, indent + 1)
    else:
        content_type = msg.get_content_type()
        if content_type=='text/plain' or content_type=='text/html':
            content = msg.get_payload(decode=True)
            charset = guess_charset(msg)
            if charset:
                content = content.decode(charset)
            print('%sText: %s' % ('  ' * indent, content + '...'))
        else:
            print('%sAttachment: %s' % ('  ' * indent, content_type))
```

邮件的Subject或者Email中包含的名字都是经过编码后的str，要正常显示，就必须decode：

```python
def decode_str(s):
    value, charset = decode_header(s)[0]
    if charset:
        value = value.decode(charset)
    return value
```

decode_header()返回一个list，因为像Cc、Bcc这样的字段可能包含多个邮件地址，所以解析出来的会有多个元素。上面的代码我们偷了个懒，只取了第一个元素。
文本邮件的内容也是str，还需要检测编码，否则，非UTF-8编码的邮件都无法正常显示：

```python
def guess_charset(msg):
    charset = msg.get_charset()
    if charset is None:
        content_type = msg.get('Content-Type', '').lower()
        pos = content_type.find('charset=')
        if pos >= 0:
            charset = content_type[pos + 8:].strip()
    return charset
```

- [POP3收取邮件 · Python 3零起点教程 · 看云](https://www.kancloud.cn/thinkphp/python-guide/39542)
- [Python3读取邮件内容-卫莨-51CTO博客](https://blog.51cto.com/acevi/2442415)
- [8.6 Python使用poplib模块收取邮件](https://www.okcode.net/article/43551)

#### python 获取邮件的所有收件人

```
from email.utils import getaddresses

tos = msg.get_all('to', [])
ccs = msg.get_all('cc', [])
resent_tos = msg.get_all('resent-to', [])
resent_ccs = msg.get_all('resent-cc', [])
all_recipients = getaddresses(tos + ccs + resent_tos + resent_ccs)
```

- [18.1.9. email.utils: Miscellaneous utilities — Python 2.7.17 documentation](https://docs.python.org/2/library/email.utils.html)

#### python 时间对象多加一天、一小时、一分钟
首先看下，datetime的使用

```
import datetime

>>> print datetime.datetime.now()
2017-07-15 15:01:24.619000
```

- 格式化时间
```
>>> print datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
2017-07-15 15:01:35

>>> print datetime.datetime.now().strftime("%Y-%m-%d %H:%M")
2017-07-15 15:01

>>> print datetime.datetime.now().strftime("%Y%m%d")
20170715
```

- 多加一天


```
>>> print (datetime.datetime.now()+datetime.timedelta(days=1)).strftime("%Y-%m-%
d %H:%M:%S")
2017-07-16 15:12:42
>>>
```

- 多加一小时
```
>>> print (datetime.datetime.now()+datetime.timedelta(hours=1)).strftime("%Y-%m-
%d %H:%M:%S")
2017-07-15 16:10:43
>>>
```

- 多加一分钟
```
>>> print (datetime.datetime.now()+datetime.timedelta(minutes=1)).strftime("%Y-%
m-%d %H:%M:%S")
2017-07-15 15:12:56
>>>
```

- [python 当前时间多加一天、一小时、一分钟_翔云-CSDN博客](https://blog.csdn.net/lanyang123456/article/details/75169752)


#### Python 保存web页面的方法

- [Python保存.mht格式网页 | X小Mickey'Blog](https://jxbuaa.github.io/2019/01/Python%E4%BF%9D%E5%AD%98-mht%E6%A0%BC%E5%BC%8F%E7%BD%91%E9%A1%B5/)
- [利用selenium保存静态网页 - 简书](https://www.jianshu.com/p/29a0adc044d5)
- [竟用python作出这样的事！定时自动发 QQ 信息 - 知乎](https://zhuanlan.zhihu.com/p/106375472)


#### Python中保留两位小数的方法

##### 保留两位小数，并做四舍五入处理
方法一: 使用字符串格式化
```python
>>> a = 12.345
>>> print("%.2f" % a)
12.35
```

方法二: 使用`round`内置函数
```python
>>> a = 12.345
>>> round(a, 2)            
12.35
```

方法三: 使用`decimal`模块
```python
>>> from decimal import Decimal
>>> a = 12.345
>>> Decimal(a).quantize(Decimal("0.00"))
Decimal('12.35')
```

##### 仅保留两位小数，无需四舍五入
方法一: 使用序列中切片
```python
>>> a = 12.345
>>> str(a).split('.')[0] + '.' + str(a).split('.')[1][:2]
'12.34'
```

方法二: 使用re模块
```python
>>> import re
>>> a = 12.345
>>> re.findall(r"\d{1,}?\.\d{2}", str(a))
['12.34']
```
 
 - [Python中保留两位小数的几种方法_Python_杰瑞的专栏-CSDN博客](https://blog.csdn.net/Jerry_1126/article/details/85009810)


#### python下载文件

一次性下载:
```
import requests
image_url = "https://www.iHTCboy.com/ihtc.png"
r = requests.get(image_url) 
with open("python_logo.png",'wb') as f:
    f.write(r.content)
```

大文件下载：
```
import requests
file_url = "https://www.iHTCboy.com/ihtc.mp4"
r = requests.get(file_url, stream=True)
with open("python.pdf", "wb") as file:
    for chunk in r.iter_content(chunk_size=1024):
        if chunk:
            file.write(chunk)
```

注：如果文件比较大的话，那么下载下来的文件先放在内存中，内存还是比较有压力的。所以为了防止内存不够用的现象出现，我们要想办法把下载的文件分块写到磁盘中


- [python下载文件 ---- requests](https://zhuanlan.zhihu.com/p/37824910)


#### python 更新 requirements.txt 版本号


```python
# 安装
pip install pur

# 运行pur会将软件包更新为当前最新版本
pur -r requirements.txt
```

`Pur` 不会修改你的环境或者安装的软件包，它只修改你的requirements.txt 文件。

**命令行选项**

| 命令 | 全命令 | 命令作用 |
|---|---|---|
| -r | --requirement 路径 | 要更新的requirements.txt 文件；默认情况下，如果存在当前目录，则使用当前目录中的requirements.txt。|
| -o | --output 路径 | 将更新的软件包输出到这里文件；默认值为覆盖输入 requirements.txt 文件。 |
| -i | --interactive | 在更新每个软件包之前交互式提示。 |
| -f | --force | 即使在输入 requirements.txt 文件中没有指定任何版本，也强制更新软件包。 |
| -d | --dry-run | 输出更改为 STDOUT，而不是覆盖 requirements.txt 文件。 |
| -n | --no-recursive | 阻止更新嵌套的要求文件。 |
| -s | --skip 文本 | 逗号分隔的软件包列表以跳过更新。 |
| x | --only 文本 | 逗号分隔的软件包列表。仅更新这些软件包。 |
| x | --pre 文本 | 逗号分隔的软件包列表，以允许更新到预发行版本。使用 "*" 可将所有软件包更新为预发行版本。默认情况下，软件包仅更新为稳定版本。 |
| -z | --nonzero-exit-code | 当所有软件包up-to-date时退出，当某些软件包更新时，11退出。 默认值为成功时退出状态零，而失败为非零。 |
| x | --version | 显示版本和退出。 |
| x | --help | 显示这里消息并退出。 |

- [alanhamlett/pip-update-requirements](https://github.com/alanhamlett/pip-update-requirements)


#### python3 open()函数文件操作模式

| 模式 | 描述 | 
|---|---|
| `r` | 打开的文件为只读模式。文件指针位于文件的开头，这是默认模式。 |
| `rb` | 打开仅用二进制格式读取的文件。文件指针位于文件的开头，这是默认模式。 |
| `r+` | 打开读写文件。文件指针放在文件的开头。 |
| `rb+` | 以二进制格式打开一个用于读写文件。文件指针放在文件的开头。 |
| `w` | 打开仅供写入的文件。 如果文件存在，则覆盖该文件。 如果文件不存在，则创建一个新文件进行写入。 |
| `wb` | 打开仅用二进制格式写入的文件。如果文件存在，则覆盖该文件。 如果文件不存在，则创建一个新文件进行写入。 |
| `w+` | 打开写入和取读的文件。如果文件存在，则覆盖现有文件。 如果文件不存在，创建一个新文件进行阅读和写入。 |
| `wb+` | 打开一个二进制格式的写入和读取文件。 如果文件存在，则覆盖现有文件。 如果文件不存在，创建一个新文件进行阅读和写入。 |
| `a` | 打开一个文件进行追加。 如果文件存在，则文件指针位于文件末尾。也就是说，文件处于追加模式。如果文件不存在，它将创建一个新文件进行写入。 |
| `ab` | 打开一个二进制格式的文件。如果文件存在，则文件指针位于文件末尾。 也就是说，文件处于追加模式。如果文件不存在，它将创建一个新文件进行写入。 |
| `a+` | 打开一个文件，用于追加和阅读。 如果文件存在，则文件指针位于文件末尾。 文件以附加模式打开。 如果文件不存在，它将创建一个新文件进行阅读和写入。 |
| `ab+` | 打开一个二进制格式的附加和读取文件。 如果文件存在，则文件指针位于文件末尾。文件以附加模式打开。如果文件不存在，它将创建一个新文件进行读取和写入。 |


#### APScheduler
**组件：**
* 触发器（`trigger`）：触发器中包含调度逻辑，每个作业都有自己的触发器来决定下次运行时间。除了它们自己初始配置以外，触发器完全是无状态的。
* 作业存储器（`job store`）：存储被调度的作业，默认的作业存储器只是简单地把作业保存在内存中，其他的作业存储器则是将作业保存在数据库中，当作业被保存在一个持久化的作业存储器中的时候，该作业的数据会被序列化，并在加载时被反序列化，需要说明的是，作业存储器不能共享调度器。
* 执行器（`executor`）：处理作业的运行，通常通过在作业中提交指定的可调用对象到一个线程或者进程池来进行，当作业完成时，执行器会将通知调度器。
* 调度器（`scheduler`）：配置作业存储器和执行器可以在调度器中完成。例如添加、修改、移除作业，根据不同的应用场景，可以选择不同的调度器，可选的将在下一小节展示。

**调度器：**

* `BlockingScheduler`：调用start函数后会阻塞当前线程。当调度器是你应用中唯一要运行的东西时（如上例）使用。
* `BackgroundScheduler`：调用start后主线程不会阻塞。当你不运行任何其他框架时使用，并希望调度器在你应用的后台执行。
* `AsyncIOScheduler`：当你的程序使用了asyncio（一个异步框架）的时候使用。
* `GeventScheduler`：当你的程序使用了gevent（高性能的Python并发框架）的时候使用。
* `TornadoScheduler`：当你的程序基于Tornado（一个web框架）的时候使用。
* `TwistedScheduler`：当你的程序使用了Twisted（一个异步框架）的时候使用
* `QtScheduler`：如果你的应用是一个Qt应用的时候可以使用。

**特别参数：**
* `coalesce`：当由于某种原因导致某个job积攒了好几次没有实际运行（比如说系统挂了5分钟后恢复，有一个任务是每分钟跑一次的，按道理说这5分钟内本来是“计划”运行5次的，但实际没有执行），如果coalesce为True，下次这个job被submit给executor时，只会执行1次，也就是最后这次，如果为False，那么会执行5次（不一定，因为还有其他条件，看后面misfire_grace_time的解释）
* `max_instance`: 就是说同一个job同一时间最多有几个实例再跑，比如一个耗时10分钟的job，被指定每分钟运行1次，如果我们max_instance值为5，那么在第6~10分钟上，新的运行实例不会被执行，因为已经有5个实例在跑了
* `misfire_grace_time`：设想和上述coalesce类似的场景，如果一个job本来14:00有一次执行，但是由于某种原因没有被调度上，现在14:01了，这个14:00的运行实例被提交时，会检查它预订运行的时间和当下时间的差值（这里是1分钟），大于我们设置的30秒限制，那么这个运行实例不会被执行。

- [Python定时任务框架apscheduler_小龙在线-CSDN博客](https://blog.csdn.net/lilongsy/article/details/104752847)
- [APScheduler中两种调度器的区别及使用过程中要注意的问题_ybdesire的专栏-CSDN博客](https://blog.csdn.net/ybdesire/article/details/82228840)
- [Python进阶 - 定时运行程序 APScheduler_清欢-CSDN博客](https://blog.csdn.net/irving512/article/details/106294306)
- [Python - APScheduler - 听雨危楼 - 博客园](https://www.cnblogs.com/Neeo/p/10435059.html)



### Django
#### Django: 使用 Q 对象构建复杂的查询语句

多个字段模糊查询， 括号中的下划线是双下划线，双下划线前是字段名，双下划线后可以是icontains或contains,区别是是否大小写敏感，竖线是或的意思

```
sciencenews = models.Sciencenews.objects.filter(Q(title__icontains=keyword)\
	|Q(content__icontains=keyword)|Q(author__icontains=keyword))

```

- [django学习——如何实现简单的搜索功能](https://blog.csdn.net/geerniya/article/details/79025405)
- [Django模糊查询 - CSDN博客](https://blog.csdn.net/liuweiyuxiang/article/details/71104613)

#### Django 使用jquery提交post请求
Django在处理post请求时出现403错误

原文1：http://www.cnblogs.com/xtt-w/p/6232559.html

解决方法：
 在settings.py里面的MIDDLEWARE_CLASSES中去掉“‘django.middleware.csrf.CsrfViewMiddleware’,”。

原文2：http://blog.csdn.net/sherry_rui/article/details/50523725

解决方法：
1.在发送post请求的html页面前加入 `{% csrf_token %}` 如：

```html
<form action="/login" method="post">
   {% csrf_token %}
   <input type="text"  required="required" placeholder="用户名" name="u"/>
   <input type="password"  required="required" placeholder="密码" name="p"/>
   <button class="but" type="submit">登录</button>
</form>
```

2.在处理post数据的view前加 `@csrf_exempt` 装饰符，如：

```python
from django.views.decorators.csrf import csrf_exempt,csrf_protect
 
@csrf_exempt  
def profile_delte(request): 
```

#### Django下载文件时，中文文件名问题

解决：
```python
from django.utils.encoding import escape_uri_path
from django.http import HttpResponse

def test(request):
    file_name = '测试.txt'
    content = ...
    response = HttpResponse(content, content_type='application/octet-stream')
    response['Content-Disposition'] = "attachment; filename*=utf-8''{}".format(escape_uri_path(file_name))
    return response
```

- [Django中设置Content-Disposition保存中文命名的文件 - ludaming的回答 - SegmentFault 思否](https://segmentfault.com/q/1010000009719860/a-1020000011650312)


#### Django 使用HttpResponse返回图片、使用流响应处理视频


```python
def read_img(request):
    """
    : 读取图片
    :param request:
    :return:
    """
    try:
        data = request.GET
        file_name = data.get("file_name")
        imagepath = os.path.join(settings.BASE_DIR, "static/images/{}".format(file_name))  # 图片路径
        with open(imagepath, 'rb') as f:
            image_data = f.read()
        return HttpResponse(image_data, content_type="image/png")
    except Exception as e:
        print(e)
        return HttpResponse(str(e))
```

- [Django 中使用流响应处理视频 - 栖迟于一丘](https://www.hongweipeng.com/index.php/archives/1559/)


####  Django 数据库 ORM 常用查询筛选方法总结

```pythobn
__exact 精确等于 like ‘aaa’
__iexact 精确等于 忽略大小写 ilike ‘aaa’
__contains 包含 like ‘%aaa%’
__icontains 包含 忽略大小写 ilike ‘%aaa%’，但是对于sqlite来说，contains的作用效果等同于icontains。
__gt 大于
__gte 大于等于
__lt 小于
__lte 小于等于
__in 存在于一个list范围内
__startswith 以…开头
__istartswith 以…开头 忽略大小写
__endswith 以…结尾
__iendswith 以…结尾，忽略大小写
__range 在…范围内
__year 日期字段的年份
__month 日期字段的月份
__day 日期字段的日
__isnull=True/False
__isnull=True 与 __exact=None的区别
```

数据库时间查询：
```python
2、gte：大于等于某个时间：
a=yourobject.objects .filter(youdatetimcolumn__gte=start)

3、lt：小于
a=yourobject.objects .filter(youdatetimcolumn__lt=start)

4、lte：小于等于
a=yourobject.objects .filter(youdatetimcolumn__lte=start)

5、range：查询时间段
start_date = datetime.date(2005, 1, 1)
end_date = datetime.date(2005, 3, 31)
Entry.objects.filter(pub_date__range=(start_date, end_date))

6、year：查询某年
Entry.objects.filter(pub_date__year=2005)

7、month：查询某月
Entry.objects.filter(pub_date__month=12)

8、day：某天
Entry.objects.filter(pub_date__day=3)

9、week_day：星期几
Entry.objects.filter(pub_date__week_day=2)
```

- 不等于/不包含于
```python
User.objects.filter().exclude(age=10)    # 查询年龄不为10的用户
User.objects.filter().exclude(age__in=[10, 20])  # 查询年龄不为在 [10, 20] 的用户
```

- [Making queries 执行查询 | Django 文档 | Django](https://docs.djangoproject.com/zh-hans/3.0/topics/db/queries/)

#### django log日志的配置

- [django开发-log日志的配置 - wyzane - SegmentFault 思否](https://segmentfault.com/a/1190000016497135)
- [django 日志logging的配置以及处理-David-51CTO博客](https://blog.51cto.com/davidbj/1433741)
- [在Django使用Logging製作紀錄檔 - Carson's Tech save@note.youdao.com](https://carsonwah.github.io/django-logging.html)
- [Logging | Django documentation | Django](https://docs.djangoproject.com/en/2.2/topics/logging/)


#### Django 国际化和本地化
> 国际化一般简称 `i18n`，代表 Internationalization 中 i 和 n 有 18 个字母；本地化简称 `L10n`，表示 Localization 中 l 和 n 中有 10 个字母。

通过`_()`或`ugettext()`函数，指定某个变量需要翻译
```python
from django.utils.translation import ugettext as _
from django.http import HttpResponse

def my_view(request):
    output = _("Welcome to my site.")
    return HttpResponse(output)
```

首先你要在模版的顶部加载`{% load i18n %}`, 使用`{% trans %}`模板标签

```python
{% load i18n %}
<title>{% trans "This is the title." %}</title>
<title>{% trans myvar %}</title>

#提前翻译字符串但是不显示出来
{% trans "This is the title" as the_title %}

<title>{{ the_title }}</title>
<meta name="description" content="{{ the_title }}">
```

`blocktrans`标签允许你通过使用占位符来标记由文字和可变内容组成的复杂句子进行翻译


```python
{% blocktrans %}This string will have {{ value }} inside.{% endblocktrans %}

{% blocktrans with amount=article.price %}
That will cost $ {{ amount }}.
{% endblocktrans %}

{% blocktrans with myvar=value|filter %}
This will have {{ myvar }} inside.
{% endblocktrans %}
```

使用 `makemessages` 命令生成 po 语言文件

```python
python manage.py makemessages -l zh-cn  //中文简体
python manage.py makemessages -l en    //英文
```

> 注：执行命令后，Django会在根目录及其子目录下搜集所有需要翻译的字符串，默认情况下它会搜索`.html`、`.txt`和`.py`文件，然后在根目录的`locale/LANG/LC_MESSAGES`目录下创建一个django.po文件。
> 
> 在执行这一步之前，请先通过 `xgettext --version` 确认自己是否安装了 GNU gettext。GNU gettext 是一个标准 i18n L10n 库，Django 和很多其他语言和库的多语言模块都调用了 GNU gettext。

macOS:
```python
$ brew install gettext
$ brew link --force gettext
```

ubuntu:
```python
$ apt update
$ apt install gettext
```

编译 `compilemessages` 命令编译 mo 文件，将其编译成对应的`*.mo`文件，Django在运行时将使用`*.mo`文件对网站进行国际化翻译

```python
django-admin compilemessages
```
> Django将自动搜索所有的`.po`文件，将它们都翻译成`.mo`文件。


- [django Django 国际化和本地化 - 刘江的django教程](http://www.liujiangblog.com/course/django/180)
- [Django 多语言教程 (i18n) - 掘金](https://juejin.im/post/5b3efc36e51d45197136eb09)


#### Django Server Error: port is already in use（Django 启动服务失败，端口已被占用）

A more simple solution just type `sudo fuser -k 8000/tcp`. This should kill all the processes associated with port 8000.

EDIT:

For osx users you can use `sudo lsof -t -i tcp:8000 | xargs kill -9`

```shell
sudo lsof -t -i tcp:8000 | xargs kill -9
```

- [python - Django Server Error: port is already in use - Stack Overflow](https://stackoverflow.com/questions/20239232/django-server-error-port-is-already-in-use)

#### DateTime compare in django template

```python
{% if pub_date|date:"YmdHis" != mod_date|date:"YmdHis" %}
        <span>文章已于 {{ topic.mod_date }} 修改</span>
{% endif %} 
```

- [DateTime compare in django template - Stack Overflow](https://stackoverflow.com/questions/15675764/datetime-compare-in-django-template/57036650#57036650)


#### Django User 模型
- username
- password
- email
- first_name
- last_name
- groups
- user_permissions
- is_active 表示用户是否是活跃的
- is_staff 可以登录django的admin后台
- is_superuser 能够登录admin后台，并拥有所有注册模型的管理权限。
- last_login
- date_joined


#### 扩展 Django User 模型

```python
class Profile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    icon = models.CharField(max_length=1000, blank=True)
    email = models.CharField(max_length=60, blank=True)
    mobile = models.CharField(max_length=60, blank=True)

    def __str__(self):
        return 'Profile for user {}'.format(self.user.username)

@receiver(post_save, sender=User)
def create_user_profile(sender, instance, created, **kwargs):
    if created:
        Profile.objects.create(user=instance)

@receiver(post_save, sender=User)
def save_user_profile(sender, instance, created, **kwargs):
    if not instance.is_superuser:
        instance.profile.save()
    # if created:
    #     instance.profile.save()
```

- [如何扩展 Django User 模型 - 后端 - 掘金](https://juejin.im/entry/598ad78f51882548981919ac)
- [DjangoWeb开发--增加用户字段 - 简书](https://www.jianshu.com/p/414df6b1cb29)
- [Django不区分大小写的登录，混合大小写用户名 - VoidCC](http://cn.voidcc.com/question/p-rnblylwy-bke.html)

#### Django Model set Null or None

* `blank=True` allows you to input nothing (i.e `""`, `None`) and keep it empty.
* `null=True` means the database row is allowed to be `NULL`.
* `default=None` sets the field to `None` if no other value is given.

- [Django Model Field Default to Null](https://stackoverflow.com/questions/4604814/django-model-field-default-to-null)


#### Django 不区分大小写的用户名允许登录

Django 支持不区分大小写筛选运算符`iexact`：

```python
user = User.objects.get(username__iexact=name) 
```

#### 设置 Django ModelAdmin 为只读

1. 重写 `get_readonly_fields` 方法：

```python

class PostAdmin(admin.ModelAdmin):
   
   ...
   
    def get_readonly_fields(self, request, obj=None):
        return ['user']
```

2. 定义 readonly_fields 属性

```python
class PostAdmin(admin.ModelAdmin):
   
   ...
   
    readonly_fields = [field.name for field in ModelName._meta.fields]
```

其它的属性有，禁用添加操作 `has_add_permission`，禁用修改操作 `has_change_permission`，禁用删除操作，`has_delete_permission`

- [如何在 django admin site 中设置某个 model 只读 - Huang Huang 的博客](https://mozillazg.com/2015/09/django-setup-readonly-model-on-admin.html)
- [The Django admin site | Django documentation | Django](https://docs.djangoproject.com/en/1.8/ref/contrib/admin/#django.contrib.admin.ModelAdmin.readonly_fields)

#### Django version

```
>>> import django
>>> django.VERSION
```
or

```
python -c "import django; print(django.get_version())"
```
- [python - How to check Django version - Stack Overflow](https://stackoverflow.com/questions/6468397/how-to-check-django-version)

#### Django REST framework

- [Serializers - Django REST framework中文站点](https://q1mi.github.io/Django-REST-framework-documentation/api-guide/serializers_zh/)
- [Django REST framework API 指南 - 掘金](https://juejin.im/post/5a9520dc6fb9a0634f40c2db)
- [Django Rest Framework - 安装，配置 与 新建 Serialization - LABELNET - CSDN博客](https://blog.csdn.net/lablenet/article/details/53491756)
- [Django Rest Framework API指南 - Fighting蔚 - 博客园](https://www.cnblogs.com/victorwu/p/7418368.html)
- [python 全栈开发，Day95(RESTful API介绍,基于Django实现RESTful API,DRF 序列化) - 肖祥 - 博客园](https://www.cnblogs.com/xiao987334176/p/9401486.html)
- [python 全栈开发，Day96(Django REST framework 视图,django logging配置,django-debug-toolbar使用指南) - 肖祥 - 博客园](https://www.cnblogs.com/xiao987334176/p/9408378.html)

#### 关闭 Debug 后，静态资源无法显示问题
Django 关闭 Debug 后无法访问静态资源图片等，可以配置nginx做反向代理, 但是对于调试来说操作比较麻烦, 我们只需在命令 `python manage.py runserver 0.0.0.0:8000` 后加一个参数 `--insecure` 就可以啦~~

#### Django设置时区USE_TZ问题

settings 文件内容：
```
LANGUAGE_CODE = 'zh-hans'

TIME_ZONE = 'Asia/Shanghai'

USE_TZ = True
```

如果要设为中国时间，也就是北京时间，请赋值：`TIME_ZONE = 'Asia/Shanghai'`。注意是上海，不是北京，囧！

当`USE_TZ`为`False`时，`TIME_ZONE`将成为Django存储所有日期和时间数据时，使用的时区。 当`USE_TZ`为`True` 时，它是Django显示模板中的时间，解释表单中的日期，使用的时区。所以，通常我们都将`USE_TZ`同时设置为`False`！

- [Time zones | Django documentation](https://docs.djangoproject.com/en/3.0/topics/i18n/timezones/)
- [为什么Django设置时区为TIME_ZONE = Asia/Shanghai USE_TZ = True后，存入mysql中的时间只能是UTC时间 - CSDN博客](https://blog.csdn.net/qq_27361945/article/details/80580795)
- [django 中的USE_TZ设置为true有何影响? - SegmentFault 思否](https://segmentfault.com/q/1010000000405911)
- [Django时区详解_数据库 - CSDN博客](https://blog.csdn.net/laughing2333/article/details/53513414)
- [django时区问题时间差8小时 - 简书](https://www.jianshu.com/p/c1dee7d3cbb9)
- [django 核心配置项 - 刘江的django教程](https://www.liujiangblog.com/course/django/164)

#### Django外键（ForeignKey）related_name 的作用
django 默认每个主表的对象都有一个是外键的属性，可以通过它来查询到所有属于主表的子表的信息。这个属性的名称默认是以子表的名称小写加上`_set()`来表示，默认返回的是一个querydict对象，可以继续的根据情况来查询等操作。

使用最多的还是 `related_name`，上面的`_set()`定义比较麻烦的话，你也可以在定义主表的外键的时候，给这个外键用`related_name`定义好一个名称.

示例：一个老师对应多个学生
```
class Teacher(models.Model):
    name = models.CharField(max_length=50)
    
class Student(models.Modle):
    name = models.CharField(max_length=50)
    teacher = models.Foreignkey(Teacher, related_name='student_teacher', on_delete=models.CASCADE, default='')
```

现在想查询一个老师对应的学生有那些？

方法一`_set()`：
```
teacher = Teacher.objects.get(id=1)
teacher.student_set.all()
```

方法二`related_name`：
```
teacher = Teacher.objects.get(id=1)
teacher.student_teacher.all()
```

查询一个学生所对应的老师的信息？

```
student = Student.objects.get(id=1)
student.teacher
student.teacher.name
```

#### Django 数据库查询结果去重

QuerySet 增加方法 `.distinct()`

当使用distinct()函数的时候，如果不使用order_by()函数做跟随，那么该函数会自动把当前表中的默认排序字段作为DISTINCT的一个列

#### Django 数据模型 ForeignKey 的 on_delete 属性
假如有一个订单模型，定义了关联用户模型
```
class Order(models.Model):
    user= models.ForeignKey(User, on_delete=models.CASCADE)
```

* `CASCADE`：级联删除，当你删除user记录时，与之关联的所有 order 都会被删除。
* `PROTECT`: 保护模式，如果采用该选项，删除的时候，会抛出`ProtectedError`错误，也就是说，如果有外键关联，就不允许删除，除非先把关联了外键的记录删除掉。举个例子就是想要删除user，那你要把所有关联了该user的order全部删除才可能删user。
* `SET_NULL`: 置空模式，删除的时候，外键字段被设置为空，前提就是要设置为 `blank=True, null=True`。删除user后，order 记录里面的user_id 就置为null了。
* `SET_DEFAULT`: 置默认值，删除的时候，外键字段设置为默认值，所以定义外键的时候注意加上一个默认值。
* `SET()`: 自定义一个值，该值只能是对应的实体
* `DO_NOTHING`: Django啥事也不做，你要删就删吧，你的外键值我依然给你保留，但是你要是去做关联查询肯定是查不到了，比如 删除 user后，order 里面的 user_id 依然在，只是再也找不到 user_id 对应的是哪个user了，因为你把他删掉了。

- [Django 数据模型 ForeignKey 的 on_delete 属性的可选值 - FooFish-Python之禅](https://foofish.net/django-foreignkey-on-delete.html)


#### Django 模板
- [Django 模板 | 菜鸟教程](https://www.runoob.com/django/django-template.html)
- [Django 模板进阶 - Django 教程 - 自强学堂](https://code.ziqiangxuetang.com/django/django-template2.html)

#### Django 重定向

```
from django.urls import reverse
from django.shortcuts import redirect
from django.http import HttpResponseRedirect

#投票结果查看
def results(request,question_id=1):
    return HttpResponse(r"you're looking  at the results of question %s." % question_id )


#投票功能
def vote(request,question_id):
        '''
        投票逻辑
        '''
        #投票完后跳转到结果页面，如下
        return redirect(reverse('polls:results', args=[question_id]))
```

- [url带参数重定向 - 我只是一只小小鸟的个人页面 - OSCHINA](https://my.oschina.net/RabbitXiao/blog/1808871)
- [Django 几种重定向的方式_orangleliu 笔记本-CSDN博客](https://blog.csdn.net/orangleliu/article/details/38347863)
- [Django URL重定向的3种方法详解 - 知乎](https://zhuanlan.zhihu.com/p/41547331)


#### Django 模型多个属性设置为唯一

```
    class Meta:
        unique_together = ("title", "category")
```

#### Django class view 增加权限判断

1/定义一个基类，包含一个 as_view 方法，在 as_view 方法中判断用户权限。然后其他 class view 继承这个基类

```python
from django.contrib.auth.decorators import login_required

class LoginRequiredMixin(object):
    @classmethod
    def as_view(cls, **initkwargs):
        view = super(LoginRequiredMixin, cls).as_view(**initkwargs)
        return login_required(view)
```

2、定义一个基类，包含一个 dispatch 方法，给这个方法加个权限判断的装饰器。然后其他 class view 继承这个基类


```python
from django.contrib.auth.decorators import login_required
from django.utils.decorators import method_decorator
from django.views.generic import TemplateView

class ProtectedView(TemplateView):
    template_name = 'secret.html'

    @method_decorator(login_required)
    def dispatch(self, *args, **kwargs):
        return super(ProtectedView, self).dispatch(*args, **kwargs)
```

- [怎么给 django class view 增加权限判断 - Huang Huang 的博客](https://mozillazg.com/2015/11/django-check-user-permission-for-class-generic-view.html)

#### Django 中 ur l和 path 的区别

urls.py 在1.x的时候都是采用的url方式。如下

```python
url(r'^', include("test1.urls")),
```

在2.0中，它推荐使用的是path模块。需要引入包 `from django.urls import path`

```python
path('', include("test1.urls")),
```

这里要注意的是，如果要使用正则，则要引入re_path，`from django.urls import path, re_path`。


1.x里面的写法是：
```python
url(r’^page=(\d+)&key=(\w+)$’, views.detail, name=”detail”), 
```

现在的写法
```python
re_path('page=(?P<page>\d+)&key=(?P<key>\w+)', views.detail, name="detail"),
```

关于系统的urls.py里的namespace的问题，1.x中写法
```python
 url(r'^', include("test1.urls", namespace='test1')),
```

2.0 这么写，在项目urls.py中加上

```python
app_name = 'test1'
```

- [URL调度器 | Django 3.0 文档 | Django](https://docs.djangoproject.com/zh-hans/3.0/topics/http/urls/)
- [django2笔记:路由path语法 | 程序员Barnes的博客](https://kinegratii.github.io/2017/09/25/django2-url-path/)

### Excel
#### openpyxl获取excel中函数公式的结果值

```ptyhon
import openpyxl
wb= openpyxl.load_workbook('ihtcboy.xlsx',data_only=True)
```

创建对象时增加 `data_only=True` 参数就可以读取值。

### 爬虫
#### Python Selenium 元素text获取不到内容

```python
li_list = browser.find_elements_by_class_name('myli')
for article in li_list:
    text = article.text
    text1 = article.get_attribute('innerHTML')
    text2 = article.get_attribute('innerText')
    text3 = article.get_attribute('textContent')
```

第一个 `.text` 获取有些为空，所以要用下面的3种方法。


### 项目部署
#### Fabric
Fabric：官方Fabric，兼容 Python 2 & Python 3，但不兼容Fabric 1.x的fabfile；
fabric2： 与Fabric相同，仅作为平滑迁移（使用Fabric包安装1.x 版本，使用Fabric2包安装2.x版本，来实现1.x和2.x的共存）；
Fabric3：是一个基于Fabric 1.x 的fork，兼容Python2 & Python3，兼容 Fabric1.x 的 fabfile；

- [Welcome to Fabric! — Fabric documentation](https://www.fabfile.org/)
- [欢迎访问 Fabric 中文文档 — Fabric 文档](https://fabric-chs.readthedocs.io/zh_CN/chs/index.html)
- [Python - Fabric简介 - Anliven - 博客园](https://www.cnblogs.com/anliven/p/9186994.html)
- [远程部署神器 Fabric，支持 Python3 - Python之禅 - CSDN博客](https://blog.csdn.net/zV3e189oS5c0tSknrBCL/article/details/85271219)
- [python模块fabric踩坑记录 | 淦](https://tankeryang.github.io/posts/python%E6%A8%A1%E5%9D%97fabric%E8%B8%A9%E5%9D%91%E8%AE%B0%E5%BD%95/)
- [python三大神器之fabric（2.0新特性） - 三只松鼠 - 博客园](https://www.cnblogs.com/shenh/p/10060149.html)
- [Fabric 让 Linux 系统部署变得简单](https://www.ibm.com/developerworks/cn/linux/simplyfy-linux-deployment-with-fabric/index.html)

#### uWSGI 和 Nginx

- [Python/WSGI 应用快速入门 — uWSGI 2.0 文档](https://uwsgi-docs-cn.readthedocs.io/zh_CN/latest/WSGIquickstart.html#django)
- [使用uWSGI和nginx来设置Django和你的web服务器 — uWSGI 2.0 文档](https://uwsgi-docs-zh.readthedocs.io/zh_CN/latest/tutorials/Django_and_nginx.html)
- [Linux檔案權限](http://s2.naes.tn.edu.tw/~kv/file.htm)
- [部署python项目到linux服务器 | 蓝士钦](https://www.lanshiqin.com/d8d0505b/)
- [使用 uWSGI 和 Nginx 部署 Django 项目 - 掘金](https://juejin.im/post/5cb95a0ef265da03502b34f3)
- [基于nginx和uWSGI在Ubuntu上部署Django | WolfcsTech](https://www.wolfcstech.com/2016/11/14/nginx_uWSGI_deply_django_on_ubuntu/#1-nginx)
- [用Nginx+uwsgi部署Django | 🍃(yuchanns (Atelier))](https://www.yuchanns.xyz/posts/2018/08/24/deploy-django.html)
- [Django 二级域名配置 - 简书](https://www.jianshu.com/p/d340d0645f05)
- [域名管理 · Python（Django）环境部署与使用指南 · 看云](https://www.kancloud.cn/websoft9/python-guide/613040)
- [Django 教程 11: 部署 Django 到生产环境 - 学习 Web 开发 | MDN](https://developer.mozilla.org/zh-CN/docs/learn/Server-side/Django/Deployment)
- [Day 15 - 部署Web App - 廖雪峰的官方网站](https://www.liaoxuefeng.com/wiki/1016959663602400/1018491264935776)
- [Python Web部署方式总结 - 简书](https://www.jianshu.com/p/0aece015976f)
- [Nginx, WSGI, Flask之间的关系 - 勰门歪道 | Shane Talk](http://www.shanetalk.com/2017/08/20/Nginx-WSGI-Flask/)
- [基于nginx和uWSGI在Ubuntu上部署Django - 简书](https://www.jianshu.com/p/e6ff4a28ab5a)
- [Python项目自动化部署最佳实践@搜狐 | the5fire的技术博客](https://www.the5fire.com/auto-deploy-tool-for-python-app.html)
- [以正确的方式开源 Python 项目 - OSCHINA](https://www.oschina.net/translate/open-sourcing-a-python-project-the-right-way)
- [Systemd 入门教程：命令篇 - 阮一峰的网络日志](http://www.ruanyifeng.com/blog/2016/03/systemd-tutorial-commands.html)
- [Jenkins部署Python项目实战 - 掘金](https://juejin.im/post/5ca5b886f265da30a07d2a48)
- [CentOS 环境下基于 Nginx uwsgi 搭建 Django 站点 - restran - 博客园](https://www.cnblogs.com/restran/p/4412708.html)
- [第二期 · 阿里云Python+Flask环境搭建 - 知乎](https://zhuanlan.zhihu.com/p/22126999)
- [一.阿里云服务器安装部署及第一个Python爬虫代码实现 - 杨秀璋的专栏 - CSDN博客](https://blog.csdn.net/eastmount/article/details/79321822)
- [如何在阿里云上部署 Django 应用程序 - 阿里云新手学堂](https://www.alibabacloud.com/zh/getting-started/projects/how-to-deploy-django-application-on-alibaba-cloud)
- [Django + Apache 部署 - - SegmentFault 思否](https://segmentfault.com/a/1190000017150991)
* [CentOS设定SFTP用户只能访问家目录 - Adairs的个人空间 - OSCHINA](https://my.oschina.net/adairs/blog/847093)
* [Linux 限制SFTP用户只能访问某个目录 - 经验在于积累而不在于年限---dreamboycx - CSDN博客](https://blog.csdn.net/dreamboycx/article/details/78672925)
* [Linux创建用户只能访问某个目录 - 做点儿扯谈的事儿 - CSDN博客](https://blog.csdn.net/u010073893/article/details/52953911)
* [BasicChroot - Community Help Wiki](https://help.ubuntu.com/community/BasicChroot)
* [CentOS 7部署chroot ssh和sftp监牢 - 大别阿郎的个人空间 - OSCHINA](https://my.oschina.net/u/589241/blog/3067416)