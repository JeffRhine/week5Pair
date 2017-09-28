-- Write queries to return the following:
-- Make the following changes in the "world" database.

-- 1. Add Superman's hometown, Smallville, Kansas to the city table. The 
-- countrycode is 'USA', and population of 45001. (Yes, I looked it up on 
-- Wikipedia.)
INSERT INTO city (id, name, countrycode,district,population)
VALUES (6000,'Smallville', 'USA','Kansas',45001);
-- 2. Add Kryptonese to the countrylanguage table. Kryptonese is spoken by 0.0001
-- percentage of the 'USA' population.
INSERT INTO countrylanguage (language, countrycode, isofficial, percentage) 
VALUES ('Krytonese', 'USA', false, .0001);
-- 3. After heated debate, "Kryptonese" was renamed to "Krypto-babble", change 
-- the appropriate record accordingly.
UPDATE countrylanguage SET language='Krypto-babble' WHERE language='Krytonese' AND countrycode='USA';
-- 4. Set the US captial to Smallville, Kansas in the country table.
UPDATE country SET capital=6000 WHERE code='USA';
-- 5. Delete Smallville, Kansas from the city table. (Did it succeed? Why?)
DELETE FROM city WHERE id=6000;
--won't delete because of foreign key error
-- 6. Return the US captial to Washington.
UPDATE country SET capital=3813 WHERE code='USA';
-- 7. Delete Smallville, Kansas from the city table. (Did it succeed? Why?)
DELETE FROM city WHERE id=6000;
-- 8. Reverse the "is the official language" setting for all languages where the
-- country's year of independence is within the range of 1800 and 1972 
-- (exclusive). 
-- (590 rows affected)
BEGIN TRANSACTION;

UPDATE countrylanguage
SET isofficial=NOT isofficial 
WHERE countrycode IN
(SELECT countrycode
FROM countrylanguage cl
JOIN country c ON c.code=cl.countrycode
WHERE c.indepyear>=1800 AND c.indepyear<=1972);

ROLLBACK;
-- 9. Convert population so it is expressed in 1,000s for all cities. (Round to
-- the nearest integer value greater than 0.)
-- (4079 rows affected)
BEGIN TRANSACTION;

UPDATE city
SET population=ROUND(population/1000);
SELECT * FROM city

COMMIT;
ROlLBACK;
-- 10. Assuming a country's surfacearea is expressed in miles, convert it to 
-- meters for all countries where French is spoken by more than 20% of the 
-- population.
-- (7 rows affected)
BEGIN TRANSACTION;

UPDATE country
SET surfacearea=surfacearea*1609.34
WHERE code IN(
SELECT c.code 
FROM country c
JOIN countrylanguage cl ON c.code=cl.countrycode
WHERE cl.language='French' AND cl.percentage>20)