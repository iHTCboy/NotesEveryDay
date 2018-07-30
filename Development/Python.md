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

#### Django: 使用 Q 对象构建复杂的查询语句

#多个字段模糊查询， 括号中的下划线是双下划线，双下划线前是字段名，双下划线后可以是icontains或contains,区别是是否大小写敏感，竖线是或的意思

```
sciencenews = models.Sciencenews.objects.filter(Q(title__icontains=keyword)\
	|Q(content__icontains=keyword)|Q(author__icontains=keyword))

```

- [django学习——如何实现简单的搜索功能](https://blog.csdn.net/geerniya/article/details/79025405)
- [Django模糊查询 - CSDN博客](https://blog.csdn.net/liuweiyuxiang/article/details/71104613)