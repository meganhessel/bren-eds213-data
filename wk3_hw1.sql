
-- PROBLEM 1 --- 

--  Figure out: What the AVG function returns if there are NULL values in the column being averaged. 

-- 1. Create a table with single column that has data type REAL 
CREATE TEMP TABLE mytable (
    colname REAL );


-- 2.  Insert some real numbers and at least one NULL into the table.
INSERT INTO mytable (colname)
   VALUES (1),
   (2), 
   (NULL),
   (4), 
   (5);

-- 3. AVG on the column 
SELECT AVG(colname) FROM mytable; 

-- DISCUSSION:
-- What would the average be if the function ignored NULLs? 12/4 = 3 
-- What would the average be if it somehow factored them in? 12/5 = 2.4 
-- What is actually returned? 3.0 - ignored the NULL values! 

-- Compute the average value without AVG 
SELECT SUM(colname)/COUNT(*) FROM mytable;
-- returns: 2.4 - Factored NULL in 

SELECT SUM(colname)/COUNT(colname) FROM mytable;
-- returns: 3.0 - Ignored NULL

-- Delete the table 
DROP TABLE mytable;



-- PROBLEM 2 --- 

-- This Query is flawed! 
SELECT Site_name, MAX(Area) FROM Site;
-- The is a grouping / aggregating chunk. But it doesn't have a GROUP BY parameter.
-- Therefore, SQL doesn't know how to group this request. 
-- Should look like this below: 
SELECT Site_name, MAX(Area) FROM Site GROUP BY Site_name;

-- Find the site name and area of the site having the largest area 
SELECT Site_name, Area
    FROM Site 
    ORDER BY Area DESC
    LIMIT 1;

-- Nested query 
-- Create a query that finds the maximum area.
SELECT max(Area) FROM Site;
-- Create a query that selects the site name and area of the site whose area equals the maximum
SELECT Site_name, Area 
    FROM Site 
    WHERE Area = (SELECT max(Area) FROM Site);



-- PROBLEM 3 -- 
-- List the scientific names of bird species in descending order of their maximum average egg volumes. 

SELECT Species.Scientific_name, Max(Averages.Avg_volume) AS MaxAvg_Volume FROM Bird_nests -- Selecting tables.columns needed 
    -- Joining the 2 other tables 
    JOIN Species On Bird_nests.Species = Species.Code 
    JOIN Averages USING (Nest_ID)
    -- Grouping by Scientific_name and ordering by MaxAvg_Volume
    GROUP BY Species.Scientific_name
    ORDER BY MaxAvg_Volume DESC;

