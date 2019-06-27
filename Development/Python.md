[TOC]

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


### Python json dumps 非标准类型

- [Python 优雅地 dumps 非标准类型 - 掘金](https://juejin.im/post/5a06d4776fb9a04515435afe)


### Python 解析iOS的 p12、mobileprovision文件内容

- [Python查看ipa UDID和其他基本信息 - 简书](https://www.jianshu.com/p/7b84f95bdf6f)
- [cryptography - Python: reading a pkcs12 certificate with pyOpenSSL.crypto - Stack Overflow](https://stackoverflow.com/questions/6345786/python-reading-a-pkcs12-certificate-with-pyopenssl-crypto/6346268#6346268)
- [Python：用pyOpenSSL.crypto读取pkcs12证书 - 代码日志](https://codeday.me/bug/20181207/432700.html)

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