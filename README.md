# BaseProject

* ## 搭建基础框架
* ## 封装常用工具
* ## 架构设计、组件化学习
* ## 知识点学习掌握
* ## 开发小技巧
* ## 供测试代码
* ## 效率通用性：可依据此项目，快速搭建新项目

### 项目结构：共10个文件夹
1. Appdelegate
    1. Appdelegate:瘦身，优化启动
    2. RootController
2. BaseClass
    1. ViewModel基类
    2. 网络基类
    3. Model基类
    4. Scroll（主要是TableView及CollectionView）的基类
    5. ViewController的基类
3. General：目前暂时没用到
4. Helpers：目前暂时没用到
5. Macro
    1. Constant：字符串常量，能用Constant的不用Macro
    2. Macro：宏定义的常用方法
        1. 单例宏
        2. 颜色宏
        3. 其他工具宏：BPAppToolMacro
        4. ...
6. Main：TabBar上的控制器，目前分三个控制器
    1. 场景控制器
    2. 知识点控制器
    3. 小技巧&测试控制器
7. Resources
    1. 图片资源
    2. Plist文件：**重要的目录文件**
    3. 国际化文件
8. Scenes：场景目录
    1. 封装的场景功能
        1. 图片浏览器
        2. 播放器
        3. 弹幕
        4. 日历
        5. ...
    2. 知识点：
        1. 三大事件
        2. 基本UIKit控件使用
        3. 基本数据使用
        4. 设计模式
        5. 重要知识点：
            1. 多线程
            2. 绘图
            3. ...
        6. 其他知识点：
            1. Block
            2. Runtime
            3. ...
    3. 小技巧
        1. 小技巧
        2. 测试用
        3. ...
9. Utility：目的是随时可以拿出整个目录，给其他项目用
    1. 继承类：当需要时继承；不是基类
    2. 工具类
    3. 分类
10. Vendors：无法通过CocoaPods安装的第三方工具
