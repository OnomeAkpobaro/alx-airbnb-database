# ALX Airbnb Database Schema (DDL)

## Overview
This directory contains the Data Definition Language (DDL) scripts for the ALX Airbnb database project. The schema is designed to support a full-featured rental platform with user management, property listings, booking system, payment processing, reviews, and messaging.

## Files
- `schema.sql` - Complete database schema creation script
- `README.md` - This documentation file

## Database Structure

### Core Tables

#### 1. User Table
Stores all platform users (guests, hosts, and admins).
- **Primary Key**: `user_id` (UUID)
- **Unique Constraints**: `email`
- **Key Features**: Role-based access, secure password storage

#### 2. Property Table
Contains property listings created by hosts.
- **Primary Key**: `property_id` (UUID)
- **Foreign Keys**: `host_id` → User.user_id
- **Key Features**: Automatic timestamp updates, price validation

#### 3. Booking Table
Manages reservation records between users and properties.
- **Primary Key**: `booking_id` (UUID)
- **Foreign Keys**: `property_id` → Property.property_id, `user_id` → User.user_id
- **Key Features**: Date validation, status tracking, overlap prevention

#### 4. Payment Table
Handles payment information for bookings.
- **Primary Key**: `payment_id` (UUID)
- **Foreign Keys**: `booking_id` → Booking.booking_id (One-to-One)
- **Key Features**: Multiple payment methods, amount validation

#### 5. Review Table
Stores property reviews and ratings.
- **Primary Key**: `review_id` (UUID)
- **Foreign Keys**: `property_id` → Property.property_id, `user_id` → User.user_id
- **Key Features**: Rating constraints (1-5), duplicate review prevention

#### 6. Message Table
Facilitates communication between users.
- **Primary Key**: `message_id` (UUID)
- **Foreign Keys**: `sender_id` → User.user_id, `recipient_id` → User.user_id
- **Key Features**: Self-messaging prevention, conversation tracking

## Key Features

### 1. Data Integrity
- **Primary Keys**: UUID-based for scalability and uniqueness
- **Foreign Key Constraints**: Maintain referential integrity with CASCADE options
- **Check Constraints**: Validate data ranges and business rules
- **Unique Constraints**: Prevent duplicate critical data

### 2. Performance Optimization
- **Strategic Indexing**: Optimized for common query patterns
- **Composite Indexes**: Support complex filtering and sorting
- **View Creation**: Pre-optimized queries for frequent operations

### 3. Advanced Features
- **Triggers**: Automatic data validation and timestamp management
- **Stored Procedures**: Common operations like availability checking
- **Views**: Simplified access to joined data

## Installation Instructions

### Prerequisites
- MySQL 8.0+ or MariaDB 10.3+
- Database client (MySQL Workbench, phpMyAdmin, or command line)
- Sufficient privileges to create databases, tables, and procedures

### Setup Steps

1. **Create Database** (if needed):
   ```sql
   CREATE DATABASE IF NOT EXISTS alx_airbnb;
   USE alx_airbnb;
   ```

2. **Execute Schema Script**:
   ```bash
   mysql -u username -p alx_airbnb < schema.sql
   ```

3. **Verify Installation**:
   ```sql
   SHOW TABLES;
   DESCRIBE User;
   ```

## Usage Examples

### Basic Operations

```sql
-- Check available properties for date range
CALL GetAvailableProperties('2025-07-01', '2025-07-07', 'New York');

-- View property listings with host info
SELECT * FROM PropertyListings WHERE location LIKE '%London%';

-- Get booking details
SELECT * FROM BookingDetails WHERE status = 'confirmed';

-- Check property reviews
SELECT * FROM PropertyReviews WHERE property_id = 'your-property-uuid';
```

### Performance Monitoring

```sql
-- Analyze table sizes
SELECT 
    TABLE_NAME,
    TABLE_ROWS,
    ROUND(((DATA_LENGTH + INDEX_LENGTH) / 1024 / 1024), 2) AS 'Size (MB)'
FROM information_schema.TABLES 
WHERE TABLE_SCHEMA = 'alx_airbnb'
ORDER BY (DATA_LENGTH + INDEX_LENGTH) DESC;

-- Check index usage
SHOW INDEX FROM Booking;
```

## Business Rules Enforced

### 1. User Management
- Unique email addresses per user
- Role-based access control (guest, host, admin)
- Secure password hash storage

### 2. Property Management
- Only hosts can create properties
- Properties must have positive pricing
- Automatic timestamp tracking for updates

### 3. Booking System
- End date must be after start date
- No overlapping bookings for same property
- Status tracking (pending, confirmed, canceled)

### 4. Payment Processing
- One payment per booking
- Positive amount validation
- Multiple payment method support

### 5. Review System
- Users can only review properties once
- Rating must be between 1-5
- Comments required for all reviews

### 6. Messaging System
- Users cannot message themselves
- Conversation history maintained
- Timestamp tracking for message ordering

## Security Considerations

### 1. Data Protection
- Password hashing (never store plain text)
- UUID primary keys (prevent enumeration attacks)
- Input validation through constraints

### 2. Access Control
- Role-based user system
- Foreign key constraints prevent orphaned records
- Triggers validate business logic

### 3. Data Integrity
- Referential integrity through foreign keys
- Check constraints prevent invalid data
- Unique constraints prevent duplicates

## Maintenance

### Regular Tasks
1. **Index Optimization**: Monitor and rebuild indexes as needed
2. **Statistics Updates**: Keep table statistics current for query optimization
3. **Backup Strategy**: Regular backups of schema and data
4. **Performance Monitoring**: Track slow queries and optimize

### Troubleshooting
- Check foreign key constraint errors
- Monitor trigger execution for performance
- Validate date ranges in booking system
- Ensure UUID generation is working properly

## Extension Points

The schema is designed for easy extension:

### Potential Enhancements
1. **Property Amenities**: Additional table for property features
2. **Property Images**: Media storage for property photos
3. **User Profiles**: Extended user information and preferences
4. **Notification System**: User alerts and communication preferences
5. **Booking Modifications**: Change tracking for booking updates
6. **Pricing Rules**: Dynamic pricing based on seasons/demand
7. **Cancellation Policies**: Flexible cancellation rule management

### Sample Extension Example
```sql
-- Property Amenities Extension
CREATE TABLE Amenity (
    amenity_id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    icon VARCHAR(50)
);

CREATE TABLE PropertyAmenity (
    property_id CHAR(36),
    amenity_id CHAR(36),
    PRIMARY KEY (property_id, amenity_id),
    FOREIGN KEY (property_id) REFERENCES Property(property_id) ON DELETE CASCADE,
    FOREIGN KEY (amenity_id) REFERENCES Amenity(amenity_id) ON DELETE CASCADE
);
```

## Support and Contribution

For questions, issues, or contributions to this database schema:

1. **Documentation**: Always update README when modifying schema
2. **Testing**: Test all constraints and triggers before deployment
3. **Version Control**: Use migration scripts for schema changes
4. **Performance**: Monitor query performance after schema modifications

## License

This database schema is part of the ALX Software Engineering program and follows the project's licensing terms.