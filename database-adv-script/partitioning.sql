-- Create partitioned version of Bookings table
CREATE TABLE Bookings_Partitioned (
    booking_id INT AUTO_INCREMENT,
    user_id INT,
    property_id INT,
    start_date DATE,
    end_date DATE,
    total_price DECIMAL(10, 2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (booking_id, start_date),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (property_id) REFERENCES Properties(property_id)
) PARTITION BY RANGE (YEAR(start_date)) (
    PARTITION p2020 VALUES LESS THAN (2021),
    PARTITION p2021 VALUES LESS THAN (2022),
    PARTITION p2022 VALUES LESS THAN (2023),
    PARTITION p2023 VALUES LESS THAN (2024),
    PARTITION p2024 VALUES LESS THAN (2025),
    PARTITION p2025 VALUES LESS THAN (2026),
    PARTITION p_future VALUES LESS THAN MAXVALUE
);

-- Migrate data from original table
INSERT INTO Bookings_Partitioned 
SELECT * FROM Bookings;

-- Create indexes on partitioned table
CREATE INDEX idx_part_user_id ON Bookings_Partitioned(user_id);
CREATE INDEX idx_part_property_id ON Bookings_Partitioned(property_id);
CREATE INDEX idx_part_dates ON Bookings_Partitioned(start_date, end_date);

-- Example query to test partition pruning
EXPLAIN PARTITIONS
SELECT * FROM Bookings_Partitioned
WHERE start_date BETWEEN '2024-01-01' AND '2024-12-31';