/* CS121 Final Project 

 */

-- This file for the CS121 Final Project contains:
-- 2 User Defined Functions (UDFs)
-- 1 Procedure
-- 1 Trigger

DELIMITER !
-- A user-defined function that 
CREATE FUNCTION
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
-- A trigger that
CREATE TRIGGER trg_ AFTER INSERT
       ON __ FOR EACH ROW
BEGIN
    
END !
DELIMITER ;