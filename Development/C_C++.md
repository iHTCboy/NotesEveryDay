[TOC]

#### 函数属性 __attribute__((constructor))和__attribute__((destructor)) 

1）函数属性功能

`__attribute__ ((constructor))`：会使函数在 main()函数之前执行

`__attribute__ ((destructor))`：会使函数在 main()函数之后执行

2）功能范围

函数属性`__attribute__((constructor))`和`__attribute__((destructor))`在可执行文件或者库文件里都可以生效


3）与全局变量比较

全局变量对象的构造函数和析构函数分别在`__attribute__((constructor))`和`__attribute__((destructor))`标志的函数之前调用。

4）PRIORITY 优先级

```
__attribute__((constructor(PRIORITY)))
__attribute__((destructor(PRIORITY)))
```

`__attribute__((constructor))` 按照优先级小到大执行， `__attribute__((destructor(PRIORITY)))` 则是从大到小执行。

注意：
1、可执行程序或库文件都可以使用此属性修饰函数
2、同一个可执行程序或库文件允许多个函数被修饰，执行顺序由代码编写顺序或编译链接顺序有关


- [函数属性__attribute__((constructor))和__attribute__((destructor)) - tianmo2010的专栏](https://blog.csdn.net/tianmohust/article/details/45310349)

