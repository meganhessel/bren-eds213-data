# To open database 
# Inside of database directory, 
duckdb database.duckdb 


# to varify that we have the "right" databases open, look what tabels aer in the database 
.table

# To see he DuckDB-specific commans, do this: 
.help 

# To exit: .exit OR ctrl-D

# In SQL, comments are delimited with -- 
--.table -- List tabels 
--.scheme - -lists the while schema 
.schema
# schema is inside the database

-- Getting help on SQL: look at the "railroad" diagmaes in SQL lite 
-- Check out https://sqlite.org/lang.html

-- Our first query 
-- The * means all columns; all rows are implied because we didn't specify a WHERE clause 
-- To run, highlight the Query, *shift return* 

-- A couple gotchas 
-- 1. Dont forget the closing semi colon - DuchDB will wait fir it forever 
-- 2. Watch out for missing closing quotes 

-- To see a few rows: 
SELECT * FROM Species LIMIT 5;
-- "Page" thru the rows (show the next 5) 
SELECT * FROM Species LIMIT 5 OFFSET 5;

-- Of course, we can select which columns we want 
SELECT Code, Scientific_name FROM Species;

-- Another hand query to explore data 
SELECT Species FROM Bird_nests;
SELECT DISTINCT Species FROM Bird_nests;

-- Disticnt pairs or tuples that occur 
SELECT DISTINCT Species, Observer FROM Bird_nests;

-- To Order output 
SELECT Scientific_name FROM Species ORDER BY Scientific_name

SELECT DISTINCT Species FROM Bird_nests;
SELECT DISTINCT Species FROM Bird_nests LIMIT 3;

-- LEts try again byt ask that results be ordered 
SELECT DISTINCT Species FROM Bird_nests ORDER BY Species;
SELECT DISTINCT Species FROM Bird_nests ORDER BY Species LIMIT 3;

-- In class challenge, 
-- Select distunct locatoins form the Site tabel; are they in order? If not, order them. 
SELECT DISTINCT Location FROM Site ORDER BY Site;
