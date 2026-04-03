--ADVANCED KPI 
--1) ESTIMATED REVENUE LOSS 
SELECT SUM(estimated_loss) AS total_loss
FROM uber_rides;
--2) DRIVER PERFORMANCE 
SELECT AVG(avg_vtat)
FROM uber_rides
WHERE avg_vtat != -1;
--3) RIDE EFFICIENCY
SELECT AVG(avg_vtat)
FROM uber_rides
WHERE avg_vtat != -1;
--4) RATING ANALYSIS 
SELECT AVG(driver_rating), AVG(customer_rating)
FROM uber_rides
WHERE final_status = 'Completed';

--5) 
SELECT 
    SUM(booking_value) AS revenue,
    SUM(estimated_loss) AS loss,
    AVG(avg_vtat) FILTER (WHERE avg_vtat != -1) AS avg_vtat,
    AVG(avg_ctat) FILTER (WHERE avg_ctat != -1) AS avg_ctat,
    AVG(driver_rating) AS driver_rating,
    AVG(customer_rating) AS customer_rating
FROM uber_rides
WHERE final_status = 'Completed';