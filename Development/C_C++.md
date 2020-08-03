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


#### DBL_EPSILON 和 FLT_EPSILON

主要用于单精度和双精度的比较当中：
```c
    double a = 0.5;
    if (a == 0.5) { //正确
        x++;
    }
    
    double b = sin(M_PI / 6.0);
    if (b == 0.5) { //可能错误
        x++;
    }
```
第一个比较正确，第二个可能正确也可能错误，b==0.5的结果取决于处理器、编译器的版本和设置。比如 Visual C++ 2010 编译器编译后运行b的值为0.49999999999999994

一种正确的比较方法应该是这样的：
```c
    double b = sin(M_PI / 6.0);
    if (fabs(b - 0.5) < DBL_EPSILON) {
        x++;
    }
```

EPSILON 是最小误差。如果整数值减去浮点数值误差低于DBL_EPSILON，则说明该数可以近似看成整数，否则则是浮点数。（ `fabs()`函数是一个求绝对值的函数）
