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

#### JS获取子节点、父节点和兄弟节点的若干种方式

一、js获取子节点的方式
1.通过获取dom方式直接获取子节点
其中test的父标签id的值，div为标签的名字。getElementsByTagName是一个方法。返回的是一个数组。在访问的时候要按数组的形式访问。

```javascript
var a = document.getElementById("test").getElementsByTagName("div");
```

2.通过childNodes获取子节点
使用childNodes获取子节点的时候，childNodes返回的是子节点的集合，是一个数组的格式。他会把换行和空格也当成是节点信息。


```javascript
var b =document.getElementById("test").childNodes;
```

为了不显示不必须的换行的空格，我们如果要使用childNodes就必须进行必要的过滤。通过正则表达式式取掉不必要的信息。下面是过滤掉


```javascript
//去掉换行的空格
for(var i=0; i<b.length;i++){
    if(b[i].nodeName == "#text" && !/\s/.test(b.nodeValue)){
        document.getElementById("test").removeChild(b[i]);
    }
}
//打印测试
for(var i=0;i<b.length;i++){
    console.log(i+"---------")
    console.log(b[i]);
}
//补充 document.getElementById("test").childElementCount;  可以直接获取长度 同length
```

4.通过children来获取子节点
利用children来获取子元素是最方便的，他也会返回出一个数组。对其获取子元素的访问只需按数组的访问形式即可。


```javascript
var getFirstChild = document.getElementById("test").children[0];
```

5.获取第一个子节点
firstChild来获取第一个子元素，但是在有些情况下我们打印的时候会显示undefined，这是什么情况呢？？其实firstChild和childNodes是一样的，在浏览器解析的时候会把他当换行和空格一起解析，其实你获取的是第一个子节点，只是这个子节点是一个换行或者是一个空格而已。那么不要忘记和childNodes一样处理呀。


```javascript
var getFirstChild = document.getElementById("test").firstChild;
```

6.firstElementChild获取第一个子节点
使用firstElementChild来获取第一个子元素的时候，这就没有firstChild的那种情况了。会获取到父元素第一个子元素的节点 这样就能直接显示出来文本信息了。他并不会匹配换行和空格信息。


```javascript
var getFirstChild = document.getElementById("test").firstElementChild;
```

7.获取最后一个子节点
lastChild获取最后一个子节点的方式其实和firstChild是类似的。同样的lastElementChild和firstElementChild也是一样的。不再赘余。


```javascript
var getLastChildA = document.getElementById("test").lastChild;
 var getLastChildB = document.getElementById("test").lastElementChild;
```

二、js获取父节点的方式
1.parentNode获取父节点
获取的是当前元素的直接父元素。parentNode是w3c的标准。


```javascript
var p  = document.getElementById("test").parentNode;
```

2.parentElement获取父节点
parentElement和parentNode一样，只是parentElement是ie的标准。


```javascript
var p1 = document.getElementById("test").parentElement;
```

3.offsetParent获取所有父节点
一看offset我们就知道是偏移量 其实这个是于位置有关的上下级 ，直接能够获取到所有父亲节点， 这个对应的值是body下的所有节点信息。


```javascript
var p2 = document.getElementById("test").offsetParent;
```

三、js获取兄弟节点的方式
1.通过获取父亲节点再获取子节点来获取兄弟节点

```javascript
var brother1 = document.getElementById("test").parentNode.children[1];
```

2.获取上一个兄弟节点
在获取前一个兄弟节点的时候可以使用previousSibling和previousElementSibling。他们的区别是previousSibling会匹配字符，包括换行和空格，而不是节点。previousElementSibling则直接匹配节点。


```javascript
var brother2 = document.getElementById("test").previousElementSibling;
var brother3 = document.getElementById("test").previousSibling;
```

3.获取下一个兄弟节点
同previousSibling和previousElementSibling，nextSibling和nextElementSibling也是类似的。


```javascript
var brother4 = document.getElementById("test").nextElementSibling;
var brother5 = document.getElementById("test").nextSibling;
```

- [JS获取子节点、父节点和兄弟节点的若干种方式 - CSDN博客](https://blog.csdn.net/laok_/article/details/75760572)