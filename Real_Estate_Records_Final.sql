-- Real Estate Property Listing and Rental Management System
-- Sample records: minimum 5 rows in EVERY table.
-- Run this file ONLY AFTER Real_Estate_Tables_Final.sql succeeds.

PRAGMA foreign_keys = ON;

-- 1. OWNERS (5 rows)
INSERT INTO owners (owner_id, first_name, last_name, email, phone_number, address, city) VALUES
(1, 'Ramon', 'Villanueva', 'ramon.villanueva@email.com', '09171234501', '12 Aguinaldo St.', 'Imus'),
(2, 'Carmela', 'Santos', 'carmela.santos@email.com', '09171234502', '45 Bonifacio Ave.', 'Bacoor'),
(3, 'Ferdinand', 'Cruz', 'ferdinand.cruz@email.com', '09171234503', '78 Mabini St.', 'Dasmarinas'),
(4, 'Liza', 'Reyes', 'liza.reyes@email.com', '09171234504', '23 Rizal Ave.', 'Tagaytay'),
(5, 'Antonio', 'Bautista', 'antonio.bautista@email.com', '09171234505', '66 Molino Blvd.', 'Bacoor');

-- 2. AGENTS (5 rows)
INSERT INTO agents (agent_id, first_name, last_name, email, phone_number, license_number, agency_name) VALUES
(1, 'Jasmine', 'Del Rosario', 'jasmine.delrosario@email.com', '09181234501', 'PRC-RE-10001', 'CaviteHomes Realty'),
(2, 'Miguel', 'Torres', 'miguel.torres@email.com', '09181234502', 'PRC-RE-10002', 'PrimeSpace Realty'),
(3, 'Angela', 'Mendoza', 'angela.mendoza@email.com', '09181234503', 'PRC-RE-10003', 'CaviteHomes Realty'),
(4, 'Patrick', 'Aquino', 'patrick.aquino@email.com', '09181234504', 'PRC-RE-10004', 'GreenLand Properties'),
(5, 'Bianca', 'Fernandez', 'bianca.fernandez@email.com', '09181234505', 'PRC-RE-10005', 'PrimeSpace Realty');

-- 3. CLIENTS (5 rows)
INSERT INTO clients (client_id, first_name, last_name, email, phone_number, client_type) VALUES
(1, 'Joseph', 'Garcia', 'joseph.garcia@email.com', '09191234501', 'Buyer'),
(2, 'Kristine', 'Lopez', 'kristine.lopez@email.com', '09191234502', 'Renter'),
(3, 'Michael', 'Ramos', 'michael.ramos@email.com', '09191234503', 'Buyer'),
(4, 'Sheila', 'Navarro', 'sheila.navarro@email.com', '09191234504', 'Renter'),
(5, 'Vladimir', 'Rosello', 'vladimir.rosello@email.com', '09191234505', 'Buyer');

-- 4. PROPERTIES (7 rows)
INSERT INTO properties (property_id, owner_id, address, city, property_type, bedrooms, bathrooms, floor_area_sqm, price, status, date_listed) VALUES
(1, 1, '101 Palm St., Anabu', 'Imus', 'House', 3, 2, 120.50, 4500000.00, 'Available', '2024-03-10'),
(2, 2, 'Unit 14B, Vista Towers', 'Bacoor', 'Condo', 2, 1, 55.00, 2800000.00, 'Available', '2024-06-15'),
(3, 3, '9 Emerald St.', 'Dasmarinas', 'House', 4, 3, 180.00, 6200000.00, 'Rented', '2024-09-02'),
(4, 4, '5 Hillview Rd.', 'Tagaytay', 'House', 5, 4, 250.00, 9800000.00, 'Available', '2025-01-20'),
(5, 5, 'Unit 3, Molino Residences', 'Bacoor', 'Apartment', 1, 1, 32.00, 1500000.00, 'Rented', '2025-02-18'),
(6, 1, '22 Kawit Rd.', 'Kawit', 'Lot', NULL, NULL, 400.00, 3200000.00, 'Available', '2025-05-05'),
(7, 3, '77 Aguinaldo Hwy.', 'Dasmarinas', 'Condo', 2, 2, 60.00, 3100000.00, 'Sold', '2025-08-11');

-- 5. PROPERTY_LISTINGS (5 rows)
INSERT INTO property_listings (listing_id, property_id, agent_id, listing_type, listing_price, listing_status, date_posted) VALUES
(1, 1, 1, 'Sale', 4500000.00, 'Active', '2024-03-12'),
(2, 2, 2, 'Sale', 2800000.00, 'Active', '2024-06-16'),
(3, 3, 3, 'Rent', 35000.00, 'Completed', '2024-09-05'),
(4, 4, 4, 'Sale', 9800000.00, 'Pending', '2025-01-22'),
(5, 5, 5, 'Rent', 12000.00, 'Completed', '2025-02-20');

-- 6. VIEWINGS (5 rows)
INSERT INTO viewings (viewing_id, client_id, property_id, viewing_date, viewing_time, viewing_status) VALUES
(1, 1, 1, '2025-03-15', '10:00 AM', 'Completed'),
(2, 2, 2, '2025-04-02', '02:30 PM', 'Completed'),
(3, 3, 4, '2025-04-10', '11:00 AM', 'Scheduled'),
(4, 4, 5, '2025-04-18', '09:00 AM', 'Cancelled'),
(5, 5, 6, '2025-05-01', '03:00 PM', 'Scheduled');

-- 7. RENT_PAYMENTS (5 rows)
INSERT INTO rent_payments (payment_id, client_id, property_id, payment_amount, payment_date, payment_status, payment_method) VALUES
(1, 2, 3, 35000.00, '2025-05-01', 'Completed', 'GCash'),
(2, 2, 3, 35000.00, '2025-06-01', 'Completed', 'GCash'),
(3, 4, 5, 12000.00, '2025-05-05', 'Completed', 'Bank Transfer'),
(4, 4, 5, 12000.00, '2025-06-05', 'Pending', 'Bank Transfer'),
(5, 2, 3, 35000.00, '2025-07-01', 'Completed', 'Cash');
