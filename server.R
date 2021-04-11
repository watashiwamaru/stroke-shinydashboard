options(scipen = 9999)
function(input, output) {
    
    
    
    
    reactive_disease <- reactive({
        data_stroke %>% 
            filter(gender == input$gender)
    })
    
    
    output$total_case <- renderValueBox({

        value_total_case <- length(data_stroke$id)
        
        valueBox(
            value = value_total_case,
            subtitle = "Total Sample",
            color = "green", width = 3
        )
    })

    
    output$stroke_rate <- renderValueBox({
       
         value_stroke_rate <- reactive_disease() %>% 
             pull(stroke) %>% 
             sum()
         
         valueBox(
             value = value_stroke_rate,
             subtitle = "Total Stroke Case",
             color = "red", width = 3
         )
    })
    
    
    output$hypertension_rate <- renderValueBox({
        
        value_hypertension_rate <- reactive_disease() %>% 
            pull(hypertension) %>% 
            sum()
        
        valueBox(
            value = value_hypertension_rate,
            subtitle = "Total Hypertension Case",
            color = "red", width = 3
        )
    })
    
    output$heartdis_rate <- renderValueBox({
        
        value_heartdis <- reactive_disease() %>% 
            pull(heart_disease) %>% 
            sum()
        
        valueBox(
            value = value_heartdis,
            subtitle = "Total Heart Disease Case",
            color = "red", width = 3
        )
    })
    
    
    
    output$risk1 <- renderPlotly({
        
        title_num <- input$tabset1 %>%
            str_replace_all(pattern = "_", replacement = " ") %>%
            str_to_title()
        
        
        risk <- data_stroke %>% 
            filter(!! sym(input$tabset1) == 1) %>%
            filter(bmi >0) %>% 
            ggplot(aes(x= avg_glucose_level, y= bmi))+
            geom_point(col = "#ad1b0e")+
            geom_smooth(method= "lm", se= F, col= "green")
            theme_bw()+
            labs(title = title_num,
                 x= "Average Glucose Level",
                 y= "BMI")
        
        
        
        ggplotly(risk)
        
    })
    
    
    
    output$glucose <- renderPlotly({
        
        title_two <- input$tabset2 %>%
            str_replace_all(pattern = "_", replacement = " ") %>%
            str_to_title()
        
        
        glucose <- data_stroke %>%
            group_by(!!sym(input$tabset2)) %>% 
            summarise(mean_avg_glucose_level= mean(avg_glucose_level)) %>% 
            mutate(label = glue(
                "Glucose Level: {round(mean_avg_glucose_level,2)}"))%>%
            ggplot(aes(x= mean_avg_glucose_level,
                       y= reorder(!! sym(input$tabset2), mean_avg_glucose_level),
                       text = label))+
            geom_col(fill = "#2a8580")+
            theme_bw()+
            labs(title = title_two,
                 x= NULL,
                 y= NULL)
           
        
        ggplotly(glucose, tooltip = "text")
    })
    
    
   
    output$fun1 <- renderPlotly({

        title_three <- input$tabset3 %>%
            str_replace_all(pattern = "_", replacement = " ") %>%
            str_to_title()

        fun1 <- data_stroke %>%
            group_by(!!sym(input$tabset3)) %>%
            summarise(disease_frequency= sum(stroke)) %>% 
            mutate(label = glue(
                "Freq: {disease_frequency}")) %>% 
            ggplot(aes(x= !!sym(input$tabset3), y= disease_frequency,
                       text = label))+
            geom_col(fill= "#ad1b0e")+
            theme_bw()+
            labs(title = title_three,
                 x= NULL,
                 y= "Frequency")
        
        ggplotly(fun1, tooltip = "text")
    })
    
    output$stroke <- renderDataTable({
        datatable(data = data_stroke)
    })
    
    
    output$text1 <- renderUI(
        div(
            style = "text-align: justify",
            HTML(
                "
                Total Case Human Body Transport System Disease by Gender
                <br>
                <br>
                "
            )
        )
        
    )
    
    
    output$text2 <- renderUI(
        div(
            style = "text-align: justify",
            HTML(
                "
                This plot will show you the correlation between work type, smoking behaviour, and average glucose level.
                <br>
                <br>
                "
            )
        )
    )
    
    
    output$text3 <- renderUI(
        div(
            style = "text-align: justify",
            HTML(
                "
                According to The Centers for Disease Control and Prevention, 70% of Americans who have
                chronic heart disease and 80% who have stroke also have high blood pressure (hypertension).
                High blood pressure has correlation with Body Mass Index (BMI) and Glucose Level. The higher the number
                of BMI and Glucose Level, the risk of high blood pressure also increasing.
                <br>
                <br>
                "
            )
        )
        
    )
    
    output$text4 <- renderUI(
        div(
            style = "text-align: justify",
            HTML(
                "
                This plot will show you frequency of stroke disease by marital status, smoking bahaviour and residence type.
                <br>
                <br>
                "
            )
        )
    )
    
}