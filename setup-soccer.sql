DROP TABLE bets  IF EXISTS;
DROP TABLE odds  IF EXISTS;
DROP TABLE games IF EXISTS;
DROP TABLE teams IF EXISTS;
DROP TABLE client IF EXISTS;

-- Defines the table that holds the client's information.
CREATE TABLE client(
    client_id INT,
    username VARCHAR(25) UNIQUE NOT NULL,
    password VARCHAR(25) UNIQUE NOT NULL,
    total_bets INT NOT NULL,
    correct_bets INT NOT NULL,
    PRIMARY KEY(client_id)
);

-- Defines the table that holds the teams' information. 
CREATE TABLE teams(
    team_id INT,
    team_name VARCHAR(40) NOT NULL UNIQUE,

    -- Teams get relegated to a lower division if they are one of 
    -- the last three teams at the end of the season and so teams 
    -- could be active or not
    active BOOLEAN NOT NULL,
    PRIMARY KEY (team_id),
    CHECK (team_id > 0)
);

-- Defines the games table. 
CREATE TABLE games(
    game_id INT, 
    game_date DATE NOT NULL,
    home_id INT NOT NULL, 
    away_id INT NOT NULL,

    -- Goals scored by the home team at half time 
    ht_home_goals INT NOT NULL,  

    -- Goals scored by the away team at half time 
    ht_away_goals INT  NOT NULL,

    -- Goals scored by the home team at full time
    ft_home_goals INT NOT NULL,

    -- Goals scored by the away team at full time
    ft_away_goals INT NOT NULL,
    home_shots INT NOT NULL,
    away_shots INT NOT NULL,
    home_hit_woodwork INT NOT NULL,
    away_hit_woodwork INT NOT NULL,
    home_fouls_committed INT NOT NULL,
    away_fouls_committed INT NOT NULL,
    home_yellow_cards INT NOT NULL,
    away_yellow_cards INT NOT NULL,
    home_red_cards INT NOT NULL,
    away_red_cards  INT NOT NULL,
    home_offsides INT NOT NULL,
    away_offsides INT NOT NULL,

    PRIMARY KEY (game_id),
    FOREIGN KEY(home_id) REFERENCES team(team_id) ON CASCADE UPDATE 
                ON CASCADE DELETE,
    FOREIGN KEY(away_id) REFERENCES team(team_id) ON CASCADE UPDATE 
                ON CASCADE DELETE,
    CHECK (game_id > 0),
    CHECK (ht_home_goals >= 0 AND ht_away_goals >= 0 AND ft_home_goals >= 0 AND 
            ft_away_goals >= 0),
    CHECK (home_hit_woodwork >= 0 AND away_hit_woodwork >= 0 AND
           home_fouls_committed >= 0 AND away_fouls_committed >= 0),
    CHECK (home_yellow_cards >= 0 AND away_yellow_cards >= 0 AND 
            home_red_cards >= 0 AND away_red_cards >= 0),
    CHECK (home_offsides >= 0 AND away_offsides >= 0)
);

-- Defines the table that holds information about bets staked.
CREATE TABLE bets(
    bet_id INT,
    game_id INT NOT NULL,
    client_id INT NOT NULL,
    bet_type VARCHAR(15) NOT NULL,
    amount_placed NUMERIC(x, 2) NOT NULL,
    is_correct BOOLEAN NOT NULL,

    PRIMARY KEY(bet_id),
    FOREIGN KEY(game_id) REFERENCES games(game_id) ON CASCADE UPDATE 
                ON CASCADE DELETE,
    FOREIGN KEY(client_id) REFERENCES client(client_id) ON CASCADE UPDATE 
                ON CASCADE DELETE,
    CHECK (game_id > 0),
    CHECK (amount_placed > 0.00),
    CHECK (bet_type) IN ('home_win', 'away_win', 'draw', 'goals_over_2.5', 
                'goals_under_2.5')
);