--CREATE TABLE dim_customer AS
--SELECT DISTINCT customer_id
--FROM uber_rides;
--ALTER TABLE dim_vehicle ADD COLUMN vehicle_id SERIAL PRIMARY KEY;

--DIM_VEHICLE 
CREATE TABLE dim_vehicle AS
SELECT DISTINCT vehicle_type
FROM uber_rides;
--DIM_LOCATION

CREATE TABLE dim_location AS
SELECT DISTINCT pickup_location AS location FROM uber_rides
UNION
SELECT DISTINCT drop_location FROM uber_rides;

--DIM_DATE 
CREATE TABLE dim_date AS
SELECT DISTINCT date,
       EXTRACT(DAY FROM date) AS day,
       EXTRACT(MONTH FROM date) AS month,
       EXTRACT(YEAR FROM date) AS year,
       EXTRACT(DOW FROM date) AS day_of_week
FROM uber_rides;

CREATE TABLE fact_rides AS
SELECT 
    booking_id,
    customer_id,
    vehicle_type,
    date,
    pickup_location,
    drop_location,
    booking_value,
    ride_distance,
    estimated_loss,
    is_cancelled
FROM uber_rides;

-- FOREIGN KEY 
ALTER TABLE fact_rides
ADD COLUMN vehicle_id INT;

UPDATE fact_rides f
SET vehicle_id = d.vehicle_id
FROM dim_vehicle d
WHERE f.vehicle_type = d.vehicle_type;






