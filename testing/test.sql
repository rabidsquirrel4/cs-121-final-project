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