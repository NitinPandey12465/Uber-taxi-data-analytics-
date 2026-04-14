# Uber-taxi-data-analytics-
Data analytics project analyzing Uber ride data to uncover insights on revenue, cancellations, and customer behavior using Python and SQL.
# 🚖 Uber Ride Data Analysis Project (SQL + Python)

## 📌 Project Overview

This project focuses on analyzing Uber ride data using **Python and SQL** to extract meaningful insights related to ride performance, cancellations, customer behavior, and revenue patterns.

The goal is to simulate a **real-world data analytics workflow** including:

* Data Cleaning
* Data Transformation
* Feature Engineering
* SQL-based Analysis

---

## 📊 Dataset Description

The dataset contains **150,000 ride records** with the following key columns:

* Date, Time
* Booking ID
* Booking Status
* Customer ID
* Vehicle Type
* Pickup & Drop Location
* Avg VTAT (Vehicle Time Allocation Time)
* Avg CTAT (Customer Time Allocation Time)
* Cancellation Details
* Booking Value
* Ride Distance
* Ratings (Driver & Customer)
* Payment Method

---

## 🧹 Data Cleaning (Python - Pandas)

### 🔧 Steps Performed:

### 1. Handling Missing Values

* Replaced numerical missing values with:

  * `-1` (to preserve analytical meaning)
* Replaced categorical missing values with:

  * `"Unknown"`

---

### 2. Feature Engineering

#### ✅ Final Status Creation

```python
def simplify_status(status):
    if "Cancelled" in str(status):
        return "cancelled"
    elif "Completed" in str(status):
        return "completed"
    elif "Incomplete" in str(status):
        return "incomplete"
    else:
        return "other"

df["final_status"] = df["Booking Status"].apply(simplify_status)
```

---

#### ✅ Binary Flags

```python
df["is_cancelled"] = df["final_status"] == "cancelled"
df["is_completed"] = df["final_status"] == "completed"
```

---

#### ✅ Estimated Revenue Loss

```python
avg_fare = df[df["final_status"] == "completed"]["Booking Value"].mean()
df["estimated_loss"] = df["is_cancelled"] * avg_fare
```

---

#### ✅ Cancellation Reason Merging

* Combined:

  * Customer cancellation reason
  * Driver cancellation reason
* Created unified column:

```python
df["cancellation_reason"]
```

---

### 3. Data Cleaning Decisions

| Column               | Action                |
| -------------------- | --------------------- |
| VTAT / CTAT          | Missing → kept as -1  |
| Ratings              | Missing → kept as -1  |
| Payment Method       | Filled with "Unknown" |
| Cancellation Columns | Merged                |

---

## 🧠 Key Concepts Used

* Data Cleaning
* Feature Engineering
* Conditional Logic
* Handling Missing Data
* Business Logic Transformation

---

## 🗄️ SQL Analysis

After cleaning, data was loaded into PostgreSQL for analysis.

---

### 🔥 Key Queries & Insights

---

### 💰 Total Revenue

```sql
SELECT SUM(booking_value) AS total_revenue
FROM uber_rides
WHERE final_status = 'completed';
```

---

### ❌ Cancellation Rate

```sql
SELECT 
    COUNT(*) FILTER (WHERE final_status = 'cancelled') * 100.0 / COUNT(*) AS cancellation_rate
FROM uber_rides;
```

---

### 🚗 Vehicle-wise Performance

```sql
SELECT vehicle_type, COUNT(*) AS total_rides
FROM uber_rides
GROUP BY vehicle_type
ORDER BY total_rides DESC;
```

---

### 📍 Location Analysis

```sql
SELECT pickup_location, COUNT(*) AS rides
FROM uber_rides
GROUP BY pickup_location
ORDER BY rides DESC;
```

---

### ⏰ Time-Based Analysis

* Peak hours
* Ride demand patterns
* Time-wise cancellations

---

### 🔥 Window Function Example

```sql
SELECT 
    vehicle_type,
    booking_value,
    RANK() OVER (PARTITION BY vehicle_type ORDER BY booking_value DESC) AS rank
FROM uber_rides;
```

---

## 📊 Key Insights

* High number of cancellations due to **driver unavailability**
* Certain locations show **higher ride demand**
* Revenue is heavily dependent on **completed rides**
* Missing VTAT/CTAT indicates **system inefficiencies**
* Peak demand observed during **specific hours**

---

## ⚠️ Challenges Faced

* Large number of missing values
* Inconsistent booking status
* PostgreSQL authentication issues
* Data import errors (CSV formatting issues)

---

## 🛠️ Tools & Technologies

* Python (Pandas, NumPy)
* PostgreSQL
* SQL
* Jupyter Notebook

---

## 🚀 Future Improvements

* Add Power BI dashboard
* Create star schema model
* Build automated ETL pipeline
* Add predictive analytics (ML model)

---

## 📌 Conclusion

This project demonstrates an end-to-end data analysis workflow:

* Raw data → Cleaned data → SQL insights

It reflects real-world challenges and solutions in data analytics, making it a strong foundation for advanced projects.

---

## 💡 Author

Nitin Pandey
Aspiring Data Analyst
