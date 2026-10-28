SELECT 
    e.employee_name, 
    e.position, 
    COUNT(v.record_id) AS total_visits
FROM visits v
JOIN employee e ON v.assigned_employee_id = e.assigned_employee_id
GROUP BY e.assigned_employee_id, e.employee_name, e.position
ORDER BY total_visits DESC;