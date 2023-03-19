/*
 * Grants permissions to two users 
 */
CREATE USER 'leoadmin'@'localhost' IDENTIFIED BY 'leopw';
CREATE USER 'racheladmin'@'localhost' IDENTIFIED BY 'rachelpw';
CREATE USER 'appclient'@'localhost' IDENTIFIED BY 'clientpw';
 -- Can add more users or refine permissions
GRANT ALL PRIVILEGES ON soccerdb.* TO 'leoadmin'@'localhost';
GRANT ALL PRIVILEGES ON soccerdb.* TO 'racheladmin'@'localhost';
GRANT SELECT ON soccerdb.* TO 'appclient'@'localhost';
FLUSH PRIVILEGES;
