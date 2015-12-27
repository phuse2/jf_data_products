library(ggplot2)

shinyServer(
      function(input, output) {
            v <- reactiveValues(doPlot = FALSE)
            
            observeEvent(input$go, {
                  v$doPlot <- input$go
            })
            
            observeEvent(input$maxLoss, {
                  v$doPlot <- FALSE
            })
            
            observeEvent(input$maxGain, {
                  v$doPlot <- FALSE
            })
            
            output$results <- renderPlot({
                  if (v$doPlot == FALSE) return()
                  
                  nTrials <- 25
                  nThrows <- 100
                  
                  mL <- input$maxLoss
                  mG <- input$maxGain
                  
                  resultsMat <- matrix(100, nrow = nThrows, ncol = nTrials)
                  for (j in 1:nTrials){
                        for (i in 2:nThrows) {
                              if ((resultsMat[i-1,j] == (100 - mL)) ||
                                  (resultsMat[i-1,j] == (100 + mG))) {
                                    resultsMat[i,j] <- resultsMat[i-1,j]
                              } else {
                                    if (sample(1:37,1) < 19) {
                                          resultsMat[i,j] <- resultsMat[i-1,j] + 1
                                    } else {
                                          resultsMat[i,j] <- resultsMat[i-1,j] - 1
                                    }
                              }
                        }
                  }
                  
                  avg <- rowMeans(resultsMat)
                  
                  outcome <- avg[nThrows]
                  
                  if (outcome >= 100) {
                        lineColor <- "green"
                        title <- sprintf("Average gain of %.2f dollars", 
                                         abs(100 -outcome))
                  } else{
                        lineColor <- "red"
                        title <- sprintf("Average loss of %.2f dollars", 
                                         abs(100 -outcome))
                  }
                  
                  plot(1:nThrows,resultsMat[,1],'l', ylim = range(resultsMat),
                       main = title,
                       xlab = "# of Throws",
                       ylab = "Results by Trial")
                  
                  for (i in 2:nTrials) {
                       lines(1:nThrows,resultsMat[,i])
                  }

                  lines(1:nThrows,avg,col = lineColor, lwd = 5)
                  
            })
            
      }
)