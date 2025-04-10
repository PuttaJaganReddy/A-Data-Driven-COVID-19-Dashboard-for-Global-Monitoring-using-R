# 📊 Interactive COVID-19 Dashboard using R Shiny

## 📝 Project Overview

This project is an **interactive data visualization dashboard** built using **R Shiny**. It allows users to explore COVID-19 data by selecting countries and date ranges, displaying trends in total cases, deaths, and vaccinations. The dashboard is designed for analysts, researchers, students, and policymakers to monitor and analyze the pandemic using real-world data in a dynamic and user-friendly interface.

---

## 🎯 Features

- 🔎 **Filter by Country and Date**  
- 📈 **Interactive Line Charts** for cases, deaths, and vaccinations  
- 📦 **Summary Value Boxes** showing key metrics  
- 🧾 **Interactive Data Table** (searchable and paginated)  
- ⚙️ **Reactive UI** that updates instantly based on user input  
- 🧹 **Data cleaning and validation** for real-world CSV data  

---

## 📁 Dataset

- Source: [Our World in Data – COVID-19 Dataset](https://ourworldindata.org/coronavirus-source-data)  
- Format: CSV  
- Path used: give the file path.

---


---

## 🧠 What I Learned

- How to build **interactive dashboards** using `shiny` and `shinydashboard`
- Data cleaning and transformation with `dplyr`
- Using `ggplot2` and `plotly` to build dynamic visualizations
- Creating summary statistics and value boxes
- Implementing reactive programming for real-time updates
- Displaying searchable data tables using `DT`

---

## 🧰 Technologies Used

| Tool/Package     | Purpose                          |
|------------------|----------------------------------|
| `shiny`          | Web app framework in R           |
| `shinydashboard` | Dashboard layout system          |
| `dplyr`          | Data manipulation                |
| `ggplot2`        | Data visualization               |
| `plotly`         | Interactive plotting             |
| `DT`             | Interactive data tables          |
| `lubridate`      | Date formatting and manipulation |

---

## ▶️ How to Run

1. Make sure R and RStudio of the latest versions are installed.
2. Install the required packages if not already installed using the below line:

install.packages(c("shiny", "shinydashboard", "dplyr", "ggplot2", "plotly", "DT", "lubridate"))


---

## Place the CSV dataset at the correct file path.

Run the app using:

shiny::runApp("app.R")


