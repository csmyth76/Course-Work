-- What are the three longest trips on rainy days?

-- Collect days with rain
WITH 
	rainydays
AS (
	SELECT 
		date,
		events
	FROM 
		weather
	WHERE 
		events LIKE 'rain'
),

-- collect start days with rain
rainy_start_days
AS
(
	SELECT 
		trips.trip_id as start_trip_id,
		-- get rid of timestamp in date string
		substr(start_date, 1, 10) as start_date_sub, 
		rainydays.events, 
		duration as start_duration
	FROM 
		trips
	-- filter out any non-rainy days
	LEFT JOIN 
		rainydays
	ON
		rainydays.date = start_date_sub
),
-- collect end days with rain (longest trips are over two days, want both days with rain
rainy_end_days
AS
(
	SELECT 
		trips.trip_id as end_trip_id,
		-- get rid of timestamp in date string
		substr(end_date, 1, 10) as end_date_sub,
		rainydays.events, 
		duration as end_duration
	FROM 
		trips
	-- filter out any non-rainy days
	LEFT JOIN 
		rainydays
	ON
		rainydays.date = end_date_sub
)
-- grab the longest trips with rain on both days
SELECT 
	end_trip_id,
	start_date_sub as 'Start Date',
	end_date_sub as 'End Date',
	end_duration as 'Duration'
FROM 
	rainy_end_days
JOIN 
	rainy_start_days
ON 
	start_trip_id = end_trip_id
ORDER BY end_duration DESC
LIMIT 3
