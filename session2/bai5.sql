create schema if not exists  hotel;
set search_path to hotel;

CREATE TABLE RoomTypes (
                           room_type_id SERIAL PRIMARY KEY,
                           type_name VARCHAR(50) NOT NULL UNIQUE,
                           price_per_night NUMERIC(10,2) CHECK (price_per_night > 0),
                           max_capacity INT CHECK (max_capacity > 0)
);

CREATE TABLE Rooms (
                       room_id SERIAL PRIMARY KEY,
                       room_number VARCHAR(10) NOT NULL UNIQUE,
                       room_type_id INT REFERENCES RoomTypes(room_type_id),
                       status VARCHAR(20) CHECK (status IN ('Available','Occupied','Maintenance'))
);

CREATE TABLE Customers (
                           customer_id SERIAL PRIMARY KEY,
                           full_name VARCHAR(100) NOT NULL,
                           email VARCHAR(100) NOT NULL UNIQUE,
                           phone VARCHAR(15) NOT NULL
);

CREATE TABLE Bookings (
                          booking_id SERIAL PRIMARY KEY,
                          customer_id INT REFERENCES Customers(customer_id),
                          room_id INT REFERENCES Rooms(room_id),
                          check_in DATE NOT NULL,
                          check_out DATE NOT NULL,
                          status VARCHAR(20) CHECK (status IN ('Pending','Confirmed','Cancelled'))
);

CREATE TABLE Payments (
                          payment_id SERIAL PRIMARY KEY,
                          booking_id INT REFERENCES Bookings(booking_id),
                          amount NUMERIC(10,2) CHECK (amount >= 0),
                          payment_date DATE NOT NULL,
                          method VARCHAR(20) CHECK (method IN ('Credit Card','Cash','Bank Transfer'))
);