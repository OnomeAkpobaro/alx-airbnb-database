-- ====================================================================
-- ALX AIRBNB DATABASE SCHEMA (DDL)
-- ====================================================================
-- This script creates the complete database schema for the ALX Airbnb
-- application, including all tables, constraints, and indexes.
-- ====================================================================

-- Create database (uncomment if needed)
-- CREATE DATABASE IF NOT EXISTS alx_airbnb;
-- USE alx_airbnb;

-- ====================================================================
-- 1. USER TABLE
-- ====================================================================
CREATE TABLE User (
    user_id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20) NULL,
    role ENUM('guest', 'host', 'admin') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Indexes
    INDEX idx_user_email (email),
    INDEX idx_user_role (role)
);

-- ====================================================================
-- 2. PROPERTY TABLE
-- ====================================================================
CREATE TABLE Property (
    property_id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    host_id CHAR(36) NOT NULL,
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR(255) NOT NULL,
    price_per_night DECIMAL(10, 2) NOT NULL CHECK (price_per_night > 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    -- Foreign Key Constraints
    FOREIGN KEY (host_id) REFERENCES User(user_id) ON DELETE CASCADE ON UPDATE CASCADE,
    
    -- Indexes
    INDEX idx_property_host_id (host_id),
    INDEX idx_property_location (location),
    INDEX idx_property_price (price_per_night)
);

-- ====================================================================
-- 3. BOOKING TABLE
-- ====================================================================
CREATE TABLE Booking (
    booking_id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    property_id CHAR(36) NOT NULL,
    user_id CHAR(36) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL CHECK (total_price > 0),
    status ENUM('pending', 'confirmed', 'canceled') NOT NULL DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Check Constraints
    CHECK (end_date > start_date),
    
    -- Foreign Key Constraints
    FOREIGN KEY (property_id) REFERENCES Property(property_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (user_id) REFERENCES User(user_id) ON DELETE CASCADE ON UPDATE CASCADE,
    
    -- Indexes
    INDEX idx_booking_property_id (property_id),
    INDEX idx_booking_user_id (user_id),
    INDEX idx_booking_dates (start_date, end_date),
    INDEX idx_booking_status (status)
);

-- ====================================================================
-- 4. PAYMENT TABLE
-- ====================================================================
CREATE TABLE Payment (
    payment_id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    booking_id CHAR(36) UNIQUE NOT NULL,
    amount DECIMAL(10, 2) NOT NULL CHECK (amount > 0),
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method ENUM('credit_card', 'paypal', 'stripe') NOT NULL,
    
    -- Foreign Key Constraints
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id) ON DELETE CASCADE ON UPDATE CASCADE,
    
    -- Indexes
    INDEX idx_payment_booking_id (booking_id),
    INDEX idx_payment_method (payment_method),
    INDEX idx_payment_date (payment_date)
);

-- ====================================================================
-- 5. REVIEW TABLE
-- ====================================================================
CREATE TABLE Review (
    review_id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    property_id CHAR(36) NOT NULL,
    user_id CHAR(36) NOT NULL,
    rating INTEGER NOT NULL CHECK (rating >= 1 AND rating <= 5),
    comment TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Foreign Key Constraints
    FOREIGN KEY (property_id) REFERENCES Property(property_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (user_id) REFERENCES User(user_id) ON DELETE CASCADE ON UPDATE CASCADE,
    
    -- Composite Index to prevent duplicate reviews from same user for same property
    UNIQUE KEY unique_user_property_review (user_id, property_id),
    
    -- Indexes
    INDEX idx_review_property_id (property_id),
    INDEX idx_review_user_id (user_id),
    INDEX idx_review_rating (rating),
    INDEX idx_review_created_at (created_at)
);

-- ====================================================================
-- 6. MESSAGE TABLE
-- ====================================================================
CREATE TABLE Message (
    message_id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    sender_id CHAR(36) NOT NULL,
    recipient_id CHAR(36) NOT NULL,
    message_body TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Check Constraints
    CHECK (sender_id != recipient_id),
    
    -- Foreign Key Constraints
    FOREIGN KEY (sender_id) REFERENCES User(user_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (recipient_id) REFERENCES User(user_id) ON DELETE CASCADE ON UPDATE CASCADE,
    
    -- Indexes
    INDEX idx_message_sender_id (sender_id),
    INDEX idx_message_recipient_id (recipient_id),
    INDEX idx_message_sent_at (sent_at),
    INDEX idx_message_conversation (sender_id, recipient_id, sent_at)
);

-- ====================================================================
-- ADDITIONAL PERFORMANCE OPTIMIZATIONS
-- ====================================================================

-- Composite indexes for common query patterns
CREATE INDEX idx_booking_property_dates ON Booking(property_id, start_date, end_date);
CREATE INDEX idx_booking_user_status ON Booking(user_id, status);
CREATE INDEX idx_property_host_price ON Property(host_id, price_per_night);

-- ====================================================================
-- DATABASE VIEWS FOR COMMON QUERIES
-- ====================================================================

-- View for property listings with host information
CREATE VIEW PropertyListings AS
SELECT 
    p.property_id,
    p.name AS property_name,
    p.description,
    p.location,
    p.price_per_night,
    CONCAT(u.first_name, ' ', u.last_name) AS host_name,
    u.email AS host_email,
    p.created_at,
    p.updated_at
FROM Property p
INNER JOIN User u ON p.host_id = u.user_id
WHERE u.role = 'host';

-- View for booking details with user and property information
CREATE VIEW BookingDetails AS
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    p.name AS property_name,
    p.location AS property_location,
    CONCAT(guest.first_name, ' ', guest.last_name) AS guest_name,
    guest.email AS guest_email,
    CONCAT(host.first_name, ' ', host.last_name) AS host_name,
    b.created_at AS booking_created_at
FROM Booking b
INNER JOIN Property p ON b.property_id = p.property_id
INNER JOIN User guest ON b.user_id = guest.user_id
INNER JOIN User host ON p.host_id = host.user_id;

-- View for property reviews with ratings
CREATE VIEW PropertyReviews AS
SELECT 
    r.review_id,
    r.property_id,
    p.name AS property_name,
    r.rating,
    r.comment,
    CONCAT(u.first_name, ' ', u.last_name) AS reviewer_name,
    r.created_at AS review_date
FROM Review r
INNER JOIN Property p ON r.property_id = p.property_id
INNER JOIN User u ON r.user_id = u.user_id
ORDER BY r.created_at DESC;

-- ====================================================================
-- TRIGGERS FOR DATA INTEGRITY AND AUTOMATION
-- ====================================================================

-- Trigger to automatically update property updated_at timestamp
DELIMITER //
CREATE TRIGGER update_property_timestamp
    BEFORE UPDATE ON Property
    FOR EACH ROW
BEGIN
    SET NEW.updated_at = CURRENT_TIMESTAMP;
END//
DELIMITER ;

-- Trigger to validate booking dates don't overlap for same property
DELIMITER //
CREATE TRIGGER validate_booking_overlap
    BEFORE INSERT ON Booking
    FOR EACH ROW
BEGIN
    DECLARE overlap_count INT;
    
    SELECT COUNT(*) INTO overlap_count
    FROM Booking
    WHERE property_id = NEW.property_id
      AND status IN ('confirmed', 'pending')
      AND (
          (NEW.start_date BETWEEN start_date AND end_date)
          OR (NEW.end_date BETWEEN start_date AND end_date)
          OR (start_date BETWEEN NEW.start_date AND NEW.end_date)
      );
    
    IF overlap_count > 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Booking dates overlap with existing booking';
    END IF;
END//
DELIMITER ;

-- ====================================================================
-- STORED PROCEDURES FOR COMMON OPERATIONS
-- ====================================================================

-- Procedure to get available properties for date range
DELIMITER //
CREATE PROCEDURE GetAvailableProperties(
    IN search_start_date DATE,
    IN search_end_date DATE,
    IN search_location VARCHAR(255)
)
BEGIN
    SELECT DISTINCT
        p.property_id,
        p.name,
        p.description,
        p.location,
        p.price_per_night,
        CONCAT(u.first_name, ' ', u.last_name) AS host_name
    FROM Property p
    INNER JOIN User u ON p.host_id = u.user_id
    WHERE (search_location IS NULL OR p.location LIKE CONCAT('%', search_location, '%'))
      AND p.property_id NOT IN (
          SELECT DISTINCT b.property_id
          FROM Booking b
          WHERE b.status IN ('confirmed', 'pending')
            AND (
                (search_start_date BETWEEN b.start_date AND b.end_date)
                OR (search_end_date BETWEEN b.start_date AND b.end_date)
                OR (b.start_date BETWEEN search_start_date AND search_end_date)
            )
      );
END//
DELIMITER ;

-- ====================================================================
-- PERFORMANCE ANALYSIS QUERIES
-- ====================================================================

-- Query to analyze table sizes (uncomment to use)
/*
SELECT 
    TABLE_NAME,
    TABLE_ROWS,
    ROUND(((DATA_LENGTH + INDEX_LENGTH) / 1024 / 1024), 2) AS 'Size (MB)'
FROM information_schema.TABLES 
WHERE TABLE_SCHEMA = DATABASE()
ORDER BY (DATA_LENGTH + INDEX_LENGTH) DESC;
*/

-- ====================================================================
-- END OF SCHEMA CREATION
-- ====================================================================

-- Show all created tables
SHOW TABLES;

-- Verify foreign key constraints
SELECT 
    TABLE_NAME,
    COLUMN_NAME,
    CONSTRAINT_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM information_schema.KEY_COLUMN_USAGE
WHERE REFERENCED_TABLE_SCHEMA = DATABASE()
ORDER BY TABLE_NAME, COLUMN_NAME;