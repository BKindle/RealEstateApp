
library(shiny)
library(ggplot2)

# Define server logic for slider examples
shinyServer(function(input, output) {
  
  # Reactive expression to compose a data frame containing all of
  # the values
  sliderValues <- reactive({
    
    if (input$select1==1) {Mortgage.Term <- 30}
    else if (input$select1==2) {Mortgage.Term <- 20}
    else if (input$select1==3) {Mortgage.Term <- 15} 
    Cash.Input <- input$slider2+((input$slider6/100)*input$slider1)+((input$slider7/100)*input$slider1)
    Loan.Value <- input$slider1-((input$slider6/100)*input$slider1)
    NOI <- round(input$slider8-((input$num1/100)*input$slider8)-input$slider10,2)
    CFO <- round(NOI-input$slider11,2)
    Mortgage.Expense <- round(12*(Loan.Value*((((input$slider5/100)/12)*((1+(input$slider5/100)/12)
                        ^(Mortgage.Term*12)))/(((1+(input$slider5/100)/12)^(Mortgage.Term*12))-1))),2)
    CFAF <- round(CFO - Mortgage.Expense,2)
    Cap.Rate <- round((NOI/input$slider3)*100,2)
    ROA <- round((CFO/input$slider3)*100,2)
    Cash.On.Cash.Return <- round((CFAF/Cash.Input)*100,2)
    fifty.pct.rule <- (input$slider8*0.5) - Mortgage.Expense
    two.pct.rule <- round((((input$slider8-((input$num1/100)*input$slider8))/12)/(Loan.Value+Cash.Input))*100,2)
    seventy.pct.rule <- (0.7*input$slider3)-input$slider2
    
    # Compose data frame
    data.frame(
      Key_Metric_Name = c(
               "Cash Input ($1000s)",
               "Loan Value ($1000s)",
               "Net Operating Income ($1000s)",
               "Cash Flow From Operations ($1000s)",
               "Mortgage Expense ($1000s)",
               "Cash Flow After Financing ($1000s)",
               "Capitalization Rate (%)",
               "Return on Assets (%)",
               "Cash on Cash Return (%)",
               "Fifty Percent Rule ($1000s)",
               "Two Percent Rule (%)",
               "Seventy Percent Rule (1000s)"
               ),
      Value = as.character(c(
        Cash.Input,
        Loan.Value,
        NOI,
        CFO,
        Mortgage.Expense,
        CFAF,
        Cap.Rate,
        ROA,
        Cash.On.Cash.Return,
        fifty.pct.rule,
        two.pct.rule,
        seventy.pct.rule
        )), 
      stringsAsFactors=FALSE)
    
  }) 
  
  # Show the values using an HTML table
  output$values <- renderTable({
    sliderValues()
  })
  
  # Fill in the spot we created for a plot
  output$Plot <- renderPlot({
    
    if (input$select1==1) {Mortgage.Term <- 30}
    else if (input$select1==2) {Mortgage.Term <- 20}
    else if (input$select1==3) {Mortgage.Term <- 15} 
    Cash.Input <- input$slider2+((input$slider6/100)*input$slider1)+((input$slider7/100)*input$slider1)
    Loan.Value <- input$slider1-((input$slider6/100)*input$slider1)
    NOI <- round(input$slider8-((input$num1/100)*input$slider8)-input$slider10,2)
    CFO <- round(NOI-input$slider11,2)
    Mortgage.Expense <- round(12*(Loan.Value*((((input$slider5/100)/12)*((1+(input$slider5/100)/12)
                                                                         ^(Mortgage.Term*12)))/(((1+(input$slider5/100)/12)^(Mortgage.Term*12))-1))),2)
    CFAF <- round(CFO - Mortgage.Expense,2)
    a.Cap.Rate <- round((NOI/input$slider3)*100,2)
    b.ROA <- round((CFO/input$slider3)*100,2)
    c.Cash.On.Cash.Return <- round((CFAF/Cash.Input)*100,2)
    
    if (input$radio1=='5%') {ref.line <- 5}
    else if (input$radio1=='10%') {ref.line <- 10}
    else if (input$radio1=='15%') {ref.line <- 15}
    else if (input$radio1=='20%') {ref.line <- 20}
    
    cap.col <- ifelse(a.Cap.Rate > ref.line, '#95C486', '#D16549')
    roa.col <- ifelse(b.ROA > ref.line, '#95C486', '#D16549')
    coc.col <- ifelse(c.Cash.On.Cash.Return > ref.line, '#95C486', '#D16549')
    
    plotframe <- data.frame(metric=c("a. Capitalization Rate","b. Return on Assets","c. Cash on Cash Return"),
                            value=c(a.Cap.Rate,b.ROA,c.Cash.On.Cash.Return),
                            colorz=c(cap.col,roa.col,coc.col))
    
    # Render a barplot
    ggplot(plotframe,aes(x=metric,y=value))+geom_bar(stat="identity",fill=plotframe$colorz)+geom_text(aes(label=paste(value,'%')),vjust=-0.25)+geom_hline(yintercept=ref.line,color='blue')+xlab("")+ylab("Return on Investment (%)")
  })  
  
})