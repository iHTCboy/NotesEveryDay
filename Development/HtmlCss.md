
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

a:link 指正常的未被访问过的链接；
a:active 指正在点的链接；
a:hover 指鼠标在链接上；
a:visited 指已经访问过的链接；
text-decoration是文字修饰效果的意思；
none参数表示超链接文字不显示下划线；
underline参数表示超链接的文字有下划线

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