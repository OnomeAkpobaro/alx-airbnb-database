-- 1. Non-correlated subquery: Properties with average rating > 4.0
SELECT 
    p.property_id,
    p.name,
    p.location,
    p.price_per_night
FROM 
    Properties p
WHERE 
    p.property_id IN (
        SELECT 
            r.property_id
        FROM 
            Reviews r
        GROUP BY 
            r.property_id
        HAVING 
            AVG(r.rating) > 4.0
    );

-- 2. Correlated subquery: Users with more than 3 bookings
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    (SELECT COUNT(*) 
     FROM Bookings b 
     WHERE b.user_id = u.user_id) AS booking_count
FROM 
    Users u
WHERE 
    (SELECT COUNT(*) 
     FROM Bookings b 
     WHERE b.user_id = u.user_id) > 3;