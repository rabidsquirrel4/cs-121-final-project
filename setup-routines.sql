/* CS121 Final Project 

 */

-- This file for the CS121 Final Project contains:
-- 2 User Defined Functions (UDFs)
-- 1 Procedure
-- 1 Trigger and a sub-procedure for most of the trigger code to go into

DELIMITER !
-- A user-defined function that returns the result of a soccer match/game as a 
-- string that can then be printed out
-- Returns NULL if the game_id was not found or the game information has not 
-- been updated yet to include the outcome.
CREATE FUNCTION show_outcome(game_id INT) 
    RETURNS VARCHAR(200) NOT DETERMINISTIC
BEGIN
    DECLARE home_id INT;
    DECLARE away_id INT;
    DECLARE ft_home_goals INT;
    DECLARE ft_away_goals INT;
    DECLARE home_team_name VARCHAR(40);
    DECLARE away_team_name VARCHAR(40);
    DECLARE return_str VARCHAR(200);

    SELECT games.home_id, games.away_id, 
            games.ft_home_goals, games.ft_away_goals
        INTO home_id, away_id, ft_home_goals, ft_away_goals 
        FROM games
        WHERE games.game_id = game_id;
    
    IF ft_home_goals IS NULL
        THEN RETURN NULL;
    END IF;

    SELECT teams.team_name INTO home_team_name 
        FROM teams
        WHERE teams.team_id = home_id;

    SELECT teams.team_name INTO away_team_name 
        FROM teams
        WHERE teams.team_id = away_id;

    SET return_str = CONCAT(CONVERT(home_team_name, CHAR), ' (', CONVERT(ft_home_goals, CHAR),
        '-', CONVERT(ft_away_goals, CHAR), ')', away_team_name, ': ');
    /* SET return_str = home_team_name; */
    IF ft_home_goals > ft_away_goals
        THEN RETURN CONVERT(home_team_name, CHAR);-- CONCAT(return_str, 'Home Team ', home_team_name, ' Won');
    ELSEIF ft_home_goals = ft_away_goals
        THEN RETURN CONCAT(return_str, 'Draw');
    ELSE
        RETURN CONCAT(return_str, 'Away Team ', away_team_name, ' Won');
    END IF;
END !

-- A user-defined function that calculates the earnings (or losses if negative)
-- of a particular client as a numeric value with two decimal places.
-- Returns 0.00 if client has not placed any bets.
/* CREATE FUNCTION calc_earnings()
BEGIN
    
END ! */

DELIMITER ;
/* 

DELIMITER !
-- A procedure that places bets for a particular client.
-- Modifies the bets table.
CREATE PROCEDURE sp_place_bet(
    game_id INT,
    client_id INT,
    type_id INT,
    amount_placed NUMERIC(10, 2)
)
BEGIN
END !
DELIMITER ;

DELIMITER !
-- A procedure that updates the is_correct boolean for bets after a particular 
-- game has been decided.
CREATE PROCEDURE sp_update_bets(
    game_id INT,
)
BEGIN
END !

-- A trigger that updates the is_correct boolean for all bets after the game
-- information in the games table has been updated for a particular game to 
-- include non-NULL values for the information on how the game went.
CREATE TRIGGER trg_update_outcomes AFTER UPDATE
    ON games FOR EACH ROW
BEGIN
    
END !
DELIMITER ; */