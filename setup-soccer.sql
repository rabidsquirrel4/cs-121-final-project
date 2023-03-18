DROP TABLE IF EXISTS bets;
DROP TABLE IF EXISTS odds;
DROP TABLE IF EXISTS games;
DROP TABLE IF EXISTS teams;
DROP TABLE IF EXISTS client;
DROP TABLE IF EXISTS bet_types;


-- Defines the table that holds the client's information.
CREATE TABLE client(
    client_id INT AUTO_INCREMENT,
    username VARCHAR(25) UNIQUE NOT NULL,
    password VARCHAR(25) NOT NULL,
    is_admin BOOLEAN,
    PRIMARY KEY(client_id),
    CHECK (is_admin IN (0,1))
);


-- Defines the table that holds the teams' information. 
CREATE TABLE teams(
    team_id INT AUTO_INCREMENT,
    team_name VARCHAR(40) UNIQUE NOT NULL,
    PRIMARY KEY(team_id)
);


-- Defines the games table. 
CREATE TABLE games(
    game_id INT AUTO_INCREMENT,
    game_date DATE NOT NULL,
    home_id INT NOT NULL, 
    away_id INT NOT NULL,

    -- Goals scored by the home team at full time
    ft_home_goals INT NOT NULL,

    -- Goals scored by the away team at full time
    ft_away_goals INT NOT NULL,
    -- Goals scored by the home team at half time 
    ht_home_goals INT NOT NULL,  

    -- Goals scored by the away team at half time 
    ht_away_goals INT  NOT NULL,


    home_shots INT NOT NULL,
    away_shots INT NOT NULL,

    -- Fould committed by the hoome team
    home_fouls_committed INT NOT NULL,

    -- Fouls committed by the away team 
    away_fouls_committed INT NOT NULL,

    -- Corners taken by the home team
    home_corners INT NOT NULL,

    -- Corners taken by the away team
    away_corners INT NOT NULL,

    home_yellow_cards INT NOT NULL,
    away_yellow_cards INT NOT NULL,
    home_red_cards INT NOT NULL,
    away_red_cards  INT NOT NULL,

    PRIMARY KEY (game_id),
    FOREIGN KEY(home_id) REFERENCES teams(team_id) ON UPDATE CASCADE  
                ON DELETE CASCADE,
    FOREIGN KEY(away_id) REFERENCES teams(team_id) ON UPDATE CASCADE
                ON DELETE CASCADE,
    CHECK (ht_home_goals >= 0 AND ht_away_goals >= 0 AND ft_home_goals >= 0 AND 
            ft_away_goals >= 0),
    CHECK ( home_fouls_committed >= 0 AND away_fouls_committed >= 0),
    CHECK (home_yellow_cards >= 0 AND away_yellow_cards >= 0 AND 
            home_red_cards >= 0 AND away_red_cards >= 0),
    CHECK (home_corners >= 0 AND away_corners >= 0)
);


-- Defines the table that holds the odds for games
CREATE TABLE odds(
    website_name VARCHAR(50) NOT NULL,
    game_id INT,
    home_win NUMERIC(2,2) NOT NULL,
    draw NUMERIC(2,2) NOT NULL,
    away_win NUMERIC(2,2) NOT NULL,
    `goals_over_2.5` NUMERIC(2,2) NOT NULL,
    `goals_under_2.5` NUMERIC(2,2) NOT NULL,

    PRIMARY KEY(game_id),
    FOREIGN KEY(game_id) REFERENCES games(game_id) ON UPDATE CASCADE 
                ON DELETE CASCADE,
    CHECK (home_win > 0 AND draw > 0 AND away_win > 0),
    CHECK (`goals_over_2.5` > 0 AND `goals_under_2.5` > 0)

);


-- Defines the table that holds bet types for staking 
CREATE TABLE bet_types(
    type_id INT,
    type_name VARCHAR(15) UNIQUE NOT NULL,

    PRIMARY KEY(type_id),
    CHECK (type_name IN ('home_win', 'away_win', 'draw', 'goals_over_2.5', 
                'goals_under_2.5'))
);


-- Defines the table that holds information about bets staked.
CREATE TABLE bets(
    bet_id INT AUTO_INCREMENT,
    game_id INT NOT NULL,
    client_id INT NOT NULL,
    type_id INT NOT NULL,
    amount_placed NUMERIC(10, 2) NOT NULL,
    is_correct BOOLEAN NOT NULL,

    PRIMARY KEY(bet_id),
    FOREIGN KEY(game_id) REFERENCES games(game_id) ON UPDATE CASCADE
                ON DELETE CASCADE,
    FOREIGN KEY(client_id) REFERENCES client(client_id) ON UPDATE CASCADE
                ON DELETE CASCADE,
    FOREIGN KEY(type_id) REFERENCES bet_types(type_id) ON UPDATE CASCADE 
                ON DELETE CASCADE,
    CHECK (is_correct IN (0,1)),
    CHECK (amount_placed > 0.00)
);