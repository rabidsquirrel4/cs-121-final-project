-- test setup-passwords.sql
SET GLOBAL log_bin_trust_function_creators = 1;
source testing/startup.sql;
source setup-passwords.sql;
CALL sp_add_user('appadmin','adminpw');
CALL sp_add_user('appclient','clientpw');
SELECT * FROM user_info;

SELECT authenticate('appadmin','adminpw');
SELECT COUNT(*) FROM user_info WHERE user_info.username = 'appadmin';
SELECT user_info.salt FROM user_info WHERE user_info.username = 'appadmin';

-- test grant-permissions.sql
DROP USER 'leoadmin'@'localhost';
DROP USER 'racheladmin'@'localhost';
DROP USER 'appclient'@'localhost';

-- test queries.sql

-- test setup-routines.sql
source testing/startup.sql
source setup-routines.sql
-- 6,30-08-09,22,34
-- 22,Mallorca
-- 34,Xerez
SELECT show_outcome(6);
SELECT * FROM games WHERE games.game_id = 6;
SELECT * FROM teams;
SELECT calc_earnings(1);
CALL sp_place_bet(1, 1, 0, 16.00);

UPDATE bets SET is_correct = 0
        WHERE bets.type_id IN (SELECT type_id FROM bet_types 
            WHERE type_name LIKE 'away%');

SELECT COUNT(*) FROM bet_types 
            WHERE type_id = 1 AND 
                    type_name LIKE 'home%';

-- should result in home win rows being changed
UPDATE games SET
            ft_home_goals = 1,
            ft_away_goals = 0
        WHERE game_id = 1; 