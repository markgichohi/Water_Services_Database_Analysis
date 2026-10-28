SELECT 
    e.employee_name,
    COUNT(v.record_id) AS total_visits,
    COUNT(DISTINCT l.town_name) AS towns_covered
FROM visits v
JOIN employee e ON v.assigned_employee_id = e.assigned_employee_id
JOIN location l ON v.location_id = l.location_id
GROUP BY e.assigned_employee_id, e.employee_name
ORDER BY total_visits DESC;