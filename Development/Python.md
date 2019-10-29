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
1.在发送post请求的html页面前加入{% csrf_token %}    如：

```html
<form action="/login" method="post">
   {% csrf_token %}
   <input type="text"  required="required" placeholder="用户名" name="u"/>
   <input type="password"  required="required" placeholder="密码" name="p"/>
   <button class="but" type="submit">登录</button>
</form>
```

2.在处理post数据的view前加@csrf_exempt装饰符，如：

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


####  Django 数据库查询方法总结


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


#### Django Server Error: port is already in use

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
- [Centos7 + Django + Nginx +Uwsgi - 简书](https://www.jianshu.com/p/0bb254029579)
- [Day 15 - 部署Web App - 廖雪峰的官方网站](https://www.liaoxuefeng.com/wiki/1016959663602400/1018491264935776)
- [Python Web部署方式总结 - 简书](https://www.jianshu.com/p/0aece015976f)
- [基于nginx和uWSGI在Ubuntu上部署Django - 简书](https://www.jianshu.com/p/e6ff4a28ab5a)
- [Python项目自动化部署最佳实践@搜狐 | the5fire的技术博客](https://www.the5fire.com/auto-deploy-tool-for-python-app.html)
- [以正确的方式开源 Python 项目 - OSCHINA](https://www.oschina.net/translate/open-sourcing-a-python-project-the-right-way)
- [Systemd 入门教程：命令篇 - 阮一峰的网络日志](http://www.ruanyifeng.com/blog/2016/03/systemd-tutorial-commands.html)
- [部署python项目到linux服务器 | 蓝士钦](https://www.lanshiqin.com/d8d0505b/)
- [Jenkins部署Python项目实战 - 掘金](https://juejin.im/post/5ca5b886f265da30a07d2a48)
- [阿里云部署Flask+WSGI+Nginx详解-云栖社区-阿里云](https://yq.aliyun.com/articles/657026)
- [第二期 · 阿里云Python+Flask环境搭建 - 知乎](https://zhuanlan.zhihu.com/p/22126999)
- [一.阿里云服务器安装部署及第一个Python爬虫代码实现 - 杨秀璋的专栏 - CSDN博客](https://blog.csdn.net/eastmount/article/details/79321822)
- [阿里云上部署 Flask 最小的应用 - 勰门歪道 | Shane Talk](http://www.shanetalk.com/2017/06/16/How-to-deploy-Flask-on-the-Aliyun/)
- [如何在阿里云上部署 Django 应用程序 - 阿里云新手学堂](https://www.alibabacloud.com/zh/getting-started/projects/how-to-deploy-django-application-on-alibaba-cloud)
- [Welcome to Fabric! — Fabric documentation](https://www.fabfile.org/)
- [欢迎访问 Fabric 中文文档 — Fabric 文档](https://fabric-chs.readthedocs.io/zh_CN/chs/index.html)
- [远程部署神器 Fabric，支持 Python3 - FooFish-Python之禅](https://foofish.net/fabric.html)
- [远程部署神器 Fabric，支持 Python3 - Python之禅 - CSDN博客](https://blog.csdn.net/zV3e189oS5c0tSknrBCL/article/details/85271219)