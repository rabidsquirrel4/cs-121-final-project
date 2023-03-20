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
        '-', CONVERT(ft_away_goals, CHAR), ') ', away_team_name, ': ');

    IF ft_home_goals > ft_away_goals
        THEN RETURN CONCAT(return_str, 'Home Team ', home_team_name, ' Won');
    ELSEIF ft_home_goals = ft_away_goals
        THEN RETURN CONCAT(return_str, 'Draw');
    ELSE
        RETURN CONCAT(return_str, 'Away Team ', away_team_name, ' Won');
    END IF;
END !

-- A user-defined function that calculates the earnings (or losses if negative)
-- of a particular client as a numeric value with two decimal places.
-- Returns 0.00 if client has not placed any bets.
CREATE FUNCTION calc_earnings(client_id INT)
    RETURNS NUMERIC(10, 2) NOT DETERMINISTIC
BEGIN
    DECLARE earnings NUMERIC(10, 2) DEFAULT 0;
    DECLARE curr_amt NUMERIC(10, 2) DEFAULT 0;
    DECLARE curr_correct BOOLEAN;
    -- The flag that gets set to 1 when the cursor fetch is complete.
    DECLARE done INT DEFAULT 0;
    -- The cursor used for looping through bets in the bets table
    DECLARE cur CURSOR FOR 
        SELECT amount_placed, is_correct FROM bets 
        WHERE bets.client_id = client_id;

    -- When fetch is complete, handler sets flag 
    -- 02000 is MySQL error for "zero rows fetched"
    DECLARE CONTINUE HANDLER FOR SQLSTATE '02000'
        SET done = 1;

    -- Use cursor to loop through all submission times
    OPEN cur;
    FETCH cur INTO curr_amt, curr_correct;
    WHILE NOT done DO
        FETCH cur INTO curr_amt, curr_correct;
        IF curr_correct = 1
            THEN SET earnings = earnings + curr_amt;
        ELSEIF curr_correct = 0
            THEN SET earnings = earnings - curr_amt;
        END IF;
    END WHILE;
    CLOSE cur;
    RETURN earnings;
END !

DELIMITER ;


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
    INSERT INTO bets (game_id, client_id, type_id, amount_placed) 
        VALUES (game_id, client_id, type_id, amount_placed);
END !
-- A procedure that updates the is_correct boolean for bets after a particular 
-- game has been decided.
CREATE PROCEDURE sp_update_bets(
    game_id INT,
    goal_difference INT
)
BEGIN
    UPDATE bets SET is_correct = (goal_difference > 0)
        WHERE bets.type_id IN (SELECT type_id FROM bet_types 
            WHERE type_name LIKE 'home%');

    UPDATE bets SET is_correct = (goal_difference < 0)
        WHERE bets.type_id IN (SELECT type_id FROM bet_types 
            WHERE type_name LIKE 'away%');

    UPDATE bets SET is_correct = (goal_difference = 0)
        WHERE bets.type_id IN (SELECT type_id FROM bet_types 
            WHERE type_name LIKE 'draw%');
END !

-- A trigger that updates the is_correct boolean for all bets after the game
-- information in the games table has been updated for a particular game to 
-- include non-NULL values for the information on how the game went.
CREATE TRIGGER trg_update_outcomes AFTER UPDATE
    ON games FOR EACH ROW
BEGIN
    CALL sp_update_bets(NEW.game_id, NEW.ft_home_goals - NEW.ft_away_goals);
END !
DELIMITER ;