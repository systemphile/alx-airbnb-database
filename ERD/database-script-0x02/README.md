# Airbnb Database Sample Data

## Overview

This SQL script populates the Airbnb clone database (in 3NF) with realistic sample data for testing and development.
It includes users, properties, bookings, payments, reviews, and messages that reflect real-world interactions between guests and hosts

## Contents

- Users: Guests, hosts, and one admin user
- Properties: Three listings in Kenya
- Bookings: Example reservations with realistic statuses
- Payments: Only for confirmed bookings
- Reviews: Guest feedback after stays
- Messages: Direct communication between users

## Usage

- Ensure all tables from the 3NF schema have been created.
- Run the INSERT statements in your SQL client or migration tool.
- To view total booking costs dynamically:

```bash
SELECT 
    b.booking_id,
    p.name AS property_name,
    p.pricepernight * DATEDIFF(b.end_date, b.start_date) AS total_price
FROM Booking b
JOIN Property p ON b.property_id = p.property_id;
```

## Notes

- Replace short IDs (u1, p1, etc.) with UUIDs in production.
- Data is for demonstration and testing only