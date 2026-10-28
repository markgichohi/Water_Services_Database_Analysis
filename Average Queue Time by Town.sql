SELECT 
    l.town_name, 
    ROUND(AVG(v.time_in_queue), 2) AS avg_queue_time
FROM visits v
JOIN location l ON v.location_id = l.location_id
GROUP BY l.town_name
ORDER BY avg_queue_time DESC;