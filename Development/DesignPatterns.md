### Design Patterns（设计模式）

### System（系统理论）

#### CAP 理论

> 2000年7月，来自加州大学伯克利分校的 Eric Brewer 教授注 在 ACM PODC（Principles of Distributed Computing）会议上，首次提出了著名的CAP猜想注 。2年后，来自麻省理工学院的 Seth Gilbert 和 Nancy Lynch 从理论上证明了 Brewer教授 CAP 猜想的可行性注 ，从此，CAP 理论正式在学术上成为了分布式计算领域的公认定理，并深深地影响了分布式计算的发展。

CAP理论告诉我们，一个分布式系统不可能同时满足：

1. 一致性（C：Consistency）
2. 可用性（A：Availability）
3. 分区容错性（P：Partition tolerance）

这三个基本需求，最多只能同时满足其中的两项。

分布式系统（distributed system）正变得越来越重要，大型网站几乎都是分布式的。分布式系统的最大难点，就是各个节点的状态如何保持一致。CAP理论是在设计分布式系统的过程中，处理数据一致性问题时必须考虑的理论。


- [CAP theorem - Wikipedia](https://en.wikipedia.org/wiki/CAP_theorem)
- [分布式CAP定理，为什么不能同时满足三个特性？- CSDN博客](https://blog.csdn.net/yeyazhishang/article/details/80758354)
- [通俗易懂的理解CAP和BASE理论知识-CSDN博客](https://blog.csdn.net/qq_19348391/article/details/83109030)
- [CAP 定理的含义 - 阮一峰的网络日志](https://www.ruanyifeng.com/blog/2018/07/cap.html)
- [CAP理论 | 一叶知秋](https://lushunjian.github.io/blog/2018/06/20/CAP%E7%90%86%E8%AE%BA/)


### Programming（编程）

计算机语言：描述了数据加工的流程

#### 数据的容器
* 数据类型
* 变量和常量
* 多个(种)的数据：数组、Map、对象

#### 数据的加工

* 赋值（将数据放入容器）
* 数学运算（加减乘除、取余）
* 逻辑运算（&&、||、!）
* 位运算（二进制处理的根本）

#### 加工流程的控制

* 顺序执行：语句分隔符
* 分支执行：条件、循环语句

#### 流程的重用

*  通过函数（方法）重用
*  通过类和对象重用
*  通过包（库）和扩展模块重用