CREATE DATABASE IF NOT EXISTS staffEval

USE staffEval

CREATE TABLE IF NOT EXISTS companies
(
    afm INT,
    doy CHAR,
    phone INT(10),      
    street CHAR,        #  did not use separate table for edra to avoid unwanted complexity
    street_num INT,
    city CHAR,
    country CHAR,
    PRIMARY KEY(afm),

)

CREATE TABLE IF NOT EXISTS users
(
    username CHAR,
    password CHAR,
    email CHAR,
    reg_date DATE,
    PRIMARY KEY(username)
)

CREATE TABLE IF NOT EXISTS managers
(
    user_username CHAR,
    company CHAR,
    experience INT,
    PRIMARY KEY(user_username),
    CONSTRAINT USRMNGR FOREIGN KEY (user_username) REFERENCES users(username)
    ON DELETE CASCADE ON UPDATE CASCADE
)

CREATE TABLE IF NOT EXISTS employees
(
    user_username CHAR,
    company_ID_number INT,
    company_AFM INT,
    experience INT,
    resume CHAR,
    certifications CHAR,
    praises CHAR, 
    PRIMARY KEY(user_username),
    CONSTRAINT USRMPL FOREIGN KEY (user_username) REFERENCES users(username)
    ON DELETE CASCADE ON UPDATE CASCADE
)

CREATE TABLE IF NOT EXISTS languages
(
    employee_username CHAR,
    language CHAR,
    CONSTRAINT LANG FOREIGN KEY (employee_username) REFERENCES emploeyee(user_username)
    ON DELETE CASCADE ON UPDATE CASCADE
)

