DROP DATABASE IF EXISTS outer_space;

CREATE DATABASE outer_space;

\c outer_space

CREATE TABLE galaxies (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    type TEXT,
    size TEXT
);

CREATE TABLE stars (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    galaxy_id INT REFERENCES galaxies(id)
);

CREATE TABLE moons (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    planet_id INT REFERENCES planets(id),
    diameter FLOAT,
    composition TEXT
);

CREATE TABLE planets (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    orbital_period_in_years FLOAT NOT NULL,
    star_id INT REFERENCES stars(id),
    diameter FLOAT,
    mass FLOAT,
    atmosphere TEXT
);

-- Insert galaxies
INSERT INTO galaxies (name, type, size) VALUES
('Milky Way', 'Spiral', 'Large');

-- Insert stars
INSERT INTO stars (name, galaxy_id) VALUES
('The Sun', 1),
('Proxima Centauri', 1),
('Gliese 876', 1);

-- Insert planets
INSERT INTO planets (name, orbital_period_in_years, star_id, diameter, mass, atmosphere) VALUES
('Earth', 1.00, 1, 12742, 5.972e24, 'Nitrogen, Oxygen'),
('Mars', 1.88, 1, 6779, 6.417e23, 'Carbon Dioxide'),
('Venus', 0.62, 1, 12104, 4.867e24, 'Carbon Dioxide'),
('Neptune', 164.8, 1, 49528, 1.024e26, 'Hydrogen, Helium, Methane'),
('Proxima Centauri b', 0.03, 2, 12000, 1.27e24, 'Unknown'),
('Gliese 876 b', 0.23, 3, 12000, 1.9e24, 'Unknown');

-- Insert moons
INSERT INTO moons (name, planet_id, diameter, composition) VALUES
('The Moon', 1, 3474, 'Rock'),
('Phobos', 2, 22, 'Rock'),
('Deimos', 2, 12, 'Rock'),
('Naiad', 4, 66, 'Ice'),
('Triton', 4, 2706, 'Nitrogen, Ice');
