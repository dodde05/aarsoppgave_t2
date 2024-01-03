-- Creating database
CREATE DATABASE highscores;

USE highscores;

CREATE TABLE attempt(
    id INT PRIMARY KEY AUTO_INCREMENT,
    user VARCHAR(30),
    password VARCHAR(255),
    score DECIMAL(6, 2) DEFAULT NULL,
    date DATE DEFAULT NULL
);

-- Admin user setup
CREATE USER 'scoreadmin'@'localhost' IDENTIFIED BY 'BigMan123';
GRANT ALL PRIVILEGES ON * TO 'scoreadmin'@'localhost';


-- Client user setup
CREATE USER 'scoreclient'@'localhost' IDENTIFIED BY 'Uuude7J2xE4wjV';
GRANT SELECT, INSERT, UPDATE ON attempt TO 'scoreclient'@'localhost';


FLUSH PRIVILEGES;
