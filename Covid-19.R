# Make sure R and RStudio of the latest versions are installed.
# Install the required packages if not already installed using the below code:
  
#install.packages(c("shiny", "shinydashboard", "dplyr", "ggplot2", "plotly", "DT", "lubridate"))


# 📦 Load necessary libraries
library(shiny)
library(shinydashboard)
library(ggplot2)
library(dplyr)
library(plotly)
library(DT)
library(lubridate)

# 📁 Load your local CSV file
data_path <- "C://Users/DELL/OneDrive/Onedrive/Documents/PredictiveDatasets/dataset/owid-covid-data.csv"
covid_data <- read.csv(data_path)

# 🧹 Clean and prepare data
covid_data$date <- as.Date(covid_data$date)
covid_data <- covid_data %>% 
  filter(!is.na(location), !is.na(date), !is.na(total_cases)) %>%
  select(location, date, total_cases, total_deaths, people_vaccinated)

# 🌐 Define UI
ui <- dashboardPage(
  dashboardHeader(title = "COVID-19 Dashboard"),
  
  dashboardSidebar(
    sidebarMenu(
      menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
      selectInput("country", "Select Country", choices = unique(covid_data$location), selected = "India", multiple = TRUE),
      dateRangeInput("date", "Select Date Range", 
                     start = min(covid_data$date), 
                     end = max(covid_data$date))
    )
  ),
  
  dashboardBody(
    tabItems(
      tabItem(tabName = "dashboard",
              fluidRow(
                valueBoxOutput("totalCases"),
                valueBoxOutput("totalDeaths"),
                valueBoxOutput("totalVaccinated")
              ),
              fluidRow(
                box(title = "COVID-19 Trends", status = "primary", solidHeader = TRUE,
                    width = 12, plotlyOutput("trendPlot"))
              ),
              fluidRow(
                box(title = "Detailed Data Table", status = "info", solidHeader = TRUE,
                    width = 12, DTOutput("dataTable"))
              )
      )
    )
  )
)

# 🧠 Server logic
server <- function(input, output) {
  
  # 🔍 Reactive filtered data
  filtered_data <- reactive({
    covid_data %>%
      filter(location %in% input$country,
             date >= input$date[1],
             date <= input$date[2])
  })
  
  # 📦 Value Boxes
  output$totalCases <- renderValueBox({
    total <- sum(filtered_data()$total_cases, na.rm = TRUE)
    valueBox(format(total, big.mark = ","), "Total Cases", icon = icon("heartbeat"), color = "red")
  })
  
  output$totalDeaths <- renderValueBox({
    total <- sum(filtered_data()$total_deaths, na.rm = TRUE)
    valueBox(format(total, big.mark = ","), "Total Deaths", icon = icon("skull"), color = "black")
  })
  
  output$totalVaccinated <- renderValueBox({
    total <- sum(filtered_data()$people_vaccinated, na.rm = TRUE)
    valueBox(format(total, big.mark = ","), "Total Vaccinated", icon = icon("syringe"), color = "green")
  })
  
  # 📈 Trend Plot
  output$trendPlot <- renderPlotly({
    data <- filtered_data()
    
    if (nrow(data) == 0 || all(is.na(data$total_cases))) return(NULL)
    
    gg <- ggplot(data, aes(x = date)) +
      geom_line(aes(y = total_cases, color = "Cases"), linewidth = 1) +
      geom_line(aes(y = total_deaths, color = "Deaths"), linewidth = 1) +
      geom_line(aes(y = people_vaccinated, color = "Vaccinated"), linewidth = 1) +
      labs(title = "COVID-19 Trends", x = "Date", y = "Count", color = "Metric") +
      theme_minimal()
    
    ggplotly(gg)
  })
  
  # 🧾 Data Table
  output$dataTable <- renderDT({
    datatable(filtered_data(), options = list(pageLength = 10))
  })
}

# 🚀 Launch the app
shinyApp(ui, server)
