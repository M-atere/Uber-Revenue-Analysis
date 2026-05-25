-- 1. THE INITIAL OBSERVATION
-- Identifying the highest-grossing drivers to investigate their geographic distribution.
SELECT d.driver_id, u.name, u.date_joined, u.city, d.rating, 
        COUNT(*) AS trips_made,
        ROUND(SUM(t.total_fare), 2) AS total_revenue
FROM users u
JOIN drivers d ON u.user_id = d.user_id
JOIN trips t ON d.driver_id = t.driver_id
WHERE t.status = 'completed'
GROUP BY 1,2,3,4,5
ORDER BY total_revenue DESC
LIMIT 30;

-- 2. HYPOTHESIS 1: MARKET SATURATION ANALYSIS (SUPPLY)
-- Counting active drivers in each city to assess market competition.
SELECT u.city, COUNT(*) AS drivers
FROM users u
JOIN drivers d ON d.user_id = u.user_id
WHERE d.is_active = 1
GROUP BY 1
ORDER BY drivers DESC;

-- 3. HYPOTHESIS 1: MARKET DEMAND ANALYSIS (DEMAND)
-- Counting the rider population to identify customer density.
SELECT u.city, COUNT(*) AS riders
FROM users u
JOIN riders r ON r.user_id = u.user_id
GROUP BY 1
ORDER BY riders DESC;

-- 4. HYPOTHESIS 2: SPATIAL ECONOMICS ANALYSIS (CITY LEVEL)
-- Determining if aggregate trip distance and city size correlate directly with market revenue.
SELECT u.city, 
        COUNT(*) AS trips_made, 
        ROUND(SUM(t.distance_km), 2) AS total_distance,
        ROUND(SUM(t.total_fare), 2) AS total_revenue
FROM users u
JOIN drivers d ON u.user_id = d.user_id
JOIN trips t ON d.driver_id = t.driver_id
WHERE t.status = 'completed'
GROUP BY 1
ORDER BY total_distance DESC;

-- 5. HYPOTHESIS 2: SPATIAL ECONOMICS ANALYSIS (DRIVER LEVEL)
-- Evaluating if individual top earners are also the ones driving the furthest distances.
SELECT d.driver_id, u.name, u.city, 
        COUNT(*) AS trips_made, 
        ROUND(SUM(t.distance_km), 2) AS total_distance,
        ROUND(SUM(t.total_fare), 2) AS total_revenue
FROM users u
JOIN drivers d ON u.user_id = d.user_id
JOIN trips t ON d.driver_id = t.driver_id
WHERE t.status = 'completed'
GROUP BY 1,2,3
ORDER BY total_distance DESC;

-- 6. ADVANCED REFACTORING: CREATING A DATA VIEW
-- Persisting the driver distance metric to allow for deeper secondary analysis without rewriting joins.
CREATE VIEW driver_distance AS 
SELECT d.driver_id, u.name, u.city, 
        COUNT(*) AS trips_made, 
        ROUND(SUM(t.distance_km), 2) AS total_distance,
        ROUND(SUM(t.total_fare), 2) AS total_revenue
FROM users u
JOIN drivers d ON u.user_id = d.user_id
JOIN trips t ON d.driver_id = t.driver_id
WHERE t.status = 'completed'
GROUP BY 1,2,3;

-- 7. THE CLOSING ARGUMENT: TRIP EFFICIENCY (AVERAGE DISTANCE)
-- Calculating average distance per trip to prove the geographic scale advantage of sprawling cities.
SELECT city, 
       SUM(trips_made) AS total_trips, 
       SUM(total_distance) AS aggregate_distance,
       ROUND((SUM(total_distance)/SUM(trips_made)), 2) AS avg_dst,
       SUM(total_revenue) AS aggregate_revenue
FROM driver_distance
GROUP BY city
ORDER BY aggregate_distance DESC;
