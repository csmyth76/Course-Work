-- Which station is full most often?
SELECT 
	stations.name,
	COUNT (CASE WHEN docks_available=0 THEN 1 END) full_count
FROM 
	status
JOIN 
	stations
ON
	status.station_id = stations.station_id
GROUP BY 1
ORDER BY full_count DESC
	
