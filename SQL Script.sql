-- MySQL Script generated by MySQL Workbench
-- Sun Sep 12 14:00:51 2021
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema CEID-Staff-Evaluation
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `CEID-Staff-Evaluation` ;

-- -----------------------------------------------------
-- Schema CEID-Staff-Evaluation
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `CEID-Staff-Evaluation` DEFAULT CHARACTER SET utf8 ;
USE `CEID-Staff-Evaluation` ;

-- -----------------------------------------------------
-- Table `CEID-Staff-Evaluation`.`company`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CEID-Staff-Evaluation`.`company` ;

CREATE TABLE IF NOT EXISTS `CEID-Staff-Evaluation`.`company` (
  `AFM` CHAR(9) NOT NULL,
  `DOY` VARCHAR(15) NOT NULL,
  `name` VARCHAR(35) NOT NULL,
  `phone` BIGINT(16) NULL DEFAULT NULL,
  `street` VARCHAR(15) NULL DEFAULT NULL,
  `num` TINYINT(4) NULL DEFAULT NULL,
  `city` VARCHAR(15) NULL DEFAULT NULL,
  `country` VARCHAR(15) NULL DEFAULT NULL,
  PRIMARY KEY (`AFM`));


-- -----------------------------------------------------
-- Table `CEID-Staff-Evaluation`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CEID-Staff-Evaluation`.`user` ;

CREATE TABLE IF NOT EXISTS `CEID-Staff-Evaluation`.`user` (
  `username` VARCHAR(12) NOT NULL,
  `password` VARCHAR(30) NOT NULL,
  `name` VARCHAR(25) NULL DEFAULT NULL,
  `surname` VARCHAR(35) NULL DEFAULT NULL,
  `regDate` DATETIME NULL DEFAULT NULL,
  `email` VARCHAR(30) NULL DEFAULT NULL,
  PRIMARY KEY (`username`));


-- -----------------------------------------------------
-- Table `CEID-Staff-Evaluation`.`manager`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CEID-Staff-Evaluation`.`manager` ;

CREATE TABLE IF NOT EXISTS `CEID-Staff-Evaluation`.`manager` (
  `managerUsername` VARCHAR(12) NOT NULL,
  `experience` TINYINT(4) NULL DEFAULT NULL,
  `firm` CHAR(9) NULL DEFAULT NULL,
  PRIMARY KEY (`managerUsername`),
  CONSTRAINT `MNGRUSR`
    FOREIGN KEY (`managerUsername`)
    REFERENCES `CEID-Staff-Evaluation`.`user` (`username`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);


-- -----------------------------------------------------
-- Table `CEID-Staff-Evaluation`.`employee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CEID-Staff-Evaluation`.`employee` ;

CREATE TABLE IF NOT EXISTS `CEID-Staff-Evaluation`.`employee` (
  `username` VARCHAR(12) NOT NULL,
  `firm` CHAR(9) NULL DEFAULT NULL,
  `resume` VARCHAR(35) NULL DEFAULT NULL,
  `sistatikes` VARCHAR(35) NULL DEFAULT NULL,
  `certificates` VARCHAR(35) NULL DEFAULT NULL,
  `awards` VARCHAR(35) NULL DEFAULT NULL,
  PRIMARY KEY (`username`),
  INDEX `EMPLFIRM` (`firm` ASC) VISIBLE,
  CONSTRAINT `EMPLUSR`
    FOREIGN KEY (`username`)
    REFERENCES `CEID-Staff-Evaluation`.`user` (`username`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `EMPLFIRM`
    FOREIGN KEY (`firm`)
    REFERENCES `CEID-Staff-Evaluation`.`company` (`AFM`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);


-- -----------------------------------------------------
-- Table `CEID-Staff-Evaluation`.`degree`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CEID-Staff-Evaluation`.`degree` ;

CREATE TABLE IF NOT EXISTS `CEID-Staff-Evaluation`.`degree` (
  `title` VARCHAR(50) NOT NULL,
  `institution` VARCHAR(50) NOT NULL,
  `bathmida` ENUM('LYKEIO', 'UNI', 'MASTER', 'PHD') NULL,
  `degreecol` VARCHAR(45) NULL,
  PRIMARY KEY (`title`));


-- -----------------------------------------------------
-- Table `CEID-Staff-Evaluation`.`has_degree`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CEID-Staff-Evaluation`.`has_degree` ;

CREATE TABLE IF NOT EXISTS `CEID-Staff-Evaluation`.`has_degree` (
  `title` VARCHAR(50) NOT NULL,
  `institution` VARCHAR(50) NOT NULL,
  `emplUsername` VARCHAR(12) NOT NULL,
  `etos` YEAR(4) NULL,
  `grade` FLOAT(3,1) NULL DEFAULT NULL,
  PRIMARY KEY (`emplUsername`, `institution`, `title`),
  INDEX `HASDEGREMPL_idx` (`emplUsername` ASC) VISIBLE,
  INDEX `HASDEGRTITLE_idx` (`title` ASC) VISIBLE,
  CONSTRAINT `HASDEGREMPL`
    FOREIGN KEY (`emplUsername`)
    REFERENCES `CEID-Staff-Evaluation`.`employee` (`username`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `HASDEGRTITLE`
    FOREIGN KEY (`title`)
    REFERENCES `CEID-Staff-Evaluation`.`degree` (`title`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE);


-- -----------------------------------------------------
-- Table `CEID-Staff-Evaluation`.`project`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CEID-Staff-Evaluation`.`project` ;

CREATE TABLE IF NOT EXISTS `CEID-Staff-Evaluation`.`project` (
  `employee` VARCHAR(12) NOT NULL,
  `num` INT NOT NULL AUTO_INCREMENT,
  `descr` TEXT NULL DEFAULT NULL,
  `url` VARCHAR(60) NULL DEFAULT NULL,
  PRIMARY KEY (`num`, `employee`),
  INDEX `PROJEMPL` (`employee` ASC) VISIBLE,
  CONSTRAINT `PROJEMPL`
    FOREIGN KEY (`employee`)
    REFERENCES `CEID-Staff-Evaluation`.`employee` (`username`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);


-- -----------------------------------------------------
-- Table `CEID-Staff-Evaluation`.`evaluator`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CEID-Staff-Evaluation`.`evaluator` ;

CREATE TABLE IF NOT EXISTS `CEID-Staff-Evaluation`.`evaluator` (
  `username` VARCHAR(12) NOT NULL,
  `experience` TINYINT(4) NULL DEFAULT NULL,
  `firm` CHAR(9) NULL DEFAULT NULL,
  `evaluatorID` INT(10) NULL DEFAULT NULL,
  PRIMARY KEY (`username`),
  CONSTRAINT `EMPLEVAL`
    FOREIGN KEY (`username`)
    REFERENCES `CEID-Staff-Evaluation`.`user` (`username`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);


-- -----------------------------------------------------
-- Table `CEID-Staff-Evaluation`.`job`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CEID-Staff-Evaluation`.`job` ;

CREATE TABLE IF NOT EXISTS `CEID-Staff-Evaluation`.`job` (
  `ID` INT(4) NOT NULL,
  `startDate` DATE NULL DEFAULT NULL,
  `salary` FLOAT(6,1) NULL DEFAULT NULL,
  `position` VARCHAR(40) NULL DEFAULT NULL,
  `edra` CHAR(9) NULL DEFAULT NULL,
  `evaluator` VARCHAR(12) NULL DEFAULT NULL,
  `announcement_date` DATETIME NULL DEFAULT NULL,
  `expiration_date` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`ID`),
  INDEX `JOBEVAL` (`evaluator` ASC) VISIBLE,
  INDEX `JOBEDRA` (`edra` ASC) INVISIBLE,
  CONSTRAINT `JOBEVAL`
    FOREIGN KEY (`evaluator`)
    REFERENCES `CEID-Staff-Evaluation`.`evaluator` (`username`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `JOBEDRA`
    FOREIGN KEY (`edra`)
    REFERENCES `CEID-Staff-Evaluation`.`company` (`AFM`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `CEID-Staff-Evaluation`.`antikeim`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CEID-Staff-Evaluation`.`antikeim` ;

CREATE TABLE IF NOT EXISTS `CEID-Staff-Evaluation`.`antikeim` (
  `title` VARCHAR(36) NOT NULL,
  `descr` TINYTEXT NULL DEFAULT NULL,
  `parentField` VARCHAR(36) NULL DEFAULT NULL,
  PRIMARY KEY (`title`),
  INDEX `ANTIKEIMANTIKEIM` (`parentField` ASC) INVISIBLE,
  CONSTRAINT `ANTIKEIMANTIKEIM`
    FOREIGN KEY (`parentField`)
    REFERENCES `CEID-Staff-Evaluation`.`antikeim` (`title`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE);


-- -----------------------------------------------------
-- Table `CEID-Staff-Evaluation`.`needs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CEID-Staff-Evaluation`.`needs` ;

CREATE TABLE IF NOT EXISTS `CEID-Staff-Evaluation`.`needs` (
  `jobID` INT(4) NOT NULL,
  `fieldTitle` VARCHAR(36) NOT NULL,
  PRIMARY KEY (`jobID`, `fieldTitle`),
  INDEX `NEEDSANTIKEIM` (`fieldTitle` ASC) VISIBLE,
  CONSTRAINT `NEEDSJOB`
    FOREIGN KEY (`jobID`)
    REFERENCES `CEID-Staff-Evaluation`.`job` (`ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `NEEDSANTIKEIM`
    FOREIGN KEY (`fieldTitle`)
    REFERENCES `CEID-Staff-Evaluation`.`antikeim` (`title`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);


-- -----------------------------------------------------
-- Table `CEID-Staff-Evaluation`.`request_evaluation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CEID-Staff-Evaluation`.`request_evaluation` ;

CREATE TABLE IF NOT EXISTS `CEID-Staff-Evaluation`.`request_evaluation` (
  `emplUsername` VARCHAR(12) NOT NULL,
  `jobID` INT(4) NOT NULL,
  PRIMARY KEY (`emplUsername`, `jobID`),
  INDEX `REQEVALJOB` (`jobID` ASC) VISIBLE,
  CONSTRAINT `REQEVALEMPL`
    FOREIGN KEY (`emplUsername`)
    REFERENCES `CEID-Staff-Evaluation`.`employee` (`username`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `REQEVALJOB`
    FOREIGN KEY (`jobID`)
    REFERENCES `CEID-Staff-Evaluation`.`job` (`ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);


-- -----------------------------------------------------
-- Table `CEID-Staff-Evaluation`.`evaluation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CEID-Staff-Evaluation`.`evaluation` ;

CREATE TABLE IF NOT EXISTS `CEID-Staff-Evaluation`.`evaluation` (
  `evaluationID` INT(4) NOT NULL,
  `emplUsername` VARCHAR(12) NOT NULL,
  `evalUsername` VARCHAR(45) NULL DEFAULT NULL,
  `jobID` INT(4) NULL DEFAULT NULL,
  `interviewGrade` INT(1) NULL DEFAULT NULL,
  `reportGrade` INT(1) NULL DEFAULT NULL,
  `recGrade` INT(1) NULL DEFAULT NULL,
  `finalGrade` INT(2) NULL DEFAULT NULL,
  `comments` VARCHAR(255) NULL DEFAULT NULL,
  `completed` TINYINT NULL DEFAULT 0,
  PRIMARY KEY (`evaluationID`, `emplUsername`),
  INDEX `EVALEMPL` (`emplUsername` ASC) VISIBLE,
  INDEX `EVALJOB` (`jobID` ASC) VISIBLE,
  CONSTRAINT `EVALEMPL`
    FOREIGN KEY (`emplUsername`)
    REFERENCES `CEID-Staff-Evaluation`.`employee` (`username`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `EVALJOB`
    FOREIGN KEY (`jobID`)
    REFERENCES `CEID-Staff-Evaluation`.`job` (`ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);


-- -----------------------------------------------------
-- Table `CEID-Staff-Evaluation`.`languages`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CEID-Staff-Evaluation`.`languages` ;

CREATE TABLE IF NOT EXISTS `CEID-Staff-Evaluation`.`languages` (
  `employee` VARCHAR(12) NOT NULL,
  `language` VARCHAR(10) NOT NULL,
  INDEX `LANGEMPL` (`employee` ASC) VISIBLE,
  CONSTRAINT `LANGEMPL`
    FOREIGN KEY (`employee`)
    REFERENCES `CEID-Staff-Evaluation`.`employee` (`username`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);


-- -----------------------------------------------------
-- Table `CEID-Staff-Evaluation`.`logs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CEID-Staff-Evaluation`.`logs` ;

CREATE TABLE IF NOT EXISTS `CEID-Staff-Evaluation`.`logs` (
  `username` VARCHAR(50) NOT NULL,
  `xronos` DATETIME NOT NULL,
  `actionTable` VARCHAR(45) NULL DEFAULT NULL,
  `actionType` VARCHAR(15) NOT NULL,
  `actionSuccess` TINYINT NOT NULL);

USE `CEID-Staff-Evaluation` ;

-- -----------------------------------------------------
-- procedure manager1
-- -----------------------------------------------------

USE `CEID-Staff-Evaluation`;
DROP procedure IF EXISTS `CEID-Staff-Evaluation`.`manager1`;

DELIMITER $$
USE `CEID-Staff-Evaluation`$$
CREATE PROCEDURE `manager1` (IN managerName VARCHAR(12), IN newPhone BIGINT(16), IN newNum TINYINT(4), IN newCity VARCHAR(15), IN newCountry VARCHAR(15))
BEGIN

	DECLARE companyAFM CHAR;

    SELECT companyAFM = manager.firm
    FROM manager
    WHERE manager.managerUsername =  managerName
    ;

    UPDATE company
    SET company.phone = newPhone, company.street = newStreet, company.num = newNum, company.city = newCity, company.country = newCountry
    WHERE company.AFM = companyAFM
    ;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure manager2
-- -----------------------------------------------------

USE `CEID-Staff-Evaluation`;
DROP procedure IF EXISTS `CEID-Staff-Evaluation`.`manager2`;

DELIMITER $$
USE `CEID-Staff-Evaluation`$$
CREATE PROCEDURE `manager2` (IN managerName VARCHAR(12), IN newPassword VARCHAR(10), IN newEmail VARCHAR(30))
BEGIN
	UPDATE user
    SET user.password = newPassword, user.email = newEmail
    WHERE user.username = managerName
    ;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure manager7
-- -----------------------------------------------------

USE `CEID-Staff-Evaluation`;
DROP procedure IF EXISTS `CEID-Staff-Evaluation`.`manager7`;

DELIMITER $$
USE `CEID-Staff-Evaluation`$$
CREATE PROCEDURE `manager7` (IN managerName VARCHAR(12), IN emplName VARCHAR(25), IN emplSurname VARCHAR(35))
BEGIN
	DECLARE managerComp, emplComp CHAR(9);

	DECLARE emplUname, evalUsername VARCHAR(12);

    SELECT emplUname = employee.username
    FROM employee
    WHERE employee.name = emplName AND employee.surname = emplSurname
    ;

    SELECT managerComp = manager.firm
    FROM manager
    WHERE manager.managerUsername = managerName
    ;

    SELECT emplComp = employee.firm
    FROM employee
    WHERE employee.username = emplUname
    ;

    IF managerComp = emplComp THEN
		SELECT evaluation.evaluationID, evaluation.emplUsername, evaluation.jobID, evaluation.interviewGrade, evaluation.reportGrade, evaluation.recGrade, evaluation.finalGrade, evaluation.comments, user.name, user.surname
		FROM evaluation
		INNER JOIN user
		ON evaluation.evalUsername = user.username AND evaluation.emplUsername = emplUname AND evaluation.completed = 1
		;
	ELSE
		SELECT 'No employee found.' ;
	END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure manager3
-- -----------------------------------------------------

USE `CEID-Staff-Evaluation`;
DROP procedure IF EXISTS `CEID-Staff-Evaluation`.`manager3`;

DELIMITER $$
USE `CEID-Staff-Evaluation`$$
CREATE PROCEDURE `manager3` (IN managerName VARCHAR(12), IN id INT(4), IN newSalary FLOAT(6,1))
BEGIN
	DECLARE managerComp CHAR(9);

    SELECT managerComp = manager.firm
    FROM manager
    WHERE manager.managerUsername = managerName
    ;

    UPDATE job
    SET job.salary = newSalary
    WHERE job.jodID = id AND job.edra = managerComp
    ;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure manager6
-- -----------------------------------------------------

USE `CEID-Staff-Evaluation`;
DROP procedure IF EXISTS `CEID-Staff-Evaluation`.`manager6`;

DELIMITER $$
USE `CEID-Staff-Evaluation`$$
CREATE PROCEDURE `manager6` (IN managerName VARCHAR(12), IN emplUsername VARCHAR(12), IN newSistatikes VARCHAR(35), IN newCertificates VARCHAR(35), IN newAwards VARCHAR(35))
BEGIN
	DECLARE managerComp, emplComp CHAR(9);

    SELECT managerComp = manager.firm
    FROM manager
    WHERE manager.managerUsername = managerName
    ;

    UPDATE employee
    SET employee.sistatikes = newSistatikes, employee.certificates = newCertificates, employee.awards = newAwards
    WHERE employee.username = emplUsername AND employee.firm = managerComp
    ;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure manager4
-- -----------------------------------------------------

USE `CEID-Staff-Evaluation`;
DROP procedure IF EXISTS `CEID-Staff-Evaluation`.`manager4`;

DELIMITER $$
USE `CEID-Staff-Evaluation`$$
CREATE PROCEDURE `manager4` (IN managerName VARCHAR(12))
BEGIN
	DECLARE managerComp CHAR(9);

    SELECT managerComp = manager.firm
    FROM manager
    WHERE manager.managerUsername = managerName
    ;

    SELECT evaluation.evaluationID, evaluation.emplUsername, evaluation.evalUsername, job.ID, evaluation.finalGrade, evaluation.comments
    FROM evaluation
    INNER JOIN job
    ON job.ID = evaluation.jobID AND job.edra = managerComp AND evaluation.completed = 1
    ;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure admin2.1
-- -----------------------------------------------------

USE `CEID-Staff-Evaluation`;
DROP procedure IF EXISTS `CEID-Staff-Evaluation`.`admin2.1`;

DELIMITER $$
USE `CEID-Staff-Evaluation`$$
CREATE PROCEDURE `admin2.1` (IN newAFM CHAR(9), IN newDOY VARCHAR(15), IN newName VARCHAR(15), IN newPhone BIGINT(16), IN newStreet VARCHAR(15), IN newNum TINYINT(4), IN newCity VARCHAR(15), IN newCountry VARCHAR(15))
BEGIN
	INSERT INTO company
    VALUES (newAFM, newDOY, newName, newPhone, newStreet, newNum, newCity, newCountry)
    ;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure admin2.2
-- -----------------------------------------------------

USE `CEID-Staff-Evaluation`;
DROP procedure IF EXISTS `CEID-Staff-Evaluation`.`admin2.2`;

DELIMITER $$
USE `CEID-Staff-Evaluation`$$
CREATE PROCEDURE `admin2.2` (IN newTitle VARCHAR(36), IN newDescr TINYTEXT, IN newParentField VARCHAR(36))
BEGIN
	INSERT INTO antikeim
    VALUES (newTitle, newDescr, newParentField)
    ;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure employee1.2
-- -----------------------------------------------------

USE `CEID-Staff-Evaluation`;
DROP procedure IF EXISTS `CEID-Staff-Evaluation`.`employee1.2`;

DELIMITER $$
USE `CEID-Staff-Evaluation`$$
CREATE PROCEDURE `employee1.2` (IN emplUsername VARCHAR(12), IN newPassword VARCHAR(10))
BEGIN
	UPDATE user
	SET user.password = newPassword
	WHERE user.username = emplUsername
    ;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure employee1.3
-- -----------------------------------------------------

USE `CEID-Staff-Evaluation`;
DROP procedure IF EXISTS `CEID-Staff-Evaluation`.`employee1.3`;

DELIMITER $$
USE `CEID-Staff-Evaluation`$$
CREATE PROCEDURE `employee1.3` (IN emplUsername VARCHAR(12), IN newResume VARCHAR(35))
BEGIN
	UPDATE employee
	SET employee.resume = newResume
	WHERE employee.username = emplUsername
    ;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure employee1.1
-- -----------------------------------------------------

USE `CEID-Staff-Evaluation`;
DROP procedure IF EXISTS `CEID-Staff-Evaluation`.`employee1.1`;

DELIMITER $$
USE `CEID-Staff-Evaluation`$$
CREATE PROCEDURE `employee1.1` (IN emplUsername VARCHAR (12))
BEGIN
	SELECT *
    FROM employee
    INNER JOIN user
    ON employee.username = user.username AND employee.username = emplUsername
    ;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure employee2
-- -----------------------------------------------------

USE `CEID-Staff-Evaluation`;
DROP procedure IF EXISTS `CEID-Staff-Evaluation`.`employee2`;

DELIMITER $$
USE `CEID-Staff-Evaluation`$$
CREATE PROCEDURE `employee2` (IN emplUsername VARCHAR(12), IN id INT(4))
BEGIN
	INSERT INTO request_evaluation
    VALUES (emplUsername, id)
    ;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure employee3
-- -----------------------------------------------------

USE `CEID-Staff-Evaluation`;
DROP procedure IF EXISTS `CEID-Staff-Evaluation`.`employee3`;

DELIMITER $$
USE `CEID-Staff-Evaluation`$$
CREATE PROCEDURE `employee3` (IN emplUsrname VARCHAR(12))
BEGIN
	SELECT *
    FROM request_evaluation
    WHERE request_evaluation.emplUsername = emplUsrname
    ;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure employee4
-- -----------------------------------------------------

USE `CEID-Staff-Evaluation`;
DROP procedure IF EXISTS `CEID-Staff-Evaluation`.`employee4`;

DELIMITER $$
USE `CEID-Staff-Evaluation`$$
CREATE PROCEDURE `employee4` (IN emplUsrname VARCHAR(12), IN id INT(4))
BEGIN
	DELETE FROM request_evaluation
    WHERE request_evaluation.emplUsername = emplUsrname AND request_evaluation.jobID = id
    ;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure evaluator1.1
-- -----------------------------------------------------

USE `CEID-Staff-Evaluation`;
DROP procedure IF EXISTS `CEID-Staff-Evaluation`.`evaluator1.1`;

DELIMITER $$
USE `CEID-Staff-Evaluation`$$
CREATE PROCEDURE `evaluator1.1` (IN evalUsername VARCHAR (12))
BEGIN
	SELECT *
    FROM user
    WHERE user.username = evalUsername
    ;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure evaluator1.2
-- -----------------------------------------------------

USE `CEID-Staff-Evaluation`;
DROP procedure IF EXISTS `CEID-Staff-Evaluation`.`evaluator1.2`;

DELIMITER $$
USE `CEID-Staff-Evaluation`$$
CREATE PROCEDURE `evaluator1.2` (IN evalUsername VARCHAR(12), IN newEmail VARCHAR(30), IN newPassword VARCHAR(10))
BEGIN
	UPDATE user
    SET user.password = newPassword, user.email = newEmail
    WHERE user.username = evalUsername
    ;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure evaluator2
-- -----------------------------------------------------

USE `CEID-Staff-Evaluation`;
DROP procedure IF EXISTS `CEID-Staff-Evaluation`.`evaluator2`;

DELIMITER $$
USE `CEID-Staff-Evaluation`$$
CREATE PROCEDURE `evaluator2` (IN afm CHAR(9))
BEGIN
	SELECT *
    FROM job
    WHERE job.edra = afm
    ;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure evaluator3.1
-- -----------------------------------------------------

USE `CEID-Staff-Evaluation`;
DROP procedure IF EXISTS `CEID-Staff-Evaluation`.`evaluator3.1`;

DELIMITER $$
USE `CEID-Staff-Evaluation`$$
CREATE PROCEDURE `evaluator3.1` (IN evalUsrname VARCHAR(12), IN newID INT(4), IN newStartDate DATE, IN newSalary FLOAT(6,1), IN newPosition VARCHAR(40), IN newEdra CHAR(9), IN newExpirationDate DATETIME)
BEGIN
	INSERT INTO job
    VALUES (newID, newStartDate, newSalary, newPosition, newEdra, evalUsrname, CURRENT_DATE(), newEmpirationDate)
    ;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure evaluator3.2
-- -----------------------------------------------------

USE `CEID-Staff-Evaluation`;
DROP procedure IF EXISTS `CEID-Staff-Evaluation`.`evaluator3.2`;

DELIMITER $$
USE `CEID-Staff-Evaluation`$$
CREATE PROCEDURE `evaluator3.2` (IN id INT(4), IN field VARCHAR(36))
BEGIN
	INSERT INTO needs
    VALUES(id, field)
    ;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure evaluator3.3
-- -----------------------------------------------------

USE `CEID-Staff-Evaluation`;
DROP procedure IF EXISTS `CEID-Staff-Evaluation`.`evaluator3.3`;

DELIMITER $$
USE `CEID-Staff-Evaluation`$$
CREATE PROCEDURE `evaluator3.3` (IN newTitle VARCHAR(36), IN newDescr TINYTEXT, IN newParentField VARCHAR(36))
BEGIN
	INSERT INTO antikeim
    VALUES (newTitle, newDescr, newParentField)
    ;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure evaluator4.1
-- -----------------------------------------------------

USE `CEID-Staff-Evaluation`;
DROP procedure IF EXISTS `CEID-Staff-Evaluation`.`evaluator4.1`;

DELIMITER $$
USE `CEID-Staff-Evaluation`$$
CREATE PROCEDURE `evaluator4.1` (IN evalUsrname VARCHAR(12))
BEGIN
	SELECT *
    FROM job
    WHERE job.evaluator = evalUsrname
    ;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure evaluator4.2
-- -----------------------------------------------------

USE `CEID-Staff-Evaluation`;
DROP procedure IF EXISTS `CEID-Staff-Evaluation`.`evaluator4.2`;

DELIMITER $$
USE `CEID-Staff-Evaluation`$$
CREATE PROCEDURE `evaluator4.2` (IN evalUsrname VARCHAR(12), IN id INT(4), IN newStartDate DATE, IN newSalary FLOAT(6,1), IN newPosition VARCHAR(40), IN newEdra CHAR(9), IN newExpirationDate DATETIME)
BEGIN
	UPDATE job
    SET startDate = newStartDate, salary = newSalary, position = newPosition, edra = newEdra, expiration_date = newExpirationDate
    WHERE job.ID = id AND job.evaluator = evalUsrname
    ;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure evaluator7
-- -----------------------------------------------------

USE `CEID-Staff-Evaluation`;
DROP procedure IF EXISTS `CEID-Staff-Evaluation`.`evaluator7`;

DELIMITER $$
USE `CEID-Staff-Evaluation`$$
CREATE PROCEDURE `evaluator7` (IN evalUsrname VARCHAR(12))
BEGIN
	DECLARE evalComp CHAR(9);

    SELECT evalComp = evaluator.firm
    FROM evaluator
    WHERE evaluator.username = evalUsrname
    ;

	SELECT *
    FROM job
    WHERE job.edra = evalComp
    ;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure procedure1
-- -----------------------------------------------------

USE `CEID-Staff-Evaluation`;
DROP procedure IF EXISTS `CEID-Staff-Evaluation`.`procedure1`;

DELIMITER $$
USE `CEID-Staff-Evaluation`$$
CREATE PROCEDURE `procedure1` (IN emplName VARCHAR(25), IN emplUsername VARCHAR(35))
BEGIN
	DECLARE username VARCHAR(12);

    SELECT *
    FROM request_evaluation
    WHERE request_evaluation.emplUsername = username
    ;

    SELECT evaluation.emplUsername, user.name AS evalName, user.surname AS evalSurname, evaluation.jobID, evaluation.interviewGrade, evaluation.reportGrade, evaluation.recGrade, evaluation.finalGrade, evaluation.comments
    FROM evaluation
    INNER JOIN user
    ON evaluation.evalUsername = user.username AND evaluation.emplUsername = username AND evaluation.completed = 1
    ;

    SELECT "Αξιολόγηση σε εξέλιξη:" ;

    SELECT evaluation.emplUsername, evaluation.evalUsername, evaluation.jobID, evaluation.interviewGrade, evaluation.reportGrade, evaluation.recGrade, evaluation.finalGrade, evaluation.comments
    FROM evaluation
    WHERE evaluation.completed = 0
    ;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure admin1.1
-- -----------------------------------------------------

USE `CEID-Staff-Evaluation`;
DROP procedure IF EXISTS `CEID-Staff-Evaluation`.`admin1.1`;

DELIMITER $$
USE `CEID-Staff-Evaluation`$$
CREATE PROCEDURE `admin1.1` (IN usrname VARCHAR(12), IN pass VARCHAR(10), IN name VARCHAR(25), IN surname VARCHAR(35), IN email VARCHAR(30), IN exp TINYINT(4), IN firm CHAR(9))
BEGIN
	INSERT INTO user
    VALUES (usrname, pass, name, surname, CURRENT_DATE(), email)
    ;

    INSERT INTO manager
    VALUES (usrname, exp, firm)
    ;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure admin1.2
-- -----------------------------------------------------

USE `CEID-Staff-Evaluation`;
DROP procedure IF EXISTS `CEID-Staff-Evaluation`.`admin1.2`;

DELIMITER $$
USE `CEID-Staff-Evaluation`$$
CREATE PROCEDURE `admin1.2` (IN usrname VARCHAR(12), IN pass VARCHAR(10), IN name VARCHAR(25), IN surname VARCHAR(35), IN email VARCHAR(30), IN firm CHAR(9), IN res VARCHAR(35), sist VARCHAR(35), IN cert VARCHAR(35), IN awards VARCHAR(35))
BEGIN
	INSERT INTO user
    VALUES (usrname, pass, name, surname, CURRENT_DATE(), email)
    ;

    INSERT INTO employee
    VALUES (usrname, firm, res, sist, cert, awards)
    ;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure admin1.3
-- -----------------------------------------------------

USE `CEID-Staff-Evaluation`;
DROP procedure IF EXISTS `CEID-Staff-Evaluation`.`admin1.3`;

DELIMITER $$
USE `CEID-Staff-Evaluation`$$
CREATE PROCEDURE `admin1.3` (IN usrname VARCHAR(12), IN pass VARCHAR(10), IN name VARCHAR(25), IN surname VARCHAR(35), IN email VARCHAR(30), IN exp TINYINT(4), IN firm CHAR(9), in evalID INT(10))
BEGIN
	INSERT INTO user
    VALUES (usrname, pass, name, surname, CURRENT_DATE(), email)
    ;

    INSERT INTO evaluator
    VALUES (usrname, exp, firm, evalID)
    ;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure porcedure2
-- -----------------------------------------------------

USE `CEID-Staff-Evaluation`;
DROP procedure IF EXISTS `CEID-Staff-Evaluation`.`porcedure2`;

DELIMITER $$
USE `CEID-Staff-Evaluation`$$
CREATE PROCEDURE `porcedure2` (IN job_ID INT, IN evalUsrname VARCHAR(12))
BEGIN

DECLARE interview, report, recommendation TEXT;
DECLARE completed_eval BOOLEAN;
DECLARE final float;
DECLARE message VARCHAR(50);

DECLARE finishedFlag INT;

DECLARE evalCursor CURSOR FOR
SELECT interviewGrade, reportGrade, recGrade, completed
FROM evaluation 
WHERE evalUsername = evalUsrname  AND jobID = job_ID;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET finishedFlag=1;

OPEN evalCursor;
SET finishedFlag=0;

FETCH evalCursor INTO interview, report, recommendation, completed_eval;
	WHILE finishedFlag=0  DO

		IF completed_eval = 0 THEN
			IF interview AND report and recommendation IS NOT NULL THEN
				SET final = (interview + report + recommendation);
				UPDATE evaluation
				SET finalGrade = final
				WHERE evalUsername = evalUsrname AND jobID = job_ID
				;
			ELSE
				SET message = "There are not enough grades to compute the final result";
			END IF;
		ELSE
			SET message = "The evaluation is already completed";
		END IF;

		FETCH evalCursor INTO interview, report, recommendation, completed_eval;

	END WHILE;
CLOSE evalCursor;

SELECT message;

END$$

DELIMITER ;
USE `CEID-Staff-Evaluation`;

DELIMITER $$

USE `CEID-Staff-Evaluation`$$
DROP TRIGGER IF EXISTS `CEID-Staff-Evaluation`.`company_BEFORE_UPDATE` $$
USE `CEID-Staff-Evaluation`$$
CREATE DEFINER = CURRENT_USER TRIGGER `CEID-Staff-Evaluation`.`company_BEFORE_UPDATE` BEFORE UPDATE ON `company` FOR EACH ROW
BEGIN
  IF NEW.AFM != OLD.AFM THEN
    SET NEW.AFM = OLD.AFM;
  ELSEIF NEW.DOY != OLD.DOY THEN
    SET NEW.DOY = OLD.DOY;
  ELSEIF NEW.name != OLD.name THEN
    SET NEW.name = OLD.name;
  END IF;
END$$


USE `CEID-Staff-Evaluation`$$
DROP TRIGGER IF EXISTS `CEID-Staff-Evaluation`.`user_AFTER_INSERT` $$
USE `CEID-Staff-Evaluation`$$
CREATE DEFINER = CURRENT_USER TRIGGER `CEID-Staff-Evaluation`.`user_AFTER_INSERT` AFTER INSERT ON `user` FOR EACH ROW
BEGIN

END
$$


USE `CEID-Staff-Evaluation`$$
DROP TRIGGER IF EXISTS `CEID-Staff-Evaluation`.`user_BEFORE_UPDATE` $$
USE `CEID-Staff-Evaluation`$$
CREATE DEFINER = CURRENT_USER TRIGGER `CEID-Staff-Evaluation`.`user_BEFORE_UPDATE` BEFORE UPDATE ON `user` FOR EACH ROW
BEGIN
	IF current_user() != 'administrator' THEN
		IF NEW.username != OLD.username OR NEW.regDate != OLD.regDate OR NEW.name != OLD.name OR OLD.surname != NEW.surname THEN
			SIGNAL SQLSTATE VALUE '45000'
            SET MESSAGE_TEXT = 'You are not allowed to change this field!';
		END IF;
	END IF;
END$$


USE `CEID-Staff-Evaluation`$$
DROP TRIGGER IF EXISTS `CEID-Staff-Evaluation`.`employee_BEFORE_INSERT` $$
USE `CEID-Staff-Evaluation`$$
CREATE DEFINER = CURRENT_USER TRIGGER `CEID-Staff-Evaluation`.`employee_BEFORE_INSERT` BEFORE INSERT ON `employee` FOR EACH ROW
BEGIN
	INSERT INTO logs(username,xronos,actionTable,actionType,actionSuccess)
    VALUES (current_user(),sysdate(),'employee','INSERT',0)
    ;
END$$


USE `CEID-Staff-Evaluation`$$
DROP TRIGGER IF EXISTS `CEID-Staff-Evaluation`.`employee_AFTER_INSERT` $$
USE `CEID-Staff-Evaluation`$$
CREATE DEFINER = CURRENT_USER TRIGGER `CEID-Staff-Evaluation`.`employee_AFTER_INSERT` AFTER INSERT ON `employee` FOR EACH ROW
BEGIN
	UPDATE logs
    SET logs.actionSuccess = 1
    WHERE username = current_user() AND actionTable = 'employee' AND actionType = 'INSERT'
    ;
END$$


USE `CEID-Staff-Evaluation`$$
DROP TRIGGER IF EXISTS `CEID-Staff-Evaluation`.`employee_BEFORE_UPDATE` $$
USE `CEID-Staff-Evaluation`$$
CREATE DEFINER = CURRENT_USER TRIGGER `CEID-Staff-Evaluation`.`employee_BEFORE_UPDATE` BEFORE UPDATE ON `employee` FOR EACH ROW
BEGIN
	INSERT INTO logs(username,xronos,actionTable,actionType,actionSuccess)
    VALUES (current_user(),sysdate(),'employee','UPDATE',0)
    ;
END$$


USE `CEID-Staff-Evaluation`$$
DROP TRIGGER IF EXISTS `CEID-Staff-Evaluation`.`employee_AFTER_UPDATE` $$
USE `CEID-Staff-Evaluation`$$
CREATE DEFINER = CURRENT_USER TRIGGER `CEID-Staff-Evaluation`.`employee_AFTER_UPDATE` AFTER UPDATE ON `employee` FOR EACH ROW
BEGIN
	UPDATE logs
    SET logs.actionSuccess = 1
    WHERE username = current_user() AND actionTable = 'employee' AND actionType = 'UPDATE'
    ;
END$$


USE `CEID-Staff-Evaluation`$$
DROP TRIGGER IF EXISTS `CEID-Staff-Evaluation`.`employee_BEFORE_DELETE` $$
USE `CEID-Staff-Evaluation`$$
CREATE DEFINER = CURRENT_USER TRIGGER `CEID-Staff-Evaluation`.`employee_BEFORE_DELETE` BEFORE DELETE ON `employee` FOR EACH ROW
BEGIN
	INSERT INTO logs(username,xronos,actionTable,actionType,actionSuccess)
    VALUES (current_user(),sysdate(),'employee','DELETE',0)
    ;
END$$


USE `CEID-Staff-Evaluation`$$
DROP TRIGGER IF EXISTS `CEID-Staff-Evaluation`.`employee_AFTER_DELETE` $$
USE `CEID-Staff-Evaluation`$$
CREATE DEFINER = CURRENT_USER TRIGGER `CEID-Staff-Evaluation`.`employee_AFTER_DELETE` AFTER DELETE ON `employee` FOR EACH ROW
BEGIN
	UPDATE logs
    SET logs.actionSuccess = 1
    WHERE username = current_user() AND actionTable = 'employee' AND actionType = 'UPDATE'
    ;
END$$


USE `CEID-Staff-Evaluation`$$
DROP TRIGGER IF EXISTS `CEID-Staff-Evaluation`.`job_BEFORE_INSERT` $$
USE `CEID-Staff-Evaluation`$$
CREATE DEFINER = CURRENT_USER TRIGGER `CEID-Staff-Evaluation`.`job_BEFORE_INSERT` BEFORE INSERT ON `job` FOR EACH ROW
BEGIN
	INSERT INTO logs(username,xronos,actionTable,actionType,actionSuccess)
    VALUES (current_user(),sysdate(),'job','INSERT',0)
    ;
END$$


USE `CEID-Staff-Evaluation`$$
DROP TRIGGER IF EXISTS `CEID-Staff-Evaluation`.`job_AFTER_INSERT` $$
USE `CEID-Staff-Evaluation`$$
CREATE DEFINER = CURRENT_USER TRIGGER `CEID-Staff-Evaluation`.`job_AFTER_INSERT` AFTER INSERT ON `job` FOR EACH ROW
BEGIN
	UPDATE logs
    SET logs.actionSuccess = 1
    WHERE username = current_user() AND actionTable = 'job' AND actionType = 'INSERT'
    ;
END$$


USE `CEID-Staff-Evaluation`$$
DROP TRIGGER IF EXISTS `CEID-Staff-Evaluation`.`job_BEFORE_UPDATE` $$
USE `CEID-Staff-Evaluation`$$
CREATE DEFINER = CURRENT_USER TRIGGER `CEID-Staff-Evaluation`.`job_BEFORE_UPDATE` BEFORE UPDATE ON `job` FOR EACH ROW
BEGIN
	INSERT INTO logs(username,xronos,actionTable,actionType,actionSuccess)
    VALUES (current_user(),sysdate(),'job','UPDATE',0)
    ;
END$$


USE `CEID-Staff-Evaluation`$$
DROP TRIGGER IF EXISTS `CEID-Staff-Evaluation`.`job_AFTER_UPDATE` $$
USE `CEID-Staff-Evaluation`$$
CREATE DEFINER = CURRENT_USER TRIGGER `CEID-Staff-Evaluation`.`job_AFTER_UPDATE` AFTER UPDATE ON `job` FOR EACH ROW
BEGIN
	UPDATE logs
    SET logs.actionSuccess = 1
    WHERE username = current_user() AND actionTable = 'job' AND actionType = 'UPDATE'
    ;
END$$


USE `CEID-Staff-Evaluation`$$
DROP TRIGGER IF EXISTS `CEID-Staff-Evaluation`.`job_BEFORE_DELETE` $$
USE `CEID-Staff-Evaluation`$$
CREATE DEFINER = CURRENT_USER TRIGGER `CEID-Staff-Evaluation`.`job_BEFORE_DELETE` BEFORE DELETE ON `job` FOR EACH ROW
BEGIN
	INSERT INTO logs(username,xronos,actionTable,actionType,actionSuccess)
    VALUES (current_user(),sysdate(),'job','DELETE',0)
    ;
END$$


USE `CEID-Staff-Evaluation`$$
DROP TRIGGER IF EXISTS `CEID-Staff-Evaluation`.`job_AFTER_DELETE` $$
USE `CEID-Staff-Evaluation`$$
CREATE DEFINER = CURRENT_USER TRIGGER `CEID-Staff-Evaluation`.`job_AFTER_DELETE` AFTER DELETE ON `job` FOR EACH ROW
BEGIN
	UPDATE logs
    SET logs.actionSuccess = 1
    WHERE username = current_user() AND actionTable = 'job' AND actionType = 'DELETE'
    ;
END$$


USE `CEID-Staff-Evaluation`$$
DROP TRIGGER IF EXISTS `CEID-Staff-Evaluation`.`request_evaluation_BEFORE_INSERT` $$
USE `CEID-Staff-Evaluation`$$
CREATE DEFINER = CURRENT_USER TRIGGER `CEID-Staff-Evaluation`.`request_evaluation_BEFORE_INSERT` BEFORE INSERT ON `request_evaluation` FOR EACH ROW
BEGIN
	INSERT INTO logs(username,xronos,actionTable,actionType,actionSuccess)
    VALUES (current_user(),sysdate(),'request_evaluation','INSERT',0)
    ;
END$$


USE `CEID-Staff-Evaluation`$$
DROP TRIGGER IF EXISTS `CEID-Staff-Evaluation`.`request_evaluation_AFTER_INSERT` $$
USE `CEID-Staff-Evaluation`$$
CREATE DEFINER = CURRENT_USER TRIGGER `CEID-Staff-Evaluation`.`request_evaluation_AFTER_INSERT` AFTER INSERT ON `request_evaluation` FOR EACH ROW
BEGIN
	UPDATE logs
    SET logs.actionSuccess = 1
    WHERE username = current_user() AND actionTable = 'request_evaluation' AND actionType = 'INSERT'
    ;
END$$


USE `CEID-Staff-Evaluation`$$
DROP TRIGGER IF EXISTS `CEID-Staff-Evaluation`.`request_evaluation_BEFORE_UPDATE` $$
USE `CEID-Staff-Evaluation`$$
CREATE DEFINER = CURRENT_USER TRIGGER `CEID-Staff-Evaluation`.`request_evaluation_BEFORE_UPDATE` BEFORE UPDATE ON `request_evaluation` FOR EACH ROW
BEGIN
	INSERT INTO logs(username,xronos,actionTable,actionType,actionSuccess)
    VALUES (current_user(),sysdate(),'request_evaluation','UPDATE',0)
    ;
END$$


USE `CEID-Staff-Evaluation`$$
DROP TRIGGER IF EXISTS `CEID-Staff-Evaluation`.`request_evaluation_AFTER_UPDATE` $$
USE `CEID-Staff-Evaluation`$$
CREATE DEFINER = CURRENT_USER TRIGGER `CEID-Staff-Evaluation`.`request_evaluation_AFTER_UPDATE` AFTER UPDATE ON `request_evaluation` FOR EACH ROW
BEGIN
	UPDATE logs
    SET logs.actionSuccess = 1
    WHERE username = current_user() AND actionTable = 'request_evaluation' AND actionType = 'UPDATE'
    ;
END$$


USE `CEID-Staff-Evaluation`$$
DROP TRIGGER IF EXISTS `CEID-Staff-Evaluation`.`request_evaluation_BEFORE_DELETE` $$
USE `CEID-Staff-Evaluation`$$
CREATE DEFINER = CURRENT_USER TRIGGER `CEID-Staff-Evaluation`.`request_evaluation_BEFORE_DELETE` BEFORE DELETE ON `request_evaluation` FOR EACH ROW
BEGIN
	INSERT INTO logs(username,xronos,actionTable,actionType,actionSuccess)
    VALUES (current_user(),sysdate(),'request_evaluation','DELETE',0)
    ;
END$$


USE `CEID-Staff-Evaluation`$$
DROP TRIGGER IF EXISTS `CEID-Staff-Evaluation`.`request_evaluation_AFTER_DELETE` $$
USE `CEID-Staff-Evaluation`$$
CREATE DEFINER = CURRENT_USER TRIGGER `CEID-Staff-Evaluation`.`request_evaluation_AFTER_DELETE` AFTER DELETE ON `request_evaluation` FOR EACH ROW
BEGIN
	UPDATE logs
    SET logs.actionSuccess = 1
    WHERE username = current_user() AND actionTable = 'request_evaluation' AND actionType = 'DELETE'
    ;
END$$


DELIMITER ;
SET SQL_MODE = '';
DROP USER IF EXISTS administrator;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'administrator' IDENTIFIED BY 'administrator';

SET SQL_MODE = '';
DROP USER IF EXISTS owner;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'owner' IDENTIFIED BY 'owner';

GRANT ALL ON `CEID-Staff-Evaluation`.* TO 'owner';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
