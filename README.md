基于dashboard及recharts建立的Web

dashboard中有汉字的转化为UTF-8即可解决乱码问题


主要是关于dashboard和recharts共用时无法显示部分图形，比如地图，饼图等等，类似许多冲突问题均可按照以下步骤尝试解决：
1.str(chart)    #展示做出图表的全部信息
2.对比无冲突的表格全部信息
3.对chart相应参数进行修改

如：在dashboard中地图无法显示，先画出地图chart1,
str(chart1)   得到该图详细信息
与条形图（可显示的其他图）进行比较发现dependencies参数不一样，修改即可

![Image text](https://github.com/1520736056/R-shiny/blob/master/Figure.jpg)




