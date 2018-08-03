#### GoogleChrome/dialog-polyfill
polyfill 仿效一个完整的 ES2015+ 环境，并意图运行于一个应用中而不是一个库/工具。

- [GoogleChrome/dialog-polyfill](https://github.com/GoogleChrome/dialog-polyfill)
- [dialog element demo](https://demo.agektmr.com/dialog/)
- [一起来看 HTML 5.2 中新的原生元素 <dialog>](https://segmentfault.com/a/1190000012894864)


#### jq获取元素内文本，但不包括其子元素内的文本值的方法

例子：
```html
<li id="listItem">
    This is some text
    <span id="firstSpan">First span text</span>
    <span id="secondSpan">Second span text</span>
</li>
```

1、jq方法

```js
$("#listitem")
    .clone()    //复制元素
    .children() //获取所有子元素
    .remove()   //删除所有子元素
    .end()  //回到选择的元素
    .text();//获取文本值
```
2、jq方法

```js
$("#listItem").contents().filter(function(){ 
  return this.nodeType == 3; 
})[0].nodeValue 
```

3、js方法

```js
document.getElementById("listItem").childNodes[0].nodeValue;
```

