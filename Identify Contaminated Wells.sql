SELECT 
    source_id, 
    pollutant_ppm, 
    biological, 
    results
FROM well_pollution
WHERE results = 'Contaminated: Biological' OR pollutant_ppm > 0.5;