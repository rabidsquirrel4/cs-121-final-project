DROP DATABASE IF EXISTS soccerdb;
CREATE DATABASE soccerdb;
USE soccerdb; 
source setup.sql
source load-data.sql
source setup-passwords.sql
source setup-routines.sql
/* source grant-permissions.sql */