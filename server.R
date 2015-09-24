library(shiny)
library(gtools)
library(datasets)

shinyServer(
    function(input, output) {
        df <- esoph
        x <- factor(esoph$agegp, levels=levels(esoph$agegp), 
                    labels=c("29.5","39.5","49.5","59.5","69.5","79.5"))
        df$agegp <- as.numeric(as.character(x))
        x <- factor(esoph$alcgp, levels=levels(esoph$alcgp), 
                    labels=c("19.5","59.5","99.5","139.5"))
        df$alcgp <- as.numeric(as.character(x))
        x <- factor(esoph$tobgp, levels=levels(esoph$tobgp), 
                    labels=c("4.5","14.5","24.5","34.5"))
        df$tobgp <- as.numeric(as.character(x))
        fin_data <- NULL
        for (i in 1:nrow(esoph)) {
            num_cases <- df$ncases[i]
            num_ctrls <- df$ncontrols[i] - num_cases
            cases <- NULL
            ctrls <- NULL
            row <- c(df$agegp[i], df$alcgp[i], df$tobgp[i])
            while (num_cases > 0) {
                cases <- rbind(cases, c(row, 1))
                num_cases <- num_cases - 1
            }
            while (num_ctrls > 0) {
                ctrls <- rbind(ctrls, c(row, 0))
                num_ctrls <- num_ctrls - 1
            }
            fin_data <- rbind(fin_data, cases, ctrls)
        }
        fin_data <- data.frame(fin_data)
        names(fin_data) <- c("agegp","alcgp","tobgp","outcome")
        fit <- glm(outcome~., family="binomial", data=fin_data)
        inp <- reactive(c(1, input$age, input$alc, input$tob))
        res <- reactive(inv.logit(sum(coefficients(fit) * inp())))
        
        output$oage <- renderText({input$age})
        output$oalc <- renderText({input$alc})
        output$otob <- renderText({input$tob})
        output$ores <- renderText({paste0(round(res() * 100, 2), "%")})
    }
)