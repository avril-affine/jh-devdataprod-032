library(shiny)

shinyUI(fluidPage(
    titlePanel("Chance of Esophageal Cancer"),
    sidebarPanel(
        headerPanel("Inputs"),
        sliderInput(inputId="age", label="Age (years)",
                    min=18, max=99, value=18, step=1),
        sliderInput(inputId="alc", 
                    label="Daily Alcohol Consumption (gm/day)",
                    min=0, max=150, value=0, step=1),
        sliderInput(inputId="tob", 
                    label="Daily Tobacco Consumption (gm/day)",
                    min=0, max=50, value=0, step=0.5)
    ),
    mainPanel(
        headerPanel("Results"),
        h4("Age:"),
        verbatimTextOutput("oage"),
        h4("Alcohol Consumption:"),
        verbatimTextOutput("oalc"),
        h4("Tobacco Consumption:"),
        verbatimTextOutput("otob"),
        h4("Predicted Chance of Esophageal Cancer:"),
        verbatimTextOutput("ores")
    )
))