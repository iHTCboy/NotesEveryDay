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

#多个字段模糊查询， 括号中的下划线是双下划线，双下划线前是字段名，双下划线后可以是icontains或contains,区别是是否大小写敏感，竖线是或的意思

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