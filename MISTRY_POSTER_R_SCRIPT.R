

#IST719
#POSTER 
#TITLE : NVIDIA’s Game-Changing GPUs:Performance, Market Impact, and Competitive Edge
#AUTHOR: TEJAS MISTRY

##############################Required libraries:############################################

install.packages(c("tidyverse", "ggplot2", "lubridate", "scales", "ggpubr"))
library(tidyverse)
library(ggplot2)
library(lubridate)
library(scales)
library(ggpubr)
library(fmsb)
library(readr)
library(dplyr)

#################################Load All Datasets#########################################

# GPU specs and benchmarks
gpu_specs <- read_csv('GPU_SPECS.csv')
gpu_benchmarks <- read_csv('GPU_UserBenchmarks.csv')

# NVIDIA Stock Data
nvidia_stock <- bind_rows(
  read_csv('NVIDIA (1999 -11.07.2023).csv'),
  read_csv('Nvidia (2023 - 08.04.2024).csv')
) %>% mutate(Date = as.Date(Date))

# AMD Stock Data
amd_stock <- bind_rows(
  read_csv('AMD (1980 -11.07.2023).csv'),
  read_csv('AMD (2023 - 08.04.2024).csv')
) %>% mutate(Date = as.Date(Date))

# ASUS Stock Data
# Load datasets separately first
asus_old <- read_csv('ASUS (2000 - 11.07.2023).csv') %>% 
  mutate(Date = as.Date(Date, "%Y-%m-%d"),
         Open = as.numeric(Open),
         High = as.numeric(High),
         Low = as.numeric(Low),
         Close = as.numeric(Close),
         `Adj Close` = as.numeric(`Adj Close`),
         Volume = as.numeric(Volume))

asus_recent <- read_csv('ASUS (2023 - 08.04.2024).csv') %>% 
  mutate(Date = as.Date(Date, "%Y-%m-%d"))

asus_stock <- bind_rows(asus_old, asus_recent)

# Intel Stock Data
intel_stock <- bind_rows(
  read_csv('INTEL (1980 - 11.07.2023).csv'),
  read_csv('Intel (2023 - 08.04.2024).csv')
) %>% mutate(Date = as.Date(Date))

# MSI Stock Data (Recent Only)
msi_stock <- read_csv('MSI (2023 - 08.04.2024).csv') %>% mutate(Date = as.Date(Date))

###########################Data Preparation and Cleaning#############################################

market_share <- tibble(
  Manufacturer = c("NVIDIA", "AMD", "Intel", "ASUS", "MSI"),
  Share = c(60, 20, 10, 5, 5) # replace with your calculated shares
)

###########################Visualizations############################################################

#Visualization 1: "NVIDIA vs Competitors: A Multi-Dimensional Performance Comparison" (RADAR PLOT)


library(fmsb)

gpu_data <- data.frame(
  row.names = c("Max", "Min", "NVIDIA", "AMD", "Intel"),
  Performance = c(100, 0, 95, 85, 70),
  Efficiency = c(100, 0, 90, 80, 75),
  Popularity = c(100, 0, 92, 75, 68),
  PriceCompetitiveness = c(100, 0, 75, 85, 80),
  Innovation = c(100, 0, 98, 80, 65)
)

colors_border <- c("#76B900", "#FF0000", "#0071C5")
colors_in <- adjustcolor(colors_border, alpha.f = 0.3)

radarchart(gpu_data, axistype=1, pcol=colors_border, pfcol=colors_in,
           title="NVIDIA vs Competitors: GPU Performance Radar", plwd=2)
legend("topright", legend=rownames(gpu_data[-c(1,2),]), col=colors_border, pch=20, pt.cex=2)

###################################################################################

#Visualization 2: "GPU Market Share Snapshot: NVIDIA’s Clear Lead"  (PIE CHART)
ggplot(market_share, aes(x="", y=Share, fill=Manufacturer)) +
  geom_bar(width=1, stat="identity") +
  coord_polar("y") +
  theme_void() +
  labs(title="GPU Market Share Distribution")

########################################################################################

#Visualization 3 : "NVIDIA’s Market Outperformance vs. AMD, Intel, ASUS, and MSI" (LINE GRAPH)

ggplot(nvidia_stock, aes(Date, Close)) +
  geom_line(color='blue') +
  labs(title='NVIDIA Stock Price and GPU Launch Correlation', x='Date', y='Closing Price (USD)') +
  geom_vline(xintercept=as.Date(c("2020-09-17", "2022-10-12")), color="red", linetype="dashed") +
  annotate("text", x=as.Date("2020-09-17"), y=max(nvidia_stock$Close), label="RTX 3080 Launch", color="red", angle=90, vjust=-0.5) +
  theme_minimal()

stocks_combined <- bind_rows(nvidia_stock, amd_stock, intel_stock, asus_stock, msi_stock, .id="Company")
stocks_combined <- stocks_combined %>%
  group_by(Company) %>%
  mutate(Indexed = Close/first(Close)*100)

ggplot(stocks_combined, aes(Date, Indexed, color=Company)) +
  geom_line() +
  labs(title="Indexed Comparative Stock Price Growth", y="Indexed Stock Price (100=Start Date)", x="Date") +
  theme_minimal()

####################################################################################

#Visualization 4: "GPU Launch Frequency Highlights Aggressive Innovation Post-2018" (BAR CHART)

# 📦 Load required packages
library(tidyverse)

# 📂 Load the dataset
gpu_specs <- read_csv("GPU_SPECS.csv")  # Make sure this file is in your working directory

# 🔍 Filter for NVIDIA GPUs and count launches per year
nvidia_launches <- gpu_specs %>%
  filter(manufacturer == "NVIDIA") %>%
  group_by(releaseYear) %>%
  summarise(Launches = n()) %>%
  arrange(releaseYear) %>%
  mutate(highlight = if_else(releaseYear >= 2018, "Recent (2018+)", "Earlier"))

# 📊 Create bar chart with color-coded launch periods
ggplot(nvidia_launches, aes(x = as.factor(releaseYear), y = Launches, fill = highlight)) +
  geom_bar(stat = "identity") +
  scale_fill_manual(values = c("Earlier" = "gray70", "Recent (2018+)" = "#76B900")) +
  labs(
    title = "NVIDIA GPU Launches Over Time",
    subtitle = "Recent years show an acceleration in product release frequency",
    x = "Release Year",
    y = "Number of Models Launched",
    fill = "Period"
  ) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    plot.title = element_text(face = "bold", size = 14),
    plot.subtitle = element_text(size = 10)
  )


##################################################################################

#Visualization 5: Top 10 Highest Performing GPUs: RTX 5090 Leads the Pack" ( HORIZONTAL BAR CHART)

# Load necessary libraries
library(tidyverse)

# Load the dataset
gpu_benchmarks <- read_csv("GPU_UserBenchmarks.csv")  # Update with your actual file path

# Prepare top 10 highest-performing GPUs
top_10_performance <- gpu_benchmarks %>%
  filter(!is.na(Benchmark)) %>%
  arrange(desc(Benchmark)) %>%
  slice(1:10)

# Plot horizontal bar chart
ggplot(top_10_performance, aes(x = Benchmark, y = reorder(Model, Benchmark), fill = Brand)) +
  geom_col() +
  labs(
    title = "Top 10 Highest Performing GPUs (Competitive Market)",
    subtitle = "Based on UserBenchmark performance scores",
    x = "Benchmark Score",
    y = "GPU Model",
    fill = "Brand"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(face = "bold", size = 14),
    axis.text.y = element_text(size = 10),
    legend.position = "right"
  )


###################################################################################





