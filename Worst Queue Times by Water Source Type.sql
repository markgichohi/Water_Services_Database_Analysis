SELECT 
    ws.type_of_water_source,
    ROUND(AVG(v.time_in_queue), 1) AS avg_queue_time_mins,
    MAX(v.time_in_queue) AS max_queue_time_mins
FROM visits v
JOIN water_source ws ON v.source_id = ws.source_id
WHERE v.time_in_queue > 0 -- excludes visits where there was no queue
GROUP BY ws.type_of_water_source
ORDER BY avg_queue_time_mins DESC;