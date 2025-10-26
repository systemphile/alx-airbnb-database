-- ======================
-- USER TABLE
-- ======================
CREATE TABLE User (
    user_id UUID PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20),
    role ENUM('guest', 'host', 'admin') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ======================
-- PROPERTY TABLE
-- ======================
CREATE TABLE Property (
    property_id UUID PRIMARY KEY,
    host_id UUID NOT NULL,
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR(255) NOT NULL,
    pricepernight DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (host_id) REFERENCES User(user_id)
);

-- ======================
-- BOOKING TABLE (3NF-compliant)
-- ======================
CREATE TABLE Booking (
    booking_id UUID PRIMARY KEY,
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status ENUM('pending', 'confirmed', 'canceled') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (property_id) REFERENCES Property(property_id),
    FOREIGN KEY (user_id) REFERENCES User(user_id)
);

-- ======================
-- PAYMENT TABLE
-- ======================
CREATE TABLE Payment (
    payment_id UUID PRIMARY KEY,
    booking_id UUID NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method ENUM('credit_card', 'paypal', 'stripe') NOT NULL,
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id)
);

-- ======================
-- REVIEW TABLE
-- ======================
CREATE TABLE Review (
    review_id UUID PRIMARY KEY,
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    rating INTEGER CHECK (rating BETWEEN 1 AND 5) NOT NULL,
    comment TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (property_id) REFERENCES Property(property_id),
    FOREIGN KEY (user_id) REFERENCES User(user_id)
);

-- ======================
-- MESSAGE TABLE
-- ======================
CREATE TABLE Message (
    message_id UUID PRIMARY KEY,
    sender_id UUID NOT NULL,
    recipient_id UUID NOT NULL,
    message_body TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sender_id) REFERENCES User(user_id),
    FOREIGN KEY (recipient_id) REFERENCES User(user_id)
);

-- ======================
-- INDEXES FOR PERFORMANCE
-- ======================

-- User table indexes
CREATE INDEX idx_user_email ON User(email);

-- Property table indexes
CREATE INDEX idx_property_host ON Property(host_id);

-- Booking table indexes
CREATE INDEX idx_booking_property ON Booking(property_id);
CREATE INDEX idx_booking_user ON Booking(user_id);

-- Payment table indexes
CREATE INDEX idx_payment_booking ON Payment(booking_id);

-- Review table indexes
CREATE INDEX idx_review_property ON Review(property_id);
CREATE INDEX idx_review_user ON Review(user_id);

-- Message table indexes
CREATE INDEX idx_message_sender ON Message(sender_id);
CREATE INDEX idx_message_recipient ON Message(recipient_id);

-- ======================
-- DERIVED VALUE (NOT STORED)
-- ======================
-- To compute total_price dynamically:
-- SELECT b.booking_id,
--        p.pricepernight * DATEDIFF(b.end_date, b.start_date) AS total_price
-- FROM Booking b
-- JOIN Property p ON b.property_id = p.property_id;