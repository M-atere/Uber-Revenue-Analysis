/* 
1. TOP 25 EARNING DRIVERS
Goal: Identify the highest-grossing drivers across all cities.
*/
SELECT 
    u.name, 
    u.date_joined, 
    u.city, 
    d.rating, 
    COUNT(*) AS trips_made,
    ROUND(SUM(t.total_fare), 2) AS total_revenue
FROM users u
JOIN drivers d ON u.user_id = d.user_id
JOIN trips t ON d.driver_id = t.driver_id
WHERE t.status = 'completed'
GROUP BY 1, 2, 3, 4
ORDER BY total_revenue DESC
LIMIT 25;

/* 
2. REVENUE & TRIP VOLUME BY CITY
Goal: Compare city-wide performance for drivers.
*/
SELECT 
    u.city,
    COUNT(*) AS trips_made,
    ROUND(SUM(t.total_fare), 2) AS total_revenue
FROM users u
JOIN drivers d ON u.user_id = d.user_id
JOIN trips t ON d.driver_id = t.driver_id
WHERE t.status = 'completed'
GROUP BY 1
ORDER BY total_revenue DESC;

/* 
3. RIDER POPULATION BY CITY
Goal: Analyze rider demand distribution.
*/
SELECT 
    u.city, 
    COUNT(*) AS riders
FROM users u
JOIN riders r ON r.user_id = u.user_id
GROUP BY 1
ORDER BY riders DESC;
