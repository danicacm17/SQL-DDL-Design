DROP DATABASE IF EXISTS air_traffic;

CREATE DATABASE air_traffic;

\c air_traffic

CREATE TABLE airlines (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE airports (
    id SERIAL PRIMARY KEY,
    city TEXT NOT NULL,
    country TEXT NOT NULL,
    code TEXT UNIQUE NOT NULL
);

CREATE TABLE flights (
    id SERIAL PRIMARY KEY,
    flight_number TEXT NOT NULL,
    airline_id INT REFERENCES airlines(id),
    from_airport_id INT REFERENCES airports(id),
    to_airport_id INT REFERENCES airports(id),
    departure TIMESTAMP NOT NULL,
    arrival TIMESTAMP NOT NULL
);

CREATE TABLE tickets (
    id SERIAL PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    seat TEXT NOT NULL,
    flight_id INT REFERENCES flights(id)
);

-- Insert airlines
INSERT INTO airlines (name) VALUES
('United'),
('British Airways'),
('Delta'),
('TUI Fly Belgium'),
('Air China'),
('American Airlines'),
('Avianca Brasil');

-- Insert airports
INSERT INTO airports (city, country, code) VALUES
('Washington DC', 'United States', 'DCA'),
('Seattle', 'United States', 'SEA'),
('Tokyo', 'Japan', 'HND'),
('London', 'United Kingdom', 'LHR'),
('Los Angeles', 'United States', 'LAX'),
('Las Vegas', 'United States', 'LAS'),
('Paris', 'France', 'CDG'),
('Casablanca', 'Morocco', 'CMN'),
('Dubai', 'UAE', 'DXB'),
('Beijing', 'China', 'PEK'),
('New York', 'United States', 'JFK'),
('Charlotte', 'United States', 'CLT'),
('Cedar Rapids', 'United States', 'CID'),
('Chicago', 'United States', 'ORD'),
('New Orleans', 'United States', 'MSY'),
('Sao Paolo', 'Brazil', 'GRU'),
('Santiago', 'Chile', 'SCL');

-- Insert flights
INSERT INTO flights (flight_number, airline_id, from_airport_id, to_airport_id, departure, arrival) VALUES
('UA123', 1, 1, 2, '2018-04-08 09:00:00', '2018-04-08 12:00:00'),
('BA456', 2, 3, 4, '2018-12-19 12:45:00', '2018-12-19 16:15:00'),
('DL789', 3, 5, 6, '2018-01-02 07:00:00', '2018-01-02 08:03:00'),
('DL012', 3, 2, 15, '2018-04-15 16:50:00', '2018-04-15 21:00:00'),
('TUI001', 4, 7, 8, '2018-08-01 18:30:00', '2018-08-01 21:50:00'),
('CA345', 5, 9, 10, '2018-10-31 01:15:00', '2018-10-31 12:55:00'),
('UA567', 1, 11, 12, '2019-02-06 06:00:00', '2019-02-06 07:47:00'),
('AA890', 6, 13, 14, '2018-12-22 14:42:00', '2018-12-22 15:56:00'),
('AA901', 6, 12, 15, '2019-02-06 16:28:00', '2019-02-06 19:18:00'),
('AV123', 7, 16, 17, '2019-01-20 19:30:00', '2019-01-20 22:45:00');

-- Insert tickets
INSERT INTO tickets (first_name, last_name, seat, flight_id) VALUES
('Jennifer', 'Finch', '33B', 1),
('Thadeus', 'Gathercoal', '8A', 2),
('Sonja', 'Pauley', '12F', 3),
('Jennifer', 'Finch', '20A', 4),
('Waneta', 'Skeleton', '23D', 5),
('Thadeus', 'Gathercoal', '18C', 6),
('Berkie', 'Wycliff', '9E', 7),
('Alvin', 'Leathes', '1A', 8),
('Berkie', 'Wycliff', '32B', 9),
('Cory', 'Squibbes', '10D', 10);
