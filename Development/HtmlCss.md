[TOC]

### HTML

### CSS

#### CSS去除去掉<a>超链接的下划线
　　
```
a:hover {
    color:#4499EE;
    text-decoration:none; /*CSS下划线效果：无下划线*/
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

#### HTML DOM confirm()	 、prompt() 方法
- confirm()	显示带有一段消息以及确认按钮和取消按钮的对话框。
- prompt()	显示可提示用户输入的对话框。


```js
var r=confirm("Press a button!");
if (r==true)
  {
  alert("You pressed OK!");
  }
else
  {
  alert("You pressed Cancel!");
  }
}
```


```js
  var name=prompt("请输入您的名字","预设值")
  if (name!=null && name!="")
    {
    document.write("你好，" + name + "！今天过得好吗？")
    }
  }
```

#### is(":checked")勾选框判断

一种是DOM节点属性，读取它的方法就是 attr() 方法
第二种是HTML元素属性，这种属性你看不到，但是确实存在，而且大部分情况和DOM节点属性对应的值一样。
在jQuery中取得这种值的方法是prop();

```js
$("#checkbox1").attr("checked") // checked
$("#checkbox2").attr("checked") // undefined
$("#checkbox1").is(":checked") // true
$("#checkbox1").prop("checked") //true
```

[从is(":checked")说起 - 哎呦大黄 - 博客园](https://www.cnblogs.com/season-huang/p/3360869.html)

#### pre 标签 自动换行
<pre> 元素可定义预格式化的文本。被包围在 pre 元素中的文本通常会保留空格和换行符。而文本也会呈现为等宽字体。

```
pre {
    white-space: pre-wrap;
    word-wrap: break-word;
}
```

- [【CSS】Pre 标签 自动换行 - 简书](https://www.jianshu.com/p/4ae0b011dcde)