## Task 4: Optimize Complex Queries

### perfomance.sql

-- Initial complex query (before optimization)
-- This query retrieves all bookings along with user details, property details, and payment details
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    p.property_id,
    p.name AS property_name,
    p.location,
    p.price_per_night,
    pay.payment_id,
    pay.amount,
    pay.payment_date,
    pay.payment_method
FROM 
    Bookings b
INNER JOIN 
    Users u ON b.user_id = u.user_id
INNER JOIN 
    Properties p ON b.property_id = p.property_id
LEFT JOIN 
    Payments pay ON b.booking_id = pay.booking_id
WHERE 
    b.booking_id IS NOT NULL
    AND u.user_id IS NOT NULL
    AND p.property_id IS NOT NULL
ORDER BY 
    b.created_at DESC;

-- Analyze the query performance using EXPLAIN
EXPLAIN SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    p.property_id,
    p.name AS property_name,
    p.location,
    p.price_per_night,
    pay.payment_id,
    pay.amount,
    pay.payment_date,
    pay.payment_method
FROM 
    Bookings b
INNER JOIN 
    Users u ON b.user_id = u.user_id
INNER JOIN 
    Properties p ON b.property_id = p.property_id
LEFT JOIN 
    Payments pay ON b.booking_id = pay.booking_id
WHERE 
    b.booking_id IS NOT NULL
    AND u.user_id IS NOT NULL
    AND p.property_id IS NOT NULL
ORDER BY 
    b.created_at DESC;

-- Optimized query after identifying inefficiencies
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    p.property_id,
    p.name AS property_name,
    p.location,
    p.price_per_night,
    pay.payment_id,
    pay.amount,
    pay.payment_date,
    pay.payment_method
FROM 
    Bookings b
    STRAIGHT_JOIN Users u ON b.user_id = u.user_id
    STRAIGHT_JOIN Properties p ON b.property_id = p.property_id
    LEFT JOIN Payments pay ON b.booking_id = pay.booking_id
WHERE 
    b.created_at >= DATE_SUB(CURRENT_DATE, INTERVAL 1 YEAR)
    AND b.user_id IS NOT NULL
    AND b.property_id IS NOT NULL
ORDER BY 
    b.booking_id DESC
LIMIT 1000;

-- EXPLAIN for optimized query to compare performance
EXPLAIN SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    p.property_id,
    p.name AS property_name,
    p.location,
    p.price_per_night,
    pay.payment_id,
    pay.amount,
    pay.payment_date,
    pay.payment_method
FROM 
    Bookings b
    STRAIGHT_JOIN Users u ON b.user_id = u.user_id
    STRAIGHT_JOIN Properties p ON b.property_id = p.property_id
    LEFT JOIN Payments pay ON b.booking_id = pay.booking_id
WHERE 
    b.created_at >= DATE_SUB(CURRENT_DATE, INTERVAL 1 YEAR)
    AND b.user_id IS NOT NULL
    AND b.property_id IS NOT NULL
ORDER BY 
    b.booking_id DESC
LIMIT 1000;