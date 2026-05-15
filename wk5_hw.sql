-- Step 1: Add tables 
-- CREATE TABLE Nests_big AS SELECT * FROM '../ASDN_csv/nests_big.csv';
-- CREATE TABLE Eggs_big AS SELECT * FROM '../ASDN_csv/eggs_big.csv';

-- When adding tables with CREATE TABLE table_name AS SELECT * FROM '...csv', column names and types are from the CSV data with no constraints, primary keys, or foreign keys. 
-- Key constraints ensure the Eggs_big table actually exists in the Nests_big table. 
-- However, in this table creation method, there are no forign key (or any other) constraints because the method does not explicity declare the constraints. 
-- To guarenatee Eggs_big table actually exists in the Nests_big table, would need to declare contraints in table creation: 
CREATE TEMP TABLE Eggs_big -- Just an example. So created temp table. 
    Nest_ID VARCHAR PRIMARY KEY 
    Egg_num INT
    Length INT
    Width INT

CREATE TEMP TABLE Nests_big 
    Site VARCHAR
    Nest_ID VARCHAR
    Species VARCHAR
    FOREIGN KEY (Nest_ID) REFERENCES Eggs_big(Nest_ID) -- These 2 tables are now linked and must be consistent 



-- To find the min and max longitude values in the Site table: 
SELECT Max(Longitude), MIN(Longitude) FROM Site;

-- Step 2 thru 6 
CREATE VIEW Egg_variance AS 
    SELECT 
        CASE WHEN Longitude > 0 THEN Longitude - 360 ELSE Longitude END AS Longitude, 
        3.14/6*(POWER(Width, 2)*Length) AS Volumn
    FROM Eggs_big
        JOIN Nests_big USING (Nest_ID)
        JOIN Species ON Nests_big.Species = Species.Code
        JOIN Site ON Nests_big.Site = Site.Code
        WHERE Scientific_name = 'Calidris alpina';


-- Find Linear regression slope and Pearson correlation coefficient
SELECT 
    REGR_SLOPE(Volumn, Longitude) AS Slope,
    CORR(Volumn, Longitude) AS PCC
FROM Egg_variance;


-- PCC INTERPRETATION: 
-- Correlation coeffient is -0.108 which means essentially normal. Therefore, there is practically no correlatinship between egg volumn and longitude.
