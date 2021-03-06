### Binary（二进制）

#### 为什么 0.1 + 0.2 = 0.300000004

```javascript
   // 加法
   0.1 + 0.2 = 0.30000000000000004
   0.1 + 0.7 = 0.7999999999999999
   0.2 + 0.4 = 0.6000000000000001

   // 减法
   0.3 - 0.2 = 0.09999999999999998
   1.5 - 1.2 = 0.30000000000000004

   // 乘法
   0.8 * 3 = 2.4000000000000004
   19.9 * 100 = 1989.9999999999998

   // 除法
   0.3 / 0.1 = 2.9999999999999996
   0.69 / 10 = 0.06899999999999999

   // 比较
   0.1 + 0.2 === 0.3 // false
   (0.3 - 0.2) === (0.2 - 0.1) // false
```

十进制到二进制的转换导致的精度问题！C/C++,Java,Javascript中，准确的说：“使用了IEEE 754浮点数格式”来存储浮点类型(float 32, double 64)的任何编程语言都有这个问题！

```javascript
console.log('0.1 的二进制是：' + 0.1.toString(2));
console.log('0.2 的二进制是：' + 0.2.toString(2));

"0.1 的二进制是：0.0001100110011001100110011001100110011001100110011001101" 
"0.2 的二进制是：0.001100110011001100110011001100110011001100110011001101"

两者相加：
0.01001100110011001100110011001100110011001100110011001100
转换成10进制之后得到：
0.30000000000000004
```

- [为什么 0.1 + 0.2 = 0.300000004 - 面向信仰编程](https://draveness.me/whys-the-design-floating-point-arithmetic/)
- [解决JS浮点数运算结果不精确的Bug](https://juejin.im/post/6844903903071322119)
- [抓住数据的小尾巴 - JS浮点数陷阱及解法 - 知乎](https://zhuanlan.zhihu.com/p/30703042) 
- [一个函数让你看懂 'Why 0.1+0.2!=0.3'](https://juejin.im/post/6844903789082705934#comment)


### 字符编码

- [字符编码笔记：ASCII，Unicode 和 UTF-8 - 阮一峰的网络日志](http://www.ruanyifeng.com/blog/2007/10/ascii_unicode_and_utf-8.html)
- [了解ASCII、gb系列、Unicode、UTF-8的区别](https://www.douban.com/note/334994123/)
- [InputField 限制字数_yangchunnoodles的博客-CSDN博客](https://blog.csdn.net/yangchunnoodles/article/details/52985441)


#### 字节顺序（大小端序）

> 字节顺序，又称端序或尾序（英语：Endianness），在计算机科学领域中，指电脑内存中或在数字通信链路中，组成多字节的字的字节的排列顺序。
> 例如假设上述变量x类型为int，位于地址0x100处，它的值为0x01234567，地址范围为0x100~0x103字节，其内部排列顺序依赖于机器的类型。
> 大端法从首位开始将是：0x100: 0x01, 0x101: 0x23,..。
> 而小端法将是：0x100: 0x67, 0x101: 0x45,..

- [字节顺序 - 维基百科](https://zh.wikipedia.org/wiki/%E5%AD%97%E8%8A%82%E5%BA%8F)
- [字节序 - FantasticLBP/knowledge-kit](https://github.com/FantasticLBP/knowledge-kit/blob/master/Chapter5%20-%20Network/5.3.md)