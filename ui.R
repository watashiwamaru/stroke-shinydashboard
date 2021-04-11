

#header definition

header <- dashboardHeader(
    title = strong("Stroke Disease")
)

#sidebar definition

sidebar <- dashboardSidebar(
    sidebarMenu(
        menuItem(
            text = "Overview",
            tabName = "overview",
            icon = icon("heartbeat")
        )
    ),
    
    
    sidebarMenu(
        menuItem(
            text = "Disease",
            tabName = "test",
            icon = icon("ambulance")
        )
    ),
    
    
    sidebarMenu(
        menuItem(
            text = "Data",
            tabName = "dataframe",
            icon = icon("newspaper-o")
        )
    )
)


#body definition

body <- dashboardBody(
    tabItems(
        tabItem(
            tabName = "overview",
            
            
            # fluidPage(
            #     mainPanel(
            #         div("Stroke, Hypertension, and Heart Disease is serious health issues and could be causing death to anyone.", style = "justify")
            #     )
            # )
            # 
            
            fluidRow(
                box(
                    htmlOutput("text1"),
                    
                    title = strong("Disease by Gender"),
                    width = 12,
                    
                    radioButtons(inputId = "gender",
                                 label = "Who's the most?",
                                 choices = c("Male", "Female"),
                                 inline = T),
                    
                    valueBoxOutput(
                        outputId = "total_case", width = 3
                    ),
                    
                    valueBoxOutput(
                        outputId = "stroke_rate", width = 3
                    ),
                    
                    valueBoxOutput(
                        outputId = "hypertension_rate", width = 3
                    ),
                    
                    valueBoxOutput(
                        outputId = "heartdis_rate", width = 3
                    )
                )
            ),
            
            
            fluidRow(
                box(
                    htmlOutput("text2"),
                    
                    width = 12,
                    title = strong("Average Glucose Level Based On Work Type and Smoking Status"),
                    selectInput(inputId = "tabset2",
                                label = strong("Select:"),
                                choices = data_stroke %>%
                                    select(work_type, smoking_status) %>% 
                                    colnames()),
                    plotlyOutput("glucose")
                )
            )
        ),
        
        
        tabItem(
            tabName = "test",
            
            
            fluidRow(
                box(
                    htmlOutput("text3"),
                    
                    width = 12,
                    title = strong("Risk of Disease by Average Glucose Level and BMI"),
                    selectInput(inputId = "tabset1",
                                label = "Select:",
                                choices = data_stroke %>% 
                                    select(stroke, heart_disease, hypertension) %>% 
                                    colnames()),
                    plotlyOutput("risk1")
                    
                )
            ),
            
            
            fluidRow(
                box(
                    htmlOutput("text4"),
                    
                    width = 12,
                    title = strong("Marital Status, Residence Type and Smoking Status on Stroke Disease"),
                    selectInput(inputId = "tabset3",
                                label = "Choose here:",
                                choices = data_stroke %>% 
                                    select(smoking_status, ever_married, Residence_type) %>% 
                                    colnames()),
                    plotlyOutput("fun1")
                )
            )
            
        ),
        
        tabItem(
            tabName = "dataframe",
            fluidRow(
                box(dataTableOutput("stroke"),
                    title = "STROKE DATASET",
                    width = 12)
            )
        )
    )
)









#full page
#page definition
dashboardPage(
    header = header,
    sidebar = sidebar,
    body = body,
    skin = "black"
)
