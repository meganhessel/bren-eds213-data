SELECT * FROM A;
SELECT * FROM B;

SELECT * FROM A CROSS JOIN B;

SELECT acol1, acol2 FROM ( SELECT * FROM A CROSS JOIN B );

-- theres a problem here! 
SELECT acol1, acol2, COUNT(*) 
    FROM (SELECT * FROM A CROSS JOIN B )
    GROUP BY acol1;

-- Need the ANY_VALUE() because the value in acol2 is the same for every acol1 group 
-- COUNT(*) counts the NULL values 
SELECT acol1, ANY_VALUE(acol2), COUNT(*) 
    FROM (SELECT * FROM A CROSS JOIN B )
    GROUP BY acol1;

-- COUNT(bcol3) does NOT count the NULL values 
SELECT acol1, ANY_VALUE(acol2), COUNT(bcol3) 
    FROM (SELECT * FROM A CROSS JOIN B )
    GROUP BY acol1;


--- USING a condition:Just join when acol1 < bcol1
SELECT * FROM A JOIN B ON acol1 < bcol1;

-- INNER and OUTER join 
SELECT * FROM Student;
SELECT * FROM House;

-- INNER 
SELECT * FROM Student AS S JOIN House AS H ON S.House_ID = H.House_ID;

-- USING () requires the same column names 
SELECT * FROM Student JOIN House USING (House_ID);

SELECT * FROM Student FULL JOIN House USING (House_ID); 

SELECT * FROM Student RIGHT JOIN House USING (House_ID); 
SELECT * FROM Student LEFT JOIN House USING (House_ID); 


SELECT * FROM Student CROSS JOIN House;

-- Create a new, empty table 
CREATE TABLE Snow_cover (
    Site VARCHAR NOT NULL,
    Year INTEGER NOT NULL CHECK (Year BETWEEN 1990 AND 2018),
    Date DATE NOT NULL,
    Plot VARCHAR NOT NULL,
    Location VARCHAR NOT NULL,
    Snow_cover REAL CHECK (Snow_cover BETWEEN 0 AND 130),
    Water_cover REAL CHECK (Water_cover BETWEEN 0 AND 130),
    Land_cover REAL CHECK (Land_cover BETWEEN 0 AND 130),
    Total_cover REAL CHECK (Total_cover BETWEEN 0 AND 130),
    Observer VARCHAR,
    Notes VARCHAR,
    PRIMARY KEY (Site, Plot, Location, Date),
    FOREIGN KEY (Site) REFERENCES Site (Code)
);

-- Fill the empty table with the csv 
COPY Snow_cover FROM "../ASDN_csv/snow_survey_fixed.csv" (header TRUE, nullstr "NA");

SELECT * FROM Snow_cover LIMIT 5;

-- create a TEMPORARY table: backup of an entire table:
CREATE TEMP TABLE Camp_assignment_copy AS
   SELECT * FROM Camp_assignment;

SELECT * FROM Personnel LIMIT 5;

SELECT Year, Site, Name FROM Camp_assignment_copy JOIN Personnel On Observer = Abbreviation;

CREATE VIEW Camp_personnel_v AS
   SELECT Year, Site, Name 
   FROM Camp_assignment_copy JOIN Personnel ON Observer = Abbreviation;

