# 🎮 NVIDIA GPU Market Analysis & Visualization

A data-driven exploration of **NVIDIA’s dominance in the GPU industry** — analyzing how their product launches impact performance benchmarks, market share, and stock price trends.

📌 **Built with R · Designed in Adobe Illustrator · Powered by real-world data**

---

## 🚀 Overview

This project investigates how **NVIDIA’s innovation strategy and GPU release timing** contribute to its market leadership — both in terms of technology and stock performance. By analyzing over **12,000 records** from 1980–2024 across five major GPU manufacturers, we uncover clear patterns linking product launches to market movement.

---

## 🔍 Key Objectives

- Compare **GPU benchmark scores** across NVIDIA, AMD, Intel, ASUS, and MSI
- Analyze **stock price trends** surrounding key GPU launch events
- Visualize **market share evolution** and GPU popularity
- Present findings through compelling, high-dimensional plots and a final poster

---

## 📊 Datasets Used

- [UserBenchmark – GPU Performance](https://gpu.userbenchmark.com/)
- [Kaggle – GPU Specifications](https://www.kaggle.com/datasets/alanjo/graphics-card-full-specs)
- [Kaggle – NVIDIA, AMD, Intel, ASUS, MSI Stock Prices](https://www.kaggle.com/datasets/kapturovalexander/nvidia-amd-intel-asus-msi-share-prices)

---

## 🧰 Tools & Technologies

- **R**: `tidyverse`, `ggplot2`, `fmsb`, `lubridate`, `scales` for analysis & visualization
- **Adobe Illustrator**: Final layout & design polish for the poster
- **Git & GitHub**: Version control, reproducibility, and public sharing

---

## 📂 Project Structure

nvidia-gpu-visualization/
├── datasets/                  # Raw datasets (CSV files)
│   ├── GPU_SPECS.csv
│   ├── GPU_UserBenchmarks.csv
│   ├── NVIDIA (1999 -11.07.2023).csv
│   ├── Nvidia (2023 - 08.04.2024).csv
│   ├── AMD (...).csv
│   └── [Other brand data files]
│
├── scripts/                   # R scripts for data cleaning, analysis, and plotting
│   ├── 01_cleaning.R
│   ├── 02_merge_transform.R
│   ├── 03_visualizations.R
│   └── 04_final_export.R
│
├── output/                    # Final outputs and visuals
│   ├── Poster.pdf
│   
├── assets/                    # Illustrator files or fonts (optional)
│   └── POSTER.ai
│
├── poster_thumbnail.jpg       # Optional preview image for README display
├── .gitignore                 # Files to ignore in version control
├── LICENSE                    # MIT license (or your preferred one)
└── README.md                  # Project documentation

