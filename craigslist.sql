-- from the terminal run:
-- psql < craigslist.sql

DROP DATABASE IF EXISTS craigslist;

CREATE DATABASE craigslist;

\c craigslist

CREATE TABLE Regions (
    region_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    preferred_region_id INT,
    FOREIGN KEY (preferred_region_id) REFERENCES Regions(region_id)
);

CREATE TABLE Posts (
    post_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL,
    text TEXT NOT NULL,
    user_id INT,
    location VARCHAR(200) NOT NULL,
    region_id INT,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (region_id) REFERENCES Regions(region_id)
);

CREATE TABLE Categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE Post_Categories (
    post_id INT,
    category_id INT,
    PRIMARY KEY (post_id, category_id),
    FOREIGN KEY (post_id) REFERENCES Posts(post_id),
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

-- Inserting sample data into Regions
INSERT INTO Regions (name) VALUES 
('San Francisco'), 
('Atlanta'), 
('Seattle');

-- Inserting sample data into Users
INSERT INTO Users (username, email, preferred_region_id) VALUES 
('HobbitFan', 'hobbitfan@example.com', 1),  -- Preferring San Francisco
('ElfLord', 'elflord@example.com', 2),      -- Preferring Atlanta
('DwarfKing', 'dwarfking@example.com', 3);  -- Preferring Seattle

-- Inserting sample data into Posts
INSERT INTO Posts (title, text, user_id, location, region_id) VALUES 
('Apartment for Rent', '2 bedroom apartment in the heart of the city.', 1, 'Downtown SF', 1),
('Job Opening: Software Engineer', 'Join our dynamic team!', 2, 'Midtown Atlanta', 2),
('For Sale: Vintage Guitar', 'In excellent condition, rare model.', 3, 'Capitol Hill', 3);

-- Inserting sample data into Categories
INSERT INTO Categories (name) VALUES 
('Housing'), 
('Jobs'), 
('For Sale');

-- Inserting sample data into Post_Categories
INSERT INTO Post_Categories (post_id, category_id) VALUES 
(1, 1),  -- Apartment for Rent belongs to Housing
(2, 2),  -- Job Opening belongs to Jobs
(3, 3);  -- Vintage Guitar belongs to For Sale


-- Data Model Overview for Craigslist
-- Entities and Attributes

-- Regions
-- region_id (Primary Key)
-- name (e.g., "San Francisco", "Atlanta", "Seattle")

-- Users
-- user_id (Primary Key)
-- username
-- email
-- preferred_region_id (Foreign Key referencing Regions)

-- Posts
-- post_id (Primary Key)
-- title
-- text
-- user_id (Foreign Key referencing Users)
-- location (specific location within the region)
-- region_id (Foreign Key referencing Regions)

-- Categories
-- category_id (Primary Key)
-- name (e.g., "Housing", "Jobs", "For Sale")

-- Post_Categories
-- post_id (Foreign Key referencing Posts, part of Composite Key)
-- category_id (Foreign Key referencing Categories, part of Composite Key)
-- PRIMARY KEY (post_id, category_id)

-- Relationships
-- Regions to Users (1 to N):
-- Each user can have a preferred region, but multiple users can prefer the same region.

-- Regions to Posts (1 to N):
-- Each post is associated with one region, but a region can have multiple posts.

-- Users to Posts (1 to N):
-- A user can create multiple posts, but each post is created by one user.

-- Posts to Categories (N to N):
-- Each post can belong to multiple categories, and each category can contain multiple posts, managed through the Post_Categories join table.