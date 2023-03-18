/*
 * Grants permissions to two users 
 */
CREATE USER 'appadmin'@'localhost' IDENTIFIED BY 'adminpw';
CREATE USER 'clientadmin'@'localhost' IDENTIFIED BY 'clientpw';
 -- Can add more users or refine permissions
GRANT ALL PRIVILEGES ON soccerdb.* TO 'appadmin'@'localhost';
GRANT SELECT ON soccerdb.* TO 'appclient'@'localhost';
FLUSH PRIVILEGES;
