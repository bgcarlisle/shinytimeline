library(shiny)
library(plotly)
library(tidyverse)

## Read in data from disk
tldata <- read_csv("timelinedata.csv")

ui <- fillPage(
    titlePanel("Fedi Timeline"),
    fillRow(
        plotlyOutput(outputId = "feditimeline")
    )
)

server <- function(input, output) {

    output$feditimeline <- renderPlotly({
        feditimeline <- plot_ly()

        for(i in 1:nrow(tldata)) {
            
            feditimeline <- add_trace(
                feditimeline,
                x = c(tldata$start[i], tldata$end[i]),
                y = c(-1*i, -1*i),
                mode = "lines",
                line = list(color = tldata$color[i], width=20),
                showlegend = F,
                hoverinfo = "text",

                text = paste(
                    tldata$label[i],
                    "\n",
                    tldata$tooltip[i]
                ),

                evaluate = T
            )
            
        }

        feditimeline <- feditimeline |>
            layout(
                yaxis = list(
                    showgrid = FALSE,
                    tickmode = "array",
                    tickvals = ""
                )
            )

        feditimeline
    })
}

shinyApp(ui, server)
