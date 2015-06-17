
# remove mpg feature for mtcars list of variables (avoid self regression)
n <- names(mtcars)
n <- n[n!='mpg']

shinyUI(pageWithSidebar(
  
  headerPanel("Influence of individual features over mtcars data"),

  sidebarPanel(

    h4("Influence of features on mgp value"),
    
  
    selectInput(inputId = "feature",
                label= "Pick Your Feature",
                choices=c('.', n), selected = NULL),
    
    sliderInput("bins",
                "Number of bins for histogram:",
                min = 1,
                max = 50,
                value = 30)

  ),
  
  mainPanel(
    
    h3('Facets formula: '),
    verbatimTextOutput("txtFormula"),
    
    
    h3('Summary of Model Fit: '),
    verbatimTextOutput("modelFit"),
    
    plotOutput('modelFitPlot'),
    
    plotOutput('boxPlot'),
             
    plotOutput('histPlot')  
    
    
    )
))
