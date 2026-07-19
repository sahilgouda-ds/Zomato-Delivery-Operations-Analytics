-- ZOMATO BUSINESS QUERIES / ANALYSIS  -- 

-- 1] CITY WISE DELIVERY PERFORMANCE 
--Which City Type has the highest average delivery time -- 

SELECT city , 
ROUND(AVG(CAST( time_taken_min as NUMERIC )) , 2 ) AS Avg_Delivery_Time
from orders 
where time_taken_min is not null 
group by city 
order by avg_delivery_time desc ; 

select*from orders ; 

--2] WEATHER IMPACT 
-- HOW DOES THE WEATHER CONDITION AFFECTS THE DELIVERY TIME ? -- 

select weather_conditions , 
ROUND(AVG(CAST( time_taken_min as NUMERIC )) , 2 ) AS Avg_Delivery_Time , 
count(*) as total_orders 
from orders 
group by weather_conditions 
order by avg_delivery_time desc ; 

3] -- TRAFFIC IMPACT -- 
-- HOW DOES ROAD TRAFFIC DENSITY AFFECTS AVG DELIVERY TIME -- 

SELECT road_traffic_density,
ROUND(AVG(CAST(time_taken_min AS NUMERIC)), 2) AS avg_delivery_time,
COUNT(*) AS total_orders
FROM orders
WHERE road_traffic_density IS NOT NULL 
  AND road_traffic_density != 'NaN'
GROUP BY road_traffic_density
ORDER BY avg_delivery_time DESC;

4] --FESTIVAL VS NORMAL DAYS -- 
-- How Different is delivery time on festivals vs normal days ? -- 

select festival , 
ROUND(AVG(CAST( time_taken_min as NUMERIC )) , 2 ) AS Avg_Delivery_Time , 
count(*) as total_orders 
from orders 
where festival is not null 
group by festival ;

5]-- VEHICLE TYPE PERFORMANCE -- 
-- which vehicle type delivers fastest on average -- 

select  type_of_vehicle , 
ROUND(AVG(CAST( time_taken_min as NUMERIC )) , 2 ) AS Avg_Delivery_Time , 
count(*) as total_orders 
from orders 
where type_of_vehicle is not null 
group by type_of_vehicle 
order by avg_delivery_time desc ; 

6] -- AGE VS RATING CORELATION -- 
 -- Is there a pattern between a delivery person's age and their rating -- 

SELECT	
a.delivery_person_age,
ROUND(AVG(CAST(a.delivery_person_ratings	AS	NUMERIC)),	2)	AS	avg_rating,
COUNT(o.id)	AS	total_deliveries
FROM	delivery_agents	a
JOIN	orders	o	ON	a.delivery_person_id	=	o.delivery_person_id
WHERE	a.delivery_person_age	~	'^[0-9]+$'
AND	a.delivery_person_ratings	~	'^[0-9.]+$'
GROUP	BY	a.delivery_person_age
ORDER	BY	a.delivery_person_age::INT;

--Q7.	Multiple	Deliveries	Impact
--How	do	multiple	deliveries	in	one	trip	affect	delivery	time?

SELECT	
multiple_deliveries,
ROUND(AVG(CAST(time_taken_min	AS	NUMERIC)),	2)	AS	avg_delivery_time,
COUNT(*)	AS	total_orders
FROM	orders
WHERE	multiple_deliveries	~	'^[0-9]+$'
GROUP	BY	multiple_deliveries
ORDER	BY	multiple_deliveries; 

--Q8.	Top	10	Performers	(JOIN)
-- Who	are	the	top	10	delivery	persons	by	rating,	and	what’s	their	average	delivery	time?

SELECT	
a.delivery_person_id,
ROUND(AVG(CAST(a.delivery_person_ratings	AS	NUMERIC)),	2)	AS	avg_rating,
ROUND(AVG(CAST(o.time_taken_min	AS	NUMERIC)),	2)	AS	avg_delivery_time,
COUNT(o.id)	AS	total_deliveries
FROM	delivery_agents	a
JOIN	orders	o	ON	a.delivery_person_id	=	o.delivery_person_id
WHERE	a.delivery_person_ratings	~	'^[0-9.]+$'
GROUP	BY	a.delivery_person_id
ORDER	BY	avg_rating	DESC
LIMIT	10 ;


-- Q9.	Order	Type	Delays
--Which	order	type	(Snack	/	Meal	/	Drinks	/	Buffet)	has	the	most	delay?

SELECT	
type_of_order,
ROUND(AVG(CAST(time_taken_min	AS	NUMERIC)),	2)	AS	avg_delivery_time,
COUNT(*)	AS	total_orders
FROM	orders
WHERE	type_of_order	IS	NOT	NULL
GROUP	BY	type_of_order
ORDER	BY	avg_delivery_time	DESC ; 

-- Q10.	City	+	Traffic	Combined
-- Which	combination	of	city	and	traffic	density	results	in	the	slowest	deliveries

SELECT	
city,
road_traffic_density,
ROUND(AVG(CAST(time_taken_min	AS	NUMERIC)),	2)	AS	avg_delivery_time,
COUNT(*)	AS	total_orders
FROM	orders
WHERE	city	IS	NOT	NULL	
AND	road_traffic_density	IS	NOT	NULL
GROUP	BY	city,	road_traffic_density
ORDER	BY	avg_delivery_time	DESC
LIMIT	10 ; 

--	Q11.	Best	Rated	Agent	Per	City	
 -- Who	is	the	highest-rated	delivery	agent	in	each	city?	

 SELECT	city,	delivery_person_id,	avg_rating
FROM	(
SELECT	
o.city,
a.delivery_person_id,
ROUND(AVG(CAST(a.delivery_person_ratings	AS	NUMERIC)),	2)	AS	avg_rating,
RANK()	OVER	(PARTITION	BY	o.city	ORDER	BY	AVG(CAST(a.delivery_person_ratings	AS	NUMERIC))	
DESC)	AS	rnk
FROM	delivery_agents	a
JOIN	orders	o	ON	a.delivery_person_id	=	o.delivery_person_id
WHERE	a.delivery_person_ratings	~	'^[0-9.]+$'
AND	o.city	IS	NOT	NULL
GROUP	BY	o.city,	a.delivery_person_id
)	ranked
WHERE	rnk	=	1 ; 