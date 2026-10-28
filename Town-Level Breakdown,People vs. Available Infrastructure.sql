SELECT 
    l.town_name,
    l.province_name,
    COUNT(DISTINCT l.location_id) AS total_locations_visited,
    SUM(ws.Number_of_people_served) AS total_population_served
FROM visits v
JOIN location l ON v.location_id = l.location_id
JOIN water_source ws ON v.source_id = ws.source_id
GROUP BY l.town_name, l.province_name
ORDER BY total_population_served DESC;