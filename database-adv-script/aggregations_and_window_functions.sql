-- 1. Total bookings per user using COUNT and GROUP BY
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    COUNT(b.booking_id) AS total_bookings
FROM 
    Users u
LEFT JOIN 
    Bookings b ON u.user_id = b.user_id
GROUP BY 
    u.user_id, u.first_name, u.last_name
ORDER BY 
    total_bookings DESC;

-- 2. Rank properties by total bookings using window functions
WITH PropertyBookings AS (
    SELECT 
        p.property_id,
        p.name,
        p.location,
        COUNT(b.booking_id) AS total_bookings
    FROM 
        Properties p
    LEFT JOIN 
        Bookings b ON p.property_id = b.property_id
    GROUP BY 
        p.property_id, p.name, p.location
)
SELECT 
    property_id,
    name,
    location,
    total_bookings,
    ROW_NUMBER() OVER (ORDER BY total_bookings DESC) AS row_num,
    RANK() OVER (ORDER BY total_bookings DESC) AS rank,
    DENSE_RANK() OVER (ORDER BY total_bookings DESC) AS dense_rank
FROM 
    PropertyBookings;