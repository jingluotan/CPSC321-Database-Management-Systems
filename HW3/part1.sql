
/*======================================================================
 * 
 *  NAME:    ... Keyu Chen ...
 *  ASSIGN:  HW-3, Part 1
 *  COURSE:  CPSC 321, Fall 2024
 *  DESC:    ... description ....
 * Create four tables for country, province, city and border
 *======================================================================*/


-- TODO:
--   * Fill in your name above and a brief description.
--   * Implement the question 1 schema as per the homework instructions.
--   * Populate each table according to the homework instructions.
--   * Be sure each table has a comment describing its purpose.
--   * Be sure to add comments as needed for attributes.
--   * Be sure your SQL code is well formatted (according to the style guides).

DROP TABLE IF EXISTS Border;
DROP TABLE IF EXISTS City;
DROP TABLE IF EXISTS Province;
DROP TABLE IF EXISTS Country;

-- Create table for Country
CREATE TABLE Country (
    country_code CHAR(2) NOT NULL,  
    country_name VARCHAR NOT NULL,  
    gdp INT NOT NULL, 
    inflation NUMERIC(5, 2) NOT NULL,
    PRIMARY KEY (country_code)
);

-- Create table for Province
CREATE TABLE Province (
    province_name VARCHAR NOT NULL, 
    country_code CHAR(2) NOT NULL, 
    area NUMERIC(10, 2) NOT NULL,  

    PRIMARY KEY (province_name, country_code),  
    FOREIGN KEY (country_code) REFERENCES Country(country_code) 
);

-- Create table for City
CREATE TABLE City (
    city_name VARCHAR NOT NULL, 
    province_name VARCHAR NOT NULL, 
    country_code CHAR(2) NOT NULL, 
    population INT NOT NULL, 

    PRIMARY KEY (city_name, province_name, country_code), 
    FOREIGN KEY (province_name, country_code) REFERENCES Province(province_name, country_code)  -- Foreign key to Province
);

-- Create table for Border
CREATE TABLE Border (
    country_code_1 CHAR(2) NOT NULL, 
    country_code_2 CHAR(2) NOT NULL, 
    border_length NUMERIC(10, 2) NOT NULL, 

    PRIMARY KEY (country_code_1, country_code_2), 
    FOREIGN KEY (country_code_1) REFERENCES Country(country_code),  
    FOREIGN KEY (country_code_2) REFERENCES Country(country_code) 
);

-- Insert sample data into Country table --
INSERT INTO Country (country_code, country_name, gdp, inflation) VALUES
('CN', 'China', 42000, 1.2),
('US', 'United States of America', 46900, 3.8),
('CA', 'Canada', 42000, 1.5),
('MX', 'Mexico', 9000, 4.2);

-- Insert sample data into Province table --
INSERT INTO Province (province_name, country_code, area) VALUES
('Beijing', 'CN', 16411),
('Shanghai', 'CN', 6340),
('Guangdong', 'CN', 179800),
('Sichuan', 'CN', 485000),

('Florida', 'US', 423967),
('Texas', 'US', 695662),
('Washington', 'US', 793904),
('California', 'US', 1698904),

('Ontario', 'CA', 1076395),
('Quebec', 'CA', 1542056),
('British Columbia', 'CA', 944735),
('Alberta', 'CA', 661848),

('Jalisco', 'MX', 78539),
('Nuevo Leon', 'MX', 64468),
('Chihuahua', 'MX', 247455),
('Puebla', 'MX', 34339);


-- Insert cities for each province in the US
INSERT INTO City (city_name, province_name, country_code, population) VALUES
('Los Angeles', 'California', 'US', 4000000),
('San Francisco', 'California', 'US', 884000),
('San Diego', 'California', 'US', 1419516),
('Sacramento', 'California', 'US', 500930),

('Houston', 'Texas', 'US', 2320000),
('Dallas', 'Texas', 'US', 1340000),
('Austin', 'Texas', 'US', 964254),
('San Antonio', 'Texas', 'US', 1532233),

('Seattle', 'Washington', 'US', 744955),
('Spokane', 'Washington', 'US', 222081),
('Tacoma', 'Washington', 'US', 217827),
('Vancouver', 'Washington', 'US', 184463),

('Miami', 'Florida', 'US', 470914),
('Tampa', 'Florida', 'US', 385430),
('Orlando', 'Florida', 'US', 307573),
('Jacksonville', 'Florida', 'US', 911507),

('Toronto', 'Ontario', 'CA', 2731000),
('Ottawa', 'Ontario', 'CA', 934243),
('Mississauga', 'Ontario', 'CA', 721599),
('Brampton', 'Ontario', 'CA', 593638),

('Montreal', 'Quebec', 'CA', 1704694),
('Quebec City', 'Quebec', 'CA', 531902),
('Laval', 'Quebec', 'CA', 422993),
('Gatineau', 'Quebec', 'CA', 276245),

('Vancouver', 'British Columbia', 'CA', 631486),
('Victoria', 'British Columbia', 'CA', 85792),
('Surrey', 'British Columbia', 'CA', 517887),
('Burnaby', 'British Columbia', 'CA', 232755),

('Calgary', 'Alberta', 'CA', 1336000),
('Edmonton', 'Alberta', 'CA', 981280),
('Red Deer', 'Alberta', 'CA', 103588),
('Lethbridge', 'Alberta', 'CA', 101482),

('Guadalajara', 'Jalisco', 'MX', 1495182),
('Zapopan', 'Jalisco', 'MX', 1418342),
('Tlaquepaque', 'Jalisco', 'MX', 608114),
('Puerto Vallarta', 'Jalisco', 'MX', 291839),

('Monterrey', 'Nuevo Leon', 'MX', 1135512),
('Guadalupe', 'Nuevo Leon', 'MX', 673616),
('San Nicolas', 'Nuevo Leon', 'MX', 443273),
('Apodaca', 'Nuevo Leon', 'MX', 536436),

('Chihuahua City', 'Chihuahua', 'MX', 878062),
('Ciudad Juarez', 'Chihuahua', 'MX', 1508255),
('Delicias', 'Chihuahua', 'MX', 139152),
('Cuauhtemoc', 'Chihuahua', 'MX', 168482),

('Puebla City', 'Puebla', 'MX', 1434062),
('Tehuacan', 'Puebla', 'MX', 319375),
('Atlixco', 'Puebla', 'MX', 129702),
('San Martin Texmelucan', 'Puebla', 'MX', 155738),

('Beijing City', 'Beijing', 'CN', 21540000),
('Haidian', 'Beijing', 'CN', 3350000),
('Fengtai', 'Beijing', 'CN', 2110000),
('Daxing', 'Beijing', 'CN', 1700000),

('Shanghai City', 'Shanghai', 'CN', 24150000),
('Pudong', 'Shanghai', 'CN', 5560000),
('Minhang', 'Shanghai', 'CN', 2410000),
('Xuhui', 'Shanghai', 'CN', 1080000),

('Guangzhou', 'Guangdong', 'CN', 14043500),
('Shenzhen', 'Guangdong', 'CN', 12528300),
('Dongguan', 'Guangdong', 'CN', 8220200),
('Foshan', 'Guangdong', 'CN', 7207000),

('Chengdu', 'Sichuan', 'CN', 16330000),
('Mianyang', 'Sichuan', 'CN', 5246700),
('Nanchong', 'Sichuan', 'CN', 6281400),
('Yibin', 'Sichuan', 'CN', 4520800);

INSERT INTO Border (country_code_1, country_code_2, border_length) VALUES
('US', 'CA', 8891),  
('US', 'MX', 3145),  
('CA', 'MX', 0),     
('CN', 'CA', 0); 


