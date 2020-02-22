[TOC]

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


#### js判断私有的内网IP


```js
//by https://blog.csdn.net/u013299635/article/details/78357041
function isInnerIpAddress(ipAddress) {
    var isInnerIp = false;//默认给定IP不是内网IP
    var ipNum = getIpNum(ipAddress);
    /**
     * 私有IP：A类  10.0.0.0    -10.255.255.255
     *       B类  172.16.0.0  -172.31.255.255
     *       C类  192.168.0.0 -192.168.255.255
     *       D类   127.0.0.0   -127.255.255.255(环回地址)
     **/
    var aBegin = getIpNum("10.0.0.0");
    var aEnd = getIpNum("10.255.255.255");
    var bBegin = getIpNum("172.16.0.0");
    var bEnd = getIpNum("172.31.255.255");
    var cBegin = getIpNum("192.168.0.0");
    var cEnd = getIpNum("192.168.255.255");
    var dBegin = getIpNum("127.0.0.0");
    var dEnd = getIpNum("127.255.255.255");
    isInnerIp = isInner(ipNum, aBegin, aEnd) || isInner(ipNum, bBegin, bEnd) || isInner(ipNum, cBegin, cEnd) || isInner(ipNum, dBegin, dEnd);

    return isInnerIp;
}

function getIpNum(ipAddress) {/*获取IP数*/
    var ip = ipAddress.split(".");
    if (ip.length !== 4) {
        return 0; //不是ip地扯格式
    }
    var a = parseInt(ip[0]);
    var b = parseInt(ip[1]);
    var c = parseInt(ip[2]);
    var d = parseInt(ip[3]);
    var ipNum = a * 256 * 256 * 256 + b * 256 * 256 + c * 256 + d;
    return ipNum;
}

function isInner(userIp, begin, end){
    return (userIp>=begin) && (userIp<=end);
}
```

- [js-先判断是否是内网IP - 人是活的，规矩是死的 - CSDN博客](https://blog.csdn.net/u013299635/article/details/78357041)


####  JavaScript中Date对象的内置方法格式化时间


```js
var d = new Date();
console.log(d); // 输出：Mon Nov 04 2013 21:50:33 GMT+0800 (中国标准时间)
console.log(d.toDateString()); // 日期字符串，输出：Mon Nov 04 2013
console.log(d.toGMTString()); // 格林威治时间，输出：Mon, 04 Nov 2013 14:03:05 GMT
console.log(d.toISOString()); // 国际标准组织（ISO）格式，输出：2013-11-04T14:03:05.420Z
console.log(d.toJSON()); // 输出：2013-11-04T14:03:05.420Z
console.log(d.toLocaleDateString()); // 转换为本地日期格式，视环境而定，输出：2013年11月4日
console.log(d.toLocaleString()); // 转换为本地日期和时间格式，视环境而定，输出：2013年11月4日 下午10:03:05
console.log(d.toLocaleTimeString()); // 转换为本地时间格式，视环境而定，输出：下午10:03:05
console.log(d.toString()); // 转换为字符串，输出：Mon Nov 04 2013 22:03:05 GMT+0800 (中国标准时间)
console.log(d.toTimeString()); // 转换为时间字符串，输出：22:03:05 GMT+0800 (中国标准时间)
console.log(d.toUTCString()); // 转换为世界时间，输出：Mon, 04 Nov 2013 14:03:05 GMT
```

- [js date对象的格式化代码-前端开发博客](http://caibaojian.com/javascript-date-format.html)

#### js快速获取li所有列表内容

```js
var ulElement = document.getElementsByClassName("c-issue__articles")[0];
var liElemnts = ulElement.getElementsByClassName('c-issue__article');
var abc = [];
for(let liElement of liElemnts) {
 	let aElements = liElement.getElementsByTagName("a");
 	let href = aElements[0].getAttribute("href");
 	let url = 'https://www.objc.io/' + href.slice(0, href.length - 1);
	abc.push(url);
}

var s = abc.join("\n");
console.log(s);
```

#### jquery 查找全部某种id元素

包含字符：
```js
    $("*[id*='DiscountType']").each(function (i, el) {
         //It'll be an array of elements
     });
```

以字符开关：
```js
    $("*[id^='DiscountType']").each(function (i, el) {
         //It'll be an array of elements
     });
```


以字符结尾：
```js
    $("*[id$='DiscountType']").each(function (i, el) {
         //It'll be an array of elements
     });
```

如果要选择id不是给定字符串的元素：
```js
    $("*[id!='DiscountType']").each(function (i, el) {
         //It'll be an array of elements
     });
```

如果要选择id包含给定单词的元素，则用空格分隔：
```js
    $("*[id~='DiscountType']").each(function (i, el) {
         //It'll be an array of elements
     });
```

如果要选择id等于给定字符串或以该字符串后跟连字符开头的元素：
```js
    $("*[id|='DiscountType']").each(function (i, el) {
         //It'll be an array of elements
     });
```

- [search - Find all elements on a page whose element ID contains a certain text using jQuery - Stack Overflow](https://stackoverflow.com/questions/1206739/find-all-elements-on-a-page-whose-element-id-contains-a-certain-text-using-jquer)

#### js生成二维码

- [davidshimjs/qrcodejs: Cross-browser QRCode generator for javascript](https://github.com/davidshimjs/qrcodejs)
- [jeromeetienne/jquery-qrcode: qrcode generation standalone (doesn't depend on external services)](https://github.com/jeromeetienne/jquery-qrcode)


#### 获取当前页面url及url参数的方法

window.location 属性

以`https://www.ihtcboy.com:1024/n/2/?order=pub_date#comment`示例:

| 属性  | 作用  | 示例结果  |
| ------------ | ------------ | ------------ |
| hash | 设置或获取 href 属性中在井号“#”后面的分段。 | #comment|
| host | 设置或获取 location 或 URL 的 hostname 和 port 号码。（如果是默认80端口的链接，:1024是没有的） |  www.ihtcboy.com:1024|
| hostname | 设置或获取 location 或 URL 的主机名称部分。 | www.ihtcboy.com  |
| href | 设置或获取整个 URL 为字符串。 | https://www.ihtcboy.com:1024/n/2/?order=pub_date |
| origin | 协议+域名。ie中获取为undefined | https://www.ihtcboy.com:1024 |
| pathname | 设置或获取对象指定的文件名或路径。 | /n/2/ |
| port | 设置或获取与 URL 关联的端口号码。 | 1024 |
| protocol | 设置或获取 URL 的协议部分。 | https: |
| search | 设置或获取 href 属性中跟在问号后面的部分。 | ?order=pub_date |

`window.location.origin` polyfill:

```js
if (!window.location.origin) {
  window.location.origin = window.location.protocol + "//" 
    + window.location.hostname 
    + (window.location.port ? ':' + window.location.port : '');
}
```

#### CSS 属性 z-index

https://pic2.zhimg.com/80/v2-1ec9491a660c0e11b7272633976da869_hd.jpg
http://img.suoniao.com/FkVlSRujvfQyXe0X65sa_qbaDZds

- [深入理解 CSS 属性 z-index - 知乎](https://zhuanlan.zhihu.com/p/33984503)

#### JS正则表达式



- [JS正则表达式完整教程（略长） - 掘金](https://juejin.im/post/5965943ff265da6c30653879)
- [JavaScript正则，看这篇就够了 - 掘金](https://juejin.im/post/5acb4d3f6fb9a028c813295e)
- [你真的懂JavaScript的正则吗？ - 掘金](https://juejin.im/post/59096d2161ff4b0066ef2017)


#### 向页面注入JS文件

```js
(function() {
  var hm = document.createElement("script");
  hm.src = "http://libs.baidu.com/jquery/2.0.0/jquery.min.js";
  var s = document.getElementsByTagName("title")[0]; 
  s.parentNode.insertBefore(hm, s);
})();
```


#### js浏览器返回上一个页面（刷新）

```js
window.history.go(-1);  //返回上一页
window.history.back();  //返回上一页，强行刷新

window.location.reload(); //刷新当前页
window.location.go(-1); //刷新上一页

```


返回上一页并刷新:
```js
$(function(){
  $("#back").click(function(
  window.location.href = document.referrer;//返回上一页并刷新  
 ))
});
```

#### js时间戳转成北京时间格式

```
function time(time = +new Date()) {
    var date = new Date(time + 8 * 3600 * 1000); // 增加8小时
    return date.toJSON().substr(0, 19).replace('T', ' ');
}
time(); // "2018-08-09 18:25:54"
```

Date的‘toJSON’方法返回格林威治时间的JSON格式字符串，实际是使用‘toISOString’方法的结果。字符串形如‘2018-08-09T10:20:54.396Z’，转化为北京时间需要额外增加八个时区，我们需要取字符串前19位，然后把‘T’替换为空格，即是我们需要的时间格式。把时间格式中的‘-’修改为‘.’或者其他符号都是可以：

```
function time(time = +new Date()) {
    var date = new Date(time + 8 * 3600 * 1000);
    return date.toJSON().substr(0, 19).replace('T', ' ').replace(/-/g, '.');
}
time(); // "2018.08.09 18:25:54"
```

- [一行js代码实现时间戳转时间格式 - 前端笔记 - SegmentFault 思否](https://segmentfault.com/a/1190000015992232)

#### js UTC时间转为北京时间

```
var utc_datetime = "2019-03-31T08:02:06Z";

function utc2beijing(utc_datetime) {
    // 转为正常的时间格式 年-月-日 时:分:秒
    var T_pos = utc_datetime.indexOf('T');
    var Z_pos = utc_datetime.indexOf('Z');
    var year_month_day = utc_datetime.substr(0,T_pos);
    var hour_minute_second = utc_datetime.substr(T_pos+1,Z_pos-T_pos-1);
    var new_datetime = year_month_day+" "+hour_minute_second; // 2017-03-31 08:02:06

    // 处理成为时间戳
    timestamp = new Date(Date.parse(new_datetime));
    timestamp = timestamp.getTime();
    timestamp = timestamp/1000;

    // 增加8个小时，北京时间比utc时间多八个时区
    var timestamp = timestamp+8*60*60;

    // 时间戳转为时间
    var beijing_datetime = new Date(parseInt(timestamp) * 1000).toLocaleString().replace(/年|月/g, "-").replace(/日/g, " ");
    return beijing_datetime; // 2019-03-31 16:02:06
} 

console.log(utc2beijing(utc_datetime));
```

- [js实现UTC时间转为北京时间，时间戳转为时间 - TBHacker - 博客园](https://www.cnblogs.com/jiqing9006/p/6652505.html)

#### JS 中按地址（引用）传递和按值传递问题

- [JS 中没有按地址（引用）传递，只有按值传递 - youxin - 博客园](https://www.cnblogs.com/youxin/p/3354903.html)

#### JS 中 Json 

- [有意思的JSON.parse（）、JSON.stringify（） - 掘金](https://juejin.im/post/5be5b9f8518825512f58ba0e)