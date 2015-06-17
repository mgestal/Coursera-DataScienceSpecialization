library(UsingR)
library(ggplot2)



shinyServer(
  
  function(input, output) {
    
    output$txtFormula <- reactive({
      paste("mpg ~", input$feature)
    })
        
    txtFormula <- reactive({
      paste("mpg ~", input$feature)
    })
    
  
    
    ## Boxplot
    
    output$boxPlot <- renderPlot({
      
      if (input$feature!='.') { 
        with(mtcars, {
          boxplot(as.formula(txtFormula()), col = "salmon", 
                  xlab = input$feature, ylab = "MPG (Miles Per Gallon)",
                  main = "Boxplot: Miles Per Gallon")
        }) 
      }
      
    })
    
    
    ### Plot for model fit
    
    output$modelFitPlot <- renderPlot({
      
      if (input$feature!='.') { 
        
      with(mtcars, {
        plot(as.formula(txtFormula()), 
             xlab = input$feature, ylab = "MPG (Miles Per Gallon)",
             main = paste("Linear model for ",txtFormula() ))
        abline(modelFit(), col=2)
      }) 
      
      }
    })
            
    
    ### Model fit summary
    
    modelFit <- reactive({
      lm(as.formula(txtFormula()), data=mtcars)  })
    
    output$modelFit <- renderPrint({
      summary(modelFit()) })
    
    
    ### Plot histogram of selected variable
    
    output$histPlot <- renderPlot({
      
      if (input$feature!='.') { 
        
        x <- mtcars[, input$feature]  
                
        bins <- seq(min(x), max(x), length.out = input$bins + 1)
        
        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'coral', border = 'black',
             main = paste("histogram for feature '", input$feature, "'"))
                
      }
      
    })    
    
  }
)


