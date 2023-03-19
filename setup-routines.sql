/* CS121 Final Project 

 */

-- This file for the CS121 Final Project contains:
-- 2 User Defined Functions (UDFs)
-- 1 Procedure
-- 1 Trigger

DELIMITER !
-- A user-defined function that returns the result of a soccer match/game as a 
-- string that can then be printed out
CREATE FUNCTION show_outcome()
BEGIN
    IF ft_home_goals > ft_away_goals
END !

-- A user-defined function that calculates the earnings (or losses if negative)
-- of a particular client as a numeric value with two decimal places.
-- Returns 0.00 if client has not placed any bets.
CREATE FUNCTION calc_earnings()
BEGIN
    
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
DELIMITER ;