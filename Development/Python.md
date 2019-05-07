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