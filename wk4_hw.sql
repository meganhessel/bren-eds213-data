-- WEEK 4 HOMEWORK 
-- Megan Hessel 

-- 4.1 MISSING DATA ---
-- Which sites have no egg data? 

-- Method 1: Using a Code NOT IN clause.
SELECT Code FROM Site 
    WHERE Code NOT IN (SELECT Site FROM Bird_eggs)
    ORDER BY Code;

-- Method 2: Outer join with a WHERE clause
SELECT Code FROM Site 
    FULL OUTER JOIN Bird_eggs ON Site.Code = Bird_eggs.Site
    WHERE Egg_num IS NULL
    ORDER BY Code;


-- 4.2 - Who worked with whom? --- 
-- GOAL: Find all pairs of people who worked at the same site & whose date ranges overlap while at that site

-- Self-join: Regular join but joining two copies of the same tableite 

SELECT A.Site, A.Observer AS Observer_1, B.Observer AS Observer_2 -- Selecting specific columns 
    FROM Camp_assignment A JOIN Camp_assignment B 
    ON A.Site = B.Site -- overlaping sites 
    AND A.Start <= B.End AND A.End >= B.Start -- overlaping time 
    AND A.Observer < B.Observer -- ordered, distinct pairs.
    WHERE A.Site = 'lkri'; -- Looking at only 1 site 

-- Bonus 
-- Join with the Personnel table

SELECT A.Site, P.Name AS Name_1, Per.Name AS Name_2 -- Selecting specific columns 
    FROM Camp_assignment A JOIN Camp_assignment B 
    ON A.Site = B.Site -- overlaping sites 
    AND A.Start <= B.End AND A.End >= B.Start -- overlaping time 
    AND A.Observer < B.Observer -- ordered, distinct pairs
    JOIN Personnel AS P ON P.Abbreviation = A.Observer -- Join the personnel table 
    JOIN Personnel AS Per ON Per.Abbreviation = B.Observer
    WHERE A.Site = 'lkri'; -- Looking at only 1 site 



-- 4.3 - Who’s the culprit? ---
-- Full name of observer who: (1) site = “nome”, (2) between 1998 and 2008 inclusive, (3) AgeFloat = 'float', and (4) observed exactly 36 nests


SELECT Observer, COUNT(*) FROM Bird_nests
    WHERE Site LIKE 'nome'
    AND Year >= 1998 AND Year <= 2008 -- Year filtering 
    AND ageMethod = 'float'
    GROUP BY Observer
    HAVING COUNT(*) = 36; 


SELECT Observer, COUNT(*) FROM Bird_nests
    WHERE Site LIKE 'nome'
    AND Date_found >= '1998-01-01' AND Date_found <= '2008-12-31' -- VS date filtering 
    AND ageMethod = 'float'
    GROUP BY Observer
    HAVING COUNT(*) = 36; 

-- Which date filtering is more common / more reliable? 