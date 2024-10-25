-- from the terminal run:
-- psql < medical_center.sql

DROP DATABASE IF EXISTS medical_center;

CREATE DATABASE medical_center;

\c medical_center

CREATE TABLE Doctors (
    doctor_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    specialty VARCHAR(100),
    phone VARCHAR(15)
);

CREATE TABLE Patients (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    dob DATE,
    phone VARCHAR(15),
    primary_doctor_id INT,
    FOREIGN KEY (primary_doctor_id) REFERENCES Doctors(doctor_id)
);

CREATE TABLE Conditions (
    condition_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    description TEXT
);

CREATE TABLE Visits (
    visit_id INT PRIMARY KEY AUTO_INCREMENT,
    date DATE,
    doctor_id INT,
    patient_id INT,
    notes TEXT,
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
);

CREATE TABLE Patient_Conditions (
    patient_id INT,
    condition_id INT,
    PRIMARY KEY (patient_id, condition_id),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (condition_id) REFERENCES Conditions(condition_id)
);

-- Inserting sample data into Doctors
INSERT INTO Doctors (name, specialty, phone) VALUES 
('Gandalf Greyhame', 'General Medicine', '555-555-0123'),
('Elrond Half-elven', 'ENT Specialist', '555-555-0456'),
('Aragorn Elessar', 'Emergency Medicine', '555-555-0789');

-- Inserting sample data into Patients, with updated primary doctors
INSERT INTO Patients (name, dob, phone, primary_doctor_id) VALUES 
('Bilbo Baggins', '2890-09-22', '555-555-1111', 2),  -- Primary Doctor: Elrond
('Frodo Baggins', '2968-09-22', '555-555-2222', 1),  -- Primary Doctor: Gandalf
('Thorin Oakenshield', '2746-01-01', '555-555-3333', 3);  -- Primary Doctor: Aragorn

-- Inserting sample data into Conditions
INSERT INTO Conditions (name, description) VALUES 
('Sinus Infection', 'An infection that causes inflammation of the sinus cavities, leading to pain and pressure.'),
('Type 2 Diabetes', 'A chronic condition that affects the way the body processes blood sugar (glucose).'),
('Fractured Wrist', 'A break in one of the bones in the wrist, causing pain and swelling.'),
('Psoriasis', 'An autoimmune condition that causes the rapid growth of skin cells, leading to scaling on the skin.');

-- Inserting sample data into Visits
INSERT INTO Visits (date, doctor_id, patient_id, notes) VALUES 
('2023-10-01', 1, 1, 'General check-up, patient complains of nasal congestion.'),
('2023-10-15', 2, 2, 'Consulted for sinus infection, prescribed nasal spray.'),
('2023-10-20', 3, 3, 'Skin condition assessed, treatment plan initiated.');

-- Inserting sample data into Patient_Conditions
INSERT INTO Patient_Conditions (patient_id, condition_id) VALUES 
(1, 1),  -- Bilbo Baggins has a Sinus Infection
(2, 2),  -- Frodo Baggins has Type 2 Diabetes
(3, 3);  -- Thorin Oakenshield has a Fractured Wrist


-- Data Model Overview for Medical Center
--Entities and Attributes
-- Doctors
-- doctor_id (Primary Key)
-- name
-- specialty
-- phone

-- Patients
-- patient_id (Primary Key)
-- name
-- dob
-- phone
-- primary_doctor_id (Foreign Key referencing Doctors)

-- Conditions
-- condition_id (Primary Key)
-- name
-- description

-- Visits
-- visit_id (Primary Key)
-- date
-- doctor_id (Foreign Key referencing Doctors)
-- patient_id (Foreign Key referencing Patients)
-- notes

-- Patient_Conditions
-- patient_id (Foreign Key referencing Patients, part of Composite Key)
-- condition_id (Foreign Key referencing Conditions, part of Composite Key)
-- PRIMARY KEY (patient_id, condition_id)

-- Relationships
-- Doctors to Patients: One-to-Many
-- A doctor can be the primary doctor for many patients.

-- Patients to Visits: One-to-Many
-- A patient can have many visits to different doctors.

-- Doctors to Visits: One-to-Many
-- A doctor can see many patients in different visits.

-- Patients to Conditions: Many-to-Many (through Patient_Conditions)
-- A patient can have multiple conditions, and each condition can affect multiple patients.