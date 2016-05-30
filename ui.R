shinyUI(fluidPage(
  
  # Custom CSS
  tags$head(
    tags$style(HTML("
      /* Smaller font for preformatted text */
      pre, table.table {
      font-size: smaller;
      }
      
      body {
      min-height: 2000px;
      }
      
      .option-group {
      border: 1px solid #ccc;
      border-radius: 6px;
      padding: 0px 5px;
      margin: 5px -10px;
      background-color: #f5f5f5;
      }
      
      .option-header {
      color: #79d;
      text-transform: uppercase;
      margin-bottom: 5px;
      }

      .option-header2 {
      color: #D16549;
      text-transform: uppercase;
      margin-bottom: 5px;
      }
      "))
    ),
  
  # Header title
  titlePanel(title = h4("Real Estate Investing - Deal Analysis", align = "left", col='blue')),
  
  fluidRow(
  column(width = 3,
  div(class = "option-group",
      div(class = "option-header", "*** General Information ***"),
      textInput("text", label = "Property Address", value = "123 Main Street"),
      sliderInput("slider1", label = "Purchase Price ($1000s)", min = 0, 
                  max = 500, value = 150, step=5),
      sliderInput("slider2", label = "Estimated Repairs ($1000s)", min = 0, 
                  max = 50, value = 6, step=1),
      sliderInput("slider3", label = "Repaired Value ($1000s)", min = 0, 
                  max = 500, value = 200, step=5)
  )
  ),
  
  column(width = 3,
         div(class = "option-group",
             div(class = "option-header", "*** Financing ***"),
             selectInput("select1", label = "Mortgage Term", 
                         choices = list("30-Year Fixed"=1, "20-Year Fixed"=2, "15-Year Fixed"=3), 
                         selected = 1),
             sliderInput("slider5", label = "Interest Rate (%)", min = 0, 
                         max = 10, value = 3.75, step=.05),
             sliderInput("slider6", label = "Down Payment (%)", min = 0, 
                         max = 100, value = 20, step=1),
             sliderInput("slider7", label = "Transaction Cost (%)", min = 0, 
                         max = 10, value = 4, step=1)
         )
  ),
  
    column(width = 3,
           div(class = "option-group",
               div(class = "option-header", "*** Revenue & Expenses ***"),
               numericInput("num1", "Vacancy + Nonpayment (%)", 7),
               sliderInput("slider8", label = "Annual Gross Revenue ($1000s)", min = 0, 
                           max = 50, value = 16, step=1),
               sliderInput("slider10", label = "Annual Operating Expense ($1000s)", min = 0, 
                           max = 50, value = 4, step=1),
               sliderInput("slider11", label = "Annual Capital Expense ($1000s)", min = 0, 
                           max = 20, value = 2, step=1)
           )
    )
  ),
  
# Show a table summarizing the values entered
fluidRow(
column(width=3,
  div(class = "option-group",
  div(class = "option-header2", "*** Key Metrics ***"),
  tableOutput("values")
)),

column(width=6,
       div(class = "option-group",
           div(class = "option-header2", "*** Visual Analysis ***"),
           radioButtons("radio1", label = "Threshold Return on Investment",
                        c("5%", "10%","15%","20%"), inline = TRUE),
           plotOutput("Plot")
           
       ))


)
))
