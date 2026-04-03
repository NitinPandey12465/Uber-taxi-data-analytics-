--TIME BASED ANALYSIS 
--1)RIDES PER DAY 
SELECT date, COUNT(*)
FROM uber_rides
GROUP BY date
ORDER BY date;
--2)PEAK HOUR 
SELECT EXTRACT(HOUR FROM time) AS hour, COUNT(*)
FROM uber_rides
GROUP BY hour
ORDER BY COUNT(*) DESC;
--3) MONTHLY REVENUE 
SELECT DATE_TRUNC('month', date) AS month,
       SUM(booking_value)
FROM uber_rides
WHERE final_status = 'Completed'
GROUP BY month;
--4) WEEKDAYS VS WEEKENDS ANALYSIS 
SELECT 
    CASE 
        WHEN EXTRACT(DOW FROM date) IN (0,6) THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type,
    COUNT(*)
FROM uber_rides
GROUP BY day_type;
--5)PEAL DAY + HOUR
SELECT 
    EXTRACT(DOW FROM date) AS day,
    EXTRACT(HOUR FROM time) AS hour,
    COUNT(*) AS rides
FROM uber_rides
GROUP BY day, hour
ORDER BY rides DESC
LIMIT 10;

--ADVANCED SQL 
--1) TOP CUSTOMERS
SELECT customer_id, COUNT(*) AS rides,
       RANK() OVER (ORDER BY COUNT(*) DESC) AS rank
FROM uber_rides
GROUP BY customer_id;

--2)RUNNING TOTAL 
SELECT 
    date,
    SUM(booking_value) OVER (ORDER BY date) AS running_revenue
FROM uber_rides
WHERE final_status = 'Completed';
--3) PARRTITION BY 
SELECT 
    vehicle_type,
    booking_value,
    AVG(booking_value) OVER (PARTITION BY vehicle_type) AS avg_vehicle_fare
FROM uber_rides;
--4)LAG FUNCTION 
SELECT 
    vehicle_type,
    booking_value,
    AVG(booking_value) OVER (PARTITION BY vehicle_type) AS avg_vehicle_fare
FROM uber_rides;
--5) TOP VEHICLE PERFORMANCE 
SELECT 
    vehicle_type,
    AVG(booking_value) AS avg_revenue,
    RANK() OVER (ORDER BY AVG(booking_value) DESC) AS rank
FROM uber_rides
GROUP BY vehicle_type;




