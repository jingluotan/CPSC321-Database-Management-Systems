
/*======================================================================
 * 
 *  NAME:    ... Keyu Chen ...
 *  ASSIGN:  HW-3, Part 2
 *  COURSE:  CPSC 321, Fall 2024
 *  DESC:    ... description ....
 * write an SQL query against your world factbook tables from Part 1 above
 *======================================================================*/


-- TODO:
--   * Fill in your name above and a brief description.
--   * Implement each query below as per the homework instructions.
--   * Be sure each query has a comment as described in the homework.
--   * Be sure your SQL code is well formatted (according to the style guides).


-- 1. 
-- Result: find all provinces that have a small total area (50000) that are in a country with high inflation (2.0).
-- returns the country code, country name, inflation, province name, and area of provinces that meet the conditions.
-- Example: Mexico: area is 34339, inflation is 4.2
SELECT p.country_code, c.country_name, c.inflation, p.province_name, p.area
FROM Province p, Country c
WHERE p. country_code = c. country_code
AND p. area < 50000
AND c. inflation > 2.0
ORDER BY c.inflation DESC, p.country_code ASC, p.area ASC;

-- 2. 
-- Result: Rewrite your query in (1) to use appropriate JOIN syntax instead of a comma join
-- Example: Mexico: area is 34339, inflation is 4.2
SELECT p.country_code, c.country_name, c.inflation, p.province_name, p.area
FROM Province p JOIN Country c USING (country_code)
WHERE p. area < 50000
AND c. inflation > 2.0
ORDER BY c.inflation DESC, p.country_code ASC, p.area ASC;

-- 3.
-- Result: finds the unique set of all provinces that have at least one city with a population greater than a specific value (1500000)
-- returns the country code, country name, province name, and province area of provinces that have at least one city with a population over 1,500,000.
-- Example: Ontario in Canada
SELECT DISTINCT p.country_code, c.country_name, p.province_name, p.area
FROM Province p, City ci, Country c
WHERE p. country_code = c. country_code
AND p. province_name = ci. province_name
AND p. country_code = ci. country_code
AND ci. population > 1500000;

-- 4. 
-- Result: Rewrite your query from (3) using JOIN syntax for all of the joins
-- Example: Ontario in Canada
SELECT DISTINCT p.country_code, c.country_name, p.province_name, p.area
FROM Province p
JOIN City ci ON (ci.province_name = p. province_name) AND (ci. country_code = p. country_code)
JOIN Country c ON (p. country_code = c. country_code)
WHERE ci. population > 1500000;

-- 5. 
-- Result: finds the unique set of all provinces with at least two cities having a population greater than a specific value (1500000). 
-- return the country code, country name, province name, and province area
-- Example: Beijing and Guangdong
SELECT DISTINCT c.country_code, c.country_name, p.province_name, p.area
FROM Province p, City ci1, City ci2, Country c
WHERE c.country_code = p.country_code
AND p.province_name = ci1.province_name
AND p.country_code = ci1.country_code
AND p.province_name = ci2.province_name
AND p.country_code = ci2.country_code
AND ci1.population > 1500000 
AND ci2.population > 1500000
AND ci1.city_name != ci2.city_name;

-- 6. 
-- Result: Rewrite your query from (5) using JOIN syntax for all of the joins.
-- Example: Beijing and Guangdong
SELECT DISTINCT c.country_code, c.country_name, p.province_name, p.area
FROM Province p
JOIN Country c ON c.country_code = p.country_code
JOIN City ci1 ON p.province_name = ci1.province_name AND p.country_code = ci1.country_code
JOIN City ci2 ON p.province_name = ci2.province_name AND p.country_code = ci2.country_code
WHERE ci1.population > 1500000 
AND ci2.population > 1500000
AND ci1.city_name != ci2.city_name;

-- 7. 
-- Result: finds pairs of different cities with the same population
-- returns the city names, province names, country codes, and population for pairs of cities with the same population but in different provinces or countries.
-- Example: NULL
SELECT ci1.city_name, ci1.province_name, ci1.country_code, ci1.population, ci2.city_name, ci2.province_name, ci2.country_code
FROM City ci1
JOIN City ci2 ON (ci1. population = ci2. population)
WHERE ci1. city_name != ci2. city_name
OR ci1. province_name != ci2. province_name 
OR ci1. country_code != ci2. country_code;


-- 8. 
-- Result: finds all countries with a high GDP (40000) and low inflation (2.0) that border a country with a low GDP (20000) and high inflation (3.0).
-- returns the country code and country name of countries that meet the conditions.
-- Example: Canada
SELECT DISTINCT c1.country_code, c1.country_name
FROM Country c1, Country c2, Border b
WHERE c1.gdp > 40000 AND c1.inflation < 2.0
AND c2.gdp < 20000 AND c2.inflation > 3.0
AND c1.country_code = b.country_code_1
AND c2.country_code = b.country_code_2;


-- 9. 
-- Result: Rewrite your query from (9) using JOIN syntax for all of the joins.
-- Example: Canada
SELECT DISTINCT c1. country_code, c1. country_name
FROM Border b
JOIN Country c2 ON (c2. country_code = b. country_code_2)
JOIN Country c1 ON (c1. country_code = b. country_code_1)
WHERE c1. gdp > 40000 AND c1. inflation < 2.0
AND c2. gdp < 20000 AND c2. inflation > 3.0;

-- 10. 
-- Result: finding pairs of cities in the same province where both cities have a population greater than 2,000,000, and the province has an area smaller than 20,000.
-- Example: Pudong in Shanghai
SELECT DISTINCT c1.city_name, c1.population, c2.city_name, c2.population, p.province_name, p.area
FROM Province p
JOIN City c1 ON (p.province_name = c1.province_name)
AND (p.country_code = c1.country_code)
JOIN City c2 ON (p.province_name = c2.province_name)
AND (p.country_code = c2.country_code)
WHERE c1.population > 2000000
AND c2.population > 2000000
AND c1.city_name != c2.city_name
AND p.area < 20000
ORDER BY c1.population DESC, c2.population DESC;


