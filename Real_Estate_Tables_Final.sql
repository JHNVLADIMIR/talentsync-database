-- Real Estate Property Listing and Rental Management System
-- Database setup for Programiz SQL / SQLite
-- Creates exactly 7 tables required by the ERD.
-- Run this file FIRST.

PRAGMA foreign_keys = OFF;

DROP TABLE IF EXISTS rent_payments;
DROP TABLE IF EXISTS viewings;
DROP TABLE IF EXISTS property_listings;
DROP TABLE IF EXISTS properties;
DROP TABLE IF EXISTS clients;
DROP TABLE IF EXISTS agents;
DROP TABLE IF EXISTS owners;

PRAGMA foreign_keys = ON;

-- 1. OWNERS
CREATE TABLE owners (
    owner_id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    phone_number TEXT NOT NULL,
    address TEXT,
    city TEXT
);

-- 2. AGENTS
CREATE TABLE agents (
    agent_id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    phone_number TEXT NOT NULL,
    license_number TEXT NOT NULL UNIQUE,
    agency_name TEXT
);

-- 3. CLIENTS
CREATE TABLE clients (
    client_id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    phone_number TEXT NOT NULL,
    client_type TEXT NOT NULL
);

-- 4. PROPERTIES
CREATE TABLE properties (
    property_id INTEGER PRIMARY KEY AUTOINCREMENT,
    owner_id INTEGER NOT NULL,
    address TEXT NOT NULL,
    city TEXT NOT NULL,
    property_type TEXT NOT NULL,
    bedrooms INTEGER,
    bathrooms INTEGER,
    floor_area_sqm REAL,
    price REAL NOT NULL,
    status TEXT NOT NULL,
    date_listed TEXT,
    FOREIGN KEY (owner_id) REFERENCES owners(owner_id)
);

-- 5. PROPERTY LISTINGS
CREATE TABLE property_listings (
    listing_id INTEGER PRIMARY KEY AUTOINCREMENT,
    property_id INTEGER NOT NULL,
    agent_id INTEGER NOT NULL,
    listing_type TEXT NOT NULL,
    listing_price REAL NOT NULL,
    listing_status TEXT NOT NULL,
    date_posted TEXT NOT NULL,
    FOREIGN KEY (property_id) REFERENCES properties(property_id),
    FOREIGN KEY (agent_id) REFERENCES agents(agent_id)
);

-- 6. VIEWINGS
CREATE TABLE viewings (
    viewing_id INTEGER PRIMARY KEY AUTOINCREMENT,
    client_id INTEGER NOT NULL,
    property_id INTEGER NOT NULL,
    viewing_date TEXT NOT NULL,
    viewing_time TEXT NOT NULL,
    viewing_status TEXT NOT NULL,
    FOREIGN KEY (client_id) REFERENCES clients(client_id),
    FOREIGN KEY (property_id) REFERENCES properties(property_id)
);

-- 7. RENT PAYMENTS
CREATE TABLE rent_payments (
    payment_id INTEGER PRIMARY KEY AUTOINCREMENT,
    client_id INTEGER NOT NULL,
    property_id INTEGER NOT NULL,
    payment_amount REAL NOT NULL,
    payment_date TEXT NOT NULL,
    payment_status TEXT NOT NULL,
    payment_method TEXT,
    FOREIGN KEY (client_id) REFERENCES clients(client_id),
    FOREIGN KEY (property_id) REFERENCES properties(property_id)
);
