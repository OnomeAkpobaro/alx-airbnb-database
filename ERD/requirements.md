# Entity-Relationship Diagram (ERD) Requirements

## Project Overview
This document outlines the requirements for the ALX Airbnb Database ERD, designed to model a comprehensive rental platform system.

## Entities and Relationships

### 1. User Entity
**Attributes:**
- user_id (Primary Key, UUID, Indexed)
- first_name (VARCHAR, NOT NULL)
- last_name (VARCHAR, NOT NULL)
- email (VARCHAR, UNIQUE, NOT NULL)
- password_hash (VARCHAR, NOT NULL)
- phone_number (VARCHAR, NULL)
- role (ENUM: guest, host, admin, NOT NULL)
- created_at (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)

**Relationships:**
- One-to-Many with Property (as host)
- One-to-Many with Booking (as guest)
- One-to-Many with Payment (through Booking)
- One-to-Many with Review (as reviewer)
- One-to-Many with Message (as sender)
- One-to-Many with Message (as recipient)

### 2. Property Entity
**Attributes:**
- property_id (Primary Key, UUID, Indexed)
- host_id (Foreign Key, references User.user_id)
- name (VARCHAR, NOT NULL)
- description (TEXT, NOT NULL)
- location (VARCHAR, NOT NULL)
- price_per_night (DECIMAL, NOT NULL)
- created_at (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)
- updated_at (TIMESTAMP, ON UPDATE CURRENT_TIMESTAMP)

**Relationships:**
- Many-to-One with User (host relationship)
- One-to-Many with Booking
- One-to-Many with Review

### 3. Booking Entity
**Attributes:**
- booking_id (Primary Key, UUID, Indexed)
- property_id (Foreign Key, references Property.property_id)
- user_id (Foreign Key, references User.user_id)
- start_date (DATE, NOT NULL)
- end_date (DATE, NOT NULL)
- total_price (DECIMAL, NOT NULL)
- status (ENUM: pending, confirmed, canceled, NOT NULL)
- created_at (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)

**Relationships:**
- Many-to-One with Property
- Many-to-One with User (guest)
- One-to-One with Payment

### 4. Payment Entity
**Attributes:**
- payment_id (Primary Key, UUID, Indexed)
- booking_id (Foreign Key, references Booking.booking_id)
- amount (DECIMAL, NOT NULL)
- payment_date (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)
- payment_method (ENUM: credit_card, paypal, stripe, NOT NULL)

**Relationships:**
- One-to-One with Booking

### 5. Review Entity
**Attributes:**
- review_id (Primary Key, UUID, Indexed)
- property_id (Foreign Key, references Property.property_id)
- user_id (Foreign Key, references User.user_id)
- rating (INTEGER, CHECK: rating >= 1 AND rating <= 5, NOT NULL)
- comment (TEXT, NOT NULL)
- created_at (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)

**Relationships:**
- Many-to-One with Property
- Many-to-One with User

### 6. Message Entity
**Attributes:**
- message_id (Primary Key, UUID, Indexed)
- sender_id (Foreign Key, references User.user_id)
- recipient_id (Foreign Key, references User.user_id)
- message_body (TEXT, NOT NULL)
- sent_at (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)

**Relationships:**
- Many-to-One with User (sender)
- Many-to-One with User (recipient)

## Key Relationships Summary

1. **User ↔ Property**: One host can have multiple properties (1:N)
2. **User ↔ Booking**: One user can make multiple bookings (1:N)
3. **Property ↔ Booking**: One property can have multiple bookings (1:N)
4. **Booking ↔ Payment**: Each booking has one payment (1:1)
5. **Property ↔ Review**: One property can have multiple reviews (1:N)
6. **User ↔ Review**: One user can write multiple reviews (1:N)
7. **User ↔ Message**: One user can send/receive multiple messages (1:N for both sender and recipient)

## Constraints and Business Rules

1. **User Constraints:**
   - Email must be unique across all users
   - Role must be one of: guest, host, admin
   - All users must have first_name, last_name, email, and password_hash

2. **Property Constraints:**
   - Must be associated with a valid host (user with host role)
   - Price per night must be positive
   - Name, description, and location are required

3. **Booking Constraints:**
   - Start date must be before end date
   - Status must be one of: pending, confirmed, canceled
   - Must reference valid property and user

4. **Payment Constraints:**
   - Amount must be positive
   - Must be linked to a valid booking
   - Payment method must be one of: credit_card, paypal, stripe

5. **Review Constraints:**
   - Rating must be between 1 and 5 (inclusive)
   - Must reference valid property and user
   - Comment is required

6. **Message Constraints:**
   - Sender and recipient must be different users
   - Message body is required
   - Both sender and recipient must be valid users

## Indexing Strategy

**Primary Indexes (Automatic):**
- user_id, property_id, booking_id, payment_id, review_id, message_id

**Additional Indexes for Performance:**
- User.email (for login and uniqueness)
- Property.host_id (for host property queries)
- Booking.property_id (for property booking queries)
- Booking.user_id (for user booking history)
- Payment.booking_id (for payment lookup)
- Review.property_id (for property reviews)
- Review.user_id (for user review history)
- Message.sender_id (for sent messages)
- Message.recipient_id (for received messages)

## ERD Diagram Notes

The ERD should visually represent:
- All entities as rectangles with their attributes listed
- Primary keys underlined or marked with key symbols
- Foreign keys clearly indicated
- Relationships shown with lines and cardinality notations (1:1, 1:N, M:N)
- Constraints and data types documented alongside entities