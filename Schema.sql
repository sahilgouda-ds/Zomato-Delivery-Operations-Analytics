DROP TABLE IF EXISTS deliveries;

CREATE TABLE deliveries (
    id VARCHAR(10),
    delivery_person_id VARCHAR(20),
    delivery_person_age VARCHAR(10),
    delivery_person_ratings VARCHAR(10),
    restaurant_latitude NUMERIC(10,6),
    restaurant_longitude NUMERIC(10,6),
    delivery_location_latitude NUMERIC(10,6),
    delivery_location_longitude NUMERIC(10,6),
    order_date VARCHAR(15),
    time_orderd VARCHAR(10),
    time_order_picked VARCHAR(10),
    weather_conditions VARCHAR(20),
    road_traffic_density VARCHAR(20),
    vehicle_condition VARCHAR(10),
    type_of_order VARCHAR(20),
    type_of_vehicle VARCHAR(20),
    multiple_deliveries VARCHAR(10),
    festival VARCHAR(5),
    city VARCHAR(20),
    time_taken_min VARCHAR(10)
);

TRUNCATE TABLE deliveries;

ALTER TABLE deliveries ALTER COLUMN time_orderd TYPE VARCHAR(30);
ALTER TABLE deliveries ALTER COLUMN time_order_picked TYPE VARCHAR(30);

-- Table 1: Delivery agents info 
CREATE TABLE delivery_agents AS
SELECT DISTINCT delivery_person_id, delivery_person_age, delivery_person_ratings
FROM deliveries;

-- Table 2: Orders info 
CREATE TABLE orders AS
SELECT id, delivery_person_id, order_date, time_orderd, time_order_picked,
       type_of_order, type_of_vehicle, weather_conditions, 
       road_traffic_density, vehicle_condition, multiple_deliveries,
       festival, city, time_taken_min
FROM deliveries;

SELECT COUNT(*) FRPM DELIV
SELECT COUNT(*) FROM orders;