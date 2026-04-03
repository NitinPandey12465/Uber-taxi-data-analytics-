--BASIC ANALYTICS
--TOTAL REVENUE 
SELECT SUM(booking_value) AS total_revenue
FROM uber_rides
WHERE final_status= 'Completed';
--TOTAL RIDES
SELECT COUNT(*) FROM  uber_rides
-- CANCELLATION RATE 
SELECT COUNT(*)FILTER (WHERE final_status='Cancelled')*100.0/count(*) as Cancellation_rate
from uber_rides;
--AVERAGE RIDE DISTANCE 
SELECT AVG(ride_distance)
FROM uber_rides
WHERE final_status = 'Completed';