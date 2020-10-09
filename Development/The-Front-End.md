[TOC]

### Front-End（前端）

### HTML（HyperText Markup Language，超文本标记语言）
> 超文本标记语言是一种用于创建网页的标准标记语言。HTML是一种基础技术，常与CSS、JavaScript一起被众多网站用于设计网页、网页应用程序以及移动应用程序的用户界面。网页浏览器可以读取HTML文件，并将其渲染成可视化网页。HTML描述了一个网站的结构语义随着线索的呈现，使之成为一种标记语言而非编程语言。


### CSS（Cascading Style Sheets，层叠样式表）
> CSS 是一种样式表语言，用来描述 HTML 或 XML（包括如 SVG、MathML、XHTML 之类的 XML 分支语言）文档的呈现。CSS 描述了在屏幕、纸质、音频等其它媒体上的元素应该如何被渲染的问题。

#### CSS去除去掉 `<a>` 超链接的下划线
　　
```css
a:hover {
    color: #4499EE;
    text-decoration: none; /*CSS下划线效果：无下划线*/
    border-bottom: 1px #0099CC dotted /*CSS加一个只有下边的框 边框为虚线*/
}
```

- a:link 指正常的未被访问过的链接；
- a:active 指正在点的链接；
- a:hover 指鼠标在链接上；
- a:visited 指已经访问过的链接；
- text-decoration 是文字修饰效果的意思；
- none 参数表示超链接文字不显示下划线；
- underline 参数表示超链接的文字有下划线


#### pre 标签自动换行
`<pre>` 元素可定义预格式化的文本。被包围在 pre 元素中的文本通常会保留空格和换行符。而文本也会呈现为等宽字体。

```
pre {
    white-space: pre-wrap;
    word-wrap: break-word;
}
```

- [【CSS】Pre 标签 自动换行 - 简书](https://www.jianshu.com/p/4ae0b011dcde)


### JS（JavaScript）
> 1996 年 Netscape 创造了 Javascript，微软推出 Jscript，为了统一标准，交由国际标准化组织 ECMA 制定规范（TC39），1997 年 ECMA 发布 262 号标准文件，Ecmascript1.0 发布。

所以：`Ecmascript` 是一种规范，而 `Javascript` 是 Ecmascript 的一种超集实现。

#### ES6 是什么？
* 2011 年 Ecmascript5.1 发布，之后开始使用年份来代替版本 
* 2015 年 6 月发布了 Ecmascript2015, 简称 ES2015 
* 2016 年 6 月发布了 Ecmascript2016, 简称 ES2016 
* 2017 年 6 月发布了 Ecmascript2016, 简称 ES2017 

所以：`ES6` 是对 5.1 以后版本的泛指。

 
#### confirm() 、prompt() 方法
- confirm()	显示带有一段消息以及确认按钮和取消按钮的对话框。
- prompt()	显示可提示用户输入的对话框。


```js
var r = confirm("Press a button!");
if (r==true) {
  alert("You pressed OK!");
} else {
  alert("You pressed Cancel!");
}
```


```js
var name = prompt("请输入您的名字", "预设值")
if (name!=null && name!="")
{
    document.write("你好，" + name + "！今天过得好吗？")
}
```

#### is(":checked")勾选框判断

一种是DOM节点属性，读取它的方法就是 `attr()` 方法
第二种是HTML元素属性，这种属性你看不到，但是确实存在，而且大部分情况和DOM节点属性对应的值一样。
在jQuery中取得这种值的方法是 `prop()`;

```js
$("#checkbox1").attr("checked") // checked
$("#checkbox2").attr("checked") // undefined
$("#checkbox1").is(":checked") // true
$("#checkbox1").prop("checked") //true
```

[从is(":checked")说起 - 哎呦大黄 - 博客园](https://www.cnblogs.com/season-huang/p/3360869.html)


### TS（TypeScript）
> TypeScript 是一种开源的编程语言，该语言项目由微软进行维护和管理。TypeScript 不仅包含 JavaScript 的语法，而且还提供了静态类型检查以及使用看起来像基于类的面向对象编程语法操作 Prototype。

#### TypeScript 是什么
* 简单的说 TypeScript 是 JavaScript 一个超集，能够编译成 JavaScript 代码
* 其核心能力是在代码编写过程中提供了类型支持，以及在编译过程中进行类型校验

* [TypeScript 核心概念梳理 - 阿里云开发者社区](https://developer.aliyun.com/article/772654)


### jQuery

> 维基百科：jQuery是一套跨浏览器的JavaScript库，简化HTML与JavaScript之间的操作。由约翰·雷西格在2006年1月的BarCamp NYC上发布第一个版本。目前由Dave Methvin领导的团队进行开发。 

- [jQuery](https://jquery.com/)

#### 抛弃jQuery，拥抱原生JavaScript
jQuery 代表着传统的以 DOM 为中心的开发模式，但现在复杂页面开发流行的是以 React 为代表的以数据/状态为中心的开发模式

- [抛弃jQuery，拥抱原生JavaScript - camsong/blog](https://github.com/camsong/blog/issues/4)
- [You-Dont-Need-jQuery/README.zh-CN.md - nefe/You-Dont-Need-jQuery](https://github.com/nefe/You-Dont-Need-jQuery/blob/master/README.zh-CN.md)

### Bootstrap
#### Remove default list-style in Bootstrap
To remove the list styles in Bootstrap, use the `.list-unstyled` class.


```css
.list-unstyled {
  padding-left: 0;
  list-style: none;
}
```

- [html - unordered is not removing the style on using class unstyled - Stack Overflow](https://stackoverflow.com/questions/17002128/unordered-is-not-removing-the-style-on-using-class-unstyled)
