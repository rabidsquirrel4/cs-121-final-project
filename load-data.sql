-- Instructions:
-- This script will load the 3 CSV files broken down from our 
-- into the tables we created.


LOAD DATA LOCAL INFILE 'teams.csv' INTO TABLE teams
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;


LOAD DATA LOCAL INFILE 'games.csv' INTO TABLE games
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;


LOAD DATA LOCAL INFILE 'odds.csv' INTO TABLE odds
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;

INSERT INTO bet_types 
VALUES
    (0, 'home_win'), 
    (1, 'away_win'), 
    (2, 'draw'), 
    (3, 'goals_over_2.5'),
    (4, 'goals_under_2.5');

INSERT INTO client (username, is_admin) 
VALUES
    ('sbf', 0),
    ('kenneth', 0),
    ('wsbadmin', 1);