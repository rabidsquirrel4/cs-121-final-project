-- File for Password Management section of Final Project

-- (Provided) This function generates a specified number of characters for using as a
-- salt in passwords.
DELIMITER !
CREATE FUNCTION make_salt(num_chars INT) RETURNS VARCHAR(20) NOT DETERMINISTIC
BEGIN
    DECLARE salt VARCHAR(20) DEFAULT '';

    -- Don't want to generate more than 20 characters of salt.
    SET num_chars = LEAST(20, num_chars);

    -- Generate the salt!  Characters used are ASCII code 32 (space)
    -- through 126 ('z').
    WHILE num_chars > 0 DO
        SET salt = CONCAT(salt, CHAR(32 + FLOOR(RAND() * 95)));
        SET num_chars = num_chars - 1;
    END WHILE;

    RETURN salt;
END !
DELIMITER ;

-- Provided (you may modify if you choose)
-- This table holds information for authenticating users based on
-- a password.  Passwords are not stored plaintext so that they
-- cannot be used by people that shouldn't have them.
-- You may extend that table to include an is_admin or role attribute if you 
-- have admin or other roles for users in your application 
-- (e.g. store managers, data managers, etc.)
CREATE TABLE user_info (
    -- Usernames are up to 20 characters.
    username VARCHAR(20) PRIMARY KEY,

    -- Salt will be 8 characters all the time, so we can make this 8.
    salt CHAR(8) NOT NULL,

    -- We use SHA-2 with 256-bit hashes.  MySQL returns the hash
    -- value as a hexadecimal string, which means that each byte is
    -- represented as 2 characters.  Thus, 256 / 8 * 2 = 64.
    -- We can use BINARY or CHAR here; BINARY simply has a different
    -- definition for comparison/sorting than CHAR.
    password_hash BINARY(64) NOT NULL,

    -- Indicates whether user is admin and has admin priviledges
    is_admin BOOLEAN NOT NULL,
    CHECK (is_admin IN (0,1))
);

-- [Problem 1a]
-- Adds a new user to the user_info table, using the specified password (max
-- of 20 characters). Salts the password with a newly-generated salt value,
-- and then the salt and hash values are both stored in the table.
DELIMITER !
CREATE PROCEDURE sp_add_user(new_username VARCHAR(20), password VARCHAR(20))
BEGIN
    DECLARE salt CHAR(8);
    DECLARE salted_password CHAR(28);
    DECLARE password_hash BINARY(64);
    -- Generate a new salt
    SELECT make_salt(8) INTO salt;
    
    SET salted_password = CONCAT(salt, password);

    -- use SHA-2 function to generate hash from salted password concatenation
    SELECT SHA2(salted_password, 256) AS password_hash INTO password_hash;
    
    -- Add new record to user_info tables with username, salt, and 
    -- salted password
    INSERT INTO user_info
        VALUES (new_username, salt, password_hash);
END !
DELIMITER ;

-- [Problem 1b]
-- Authenticates the specified username and password against the data
-- in the user_info table.  Returns 1 if the user appears in the table, and the
-- specified password hashes to the value for the user. Otherwise returns 0.
DELIMITER !
CREATE FUNCTION authenticate(username VARCHAR(20), password VARCHAR(20))
RETURNS TINYINT DETERMINISTIC
BEGIN
    -- Stores the count of how many usernames match the username argument to 
    -- this function, should be 0 or 1
    DECLARE user_exists INT;
    DECLARE salt CHAR(8);
    DECLARE salted_password CHAR(28);
    -- Stores the hash of the password that was given to this function
    DECLARE password_hash BINARY(64);
    -- Stores the hash that is stored in the database
    DECLARE correct_hash BINARY(64);

    -- check that username actually appears in the user_info table
    SELECT COUNT(*) INTO user_exists 
        FROM user_info 
        WHERE user_info.username = username;
    -- If the username does not exist, return 0
    IF user_exists = 0
        THEN RETURN 0;
    END IF;

    /* check if hash matches what is stored in database (user_info table) */
    -- select user's salt and password hash to compare to from table
    SELECT user_info.salt, user_info.password_hash INTO salt, correct_hash
        FROM user_info 
        WHERE user_info.username = username;
    
    -- concatenated to get salted password
    SET salted_password = CONCAT(salt, password);

    -- use SHA-2 function to generate hash from salted password concatenation
    SELECT SHA2(salted_password, 256) AS password_hash INTO password_hash;
    
    -- check if hash of given password matches what is in the database
    IF password_hash = correct_hash
        THEN RETURN 1;
    ELSE RETURN 0;
    END IF;
END !
DELIMITER ;

-- [Problem 1c]
-- Add at least two users into your user_info table so that when we run this file,
-- we will have examples users in the database.
CALL sp_add_user('sbf','bahamas');
CALL sp_add_user('kenneth','naturalgas');
CALL sp_add_user('wsbadmin','tothemoon');

-- [Problem 1d]
-- Optional: Create a procedure sp_change_password to generate a new salt and change the given
-- user's password to the given password (after salting and hashing)
DELIMITER !
CREATE PROCEDURE sp_change_password(
    username VARCHAR(20), 
    new_password VARCHAR(20))
BEGIN
    /* DECLARE salt CHAR(8);
    DECLARE salted_password CHAR(28);
    DECLARE password_hash BINARY(64);
    -- Generate a new salt
    SELECT make_salt(8) INTO salt;
    
    SET salted_password = CONCAT(salt, password);

    -- use SHA-2 function to generate hash from salted password concatenation
    SELECT SHA2(salted_password, 256) AS password_hash INTO password_hash;
    
    -- Add new record to user_info tables with username, salt, and 
    -- salted password
    INSERT INTO user_info
        VALUES (new_username, salt, password_hash); */
END !
DELIMITER ;