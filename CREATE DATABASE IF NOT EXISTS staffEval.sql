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



