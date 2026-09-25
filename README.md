# 📱 Google Play Store App Growth Analytics

An end-to-end **Data Analytics and Business Intelligence project** analyzing Google Play Store applications to understand **app adoption, user engagement, ratings, pricing, and category-level performance**.

The project uses **Python/Pandas for data cleaning and exploratory analysis, PostgreSQL for SQL-based analysis, and Power BI for interactive dashboarding**.

---

## 📊 Project Overview

The Google Play Store contains thousands of applications across multiple categories, with significant differences in downloads, ratings, reviews, pricing, and user engagement.

This project analyzes the Google Play Store dataset to answer questions such as:

* Which app categories have the highest total installs?
* How do free and paid apps differ?
* Which apps have the highest number of installs and reviews?
* Is there a relationship between ratings, reviews, and installs?
* Which highly rated apps also have significant user engagement?
* How does pricing vary across applications?
* Which categories have the largest number of applications?
* How frequently are applications updated?

The final output is an interactive **Power BI dashboard** supported by Python data preparation and PostgreSQL analysis.

---

## 🎯 Business Objectives

The main objectives of this project are to:

1. Analyze application distribution across categories.
2. Measure total installs and reviews by category.
3. Compare free and paid applications.
4. Identify highly installed and highly reviewed applications.
5. Analyze relationships between ratings, reviews, and installs.
6. Understand pricing patterns among paid applications.
7. Identify highly rated applications with meaningful review volume.
8. Create an interactive dashboard for business-oriented analysis.

---

## 🛠️ Tools & Technologies

| Technology           | Purpose                                 |
| -------------------- | --------------------------------------- |
| **Python**           | Data cleaning and exploratory analysis  |
| **Pandas**           | Data manipulation and transformation    |
| **NumPy**            | Numerical operations                    |
| **Matplotlib**       | Data visualization                      |
| **Seaborn**          | Statistical visualization               |
| **PostgreSQL**       | SQL analysis and aggregation            |
| **Power BI**         | Interactive dashboard and visualization |
| **Git & GitHub**     | Version control and project hosting     |
| **Jupyter Notebook** | Python-based analysis                   |

---

## 📂 Dataset

The project uses the **Google Play Store Apps** dataset containing approximately 10,000 application records.

### Original columns

* App
* Category
* Rating
* Reviews
* Size
* Installs
* Type
* Price
* Content Rating
* Genres
* Last Updated
* Current Ver
* Android Ver

### Dataset Source

The dataset is available on Kaggle:

**Google Play Store Apps — Lavanya Gupta**

https://www.kaggle.com/datasets/lava18/google-play-store-apps

---

# 🔄 Data Analytics Workflow

```text
Raw Dataset
     ↓
Python / Pandas
     ↓
Data Cleaning & Transformation
     ↓
Feature Engineering
     ↓
Cleaned CSV
     ↓
PostgreSQL
     ↓
SQL Analysis
     ↓
Power BI
     ↓
Interactive Business Dashboard
```

---

# 🐍 1. Python Data Cleaning

The raw dataset was loaded and cleaned using **Pandas**.

### Cleaning operations performed

* Removed duplicate records
* Converted `Installs` from text to integer
* Removed commas and `+` symbols from install values
* Converted `Price` from text to numeric
* Converted `Last Updated` into a datetime field
* Converted application size into numeric MB values
* Preserved missing ratings rather than incorrectly assigning values
* Created additional analytical columns

### Feature Engineering

The following features were created:

| Feature          | Description                                                          |
| ---------------- | -------------------------------------------------------------------- |
| `Size_MB`        | Application size converted to MB                                     |
| `Is_Paid`        | Indicates whether an application is free or paid                     |
| `Install_Range`  | Groups apps into Low, Medium, High and Very High install ranges      |
| `Review_Rate`    | Reviews as a percentage of installs                                  |
| `App_Age_Years`  | Approximate application age based on last update date                |
| `Price_Category` | Groups applications into Free, Low, Medium and High price categories |

The cleaned dataset contains **10,357 records and 19 analytical columns**.

---

# 🗄️ 2. PostgreSQL Analysis

The cleaned dataset was imported into PostgreSQL for structured SQL analysis.

### SQL analysis includes

* Category-level performance
* Total applications by category
* Total installs by category
* Total reviews by category
* Average rating by category
* Free vs paid application analysis
* Top applications by installs
* Top applications by reviews
* Highly rated applications with minimum review volume
* Rating vs installs correlation
* Reviews vs installs correlation
* Price category analysis
* Install range analysis
* Review engagement analysis
* Paid vs free analysis by category
* Top applications within each category
* Recently updated applications
* Data quality checks

### Example SQL analysis

```sql
SELECT
    category,
    COUNT(*) AS total_apps,
    SUM(installs) AS total_installs,
    SUM(reviews) AS total_reviews,
    ROUND(AVG(rating), 2) AS avg_rating
FROM google_play_apps
GROUP BY category
ORDER BY total_installs DESC;
```

---

# 📈 3. Power BI Dashboard

The cleaned PostgreSQL dataset was connected to **Power BI Desktop** to create an interactive business intelligence dashboard.

### Dashboard Title

**Google Play Store App Growth Analytics**

### Dashboard Focus

**App Adoption • User Engagement • Ratings • Pricing**

### KPI Cards

* Total Apps
* Total Installs
* Total Reviews
* Average Rating
* Paid Apps

### Dashboard Visuals

* Number of Apps by Category
* Total Installs by Category
* Top 10 Apps by Installs
* Top Rated Apps with 1K+ Reviews
* Rating vs Installs Scatter Plot
* Free vs Paid Applications
* Interactive slicers for:

  * Type
  * Content Rating
  * Genres
  * Category

---

# 📊 Key Analytical Findings

Based on the SQL analysis:

### Category Performance

The **GAME** category has the highest total installs in the dataset, followed by **COMMUNICATION** and **SOCIAL**.

| Category      | Total Apps | Total Installs | Avg Rating |
| ------------- | ---------: | -------------: | ---------: |
| GAME          |      1,121 |         31.54B |       4.28 |
| COMMUNICATION |        366 |         24.15B |       4.15 |
| SOCIAL        |        280 |         12.51B |       4.25 |
| PRODUCTIVITY  |        407 |         12.46B |       4.20 |
| TOOLS         |        843 |         11.45B |       4.05 |

### Free vs Paid

The dataset contains substantially more free applications than paid applications.

| Type | Applications | Avg Rating | Total Installs |
| ---- | -----------: | ---------: | -------------: |
| Free |        9,592 |       4.18 |        146.56B |
| Paid |          765 |       4.26 |         69.23M |

These figures describe the dataset and should not be interpreted as causal evidence that pricing itself produces a particular level of adoption.

---

# 🖥️ Dashboard Preview

The Power BI dashboard provides an interactive view of:

* Application adoption
* Category performance
* User engagement
* Ratings
* Pricing
* Free vs paid distribution

### Power BI File

The Power BI report is available in:

```text
power bi/
└── Google_Play_Store_App_Growth_Analytics.pbix
```

---

# 📁 Project Structure

```text
Google-Play-Store-Analytics/
│
├── data/
│   ├── raw/
│   │   └── googleplaystore.csv
│   │
│   └── processed/
│       └── googleplaystore_cleaned.csv
│
├── notebook/
│   └── 01_data_exploration.ipynb
│
├── power bi/
│   └── Google_Play_Store_App_Growth_Analytics.pbix
│
├── sql/
│   └── Google play store analysis.sql
│
├── .gitignore
└── README.md
```

---

# 🚀 How to Run the Project

## 1. Clone the repository

```bash
git clone https://github.com/Jaiswalaniket989/Google-Play-Store-Analytics.git
```

## 2. Navigate to the project

```bash
cd Google-Play-Store-Analytics
```

## 3. Create a Python virtual environment

```bash
python -m venv .venv
```

## 4. Activate the environment

### Windows

```powershell
.\.venv\Scripts\Activate.ps1
```

## 5. Install dependencies

```bash
pip install pandas numpy matplotlib seaborn jupyter openpyxl
```

## 6. Launch Jupyter Notebook

```bash
jupyter notebook
```

Open:

```text
notebook/01_data_exploration.ipynb
```

---

# 🗄️ PostgreSQL Setup

Create a PostgreSQL database:

```sql
CREATE DATABASE google_play_analytics;
```

Create the required table using the SQL script provided in:

```text
sql/Google play store analysis.sql
```

Import the cleaned dataset into PostgreSQL and execute the analytical queries.

---

# 📊 Power BI

Open:

```text
power bi/Google_Play_Store_App_Growth_Analytics.pbix
```

The report contains the completed dashboard and analytical visuals.

---

# 💡 Skills Demonstrated

This project demonstrates practical experience in:

* Data Cleaning
* Exploratory Data Analysis
* Pandas
* Python
* SQL
* PostgreSQL
* Data Aggregation
* Feature Engineering
* Correlation Analysis
* KPI Development
* Business Intelligence
* Power BI
* Data Visualization
* Dashboard Development
* Git & GitHub

---

# 👨‍💻 Author

**Aniket Jaiswal**

Data Analyst | MIS | Power BI | SQL | Python

* GitHub: [Jaiswalaniket989](https://github.com/Jaiswalaniket989)
* LinkedIn: [Aniket Jaiswal](https://linkedin.com/in/aniket-jaiswal-27b224275)

---

## 📌 Project Status

**Completed**

The project covers the complete analytics workflow from raw data preparation to SQL analysis and interactive Power BI visualization.
