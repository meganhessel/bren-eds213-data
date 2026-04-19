-- Filteriung 
-- looks just like R or python 
SELECT * FROM Site WHERE Area < 200; 
SELECT * FROM Site WHERE Area < 200 AND Latitude > 60; 

-- order style operators 
SELECT * FROM Site WHERE Code != 'iglo';
SELECT * FROM Site WHERE Code <> 'iglo'; -- order style
-- expersion: 

## Experssion 
SELECT Site_name, Area*2.47 FROM Site;
-- Very handy to give a name to columns 
SELECT Site_name, Area*2.47 AS Area_acres FROM Site;

-- String concatentation 
-- old style operators: ||
SELECT Site_name || ', ' || Location AS Full_name Site;
-- There is probab;y other operators 
SElECT Site_name + Location FROM Site;

# Aggrigation and grouping 
-- How many rows are in this table? 

SELECT COUNT(*) FROM Bird_nests;
-- the "*" is the above means, just count rows 
-- we can also ask, how many NUll values are there ? 
SELECT COUNT(*) FROM Species;
SELECT COUNT(Scientific_name) FROM Species;

SELECT COUNT(DISTINCT Location) FROM Site; -- # of distinct locations 
SELECT COUNT(Location) FROM Site; -- # of non null locations 

SELECT DISTINCT Locations FROM Site;

-- usual aggregation functions 
SELECT AVG(Area) FROM Site; 
SELECT MIN(Area) FROM Site;

-- this wont work, but suppose we want to list the 7 locations thta occur in Site table along with average areas 
SELECT Location, AVG(Area) FROM Site;

-- enter grouning 
SELECT Location, AVG(Area) FROM Site GROUP BY Location;
SELECT Location, COUNT(*) FROM Site GROUP BY Location;

-- We can site have WHERE clauses
SELECT Location, COUNT(*)
    FROM Site 
    WHERE Location LIKE '%Canada' -- Old style pattern matching 
    GROUP BY Location;

-- The order of the calises reflect the order if the processing 
-- But want to filter on the groups (AFTER grouping)
SELECT Location, MAX(Area) AS Max_area -- Given nice name
    FROM Site
    WHERE Location LIKE '%Canada'
    GROUP BY Location 
    HAVING Max_area > 200 
    ORDER BY Max_area DESC;

## Relational Algerba 
-- Everttring is table! 
SELECT COUNT(*) FROM Site;
-- you can save tables, & nest quaries! 

-- How many rows in this table above? 
SELECT COUNT(*) FROM ( SELECT COUNT(*) FROM Site ); 

-- You can nest quaries! 
SELECT DISTINCT Species FROM Bird_nests; 

-- Select all code that is not in table above = NESTING 
SELECT Code FROM Species
    WHERE Code NOT IN ( SELECT DISTINCT Species FROM Bird_nests );

## Null processing 
-- Null is infectious 
-- in a table, null = no data / absence of a value 
-- In expression, null = unknown 

SELECT COUNT(*) FROM Bird_nests WHERE ageMETHOD = 'float';
SELECT COUNT(*) FROM Bird_nests WHERE ageMETHOD <> 'float'; 
-- '<>' = '!=' 

--  this wont work, but you will try it by accient anyway 
SELECT COUNT(*) FROM Bird_nests WHERE ageMETHOD = NULL; 

-- THE ONLY WAY 
SELECT COUNT(*) FROM Bird_nests WHERE ageMETHOD IS NULL; 

-- JOINS 
-- 90% of time, we join tables on foreign key relationship 
SELECT * FROM Camp_assignment;
SELECT * FROM Camp_assignment JOIN Personnel
    ON Observer = Abbreviation
    LIMIT 10;

-- Join is general operation, can be applied to any tables, with any expression joining them 
-- Fundamentally binds all objects
SELECT * FROM Site CROSS JOIN Species;

-- Lets see if this makes sense 
SELECT COUNT(*) FROM Site;
SELECT COUNT(*) FROM Species;
SELECT 99*16;

-- Any condition can be expression, we have complete freedom
-- But when there *is* a foreign jet relationship, then 
-- What happens 
-- the results is the same as the tabel with theforeign, but augmented wiuth additional columsn 

SELECT(*) FROM Bird_nests BN JOIN Species S
    ON BN.Species = S.Code
    Limit 5;
    
SELECT COUNT(*) FROM Bird_nests BN JOIN Species S
    ON BN.Species = S.Code;

-- Table alias 
-- if colnanes are ambigious, need to qualify them
-- The long way 
SELECT * FROM Bird_nests JOIN Species 
    ON Bird_nests.Species = Species.Code;
-- Shorter 
SELECT * FROM Bird_nests AS BN JOIN Species AS S
    ON BN.Species = S.Code;
-- Even shorter 
SELECT * FROM Bird_nests BN JOIN Species S
    ON BN.Species = S.Code;
