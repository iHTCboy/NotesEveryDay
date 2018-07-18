
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

