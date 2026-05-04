
- Create a view  
CREATE VIEW Nest_view AS 
    SELECT Book_page, Year, Site, Nest_ID, Scientific_name, Observer
    FROM Bird_nests JOIN species
    ON Species = Code;


SELECT * FROM Nest_view LIMIT 1;
-- For comparison 
SELECT * FROM Bird_nests LIMIT 1;

-- Join view 
SELECT Nest_ID, ANY_VALUE(Scientific_name) AS Scientific_name, COUNT(*) AS Num_eggs
    FROM Nest_view JOIN Bird_eggs
    USING (Nest_ID)
    GROUP BY Nest_ID;

-- Use a with clause 
WITH x AS ( 
    SELECT Nest_ID, ANY_VALUE(Scientific_name) AS Scientific_name, COUNT(*) AS Num_eggs
        FROM Nest_view JOIN Bird_eggs
        USING (Nest_ID)
        GROUP BY Nest_ID
) SELECT Scientific_name, AVG(Num_eggs) AS Avg_num_eggs FROM x 
    GROUP BY Scientific_name; -- Group by scientific name and pull + computate avg number of eggs  

### Set opertaions 
-- (1) UNION 
-- Duplicates are eleimaited in UNIONS 
-- If want to percers all rows, UNION ALL 


-- EX: Create 2 tables (1 with bird egg counts and 1 with no eggs) and union them together 

SELECT Nest_ID, COUNT(*) AS Num_eggs -- Aggregation of nests that do have eggs 
    FROM Bird_eggs
    GROUP BY Nest_ID

UNION 

SELECT Nest_ID, 0 AS Num_eggs -- Column called Num_eggs with value 0 
    FROM Bird_nests
    WHERE Nest_ID NOT IN (SELECT DISTINCT Nest_ID FROM Bird_eggs);


-- (2) EXCEPT: Give me everything in A thats not in B

-- Which species dfo we not have data for? 3 ways 

SELECT Code FROM Species
    WHERE Code NOT IN (SELECT DISTINCT Nest_ID FROM Bird_eggs);


SELECT Species 
    FROM Bird_nests RIGHT JOIN Species
    On Species = Code 
    WHERE Species IS NULL;


SELECT Code FROM Species 
EXCEPT 
SELECT DISTINCT Species FROM Bird_nests;

-- (3) INTERSECT: Give me only the intersection of A and B



-- Insert statements 
SELECT * FROM Personnel; 
INSERT INTO Personnel VALUES ('gjamee', 'Greg Janee');

SELECT * FROM Personnel;

INSERT INTO Personnel (Abbreviation, Name) VALUES ('jbrun', 'Julien Brun');

-- Also, when you insert a row in a table, you dont ness have to specify all the values; 
-- Anything not specified will either be fillled with NULL oe a default value 

-- Updates and deletes 
SELECT * FROM Bird_nests LIMIT 10;

UPDATE Bird_nests SET floatAge = 6.5, ageMethod = 'float'
    WHERE Nest_ID = '14HPE1'; -- use Primary key to distinguish row 

-- dont really wanna delete a row 
DELETE FROM Bird_nest 
    WHERE Nest_ID = '14HPEblahblah'

-- The above 2 commands (UPDATE and DELETE) are just incredible dangerous 

