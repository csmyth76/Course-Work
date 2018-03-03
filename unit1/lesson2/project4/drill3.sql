-- Return a list of stations with a count of number of 
-- trips starting at that station but ordered by dock count.
SELECT
	start_station,
	dockcount,
	COUNT(*) as 'Trips Started'
FROM 
	trips
JOIN 
	stations
ON 
	stations.name=trips.start_station
GROUP BY 1, 2
order by dockcount DESC
	
