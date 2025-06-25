-- ====================================================================
-- ALX AIRBNB DATABASE SEED DATA SCRIPT
-- ====================================================================
-- This script populates the database with realistic sample data
-- simulating a real-world Airbnb-like environment
-- ====================================================================

-- Clear existing data (uncomment if needed for fresh start)
-- SET FOREIGN_KEY_CHECKS = 0;
-- TRUNCATE TABLE Message;
-- TRUNCATE TABLE Review;
-- TRUNCATE TABLE Payment;
-- TRUNCATE TABLE Booking;
-- TRUNCATE TABLE Property;
-- TRUNCATE TABLE User;
-- SET FOREIGN_KEY_CHECKS = 1;

-- ====================================================================
-- 1. SEED USER DATA
-- ====================================================================

INSERT INTO User (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at) VALUES
-- Admins
('550e8400-e29b-41d4-a716-446655440000', 'Admin', 'User', 'admin@alxairbnb.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+1234567890', 'admin', '2024-01-15 08:00:00'),

-- Hosts
('550e8400-e29b-41d4-a716-446655440001', 'Sarah', 'Johnson', 'sarah.johnson@email.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+1555123456', 'host', '2024-01-20 10:30:00'),
('550e8400-e29b-41d4-a716-446655440002', 'Michael', 'Chen', 'michael.chen@email.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+1555234567', 'host', '2024-01-25 14:15:00'),
('550e8400-e29b-41d4-a716-446655440003', 'Emma', 'Williams', 'emma.williams@email.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+1555345678', 'host', '2024-02-01 09:45:00'),
('550e8400-e29b-41d4-a716-446655440004', 'David', 'Brown', 'david.brown@email.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+1555456789', 'host', '2024-02-05 16:20:00'),
('550e8400-e29b-41d4-a716-446655440005', 'Lisa', 'Garcia', 'lisa.garcia@email.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+1555567890', 'host', '2024-02-10 11:00:00'),

-- Guests
('550e8400-e29b-41d4-a716-446655440010', 'John', 'Smith', 'john.smith@email.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+1555678901', 'guest', '2024-02-15 13:30:00'),
('550e8400-e29b-41d4-a716-446655440011', 'Emily', 'Davis', 'emily.davis@email.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+1555789012', 'guest', '2024-02-20 15:45:00'),
('550e8400-e29b-41d4-a716-446655440012', 'Robert', 'Wilson', 'robert.wilson@email.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+1555890123', 'guest', '2024-02-25 10:15:00'),
('550e8400-e29b-41d4-a716-446655440013', 'Jessica', 'Miller', 'jessica.miller@email.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+1555901234', 'guest', '2024-03-01 12:00:00'),
('550e8400-e29b-41d4-a716-446655440014', 'Christopher', 'Moore', 'chris.moore@email.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+1555012345', 'guest', '2024-03-05 14:30:00'),
('550e8400-e29b-41d4-a716-446655440015', 'Amanda', 'Taylor', 'amanda.taylor@email.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+1555123450', 'guest', '2024-03-10 16:45:00'),
('550e8400-e29b-41d4-a716-446655440016', 'Daniel', 'Anderson', 'daniel.anderson@email.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+1555234501', 'guest', '2024-03-15 09:20:00'),
('550e8400-e29b-41d4-a716-446655440017', 'Michelle', 'Thomas', 'michelle.thomas@email.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+1555345012', 'guest', '2024-03-20 11:35:00');

-- ====================================================================
-- 2. SEED PROPERTY DATA
-- ====================================================================

INSERT INTO Property (property_id, host_id, name, description, location, price_per_night, created_at, updated_at) VALUES
-- Sarah Johnson's properties
('660e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440001', 'Cozy Downtown Apartment', 'Beautiful 1-bedroom apartment in the heart of downtown with modern amenities, high-speed WiFi, and stunning city views. Perfect for business travelers and couples.', 'New York, NY', 150.00, '2024-01-21 09:00:00', '2024-01-21 09:00:00'),
('660e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440001', 'Luxury Penthouse Suite', 'Exclusive penthouse with panoramic city views, private terrace, full kitchen, and premium furnishings. Ideal for special occasions and luxury stays.', 'New York, NY', 350.00, '2024-01-22 10:30:00', '2024-01-22 10:30:00'),

-- Michael Chen's properties
('660e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440002', 'Beachfront Villa', 'Stunning 3-bedroom villa right on the beach with private access, full kitchen, WiFi, and outdoor BBQ area. Perfect for families and groups.', 'Miami, FL', 275.00, '2024-01-26 11:15:00', '2024-01-26 11:15:00'),
('660e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440002', 'Modern City Loft', 'Stylish industrial loft in trendy downtown area with exposed brick, high ceilings, and contemporary furnishings. Great for urban explorers.', 'San Francisco, CA', 200.00, '2024-01-27 14:45:00', '2024-01-27 14:45:00'),

-- Emma Williams's properties
('660e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440003', 'Mountain Cabin Retreat', 'Rustic cabin in the mountains with fireplace, hot tub, and hiking trails nearby. Perfect for nature lovers and romantic getaways.', 'Denver, CO', 180.00, '2024-02-02 08:30:00', '2024-02-02 08:30:00'),
('660e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440003', 'Historic Brownstone', 'Charming historic home with original hardwood floors, vintage details, and modern updates. Located in quiet residential neighborhood.', 'Boston, MA', 220.00, '2024-02-03 15:20:00', '2024-02-03 15:20:00'),

-- David Brown's properties
('660e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440004', 'Lakefront Cottage', 'Peaceful cottage on private lake with dock, kayaks, and fishing equipment included. Ideal for relaxing waterfront vacation.', 'Austin, TX', 160.00, '2024-02-06 12:00:00', '2024-02-06 12:00:00'),
('660e8400-e29b-41d4-a716-446655440008', '550e8400-e29b-41d4-a716-446655440004', 'Desert Oasis', 'Unique desert home with pool, spa, and stunning sunset views. Modern amenities in a serene desert setting.', 'Phoenix, AZ', 195.00, '2024-02-07 16:30:00', '2024-02-07 16:30:00'),

-- Lisa Garcia's properties
('660e8400-e29b-41d4-a716-446655440009', '550e8400-e29b-41d4-a716-446655440005', 'Wine Country Estate', 'Elegant estate in wine country with vineyard views, gourmet kitchen, and private wine cellar. Perfect for wine enthusiasts.', 'Napa Valley, CA', 400.00, '2024-02-11 13:45:00', '2024-02-11 13:45:00'),
('660e8400-e29b-41d4-a716-446655440010', '550e8400-e29b-41d4-a716-446655440005', 'Urban Studio', 'Compact but stylish studio apartment in vibrant neighborhood with easy access to restaurants, shops, and public transportation.', 'Seattle, WA', 95.00, '2024-02-12 10:15:00', '2024-02-12 10:15:00');

-- ====================================================================
-- 3. SEED BOOKING DATA
-- ====================================================================

INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at) VALUES
-- Confirmed bookings
('770e8400-e29b-41d4-a716-446655440001', '660e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440010', '2024-03-15', '2024-03-18', 450.00, 'confirmed', '2024-02-20 14:30:00'),
('770e8400-e29b-41d4-a716-446655440002', '660e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440011', '2024-04-01', '2024-04-05', 1100.00, 'confirmed', '2024-02-25 16:45:00'),
('770e8400-e29b-41d4-a716-446655440003', '660e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440012', '2024-04-10', '2024-04-12', 360.00, 'confirmed', '2024-03-01 11:20:00'),
('770e8400-e29b-41d4-a716-446655440004', '660e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440013', '2024-04-20', '2024-04-23', 480.00, 'confirmed', '2024-03-05 13:15:00'),
('770e8400-e29b-41d4-a716-446655440005', '660e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440014', '2024-05-01', '2024-05-03', 700.00, 'confirmed', '2024-03-10 15:30:00'),

-- Pending bookings
('770e8400-e29b-41d4-a716-446655440006', '660e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440015', '2024-05-15', '2024-05-17', 400.00, 'pending', '2024-03-15 09:45:00'),
('770e8400-e29b-41d4-a716-446655440007', '660e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440016', '2024-05-20', '2024-05-22', 440.00, 'pending', '2024-03-18 12:00:00'),
('770e8400-e29b-41d4-a716-446655440008', '660e8400-e29b-41d4-a716-446655440008', '550e8400-e29b-41d4-a716-446655440017', '2024-06-01', '2024-06-04', 585.00, 'pending', '2024-03-20 14:20:00'),

-- Canceled bookings
('770e8400-e29b-41d4-a716-446655440009', '660e8400-e29b-41d4-a716-446655440009', '550e8400-e29b-41d4-a716-446655440010', '2024-03-01', '2024-03-03', 800.00, 'canceled', '2024-02-15 10:30:00'),
('770e8400-e29b-41d4-a716-446655440010', '660e8400-e29b-41d4-a716-446655440010', '550e8400-e29b-41d4-a716-446655440011', '2024-03-10', '2024-03-12', 190.00, 'canceled', '2024-02-28 16:15:00'),

-- Additional confirmed bookings for more realistic data
('770e8400-e29b-41d4-a716-446655440011', '660e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440012', '2024-06-15', '2024-06-17', 300.00, 'confirmed', '2024-04-01 11:00:00'),
('770e8400-e29b-41d4-a716-446655440012', '660e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440013', '2024-07-01', '2024-07-07', 1650.00, 'confirmed', '2024-04-15 14:30:00'),
('770e8400-e29b-41d4-a716-446655440013', '660e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440014', '2024-07-15', '2024-07-20', 900.00, 'confirmed', '2024-05-01 09:15:00');

-- ====================================================================
-- 4. SEED PAYMENT DATA
-- ====================================================================

INSERT INTO Payment (payment_id, booking_id, amount, payment_date, payment_method) VALUES
-- Payments for confirmed bookings
('880e8400-e29b-41d4-a716-446655440001', '770e8400-e29b-41d4-a716-446655440001', 450.00, '2024-02-20 14:35:00', 'credit_card'),
('880e8400-e29b-41d4-a716-446655440002', '770e8400-e29b-41d4-a716-446655440002', 1100.00, '2024-02-25 16:50:00', 'stripe'),
('880e8400-e29b-41d4-a716-446655440003', '770e8400-e29b-41d4-a716-446655440003', 360.00, '2024-03-01 11:25:00', 'paypal'),
('880e8400-e29b-41d4-a716-446655440004', '770e8400-e29b-41d4-a716-446655440004', 480.00, '2024-03-05 13:20:00', 'credit_card'),
('880e8400-e29b-41d4-a716-446655440005', '770e8400-e29b-41d4-a716-446655440005', 700.00, '2024-03-10 15:35:00', 'stripe'),
('880e8400-e29b-41d4-a716-446655440011', '770e8400-e29b-41d4-a716-446655440011', 300.00, '2024-04-01 11:05:00', 'credit_card'),
('880e8400-e29b-41d4-a716-446655440012', '770e8400-e29b-41d4-a716-446655440012', 1650.00, '2024-04-15 14:35:00', 'paypal'),
('880e8400-e29b-41d4-a716-446655440013', '770e8400-e29b-41d4-a716-446655440013', 900.00, '2024-05-01 09:20:00', 'stripe');

-- ====================================================================
-- 5. SEED REVIEW DATA
-- ====================================================================

INSERT INTO Review (review_id, property_id, user_id, rating, comment, created_at) VALUES
-- Reviews for completed stays
('990e8400-e29b-41d4-a716-446655440001', '660e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440010', 5, 'Absolutely fantastic stay! The apartment was exactly as described, spotlessly clean, and in a perfect location. Sarah was an excellent host, very responsive and helpful. The city views were breathtaking, especially at night. Would definitely book again!', '2024-03-19 10:30:00'),

('990e8400-e29b-41d4-a716-446655440002', '660e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440011', 4, 'Beautiful beachfront property with amazing ocean views. The villa was spacious and well-equipped. Beach access was private and perfect for morning walks. Only minor issue was the WiFi was a bit slow, but overall an excellent vacation rental.', '2024-04-06 14:15:00'),

('990e8400-e29b-41d4-a716-446655440003', '660e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440012', 5, 'Perfect mountain getaway! The cabin was cozy and rustic with all modern amenities. Hot tub under the stars was incredible. Emma provided excellent local recommendations for hiking trails. Exactly what we needed for a romantic weekend.', '2024-04-13 16:45:00'),

('990e8400-e29b-41d4-a716-446655440004', '660e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440013', 4, 'Lovely lakefront cottage with peaceful surroundings. Enjoyed fishing from the dock and using the kayaks. The cottage was clean and comfortable. David was helpful with check-in instructions. Great value for money!', '2024-04-24 11:20:00'),

('990e8400-e29b-41d4-a716-446655440005', '660e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440014', 5, 'Luxury at its finest! The penthouse exceeded all expectations. Stunning panoramic views, elegant furnishings, and impeccable cleanliness. Perfect for our anniversary celebration. Sarah went above and beyond to make our stay special.', '2024-05-04 13:30:00'),

('990e8400-e29b-41d4-a716-446655440006', '660e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440012', 4, 'Great downtown location with easy access to restaurants and attractions. Apartment was clean and well-maintained. Check-in process was smooth. Would recommend for business travelers or city explorers.', '2024-06-18 09:45:00'),

('990e8400-e29b-41d4-a716-446655440007', '660e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440013', 5, 'Amazing beach vacation! The villa was perfect for our family group. Kids loved the private beach access and we enjoyed the BBQ area for evening meals. Michael was very accommodating and responsive to our needs.', '2024-07-08 15:20:00'),

-- Some additional reviews with varied ratings
('990e8400-e29b-41d4-a716-446655440008', '660e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440015', 3, 'The loft was stylish and in a great location, but it was smaller than expected. Noise from the street was noticeable at night. Michael was responsive to our concerns. Good for a short stay but might be tight for longer visits.', '2024-05-18 12:00:00'),

('990e8400-e29b-41d4-a716-446655440009', '660e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440016', 4, 'Charming historic home with beautiful original features. Emma provided great local recommendations. The neighborhood was quiet and safe. Only issue was parking was a bit challenging, but overall a delightful stay.', '2024-05-23 14:30:00'),

('990e8400-e29b-41d4-a716-446655440010', '660e8400-e29b-41d4-a716-446655440008', '550e8400-e29b-41d4-a716-446655440017', 5, 'Unique desert experience! The home was modern and comfortable with an incredible pool area. Sunset views were spectacular. David provided excellent local dining recommendations. Perfect for a relaxing getaway.', '2024-06-05 16:15:00');

-- ====================================================================
-- 6. SEED MESSAGE DATA
-- ====================================================================

INSERT INTO Message (message_id, sender_id, recipient_id, message_body, sent_at) VALUES
-- Pre-booking inquiries
('aa0e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440010', '550e8400-e29b-41d4-a716-446655440001', 'Hi Sarah! I\'m interested in booking your downtown apartment for March 15-18. Is it available? Also, is there parking available nearby?', '2024-02-18 10:30:00'),

('aa0e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440010', 'Hi John! Yes, the apartment is available for those dates. There\'s a parking garage just one block away that offers daily rates. I can send you the details once you book. The apartment is perfect for exploring downtown!', '2024-02-18 11:15:00'),

('aa0e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440010', '550e8400-e29b-41d4-a716-446655440001', 'Perfect! I\'ll go ahead and book it. Looking forward to staying there!', '2024-02-18 11:30:00'),

-- Booking confirmations and check-in details
('aa0e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440010', 'Thank you for booking! I\'ll send you detailed check-in instructions closer to your arrival date. The apartment has everything you need for a comfortable stay. Feel free to reach out if you have any questions!', '2024-02-20 15:00:00'),

('aa0e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440011', '550e8400-e29b-41d4-a716-446655440002', 'Hi Michael! I\'m excited about our upcoming stay at your beachfront villa. Could you let me know what amenities are included? Do you provide beach chairs and umbrellas?', '2024-03-25 14:20:00'),

('aa0e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440011', 'Hi Emily! Yes, we provide beach chairs, umbrellas, and towels. The villa also has a full kitchen, WiFi, and the BBQ area is perfect for evening cookouts. There are also bicycles available if you\'d like to explore the area. Can\'t wait to host you!', '2024-03-25 15:45:00'),

-- Post-stay follow-ups
('aa0e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440010', 'Hi John! I hope you enjoyed your stay at the downtown apartment. Would love to hear about your experience and would appreciate a review when you have a moment. Thanks again for being such a great guest!', '2024-03-19 12:00:00'),

('aa0e8400-e29b-41d4-a716-446655440008', '550e8400-e29b-41d4-a716-446655440011', '550e8400-e29b-41d4-a716-446655440002', 'Hi Emily! I hope you had a wonderful time at the beachfront villa. If you enjoyed your stay, I would be grateful if you could leave a review. Thank you for choosing us!', '2024-04-07 10:30:00'),

('aa0e8400-e29b-41d4-a716-446655440009', '550e8400-e29b-41d4-a716-446655440012', '550e8400-e29b-41d4-a716-446655440003', 'Hi Emma! Thank you for staying at the mountain cabin retreat. I hope you had a relaxing time. If you have a moment, please leave a review about your experience. It really helps us improve!', '2024-04-14 13:15:00');