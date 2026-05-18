USE EVPopulationDB;
GO

/* ============================================================
   Electric Vehicle Population Analysis
   Dataset: Washington State EV Population
   Tool: SQL Server Management Studio
   Table: dbo.ev_population
   ============================================================ */


-- 1. How big is the dataset?
-- This gives a quick overview of records, brands, models, locations, and EV types.

SELECT
    COUNT(*) AS total_ev_records,
    COUNT(DISTINCT make) AS unique_makes,
    COUNT(DISTINCT model) AS unique_models,
    COUNT(DISTINCT county) AS unique_counties,
    COUNT(DISTINCT city) AS unique_cities,
    COUNT(DISTINCT electric_vehicle_type) AS ev_types
FROM dbo.ev_population;


-- 2. Which EV manufacturers are most common?
-- This shows the top EV brands by number of registered vehicles.

SELECT TOP 10
    make,
    COUNT(*) AS vehicle_count
FROM dbo.ev_population
GROUP BY make
ORDER BY vehicle_count DESC;


-- 3. Which EV models are most common?
-- This gives a more detailed view by combining manufacturer and model.

SELECT TOP 10
    make,
    model,
    COUNT(*) AS vehicle_count
FROM dbo.ev_population
GROUP BY make, model
ORDER BY vehicle_count DESC;


-- 4. What is the split between BEV and PHEV vehicles?
-- BEV = Battery Electric Vehicle
-- PHEV = Plug-in Hybrid Electric Vehicle

SELECT
    electric_vehicle_type,
    COUNT(*) AS vehicle_count,
    ROUND(
        COUNT(*) * 100.0 / (SELECT COUNT(*) FROM dbo.ev_population),
        2
    ) AS percentage_share
FROM dbo.ev_population
GROUP BY electric_vehicle_type
ORDER BY vehicle_count DESC;


-- 5. How does EV count vary by model year?
-- Model year is not the same as registration year, but it shows how newer EV models appear in the population.

SELECT
    model_year,
    COUNT(*) AS vehicle_count
FROM dbo.ev_population
WHERE model_year IS NOT NULL
GROUP BY model_year
ORDER BY model_year;


-- 6. How does EV count vary by recent model years?
-- This removes very old model years and makes the recent trend easier to read.

SELECT
    model_year,
    COUNT(*) AS vehicle_count
FROM dbo.ev_population
WHERE model_year >= 2010
GROUP BY model_year
ORDER BY model_year;


-- 7. Which counties have the most registered EVs?
-- This shows the geographic concentration of EV registrations at county level.

SELECT TOP 10
    county,
    COUNT(*) AS vehicle_count
FROM dbo.ev_population
WHERE county IS NOT NULL
GROUP BY county
ORDER BY vehicle_count DESC;


-- 8. Which cities have the most registered EVs?
-- This gives a more local view than county-level analysis.

SELECT TOP 10
    city,
    county,
    COUNT(*) AS vehicle_count
FROM dbo.ev_population
WHERE city IS NOT NULL
GROUP BY city, county
ORDER BY vehicle_count DESC;


-- 9. Which manufacturers have the highest average electric range?
-- Electric range = 0 is excluded because many public records use 0 when range is missing or unavailable.
-- Only makes with at least 100 vehicles are included to avoid very small groups.

SELECT TOP 10
    make,
    COUNT(*) AS vehicle_count,
    ROUND(AVG(electric_range), 1) AS average_electric_range
FROM dbo.ev_population
WHERE electric_range > 0
GROUP BY make
HAVING COUNT(*) >= 100
ORDER BY average_electric_range DESC;


-- 10. What are the CAFV eligibility categories?
-- CAFV = Clean Alternative Fuel Vehicle eligibility.

SELECT
    clean_alternative_fuel_vehicle_cafv_eligibility AS cafv_eligibility,
    COUNT(*) AS vehicle_count
FROM dbo.ev_population
GROUP BY clean_alternative_fuel_vehicle_cafv_eligibility
ORDER BY vehicle_count DESC;


-- 11. What is the EV type split in the top counties?
-- This combines location and EV type to compare BEV/PHEV distribution in high-EV counties.

SELECT
    county,
    electric_vehicle_type,
    COUNT(*) AS vehicle_count
FROM dbo.ev_population
WHERE county IN (
    SELECT TOP 5
        county
    FROM dbo.ev_population
    WHERE county IS NOT NULL
    GROUP BY county
    ORDER BY COUNT(*) DESC
)
GROUP BY county, electric_vehicle_type
ORDER BY county, vehicle_count DESC;


-- 12. How does EV type vary by model year?
-- This shows whether BEVs or PHEVs dominate across recent model years.

SELECT
    model_year,
    electric_vehicle_type,
    COUNT(*) AS vehicle_count
FROM dbo.ev_population
WHERE model_year >= 2010
GROUP BY model_year, electric_vehicle_type
ORDER BY model_year, electric_vehicle_type;


-- 13. Which utilities serve the most registered EVs?
-- Some utility names may be long, but this gives a useful infrastructure-related view.

SELECT TOP 10
    electric_utility,
    COUNT(*) AS vehicle_count
FROM dbo.ev_population
WHERE electric_utility IS NOT NULL
GROUP BY electric_utility
ORDER BY vehicle_count DESC;


-- 14. Which makes are most common in each EV type?
-- This helps compare brand presence within BEV and PHEV categories.

SELECT TOP 20
    electric_vehicle_type,
    make,
    COUNT(*) AS vehicle_count
FROM dbo.ev_population
GROUP BY electric_vehicle_type, make
ORDER BY electric_vehicle_type, vehicle_count DESC;