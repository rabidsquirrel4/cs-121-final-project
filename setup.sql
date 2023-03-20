DROP TABLE IF EXISTS bets;
DROP TABLE IF EXISTS odds;
DROP TABLE IF EXISTS games;
DROP TABLE IF EXISTS teams;
DROP TABLE IF EXISTS client;
DROP TABLE IF EXISTS bet_types;


-- Defines the table that holds the client's information.
CREATE TABLE client(
    client_id INT AUTO_INCREMENT,
    -- Usernames are up to 20 characters, the same as in setup-passwords.sql
    username VARCHAR(20) UNIQUE NOT NULL,
    is_admin BOOLEAN NOT NULL,
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

    -- Goals scored by the home team at full time, may be NULL
    ft_home_goals INT,

    -- Goals scored by the away team at full time, may be NULL
    ft_away_goals INT,

    -- Goals scored by the home team at half time, may be NULL
    ht_home_goals INT,  

    -- Goals scored by the away team at half time, may be NULL 
    ht_away_goals INT,

    -- Shots taken by home team, may be NULL
    home_shots INT,

    -- Shots taken by away team, may be NULL
    away_shots INT,

    -- Fould committed by the home team, may be NULL
    home_fouls_committed INT,

    -- Fouls committed by the away team, may be NULL 
    away_fouls_committed INT,

    -- Corner kicks taken by the home team, may be NULL
    home_corners INT,

    -- Corner kicks taken by the away team, may be NULL
    away_corners INT,

    -- Yellow cards given to home team, may be NULL
    home_yellow_cards INT,
    -- Yellow cards given to away team, may be NULL
    away_yellow_cards INT,
    -- Red cards given to home team, may be NULL
    home_red_cards INT,
    -- Red cards given to away team, may be NULL
    away_red_cards INT,

    PRIMARY KEY (game_id),
    FOREIGN KEY(home_id) REFERENCES teams(team_id) ON UPDATE CASCADE  
                ON DELETE CASCADE,
    FOREIGN KEY(away_id) REFERENCES teams(team_id) ON UPDATE CASCADE
                ON DELETE CASCADE,

    -- First check if one of the attributes that would be NULL if the game has
    -- not happened yet is NULL (we only need to check one since if the game
    -- has not happened yet, they should all be NULL)
    -- If the attribute is NULL, the other statment in the OR statement should
    -- not run, since we already know the whole statement is true
    CHECK ((ht_home_goals IS NULL) OR
            (ht_home_goals >= 0 AND ht_away_goals >= 0 AND ft_home_goals 
            >= 0 AND ft_away_goals >= 0)),
    CHECK ((home_fouls_committed IS NULL) OR 
            (home_fouls_committed >= 0 AND away_fouls_committed >= 0)),
    CHECK ((home_yellow_cards IS NULL) OR
            (home_yellow_cards >= 0 AND away_yellow_cards >= 0 AND 
            home_red_cards >= 0 AND away_red_cards >= 0)),
    CHECK ((home_corners IS NULL) OR
            (home_corners >= 0 AND away_corners >= 0))
);


-- Defines the table that holds the odds for games
CREATE TABLE odds(
    website_name VARCHAR(50) NOT NULL,
    game_id INT,
    home_win NUMERIC(4,2) NOT NULL,
    draw NUMERIC(4,2) NOT NULL,
    away_win NUMERIC(4,2) NOT NULL,
    -- added DEFAULT value since one row in our imported data were missing these
    -- values, temp fix
    `goals_over_2.5` NUMERIC(4,2) NOT NULL DEFAULT 0.0,
    `goals_under_2.5` NUMERIC(4,2) NOT NULL DEFAULT 0.0,

    PRIMARY KEY(game_id, website_name),
    FOREIGN KEY(game_id) REFERENCES games(game_id) ON UPDATE CASCADE 
                ON DELETE CASCADE,
    CHECK (home_win > 0 AND draw > 0 AND away_win > 0),
    -- temp fix
    CHECK (`goals_over_2.5` >= 0 AND `goals_under_2.5` >= 0)

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
    -- We limit dollar amounts for bets placed to be under $100,000,000.00 (USD)
    amount_placed NUMERIC(10, 2) NOT NULL,
    -- whether the bet placed is correct or not, may be NULL if tne game hasn't 
    -- hasn't already happened.
    is_correct BOOLEAN, 

    PRIMARY KEY(bet_id),
    FOREIGN KEY(game_id) REFERENCES games(game_id) ON UPDATE CASCADE
                ON DELETE CASCADE,
    FOREIGN KEY(client_id) REFERENCES client(client_id) ON UPDATE CASCADE
                ON DELETE CASCADE,
    FOREIGN KEY(type_id) REFERENCES bet_types(type_id) ON UPDATE CASCADE 
                ON DELETE CASCADE,
    -- check if is_correct is 1, 0, or NULL
    CHECK ((is_correct IS NULL) OR (is_correct IN (0,1))),
    CHECK (amount_placed > 0.00)
);