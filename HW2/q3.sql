
/*======================================================================
 * 
 *  NAME:    ... Keyu Chen...
 *  ASSIGN:  HW-2, Question 3
 *  COURSE:  CPSC 321, Fall 2024
 *  DESC:    ... description ....
 Design relation schemas for storing the following information about music albums, 
 tracks, songs, music groups, group members (artists), music genres, and record labels
 *======================================================================*/


-- TODO:
--   * Fill in your name above and a brief description.
--   * Implement the question 3 schema as per the homework instructions.
--   * Populate each table according to the homework instructions.
--   * Be sure each table has a comment describing its purpose.
--   * Be sure to add comments as needed for attributes.
--   * Be sure your SQL code is well formatted (according to the style guides).

-- Drop the tables in the correct order, handling dependencies
DROP TABLE IF EXISTS GroupInfluences;
DROP TABLE IF EXISTS Group_genres;
DROP TABLE IF EXISTS Group_member;
DROP TABLE IF EXISTS Tracks;
DROP TABLE IF EXISTS SongWriters;
DROP TABLE IF EXISTS Songs;
DROP TABLE IF EXISTS Music_albums;
DROP TABLE IF EXISTS Music_groups;
DROP TABLE IF EXISTS Artists;
DROP TABLE IF EXISTS Music_genres;

-- Step 1: Create tables in the correct order to resolve foreign key dependencies

-- Create Music_groups table
CREATE TABLE Music_groups (
    name VARCHAR NOT NULL UNIQUE,
    formed_year INT NOT NULL,
    PRIMARY KEY (name)
);

-- Create Artists table
CREATE TABLE Artists (
    name VARCHAR NOT NULL UNIQUE,
    birth_year INT NOT NULL,
    PRIMARY KEY (name)
);

-- Create Music_genres table
CREATE TABLE Music_genres (
    label VARCHAR NOT NULL UNIQUE,
    description TEXT NOT NULL,
    PRIMARY KEY (label)
);

-- Create Music_albums table
CREATE TABLE Music_albums (
    title VARCHAR NOT NULL,
    recorded_year INT NOT NULL,
    recorded_group VARCHAR NOT NULL,
    record_label VARCHAR NOT NULL,
    PRIMARY KEY (title, recorded_group),
    FOREIGN KEY (recorded_group) REFERENCES Music_groups(name)
);

-- Create Songs table
CREATE TABLE Songs (
    title VARCHAR PRIMARY KEY,   
    year_written INT NOT NULL
);

-- Create SongWriters table
CREATE TABLE SongWriters (
    song_title VARCHAR NOT NULL,   
    artist_name VARCHAR NOT NULL, 
    PRIMARY KEY (song_title, artist_name), 
    FOREIGN KEY (song_title) REFERENCES Songs(title),
    FOREIGN KEY (artist_name) REFERENCES Artists(name)
);

-- Create Tracks table
CREATE TABLE Tracks (
    track_id INT NOT NULL UNIQUE,
    album_title VARCHAR NOT NULL,
    song VARCHAR NOT NULL,
    year INT NOT NULL,
    artist VARCHAR NOT NULL,
    PRIMARY KEY (track_id),
    FOREIGN KEY (song) REFERENCES Songs(title),
    FOREIGN KEY (artist) REFERENCES Artists(name)
);

-- Create Group_member table
CREATE TABLE Group_member (
    artist_name VARCHAR NOT NULL,
    group_name VARCHAR NOT NULL,
    start_year INT NOT NULL,
    end_year INT,
    PRIMARY KEY (artist_name, group_name, start_year),
    FOREIGN KEY (artist_name) REFERENCES Artists(name),
    FOREIGN KEY (group_name) REFERENCES Music_groups(name),
    CHECK (start_year <= end_year OR end_year IS NULL)
);

-- Create Group_genres table
CREATE TABLE Group_genres (
    group_name VARCHAR NOT NULL,
    genre_label VARCHAR NOT NULL,
    PRIMARY KEY (group_name, genre_label),
    FOREIGN KEY (group_name) REFERENCES Music_groups(name),
    FOREIGN KEY (genre_label) REFERENCES Music_genres(label)
);

-- Create GroupInfluences table
CREATE TABLE GroupInfluences (
    group_name VARCHAR NOT NULL, 
    influenced_by VARCHAR NOT NULL, 
    PRIMARY KEY (group_name, influenced_by),
    FOREIGN KEY (group_name) REFERENCES Music_groups(name),
    FOREIGN KEY (influenced_by) REFERENCES Music_groups(name)
);

-- Insert data into Music_groups
INSERT INTO Music_groups (name, formed_year) VALUES 
('Linkin Park', 1996),
('The Beatles', 1960),
('BigBang', 2006),
('Depeche Mode', 1980),
('Radiohead', 1985),
('Pink Floyd', 1965),
('The Pixies', 1986),
('Coldplay', 1997),
('Nirvana', 1987),
('Queen', 1970);  

-- Insert data into Artists
INSERT INTO Artists (name, birth_year) VALUES 
('G-Dragon', 1988),
('Mike Shinoda', 1977),
('T.O.P', 1987),
('John Lennon', 1940),
('Freddie Mercury', 1946),  
('Chris Martin', 1977),
('Thom Yorke', 1968);

-- Insert data into Group_member
INSERT INTO Group_member (artist_name, group_name, start_year, end_year) VALUES 
('Mike Shinoda', 'Linkin Park', 1996, NULL),  
('T.O.P', 'BigBang', 2006, 2022),              
('John Lennon', 'The Beatles', 1960, 1969),  
('Freddie Mercury', 'Queen', 1970, 1991),  
('Chris Martin', 'Coldplay', 1997, NULL),
('Thom Yorke', 'Radiohead', 1985, NULL);

-- Insert data into Music_genres
INSERT INTO Music_genres (label, description) VALUES 
('Alternative rock', 'A category of rock music that evolved from the independent music underground of the 1970s.'),
('Rock', 'A broad genre of popular music characterized by amplified instruments and rhythms.'),
('K-pop', 'A genre of popular music originating in South Korea, known for its blend of various musical elements and choreography.'),
('Pop', 'A genre of popular music that originated in its modern form during the mid-1950s.'),  
('Progressive rock', 'A broad genre of rock music known for its experimentation and ambitious compositions.');

-- Insert data into Group_genres
INSERT INTO Group_genres (group_name, genre_label) VALUES 
('Linkin Park', 'Alternative rock'),
('BigBang', 'K-pop'),
('The Beatles', 'Rock'),
('Coldplay', 'Pop'),     
('Radiohead', 'Alternative rock'),
('Queen', 'Progressive rock');

-- Insert data into GroupInfluences
INSERT INTO GroupInfluences (group_name, influenced_by) VALUES
('Linkin Park', 'Depeche Mode'),
('Coldplay', 'Radiohead'),
('Radiohead', 'Pink Floyd'),
('Nirvana', 'The Pixies'),
('Queen', 'The Beatles');  

-- Insert data into Songs
INSERT INTO Songs (title, year_written) VALUES 
('In the End', 2001),
('Boys-Live/Remastered', 2016),
('IF YOU', 2015),
('Bohemian Rhapsody', 1975),  
('Fix You', 2005),
('Creep', 1992);

-- Insert data into SongWriters
INSERT INTO SongWriters (song_title, artist_name) VALUES 
('In the End', 'Mike Shinoda'),    
('Boys-Live/Remastered', 'John Lennon'), 
('IF YOU', 'G-Dragon'),  
('Bohemian Rhapsody', 'Freddie Mercury'),  
('Fix You', 'Chris Martin'),
('Creep', 'Thom Yorke');

-- Insert data into Tracks
INSERT INTO Tracks (track_id, album_title, song, year, artist) VALUES 
(1, 'Papercuts', 'In the End', 2001, 'Mike Shinoda'), 
(2, 'Live At The Hollywood Bowl', 'Boys-Live/Remastered', 2016, 'John Lennon'),  
(3, 'Made Series', 'IF YOU', 2016, 'G-Dragon'),  
(4, 'A Night at the Opera', 'Bohemian Rhapsody', 1975, 'Freddie Mercury'),  
(5, 'Parachutes', 'Fix You', 2005, 'Chris Martin'),  
(6, 'OK Computer', 'Creep', 1992, 'Thom Yorke');  


-- Insert data into Music_albums
INSERT INTO Music_albums (title, recorded_year, recorded_group, record_label) VALUES 
('Papercuts', 2024, 'Linkin Park', 'Warner'),
('Live At The Hollywood Bowl', 2016, 'The Beatles', 'Apple Corps'),
('Made Series', 2016, 'BigBang', 'YG Entertainment'),
('A Night at the Opera', 1975, 'Queen', 'EMI'), 
('Parachutes', 2000, 'Coldplay', 'Parlophone'),
('OK Computer', 1997, 'Radiohead', 'Capitol');
