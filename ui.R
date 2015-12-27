shinyUI(fluidPage(
      
      #Application Title
      titlePanel("Can you beat the casino?"),
      h4("As an avid gambler, you wonder: is there a way to turn the odds against the casino? You know that the game Craps has the best odds in the casino: there are 37 numbers on a wheel, 18 or which are black, 18 of which are red, and 1 of which is green. A ball is rolled on the wheel, and if you correctly predict the color it lands on you win or lose the amount of money you bet. For instance, you can bet on a black or red outcome and the payout is $1 or -$1 for each $1 bet. This means you have an 18/37 chance of winning in each game. Although you expect to lose a little bit of money on average, you wonder...what if I devise a strategy as such:"), 
      h4("If you allow yourself to lose only a certain amount of money before stepping away from the table, and also allow yourself to only win a certain amount of money before stepping away from the table, perhaps this can swing the odds in your favor. To test this you run a simulation: you play 100 games betting $1 each, so for each game a success increases your wealth by $1 and a loss decreases it by $1. If you hit your Max Gain or Max Loss you stop playing. Being aware that a single simulation may not create an accurate portrayal of reality you run 25 simulations to be safe. In the box below, try different Max Loss and Max Gain parameters to see if you can devise a winning strategy!"),
      sidebarLayout(
            sidebarPanel(
                  
                  numericInput("maxLoss", "Max Loss", 25, min = 1, max = 100),
                  numericInput("maxGain", "Max Gain", 25, min = 1, max = 1e9),
                  actionButton("go","Simulate"),
                  h5("The chart at right will show each of the 25 simulations as a thin black line and the average result as thick green or red line, depending if you would've won or lost money on average")
            ),
            
            mainPanel(
                  plotOutput('results')
            )
      )
))