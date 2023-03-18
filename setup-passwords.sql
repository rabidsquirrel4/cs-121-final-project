/*
 *
 */

-- Defines the table that holds the client's information.
CREATE TABLE client(
    client_id INT AUTO_INCREMENT,
    username VARCHAR(25) UNIQUE NOT NULL,
    password VARCHAR(25) NOT NULL,
    is_admin BOOLEAN,
    PRIMARY KEY(client_id),
    CHECK (is_admin IN (0,1))
);
