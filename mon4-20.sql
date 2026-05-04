--Frist review item: tri-value logic 
--expession can have a value 
--in selecting rows, null doesn;t cut it , NBULL doesnt count as TRUE 

SELECT COUNT(*) FROM Bird_nests
    WHERE floatAge <7 OR floatAge >= 7; -- doesnt get NULLS 

SELECT COUNT(*) FROM Bird_nests
    WHERE floatAge IS NULL;

-- review items relational algebra 
-- Everything is a table! Every operations returns a table! 

-- nesting selects 
SELECT Scientific_name 
    FROM Species 
    WHERE Code NOT IN ( SELECT DISTINCT Species FROM Bird_nests ); 

-- Can we get sam fuctionality of the SQL HAVING clause?? 

-- Using HAVING: 
SELECT Location, MAX(Area) AS Max_area -- give location and max area in Canada where area > 200 
    FROM Site 
    WHERE Location LIKE '%Canada' -- Applied to rows
    GROUP BY Location
    HAVING Max_area > 200; -- Applied to groups 

-- Use nesting quaries instead of HAVING: 
SELECT * FROM

    -- table of location and max area 
        (SELECT Location, MAX(Area) AS Max_area 
         FROM Site 
        WHERE Location LIKE '%Canada' 
        GROUP BY Location)

    WHERE Max_area > 200; -- Now we can use WHERE because the table is nested 


-- JOINS 
SELECT * FROM A CROSS JOIN B; 
SELECT * FROM A; 
SELECT * FROM B; 

-- FULL JOIN 
SELECT * FROM A CROSS JOIN B;

SELECT * FROM A JOIN B ON acol1 < bcol1;

-- INNER JOIN 
SELECT * FROM A INNER JOIN B ON acol1 < bcol1;

-- Outerjoin: We're adding rows from one tabel that never got matched. 

SELECT * FROM A RIGHT JOIN B ON acol1 < bcol1;
SELECT * FROM A LEFT JOIN B ON acol1 < bcol1;

SELECT * FROM A FULL OUTER JOIN B ON acol1 < bcol1;

-- Joining on a foriegn key relationship is way more common 
.schema

SELECT * FROM House;
SELECT * FROM Student;

SELECT * FROM Student S JOIN HOUSE H ON S.House_ID = H.HOUSE_ID;

-- Beneifit of joining on a column that has the same name, use the USING claude 
SELECT * FROM Student JOIN House USING (House_ID);
-- all rows from student tabel and house info is matched/added to the student rows 


-- For better viewing 
.mode line

-- Egg row all by itself 
SELECT * FROM Bird_eggs LIMIT 1;

-- Look at the entire row 
SELECT * FROM Bird_eggs JOIN Bird_nests USING (Nest_ID) LIMIT 1;

-- How many rows? 
SELECT COUNT(*) FROM Bird_eggs JOIN Bird_nests USING (Nest_ID);

-- IMPORTANT POINT! 
-- ORDER clauses should be the very last thing 
-- Ordering is assuredly lost doing a JOIN. So don't say this: 

SELECT * FROM  
    (SELECT * FROM Bird_eggs ORDER BY Width) -- This order is lost because of the join 
    JOIN Bird_nests 
    USING (Nest_ID);

-- nest id and number of rows
-- number of eggs in each nest 
SELECT Nest_ID, COUNT(*) 
    FROM Bird_nests JOIN Bird_eggs USING (NEST_ID)
    GROUP BY Nest_ID;

-- some databases allow you to say... 
SELECT Nest_ID, Species, COUNT(*) 
    FROM Bird_nests JOIN Bird_eggs USING (NEST_ID)
    GROUP BY Nest_ID;

-- workarounds: 
SELECT Nest_ID, ANY_VALUE(Species), COUNT(*) -- ANY_VALUE = pick any of the species - "I dont care which one"
    FROM Bird_nests JOIN Bird_eggs USING (NEST_ID)
    GROUP BY Nest_ID;

SELECT Nest_ID, Species, COUNT(*)
    FROM Bird_nests JOIN Bird_eggs USING (NEST_ID)
    GROUP BY Nest_ID, Species;

SELECT Nest_ID, Species, Egg_num, Width, Length 
    FROM Bird_eggs JOIN Bird_nests 
    USING (Nest_ID) 
    ORDER BY Nest_ID, Egg_num
    LIMIT 10;

-- ANY_VALUE measn literlaly any value 
SELECT Nest_ID, ANY_VALUE(Width)
    FROM Bird_eggs
    GROUP BY NEST_ID;