#该代码为了展示常用数据处理，方便新人学习，许多地方展示原始数据处理，因此部分代码比较冗余，对于echart与dashboard不兼容的部分也注明简单解决办法

shinyServer(function(input, output) {
  
#以下四个为第一行展示内容，由于四个均相同，阅读一个即可，注意与控件交互的方式 
 output$jinjian_1 <- renderInfoBox({
    jinjian <- sum(fqdzsj1_1[apply_time>=input$date1_1[1] & apply_time<=input$date1_1[2] & variable=='进件量',]$value)
    infoBox("进件量",paste(jinjian,"件"),icon = icon("group"), fill = T,color = 'orange')
  }) 
  output$tongguolv_1 <- renderInfoBox({
    tongguolv <- 
      if(sum(fqdzsj1_1[apply_time>=input$date1_1[1] & apply_time<=input$date1_1[2] &variable=='进件量',]$value) >0) 
      {sum(fqdzsj1_1[apply_time>=input$date1_1[1] & apply_time<=input$date1_1[2] & variable=='通过量',]$value)/sum(fqdzsj1_1[apply_time>=input$date1_1[1] & apply_time<=input$date1_1[2] & variable=='进件量',]$value)}
      else{tongguolv <- 0} 
    infoBox("通过率",paste(round(tongguolv,3)*100,"%"),icon = icon("check"), fill = T,color = 'green')
 })  
  output$quxiaolv_1 <- renderInfoBox({
    quxiaolv<-  
      if(sum(fqdzsj1_1[apply_time>=input$date1_1[1] & apply_time<=input$date1_1[2] & variable=='进件量',]$value > 0))
      {sum(fqdzsj1_1[apply_time>=input$date1_1[1] & apply_time<=input$date1_1[2] & fqdzsj1_1$variable=='取消量',]$value)/sum(fqdzsj1_1[apply_time>=input$date1_1[1] & apply_time<=input$date1_1[2] & variable=='进件量',]$value)}
      else{quxiaolv <- 0} 
    infoBox("取消率",paste(round(quxiaolv,3)*100,"%"),icon = icon("share"), fill = T,color = 'blue')
 })
  output$fangkuanjine_1 <- renderInfoBox({
    shenqingjine <- sum(fqdzsj1_1[apply_time>=input$date1_1[1] & apply_time<=input$date1_1[2] & variable=='合同金额',]$value)
    infoBox("合同金额",paste(round(shenqingjine/10000,1),"万"),icon = icon("strikethrough"), fill = T,color = 'maroon')
  })
  
 
 
 #以下为交互式图表，reactive中为交互的数据，renderEChart中为可交互图表
 #条形图，横置
  chartdate_1_1 <- reactive({
    aa <- melt(fqdzsj1,id=1:5,measure=c("通过量","取消量","拒绝量"),value.factor=TRUE)
    aa <- aa[apply_time>=input$date1_1[1] & apply_time<=input$date1_1[2]]
  })
  
  output$chart1_1 = renderEChart({
  chart1 = eBar(chartdate_1_1(),xvar = ~large_area,yvar = ~value,series =~variable,horiz = T,theme = "shine",stack=T)
  })
  
  
  #折线图，由于recharts中展示默认的为条形图，改为默认展示为折线图，将修改chart中series下type参数，改成line，此处有4个变量，需要修改四次type，因此用了for循环
  chartdate_1_2 <- reactive({
    aa <- melt(fqdzsj1,id=1:6,measure=c("进件量","通过量","取消量","拒绝量"),value.factor=TRUE)
    aa <- aa[apply_time>=input$date1_1[1] & apply_time<=input$date1_1[2]][order(apply_time)]
  })
  
  output$chart1_2 = renderEChart({
    chart2 = eBar(chartdate_1_2(),xvar = ~apply_time,yvar = ~value,series =~variable,theme = "shine")
    for(i in 1:length(chart2$x$series))
      {chart2$x$series[[i]]$type <- 'line'}
    chart2
  })
  
  
  #以下四个均为饼图，阅读一个即可由于recharts与dashboard冲突，部分图形在dashboard中不显示，此处需修改chart下参数dependencies，赋值为NULL即可
  chartdate_1_3 <- reactive({
    bb <- fqdzsj1_2[apply_time>=input$date1_1[1] & apply_time<=input$date1_1[2]]
    bb <- bb[,.(进件量=sum(进件量)),by='prod_typ_detail']
    bb <- as.data.frame(bb)
  })

  output$chart1_3 = renderEChart({
    chart3 = ePie(chartdate_1_3(),~prod_typ_detail,~进件量,theme = "shine",title="进件量",reset_center = c("200",150),reset_radius = c(60,100),showL = F)+eLegend(y = "bottom")
    chart3$dependencies <- NULL
    chart3
  })


  chartdate_1_4 <- reactive({
    cc <- fqdzsj1_2[apply_time>=input$date1_1[1] & apply_time<=input$date1_1[2]]
    cc <- cc[,.(通过量=sum(通过量)),by='prod_typ_detail']
    cc <- as.data.frame(cc)
  })
  
  output$chart1_4 = renderEChart({
    chart4 = ePie(chartdate_1_4(),~prod_typ_detail,~通过量,theme = "shine",title="通过量",reset_center = c("200",150),reset_radius = c(60,100),showL = F)+eLegend(y = "bottom")
    chart4$dependencies <- NULL
    chart4
  })
  
  
  chartdate_1_5 <- reactive({
    cc <- fqdzsj1_2[apply_time>=input$date1_1[1] & apply_time<=input$date1_1[2]]
    cc <- cc[,.(取消量=sum(取消量)),by='prod_typ_detail']
    cc <- as.data.frame(cc)
  })
  
  output$chart1_5 = renderEChart({
    chart5 = ePie(chartdate_1_5(),~prod_typ_detail,~取消量,theme = "shine",title="取消量",reset_center = c("200",150),reset_radius = c(60,100),showL = F)+eLegend(y = "bottom")
    chart5$dependencies <- NULL
    chart5
  })
  
  
  chartdate_1_6 <- reactive({
    dd <- fqdzsj1_2[apply_time>=input$date1_1[1] & apply_time<=input$date1_1[2]]
    dd <- dd[,.(合同金额=round(sum(合同金额)/10000,0)),by='prod_typ_detail']
    dd <- as.data.frame(dd)
  })
  
  output$chart1_6 = renderEChart({
    chart6 = ePie(chartdate_1_6(),~prod_typ_detail,~合同金额,theme = "shine",title="合同金额",reset_center = c("200",150),reset_radius = c(60,100),showL = F)+eLegend(y = "bottom")
    chart6$dependencies <- NULL
    chart6
  }
  
})                                                       
    

 
  
  




