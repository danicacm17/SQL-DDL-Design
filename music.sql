DROP DATABASE IF EXISTS music;

CREATE DATABASE music;

\c music

CREATE TABLE artists (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE
);

CREATE TABLE producers (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE
);

CREATE TABLE songs (
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    duration_in_seconds INTEGER NOT NULL,
    release_date DATE NOT NULL,
    album TEXT NOT NULL,
    genre TEXT
);

CREATE TABLE song_artists (
    song_id INT REFERENCES songs(id),
    artist_id INT REFERENCES artists(id),
    PRIMARY KEY (song_id, artist_id)
);

CREATE TABLE song_producers (
    song_id INT REFERENCES songs(id),
    producer_id INT REFERENCES producers(id),
    PRIMARY KEY (song_id, producer_id)
);

-- Insert artists
INSERT INTO artists (name) VALUES
('Hanson'),
('Boyz II Men'),
('Paramore'),
('Kacey Musgraves'),
('No Doubt'),
('Blake Shelton'),
('Zac Brown Band'),
('Taking Back Sunday'),
('Carrie Underwood'),
('Chris Stapleton');

-- Insert producers
INSERT INTO producers (name) VALUES
('Dust Brothers'),
('Stephen Lironi'),
('Walter Afanasieff'),
('Jack Antonoff'),
('Greg Wells');

-- Insert songs
INSERT INTO songs (title, duration_in_seconds, release_date, album, genre) VALUES
('MMMBop', 238, '1997-04-15', 'Middle of Nowhere', 'Pop'),
('End of the Road', 240, '1991-08-31', 'Cooleyhighharmony', 'R&B'),
('Where's the Love?', 227, '1997-04-15', 'Middle of Nowhere', 'Pop'),
('Misery Business', 195, '2007-04-30', 'Riot!', 'Emo/Rock'),
('Tennessee Whiskey', 241, '2015-11-06', 'Traveller', 'Country'),
('I’m Just a Girl', 194, '1995-10-16', 'Tragic Kingdom', 'Rock'),
('God’s Country', 240, '2019-03-15', 'Fully Loaded: God’s Country', 'Country'),
('Chicken Fried', 257, '2008-06-30', 'The Foundation', 'Country'),
('A Decade Under the Influence', 231, '2004-06-01', 'Where You Want to Be', 'Emo/Rock'),
('Before He Cheats', 232, '2005-08-01', 'Some Hearts', 'Country');

-- Insert song-artist relationships
INSERT INTO song_artists (song_id, artist_id) VALUES
(1, 1),
(2, 2),
(3, 1),
(4, 3),
(5, 9),
(6, 4),
(7, 6),
(8, 7),
(9, 8),
(10, 9);

-- Insert song-producer relationships
INSERT INTO song_producers (song_id, producer_id) VALUES
(1, 1),
(2, 2),
(3, 1),
(4, 4),
(5, 3),
(6, 4),
(7, 5),
(8, 3),
(9, 2),
(10, 5);
