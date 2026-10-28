SELECT 
    ws.type_of_water_source,
    COUNT(DISTINCT ws.source_id) AS total_sources,
    SUM(ws.Number_of_people_served) AS total_people_affected,
    ROUND(SUM(CASE WHEN wp.results = 'Contaminated: Biological' OR wp.pollutant_ppm > 0.5 THEN 1 ELSE 0 END) * 100.0 / COUNT(ws.source_id), 2) AS contamination_percentage
FROM water_source ws
LEFT JOIN well_pollution wp ON ws.source_id = wp.source_id
GROUP BY ws.type_of_water_source
ORDER BY total_people_affected DESC;