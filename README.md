基于dashboard及recharts建立的Web，旨在帮助初学者快速入门，因此部分地方显得冗余

本代码由于直接连接数据库，以及数据保密需要，复制代码并不能得到交互式页面，仅提供基础模块供初学者参考，对于dashboard中有汉字的转化为UTF-8
即可解决乱码问题

学习完此代码即可初步掌握用dashboard设计处简易的交互Web

由于echart图有动态效果且已有成熟各式图标模板，比ggplot的静态图更容易实现，但recharts包和dashboard包冲突的问题很多新人在网上难以找到答案，
导致新人放弃，此代码给出常见问题解决方法

主要是关于dashboard和recharts共用时无法显示部分图形，比如地图，饼图等等，类似许多冲突问题均可按照以下步骤尝试解决：
1.str(chart)    #展示做出图表的全部信息
2.对比无冲突的表格全部信息
3.对chart相应参数进行修改

如：在dashboard中地图无法显示，先画出地图chart1,
str(chart1)   得到该图详细信息
与条形图（可显示的其他图）进行比较发现dependencies参数不一样，修改即可

以下为该代码效果图(部分信息已做处理)：
![Image text](https://github.com/1520736056/R-shiny/blob/master/Figure.jpg)




