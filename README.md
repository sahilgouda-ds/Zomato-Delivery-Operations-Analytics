# 🍔 Zomato Delivery Operations Analysis | SQL Project

![SQL](https://img.shields.io/badge/SQL-PostgreSQL-336791?style=flat&logo=postgresql&logoColor=white)
![Status](https://img.shields.io/badge/Status-Complete-brightgreen)
![Rows](https://img.shields.io/badge/Records-45%2C584-blue)

Analyzing 45,000+ real-world food delivery records to uncover **operational bottlenecks** — how weather, traffic, city type, and delivery agent performance impact delivery time — and translating the findings into actionable business recommendations.

> 📄 All SQL queries live in [`solutions.sql`](solutions.sql) — this README summarizes the questions, results, and insights.

---

## 📌 Objective

Zomato-style delivery platforms lose customer trust when delivery times are unpredictable. This project analyzes delivery operations data to answer:
- Where are the biggest delays happening, and why?
- Which external factors (weather, traffic, festivals) most affect delivery speed?
- Who are the top-performing delivery agents, and what drives their performance?

The goal: turn raw operational data into insights an operations manager could actually act on.

---

## 🗂️ Dataset

| | |
|---|---|
| **Source** | [Kaggle – Zomato Delivery Operations Analytics Dataset](https://www.kaggle.com/datasets/saurabhbadole/zomato-delivery-operations-analytics-dataset) |
| **Size** | 45,584 delivery records |
| **Fields** | Delivery agent details, order timestamps, weather, traffic density, vehicle type, city, festival flag, delivery time |

### Schema Design
The raw flat file was **normalized into two relational tables** (see [`schema.sql`](schema.sql)) to reflect real-world database design rather than working off a single flat CSV:

```
delivery_agents                    orders
─────────────────────              ─────────────────────────
delivery_person_id (PK)  ────┐     id (PK)
delivery_person_age          └───► delivery_person_id (FK)
delivery_person_ratings            order_date, time_orderd, city,
                                    weather_conditions, road_traffic_density,
                                    vehicle_condition, type_of_order,
                                    type_of_vehicle, multiple_deliveries,
                                    festival, time_taken_min
```

---

## 🛠️ Tools Used
- **PostgreSQL** — data storage & querying
- **pgAdmin** — query execution & exploration
- SQL concepts used: `JOIN`, `GROUP BY`, `Window Functions (RANK)`, `Regex filtering`, `Aggregations`

---

## ❓ Business Questions & Insights

| # | Question | Key Insight |
|---|---|---|
| Q1 | Which city type has the highest average delivery time? | _[Fill in after running]_ |
| Q2 | How does weather affect delivery time? | _[Fill in after running]_ |
| Q3 | How does traffic density affect delivery time? | Jam traffic pushes avg delivery time to **31.18 min** — ~17% higher than Medium traffic (26.70 min) |
| Q4 | How different is delivery time on festival vs normal days? | _[Fill in after running]_ |
| Q5 | Which vehicle type delivers fastest? | _[Fill in after running]_ |
| Q6 | Is there a pattern between agent age and rating? *(JOIN)* | _[Fill in after running]_ |
| Q7 | How do multiple deliveries per trip affect time? | _[Fill in after running]_ |
| Q8 | Who are the top 10 agents by rating? *(JOIN)* | _[Fill in after running]_ |
| Q9 | Which order type has the most delay? | _[Fill in after running]_ |
| Q10 | Which city + traffic combo is slowest? | _[Fill in after running]_ |
| Q11 (bonus) | Highest-rated agent per city *(JOIN + Window Function)* | _[Fill in after running]_ |

Full queries for each question: [`solutions.sql`](solutions.sql)

---

## 📸 Sample Results

**Q3 — Traffic Impact on Delivery Time**
![Traffic Impact Result](screenshots/q3_traffic_impact.png)

**Q6 — Agent Age vs Rating (JOIN)**
![Age vs Rating Result](screenshots/q6_age_vs_rating.png)

**Q10 — City + Traffic Combined**
![City + Traffic Result](screenshots/q10_city_traffic.png)

---

## 🔑 Key Findings

- **Traffic is the #1 delay driver** — Jam conditions add ~17% more delivery time versus Medium traffic.
- _[Add 2-3 more findings once remaining queries are run]_

## 💡 Recommendations

- Show customers **dynamic, traffic-adjusted ETAs** instead of static delivery time estimates.
- _[Add more based on your findings — e.g. weather-based staffing, festival-day surge planning]_

---

## 🚀 How to Run This Project

```bash
# 1. Clone the repo
git clone https://github.com/<your-username>/zomato-delivery-sql-analysis.git
cd zomato-delivery-sql-analysis

# 2. Create the database and tables
psql -U postgres -d your_db -f schema.sql

# 3. Import the dataset (see dataset/ folder), then run:
psql -U postgres -d your_db -f solutions.sql
```

---

## 📁 Repo Structure

```
zomato-delivery-sql-analysis/
├── README.md
├── schema.sql          # table creation + normalization
├── solutions.sql        # all 11 business question queries
├── dataset/
│   └── Zomato Dataset.csv
└── screenshots/
    ├── q3_traffic_impact.png
    ├── q6_age_vs_rating.png
    └── q10_city_traffic.png
```

---

*This project uses a normalized two-table relational schema (rather than a single flat file) to demonstrate JOIN operations and realistic database design, alongside window functions and regex-based cleaning for messy real-world data.*
