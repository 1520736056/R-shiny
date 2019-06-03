为了方便新人学习，此处代码各个部分分开放置，大多有注释说明，出于数据保密需要，此处复制代码在R中并不能得到交互式页面，本文仅介绍总览版面的各个模块
以下包均为常用数据处理包，并非一定要使用，此处交互式Web必须用到的包后均加#
library(shiny)                  #
library(shinydashboard)         #
library(ggplot2)
library(data.table)
library(RMySQL)             
library(sqldf)
library(recharts)               #
library(ECharts2Shiny)
library(shinydashboard)         #
library(plyr)



shinyUI(
  
  if (interactive()) {                           
    
    #标题与边栏 
    header <- dashboardHeader(title = "大数据监控平台",titleWidth = 230)     #此处为标题名称
    sidebar <- dashboardSidebar( 
      sidebarUserPanel(img(src="yimeilogo.png",height=50)),                 #此处为图标，图标放在该项目WWW命名的文件夹内，文件夹名称不要更改
      sidebarSearchForm(label = "Search", "searchText", "searchButton"),    #加入搜索框      
     
     
     
  #以下是侧边栏布局，第一个数据总览没有下拉副菜单，第二个贷中总览有下拉副菜单，badgeLabel表示添加一个小标签“new”，颜色设置为绿色  
   副标题icon表示在各副标题处添加了小图标  
     sidebarMenu(                                                          
        id = "tabs",
        menuItem("数据总览", tabName = "dashboard0",badgeLabel = "new",badgeColor = "green"),    
        menuItem("贷中表现", tabName = "dashboard1",
                 menuSubItem("业务数据", tabName = "subitem1_1",icon = icon("user")),
                 menuSubItem("拒绝数据", tabName = "subitem1_2",icon = icon("remove")),
                 menuSubItem("业务分布", tabName = "subitem1_3",icon = icon("globe")),
                 menuSubItem("业务占比", tabName = "subitem1_4",icon = icon("dashboard")),
                 menuSubItem("特性分布", tabName = "subitem1_5",icon = icon("group")),
                 menuSubItem("业务走势", tabName = "subitem1_6",icon = icon("signal")),
                 menuSubItem("时效分布", tabName = "subitem1_7"))
                )
    )
    

    #以下为常用控件，第一个为日期范围，后面的为复选框，inline表示复选框横置还是竖置
    
    control_1_1 <- dateRangeInput("date1_1","日期范围:",start = max(as.Date(fqdzsj1_1$apply_time))-180,end = max(as.Date(fqdzsj1_1$apply_time)),min = min(as.Date(fqdzsj1_1$apply_time)),max = max(as.Date(fqdzsj1_1$apply_time)),
     format = "yy-mm-dd",separator = "至")
    control_1_2 <- checkboxGroupInput("check_1_1", "产品:",unique(fqdzsj$prod_typ_detail),selected = unique(fqdzsj$prod_typ_detail),inline = F)
    control_1_3 <- checkboxGroupInput("check_1_2", "大区:",unique(fqdzsj$large_area),selected = unique(fqdzsj$large_area),inline = F)

    
    #以下为面板设计，此处仅保留数据总览面板代码，多用echart图形
    body = dashboardBody(
      tabItems(
        tabItem(tabName = "dashboard0",
               fluidRow(
                 column(10,infoBoxOutput("jinjian_1",width=3),
                           infoBoxOutput("tongguolv_1",width=3),
                           infoBoxOutput("quxiaolv_1",width=3),
                           infoBoxOutput("fangkuanjine_1",width=3)),
                 column(1,fixedPanel(box(control_1_1,solidHeader = TRUE,background = "purple",width = 10),draggable = TRUE))
                  ),
                
                fluidRow(
                  column(6,offset = 0,eChartOutput("chart1_1")),
                  column(6,offset = 0,eChartOutput("chart1_2"))
                ),
                  
               fluidRow(
                  column(3,offset = 0,eChartOutput("chart1_3",width = "100%",height="350px")),
                  column(3,offset = 0,eChartOutput("chart1_4",width = "100%",height="350px")),
                  column(3,offset = 0,eChartOutput("chart1_5",width = "100%",height="350px")),
                  column(3,offset = 0,eChartOutput("chart1_6",width = "100%",height="350px"))
               )
              )
        

   dashboardPage(header, sidebar, body,skin = 'blue')
  }
)
