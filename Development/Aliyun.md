### 阿里云CentOS安装了Nginx但是外网访问不到问题处理方法

安装nginx

```
首先更新系统软件
# yum update
安装nginx
1.安装nginx源
 
# yum localinstall http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm
2.安装nginx
 
# yum install nginx
3.启动nginx
 
# service nginx start
Redirecting to /bin/systemctl start  nginx.service
 
4.访问http://你的ip/
```


```
第一步。在服务器上面看一下nginx的状态
/bin/systemctl status  nginx.service
结果状态正常。
 
第二步。curl在服务器上面 尝试你的访问
curl 127.0.0.1  #正常
curl localhost  #正常
curl 本机外网IP  #不正常（防火墙等等都关闭）  
 
第三步。查阅文档，去阿里云后台查看，原来是新购的服务器都加入和实例安全组。
（OMG）立即去配置。加入你的80端口，立即就能开启了。
```

- [安全组应用案例_安全组_安全_云服务器 ECS-阿里云](https://help.aliyun.com/document_detail/25475.html?spm=5176.2020520101.121.1.1eab540fge5K2W)