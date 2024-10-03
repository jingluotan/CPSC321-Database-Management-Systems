
/*======================================================================
 * 
 *  NAME:    ... Keyu Chen ...
 *  ASSIGN:  HW-2, Question 1
 *  COURSE:  CPSC 321, Fall 2024
 *  DESC:    ... description ....
 implement the aiport, airline, flight, and segment tables from HW-1
 *======================================================================*/


-- TODO:
--   * Fill in your name above and a brief description.
--   * Implement the question 1 schema as per the homework instructions.
--   * Populate each table according to the homework instructions.
--   * Be sure each table has a comment describing its purpose.
--   * Be sure to add comments as needed for attributes.
--   * Be sure your SQL code is well formatted (according to the style guides).

-- modify the table --
DROP TABLE IF EXISTS segment;
DROP TABLE IF EXISTS flight;
DROP TABLE IF EXISTS airline;
DROP TABLE IF EXISTS airport;


-- create "airport" table --
CREATE TABLE airport(
    id VARCHAR NOT NULL,
    name VARCHAR NOT NULL,
    city VARCHAR NOT NULL,
    state VARCHAR(2) NOT NULL,
    elevation INT NOT NULL,
    PRIMARY KEY (id)
);

-- create "airline" table --
CREATE TABLE airline(
    code VARCHAR NOT NULL,
    name VARCHAR NOT NULL,
    main_hub VARCHAR NOT NULL,
    yr_founded INT NOT NULL,
    PRIMARY KEY (code),
    FOREIGN KEY (main_hub) REFERENCES airport(id)
);

-- create "flight" table --
CREATE TABLE flight(
    airline VARCHAR NOT NULL,
    flight_number INT NOT NULL,
    departure VARCHAR NOT NULL,
    arrival VARCHAR NOT NULL,
    flights_per_wk INT NOT NULL,
    PRIMARY KEY (airline, flight_number),
    FOREIGN KEY (airline) REFERENCES airline(code),
    FOREIGN KEY (departure) REFERENCES airport(id),
    FOREIGN KEY (arrival) REFERENCES airport(id)
);

-- create "segment" table --
CREATE TABLE segment(
    airline VARCHAR NOT NULL,
    flight_number INT NOT NULL,
    segment_offset INT NOT NULL,
    start_airport VARCHAR NOT NULL,
    end_airport VARCHAR NOT NULL,
    PRIMARY KEY (airline, flight_number, segment_offset),
    FOREIGN KEY (airline, flight_number) REFERENCES flight(airline, flight_number),
    FOREIGN KEY (start_airport) REFERENCES airport(id),
    FOREIGN KEY (end_airport) REFERENCES airport(id)
);

-- Insert data into the airport table --
INSERT INTO airport (id, name, city, state, elevation) VALUES
('SEA', 'Seattle-Tacoma International', 'Seattle', 'WA', 433),
('LAX', 'Los Angeles International', 'Los Angeles', 'CA', 128),
('PDX', 'Portland International', 'Portland', 'OR', 30),
('JFK', 'John F. Kennedy International', 'New York', 'NY', 13),
('GEG', 'Spokane International', 'Spokane', 'WA', 2385),
('DAL', 'Dallas Love Field', 'Dallas', 'TX', 487), 
('ORD', 'Chicago OHare International', 'Chicago', 'IL', 672),  
('DFW', 'Dallas/Fort Worth International', 'Dallas', 'TX', 607), 
('ATL', 'Hartsfield-Jackson Atlanta International', 'Atlanta', 'GA', 1026); 

-- Insert data into the airline table --
INSERT INTO airline (code, name, main_hub, yr_founded) VALUES
('AS', 'Alaska Airlines', 'SEA', 1932),
('WN', 'Southwest Airlines', 'DAL', 1967), 
('UA', 'United Airlines', 'ORD', 1926),
('AA', 'American Airlines', 'DFW', 1926),
('DL', 'Delta Airlines', 'ATL', 1928);

-- Insert data into the flight table --
INSERT INTO flight (airline, flight_number, departure, arrival, flights_per_wk) VALUES
('AS', 1, 'SEA', 'PDX', 20),
('WN', 2, 'LAX', 'SEA', 10),
('UA', 3, 'PDX', 'LAX', 14),
('AA', 4, 'JFK', 'LAX', 12),
('DL', 5, 'PDX', 'SEA', 18);

-- Insert data into the segment table --
INSERT INTO segment (airline, flight_number, segment_offset, start_airport, end_airport) VALUES
('AS', 1, 1, 'PDX', 'SEA'),
('WN', 2, 2, 'LAX', 'PDX'),
('UA', 3, 1, 'SEA', 'LAX'),
('AA', 4, 3, 'JFK', 'LAX'),
('DL', 5, 2, 'PDX', 'SEA');
