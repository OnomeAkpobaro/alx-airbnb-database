# ALX Airbnb Database Seed Data

This repository contains a comprehensive seed data script for an Airbnb-like database system, designed to populate your database with realistic sample data for development, testing, and demonstration purposes.

## 📋 Overview

The `seed.sql` script creates a complete dataset simulating a real-world vacation rental platform with users, properties, bookings, payments, reviews, and messages. This data is perfect for:

- **Development**: Testing application features with realistic data
- **Demo**: Showcasing your Airbnb-like application
- **Learning**: Understanding database relationships and data structures
- **Testing**: Validating queries and business logic

## 🗃️ Database Schema

The seed data populates the following tables:

### Core Entities

- **User**: Platform users (admins, hosts, guests)
- **Property**: Rental properties with details and pricing
- **Booking**: Reservation records with status tracking
- **Payment**: Payment transactions linked to bookings
- **Review**: Guest reviews and ratings for properties
- **Message**: Communication between users

## 📊 Sample Data Included

### Users (17 total)
- **1 Admin**: Platform administrator
- **5 Hosts**: Property owners with multiple listings
- **11 Guests**: Users who book properties

### Properties (10 total)
Diverse property types across major US cities:
- Luxury penthouses and downtown apartments (New York)
- Beachfront villas (Miami)
- Mountain cabins (Denver)
- Historic homes (Boston)
- Lakefront cottages (Austin)
- Desert retreats (Phoenix)
- Wine country estates (Napa Valley)
- Urban studios (Seattle)

### Bookings (13 total)
- **8 Confirmed** bookings with payments
- **3 Pending** bookings awaiting confirmation
- **2 Canceled** bookings

### Additional Data
- **8 Payment records** for confirmed bookings
- **10 Reviews** with ratings (3-5 stars) and detailed comments
- **7 Message threads** showing pre-booking inquiries and host communications

## 🚀 Setup Instructions

### Prerequisites
- MySQL 5.7+ or MariaDB 10.2+
- Existing database with the ALX Airbnb schema tables

### Installation

1. **Ensure your database schema is ready**
   ```sql
   -- Make sure these tables exist with proper structure:
   -- User, Property, Booking, Payment, Review, Message
   ```

2. **Run the seed script**
   ```bash
   mysql -u your_username -p your_database_name < seed.sql
   ```

   Or execute within MySQL:
   ```sql
   source /path/to/seed.sql;
   ```

### Fresh Start (Optional)
If you need to clear existing data, uncomment the truncate section at the top of the script:

```sql
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE Message;
TRUNCATE TABLE Review;
TRUNCATE TABLE Payment;
TRUNCATE TABLE Booking;
TRUNCATE TABLE Property;
TRUNCATE TABLE User;
SET FOREIGN_KEY_CHECKS = 1;
```

## 🔧 Configuration

### Password Hashing
All user passwords use bcrypt hashing with the sample hash:
```
$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi
```
*Note: This is a sample hash for development only. Use proper password hashing in production.*

### UUIDs
All primary keys use UUID format for better scalability and security:
- Users: `550e8400-e29b-41d4-a716-4466554400XX`
- Properties: `660e8400-e29b-41d4-a716-4466554400XX`
- Bookings: `770e8400-e29b-41d4-a716-4466554400XX`
- And so on...

## 📈 Data Relationships

The seed data maintains proper referential integrity:

```
User (Host) ──→ Property ──→ Booking ──→ Payment
     │                          │
     └─────→ Message ←──────────┘
     │                          │
     └─────→ Review ←───────────┘
```

## 🎯 Use Cases

### Testing Scenarios
- **Booking flow**: Complete booking process from inquiry to payment
- **Review system**: Property ratings and guest feedback
- **Host management**: Multiple properties per host
- **Payment processing**: Various payment methods
- **Messaging**: Host-guest communication

### Sample Queries
```sql
-- Find top-rated properties
SELECT p.name, AVG(r.rating) as avg_rating
FROM Property p
JOIN Review r ON p.property_id = r.property_id
GROUP BY p.property_id
ORDER BY avg_rating DESC;

-- Get booking revenue by month
SELECT DATE_FORMAT(payment_date, '%Y-%m') as month, SUM(amount) as revenue
FROM Payment
GROUP BY month
ORDER BY month;

-- Find properties with pending bookings
SELECT p.name, p.location, b.start_date, b.end_date
FROM Property p
JOIN Booking b ON p.property_id = b.property_id
WHERE b.status = 'pending';
```

## ⚠️ Important Notes

- **Development Only**: This seed data is for development and testing purposes
- **Sample Passwords**: All users have the same sample password hash
- **Realistic Data**: Addresses, names, and details are fictional but realistic
- **Foreign Keys**: Ensure foreign key constraints are properly set up in your schema

## 🤝 Contributing

To extend or modify the seed data:

1. Follow the existing UUID pattern for new records
2. Maintain referential integrity between tables
3. Keep data realistic and diverse
4. Update this README with any significant changes

## 📝 License

This seed data is provided for educational and development purposes. Adapt as needed for your specific project requirements.

---

**Created for ALX Software Engineering Program**  
*Simulating real-world data for Airbnb-like applications*