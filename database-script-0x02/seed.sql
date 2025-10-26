-- ====================================
-- USER DATA
-- ====================================
INSERT INTO User (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at)
VALUES
('u1', 'Alice', 'Kamau', 'alice@example.com', 'hashed_pw_1', '0712345678', 'guest', NOW()),
('u2', 'Brian', 'Otieno', 'brian@example.com', 'hashed_pw_2', '0723456789', 'host', NOW()),
('u3', 'Carol', 'Njoroge', 'carol@example.com', 'hashed_pw_3', '0734567890', 'host', NOW()),
('u4', 'David', 'Mwangi', 'david@example.com', 'hashed_pw_4', '0745678901', 'guest', NOW()),
('u5', 'Admin', 'User', 'admin@airbnbclone.com', 'hashed_pw_admin', NULL, 'admin', NOW());

-- ====================================
-- PROPERTY DATA
-- ====================================
INSERT INTO Property (property_id, host_id, name, description, location, pricepernight, created_at, updated_at)
VALUES
('p1', 'u2', 'Nairobi City Loft', 'Modern apartment near CBD with WiFi and parking.', 'Nairobi, Kenya', 75.00, NOW(), NOW()),
('p2', 'u3', 'Diani Beach Villa', 'Beachfront villa with pool and ocean view.', 'Diani, Kenya', 120.00, NOW(), NOW()),
('p3', 'u3', 'Naivasha Lakeside Cabin', 'Cozy cabin near Lake Naivasha.', 'Naivasha, Kenya', 90.00, NOW(), NOW());

-- ====================================
-- BOOKING DATA
-- ====================================
INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, status, created_at)
VALUES
('b1', 'p1', 'u1', '2025-11-10', '2025-11-13', 'confirmed', NOW()),
('b2', 'p2', 'u4', '2025-12-01', '2025-12-05', 'pending', NOW()),
('b3', 'p3', 'u1', '2025-12-15', '2025-12-17', 'confirmed', NOW());

-- ====================================
-- PAYMENT DATA
-- ====================================
INSERT INTO Payment (payment_id, booking_id, amount, payment_date, payment_method)
VALUES
('pay1', 'b1', 225.00, NOW(), 'credit_card'),
('pay2', 'b3', 180.00, NOW(), 'paypal');

-- Note: Booking b2 is still pending, so no payment yet.

-- ====================================
-- REVIEW DATA
-- ====================================
INSERT INTO Review (review_id, property_id, user_id, rating, comment, created_at)
VALUES
('r1', 'p1', 'u1', 5, 'Fantastic stay! Clean, modern, and great location.', NOW()),
('r2', 'p3', 'u1', 4, 'Loved the lakeside view, but water pressure was low.', NOW());

-- ====================================
-- MESSAGE DATA
-- ====================================
INSERT INTO Message (message_id, sender_id, recipient_id, message_body, sent_at)
VALUES
('m1', 'u1', 'u2', 'Hi Brian, is the Nairobi Loft available next week?', NOW()),
('m2', 'u2', 'u1', 'Yes, it is! You can book directly on the platform.', NOW()),
('m3', 'u4', 'u3', 'Hi Carol, does the Diani Villa allow pets?', NOW());