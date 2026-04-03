--GROUPED ANALYSIS 
--1) RIDE BY VEHICLE TYPE 
SELECT vehicle_type, COUNT(*)
FROM uber_rides
GROUP BY vehicle_type
ORDER BY COUNT(*) DESC;
--2) TOP PICKUP LOCATION
SELECT pickup_location, COUNT(*)
FROM uber_rides
GROUP BY pickup_location
ORDER BY COUNT(*) DESC
LIMIT 10;
--3)PAYMENT METHOD ANALYSIS
SELECT payment_method, COUNT(*)
FROM uber_rides
GROUP BY payment_method;
--4) CANCELLATION REASON
SELECT cancellation_reason,COUNT(*)
FROM uber_rides
WHERE final_status='Cancelled'
GROUP BY cancellation_reason
ORDER BY COUNT(*) DESC;
--5)
SELECT 
    vehicle_type,
    COUNT(*) AS total_rides,
    AVG(booking_value) AS avg_fare,
    AVG(ride_distance) AS avg_distance
FROM uber_rides
WHERE final_status = 'Completed'
GROUP BY vehicle_type
ORDER BY total_rides DESC;