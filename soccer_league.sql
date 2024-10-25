-- from the terminal run:
-- psql < soccer_league.sql

DROP DATABASE IF EXISTS soccer_league;

CREATE DATABASE soccer_league;

\c soccer_league

CREATE TABLE Teams (
    team_id INT PRIMARY KEY,
    team_name VARCHAR(100),
    city VARCHAR(100),
    rank INT
);

CREATE TABLE Players (
    player_id INT PRIMARY KEY,
    player_name VARCHAR(100),
    team_id INT,
    position VARCHAR(50),
    FOREIGN KEY (team_id) REFERENCES Teams(team_id)
);

CREATE TABLE Matches (
    match_id INT PRIMARY KEY,
    home_team_id INT,
    away_team_id INT,
    date DATE,
    home_score INT,
    away_score INT,
    FOREIGN KEY (home_team_id) REFERENCES Teams(team_id),
    FOREIGN KEY (away_team_id) REFERENCES Teams(team_id)
);

CREATE TABLE Goals (
    goal_id INT PRIMARY KEY,
    match_id INT,
    player_id INT,
    time_scored TIME,
    FOREIGN KEY (match_id) REFERENCES Matches(match_id),
    FOREIGN KEY (player_id) REFERENCES Players(player_id)
);

CREATE TABLE Referees (
    referee_id INT PRIMARY KEY,
    referee_name VARCHAR(100)
);

CREATE TABLE Match_Referees (
    match_id INT,
    referee_id INT,
    PRIMARY KEY (match_id, referee_id),
    FOREIGN KEY (match_id) REFERENCES Matches(match_id),
    FOREIGN KEY (referee_id) REFERENCES Referees(referee_id)
);

CREATE TABLE Seasons (
    season_id INT PRIMARY KEY,
    start_date DATE,
    end_date DATE
);

-- Teams
INSERT INTO Teams (team_id, team_name, city, rank) VALUES (1, 'Fellowship FC', 'Rivendell', 1);
INSERT INTO Teams (team_id, team_name, city, rank) VALUES (2, 'Orcish United', 'Mordor', 2);

-- Players
INSERT INTO Players (player_id, player_name, team_id, position) VALUES (1, 'Frodo Baggins', 1, 'Forward');
INSERT INTO Players (player_id, player_name, team_id, position) VALUES (2, 'Legolas Greenleaf', 1, 'Midfielder');
INSERT INTO Players (player_id, player_name, team_id, position) VALUES (3, 'Gimli', 1, 'Defender');
INSERT INTO Players (player_id, player_name, team_id, position) VALUES (4, 'Azog the Defiler', 2, 'Forward');
INSERT INTO Players (player_id, player_name, team_id, position) VALUES (5, 'Sauron', 2, 'Midfielder');

-- Matches
INSERT INTO Matches (match_id, home_team_id, away_team_id, date, home_score, away_score) VALUES (1, 1, 2, '2024-10-01', 3, 1);

-- Goals
INSERT INTO Goals (goal_id, match_id, player_id, time_scored) VALUES (1, 1, 1, '00:10:00'); -- Frodo scores
INSERT INTO Goals (goal_id, match_id, player_id, time_scored) VALUES (2, 1, 2, '00:20:00'); -- Legolas scores
INSERT INTO Goals (goal_id, match_id, player_id, time_scored) VALUES (3, 1, 4, '00:30:00'); -- Azog scores

-- Referees
INSERT INTO Referees (referee_id, referee_name) VALUES (1, 'Gandalf the Grey');

-- Match_Referees
INSERT INTO Match_Referees (match_id, referee_id) VALUES (1, 1);

-- Seasons
INSERT INTO Seasons (season_id, start_date, end_date) VALUES (1, '2024-08-01', '2025-05-31');


-- Data Model Overview for Soccer League
--Entities and Attributes

-- Teams
-- Attributes:
-- team_id (Primary Key)
-- team_name
-- city
-- rank (could be based on standings)

-- Players
-- Attributes:
-- player_id (Primary Key)
-- player_name
-- team_id (Foreign Key referencing Teams)
-- position

-- Matches
-- Attributes:
-- match_id (Primary Key)
-- home_team_id (Foreign Key referencing Teams)
-- away_team_id (Foreign Key referencing Teams)
-- date
-- home_score
-- away_score

-- Goals
-- Attributes:
-- goal_id (Primary Key)
-- match_id (Foreign Key referencing Matches)
-- player_id (Foreign Key referencing Players)
-- time_scored

-- Referees
-- Attributes:
-- referee_id (Primary Key)
-- referee_name

-- Match_Referees (to capture many-to-many relationship)
-- Attributes:
-- match_id (Foreign Key referencing Matches)
-- referee_id (Foreign Key referencing Referees)

-- Seasons
-- Attributes:
-- season_id (Primary Key)
-- start_date
-- end_date


-- Diagram

-- Teams (1) ↔ (M) Players
-- Teams (1) ↔ (M) Matches (as home/away)
-- Matches (1) ↔ (M) Goals
-- Matches (M) ↔ (M) Referees (through Match_Referees)
-- Seasons (1) ↔ (M) Matches