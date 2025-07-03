-- ============================
-- Performance Measurement: Users Table
-- ============================

-- Query performance BEFORE indexing
EXPLAIN ANALYZE
SELECT * FROM Users WHERE email = 'test@example.com';

EXPLAIN ANALYZE
SELECT * FROM Users WHERE created_at > NOW() - INTERVAL '30 days';

-- Create indexes
CREATE INDEX idx_users_email ON Users(email);
CREATE INDEX idx_users_created_at ON Users(created_at);

-- Query performance AFTER indexing
EXPLAIN ANALYZE
SELECT * FROM Users WHERE email = 'test@example.com';

EXPLAIN ANALYZE
SELECT * FROM Users WHERE created_at > NOW() - INTERVAL '30 days';


-- ============================
-- Performance Measurement: Properties Table
-- ============================

-- BEFORE indexing
EXPLAIN ANALYZE
SELECT * FROM Properties WHERE owner_id = 42;

EXPLAIN ANALYZE
SELECT * FROM Properties WHERE location = 'New York';

EXPLAIN ANALYZE
SELECT * FROM Properties WHERE price_per_night < 200;

-- Create indexes
CREATE INDEX idx_properties_owner_id ON Properties(owner_id);
CREATE INDEX idx_properties_location ON Properties(location);
CREATE INDEX idx_properties_price ON Properties(price_per_night);

-- AFTER indexing
EXPLAIN ANALYZE
SELECT * FROM Properties WHERE owner_id = 42;

EXPLAIN ANALYZE
SELECT * FROM Properties WHERE location = 'New York';

EXPLAIN ANALYZE
SELECT * FROM Properties WHERE price_per_night < 200;


-- ============================
-- Performance Measurement: Bookings Table
-- ============================

-- BEFORE indexing
EXPLAIN ANALYZE
SELECT * FROM Bookings WHERE user_id = 1001;

EXPLAIN ANALYZE
SELECT * FROM Bookings WHERE property_id = 555;

EXPLAIN ANALYZE
SELECT * FROM Bookings WHERE start_date >= '2025-07-01';

EXPLAIN ANALYZE
SELECT * FROM Bookings WHERE end_date <= '2025-07-15';

EXPLAIN ANALYZE
SELECT * FROM Bookings 
WHERE start_date >= '2025-07-01' AND end_date <= '2025-07-15';

-- Create indexes
CREATE INDEX idx_bookings_user_id ON Bookings(user_id);
CREATE INDEX idx_bookings_property_id ON Bookings(property_id);
CREATE INDEX idx_bookings_start_date ON Bookings(start_date);
CREATE INDEX idx_bookings_end_date ON Bookings(end_date);
CREATE INDEX idx_bookings_dates ON Bookings(start_date, end_date);

-- AFTER indexing
EXPLAIN ANALYZE
SELECT * FROM Bookings WHERE user_id = 1001;

EXPLAIN ANALYZE
SELECT * FROM Bookings WHERE property_id = 555;

EXPLAIN ANALYZE
SELECT * FROM Bookings WHERE start_date >= '2025-07-01';

EXPLAIN ANALYZE
SELECT * FROM Bookings WHERE end_date <= '2025-07-15';

EXPLAIN ANALYZE
SELECT * FROM Bookings 
WHERE start_date >= '2025-07-01' AND end_date <= '2025-07-15';


-- ============================
-- Performance Measurement: Reviews Table
-- ============================

-- BEFORE indexing
EXPLAIN ANALYZE
SELECT * FROM Reviews WHERE property_id = 777;

EXPLAIN ANALYZE
SELECT * FROM Reviews WHERE user_id = 1001;

EXPLAIN ANALYZE
SELECT * FROM Reviews WHERE rating >= 4;

-- Create indexes
CREATE INDEX idx_reviews_property_id ON Reviews(property_id);
CREATE INDEX idx_reviews_user_id ON Reviews(user_id);
CREATE INDEX idx_reviews_rating ON Reviews(rating);

-- AFTER indexing
EXPLAIN ANALYZE
SELECT * FROM Reviews WHERE property_id = 777;

EXPLAIN ANALYZE
SELECT * FROM Reviews WHERE user_id = 1001;

EXPLAIN ANALYZE
SELECT * FROM Reviews WHERE rating >= 4;


-- ============================
-- Performance Measurement: Payments Table
-- ============================

-- BEFORE indexing
EXPLAIN ANALYZE
SELECT * FROM Payments WHERE booking_id = 9999;

EXPLAIN ANALYZE
SELECT * FROM Payments WHERE payment_date >= '2025-07-01';

-- Create indexes
CREATE INDEX idx_payments_booking_id ON Payments(booking_id);
CREATE INDEX idx_payments_date ON Payments(payment_date);

-- AFTER indexing
EXPLAIN ANALYZE
SELECT * FROM Payments WHERE booking_id = 9999;

EXPLAIN ANALYZE
SELECT * FROM Payments WHERE payment_date >= '2025-07-01';
