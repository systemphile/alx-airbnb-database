# Airbnb Database Design (3NF)

## Description
This project defines the database schema for an Airbnb-style booking system.  
The database design is fully normalized to **Third Normal Form (3NF)** to eliminate redundancy and ensure data integrity.

---

## Normalization Steps

### 1. First Normal Form (1NF)
All tables store atomic values (no repeating groups or arrays).

### 2. Second Normal Form (2NF)
Each table has a single-column primary key (UUID), so all non-key attributes depend on the whole key.

### 3. Third Normal Form (3NF)
Removed `total_price` from the Booking table since it can be derived from: pricepernight * (end_date - start_date)

This avoids transitive dependency and ensures full 3NF compliance.

---

## Derived Value (not stored)
```sql
SELECT 
    b.booking_id,
    p.pricepernight * DATEDIFF(b.end_date, b.start_date) AS total_price
FROM Booking b
JOIN Property p ON b.property_id = p.property_id;
```