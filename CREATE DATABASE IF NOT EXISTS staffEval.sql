CREATE DATABASE IF NOT EXISTS staffEval

USE staffEval

CREATE TABLE IF NOT EXISTS companies
(
    'afm' INT,
    'doy' CHAR,
    'phone' INT(10),      
    'street' CHAR,        #  did not use separate table for edra to avoid unwanted complexity
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
    empl_username CHAR,
    language CHAR,
    CONSTRAINT LANG FOREIGN KEY (empl_username) REFERENCES employee(user_username)
    ON DELETE CASCADE ON UPDATE CASCADE
)

CREATE TABLE IF NOT EXISTS degrees
(
    title CHAR,
    institution CHAR,
    empl_username CHAR,
    grad_year INT(4),
    grade INT,
    PRIMARY KEY(title, institution),
    CONSTRAINT EMPLDEGR FOREIGN KEY (empl_username) REFERENCES employee(user_username)
    ON DELETE CASCADE ON UPDATE CASCADE
)

CREATE TABLE IF NOT EXISTS projects
(
    description CHAR,
    url CHAR,
    num INT AUTO INCREMENT,
    empl_username CHAR,
    PRIMARY KEY (num, empl_username),
    CONSTRAINT EMPLPROJ FOREIGN KEY (empl_username) REFERENCES employee(user_username)
    ON DELETE CASCADE ON UPDATE CASCADE
)

CREATE TABLE IF NOT EXISTS evaluators
(   
    eval_username CHAR,
    comp_afm INT,
    eval_number INT,
    PRIMARY KEY (eval_number),
    CONSTRAINT EMPLEVAL FOREIGN KEY (eval_username) REFERENCES users(username)
    ON DELETE CASCADE ON UPDATE CASCADE
)

CREATE TABLE IF NOT EXISTS position
(
    announcement_date DATE,
    expiration_date DATE,

)



#BEGIN INSERT COMMANDS FOR DATABASE

