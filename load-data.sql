-- Instructions:
-- This script will load the 3 CSV files broken down from our 
-- into the tables we created.


LOAD DATA LOCAL INFILE 'teams.csv' INTO TABLE teams
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;


LOAD DATA LOCAL INFILE 'games.csv' INTO TABLE games
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;


LOAD DATA LOCAL INFILE 'odds.csv' INTO TABLE odds
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;


