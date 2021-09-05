CREATE DATABASE IF NOT EXISTS staffEval

USE staffEval

CREATE TABLE IF NOT EXISTS companies
(
  AFM char(9)
  , DOY VARCHAR(15)
  , name VARCHAR(35)
  , phone BIGINT(16)
  , street VARCHAR(15)  /*  di not use separate table for office location to avoID some unwanted complexity  */
  , num TINYINT(4)
  , city VARCHAR(15)
  , country VARCHAR(15)
  , PRIMARY KEY(AFM)
  , UNIQUE (manager)
  , CONSTRAINT CMPMNGR
)

CREATE TABLE IF NOT EXISTS user
(
  username VARCHAR(12)
  , password VARCHAR(10)
  , name VARCHAR(25)
  , surname VARCHAR(35)
  , reg_date DATETIME
  , email VARCHAR(30)
  , PRIMARY KEY(username)
)

CREATE TABLE IF NOT EXISTS manager
(
  managerUsername VARCHAR(12)
  , experience TINYINT(4)
  , firm CHAR(9)
  , PRIMARY KEY(managerUsername)
  , CONSTRAINT MNGRUSR
  FOREIGN KEY (managerUsername)
  REFERENCES users(username)
  ON DELETE CASCADE
  ON UPDATE CASCADE
)

CREATE TABLE IF NOT EXISTS employee
(
  username VARCHAR(12)
  , resume TEXT
  , sistatikes VARCHAR(35)
  , certificates VARCHAR(35)
  , awards VARCHAR(35)
  , firmID INT(10)
  , PRIMARY KEY(username)
  , CONSTRAINT EMPLUSR
  FOREIGN KEY (username)
  REFERENCES users(username)
  ON DELETE CASCADE
  ON UPDATE CASCADE
)

CREATE TABLE IF NOT EXISTS languages
(
  employee VARCHAR(12)
  , language SET('EN','FR','SP','GR')
  , CONSTRAINT LANGEMPL
  FOREIGN KEY (employee)
  REFERENCES employee(username)
  ON DELETE CASCADE
  ON UPDATE CASCADE
)

CREATE TABLE IF NOT EXISTS degree
(
  title VARCHAR(50)
  , institution VARCHAR(40)
  , grad_year INT(4)
  , bathmIDa ENUM('LYKEIO','UNI','MASTER','PHD')
  , PRIMARY KEY(title, institution)
  , CONSTRAINT EMPLDEGR
  FOREIGN KEY (employee)
  REFERENCES employee(empl_username)
  ON DELETE CASCADE
  ON UPDATE CASCADE
)

CREATE TABLE IF NOT EXISTS has_degree
(
  title VARCHAR(50)
  , institution varchar(50)
  , emplUsername varchar(12)
  , etos YEAR(4)
  , grade FLOAT(3,1)
  , PRIMARY KEY(title,institution,emplUsername)
  , CONSTRAINT HASDEGRTITLE
  FOREIGN KEY (title)
  REFERENCES degree(title)
  ON DELETE RESTRICT
  ON UPDATE RESTRICT
  , CONSTRAINT HASDEGRINST
  FOREIGN KEY (institution)
  REFERENCES degree(institution)
  ON DELETE CASCADE
  ON UPDATE CASCADE
  , CONSTRAINT HASDEGREMPL
  FOREIGN KEY (emplUsername)
  REFERENCES employee(username)
  ON DELETE CASCADE
  ON UPDATE CASCADE
)

CREATE TABLE IF NOT EXISTS project
(
  employee VARCHAR(12)
  , num INT AUTO INCREMENT
  , descr TEXT,
  , url VARCHAR(60)
  , PRIMARY KEY (num, employee),
  CONSTRAINT PROJEMPL
  FOREIGN KEY (employee)
  REFERENCES employee(username)
  ON DELETE CASCADE
  ON UPDATE CASCADE
)

CREATE TABLE IF NOT EXISTS evaluator
(
  username VARCHAR(12)
  , experience TINYINT(4)
  , firm CHAR(9)
  , evalNumber INT(10)
  , PRIMARY KEY (username),
  , CONSTRAINT EMPLEVAL
  FOREIGN KEY (eval_username)
  REFERENCES users(username)
  ON DELETE CASCADE
  ON UPDATE CASCADE
)

CREATE TABLE IF NOT EXISTS job
(
      'ID_num' INT,
      'title' VARCHAR,
      'street' VARCHAR,
      'announcement_date' DATE,
      'expiration_date' DATE,
      PRIMARY KEY (ID_num)
)

CREATE TABLE IF NOT EXISTS antikeim
(
      'title' VARCHAR,
      'parent_field' VARCHAR,
      PRIMARY KEY (title)
)

CREATE TABLE IF NOT EXISTS references
(
      'position_ID' INT
      , 'field_title' VARCHAR
      , PRIMARY KEY (position_ID, field_title)
      /* position reference */
      , CONSTRAINT REFPOS
      FOREIGN KEY (position_ID)
      REFERENCES position(ID_num)
      ON DELETE CASCADE
      ON UPDATE CASCADE
      /* field reference */
      , CONSTRAINT REFFIELD
      FOREIGN KEY (field_title)
      REFERENCES field(title)
      ON DELETE CASCADE
      ON UPDATE CASCADE
)

CREATE TABLE IF NOT EXISTS evaluations
(
      'employee' VARCHAR
      , 'evaluator' VARCHAR
      , 'interview_grade' INT(1) DEFAULT 0
      , 'report_grade' INT(1) DEFAULT 0
      , 'education_grade' INT(1) DEFAULT 0
      , 'final_grade' INT(2) DEFAULT 0
CREATE TABLE IF NOT EXISTS requestevaluation
(
  emplUsername VARCHAR(12)
  , jobID INT(4)
  , PRIMARY KEY(emplUsername, jobID)
  , CONSTRAINT REQEMPL
  FOREIGN KEY (emplUsername)
  REFERENCES employee(username)
  ON DELETE CASCADE
  ON UPDATE CASCADE
  , CONSTRAINT REQJOB
  FOREIGN KEY (jobID)
  REFERENCES job(ID)
  ON DELETE CASCADE
  ON UPDATE CASCADE
)

CREATE TABLE IF NOT EXISTS evaluation
(
  evalID INT(4)
  , emplUsername VARCHAR(12)
  , eval_username VARCHAR(12)
  , jobID INT(4)
  , evaluator VARCHAR(12)
  , interview_grade SET(0,1,2,3,4) DEFAULT 0
  , report_grade SET(0,1,2,3,4) DEFAULT 0
  , education_grade SET(0,1,2) DEFAULT 0
  , finished BOOLEAN DEFAULT 0
  , grade INT(4)
  , comments VARCHAR(225)
  , PRIMARY KEY(evalID,emplUsername)
  , CONSTRAINT EVALEMPL
  FOREIGN KEY (emplUsername)
  REFERENCES employee(username)
  ON DELETE CASCADE
  ON UPDATE CASCADE
  , CONSTRAINT EVALJOB
  FOREIGN KEY (jobID)
  REFERENCES job(ID)
  ON DELETE CASCADE
  ON UPDATE CASCADE
  , CONSTRAINT EVALEVAL
  FOREIGN KEY (eval_username)
  REFERENCES evaluator(username)
  ON DELETE RESTRICT
  ON UPDATE RESTRICT
)

CREATE TABLE IF NOT EXISTS logs
(
  username VARCHAR,
  time DATETIME,
  successful BOOLEAN,
  action_type VARCHAR,
  table VARCHAR,
  /* user reference */
  CONSTRAINT LOGUSR
  FOREIGN KEY (username)
  REFERENCES users(username)
  ON DELETE CASCADE
  ON UPDATE CASCADE
)

#BEGIN INSERT COMMANDS FOR DATABASE
/*
/*STORED PROCEDURES */

/* 2nd PROCEDURE */

DELIMITER $
DROP PROCEDURE IF EXISTS evaluatorEval$

CREATE PROCEDURE evaluatorEval(IN jobID INT, IN usrname VARCHAR(12))
BEGIN

DECLARE interv TEXT;
DECLARE rep TEXT;
DECLARE extra TEXT;
DECLARE completed_ev BOOLEAN;

DECLARE final_result float;

DECLARE finishedFlag INT;

DECLARE evalCursor CURSOR FOR
SELECT interview, report, extras, completed #INTO interv, rep, extra
FROM evaluation WHERE eval_username = usrname AND job_ID = jobID;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET finishedFlag=1;

OPEN evalCursor;
SET finishedFlag=0;

FETCH evalCursor INTO interv, rep, extra, completed_ev;
WHILE(finishedFlag=0) DO

IF completed_ev = 0 THEN
  IF interv AND rep and extra IS NOT NULL THEN
   SET final_result = (interv + rep + extra);
   UPDATE evaluationresult
    SET evaluationresult.grade = final_result
    WHERE eval_username = usrname AND job_ID = job_ID
   ;
/*   SELECT grade FROM evaluationresult
   WHERE eval_username = usrname AND job_ID = jobID;
   INSERT INTO grade value (final_result); */
  ELSE
   SELECT "There are not enough grades to compute the final result";
  END IF;
ELSE
  SELECT "The evaluation is already completed";
END IF;

FETCH evalCursor into interv, rep, extra, completed_ev;

END WHILE;
CLOSE evalCursor;
END$

call evaluatorEval(2, msmith);
call evaluatorEval(3, bettyg);

/* 3rd procedure */

DROP PROCEDURE IF EXISTS finalised_jobs$

CREATE PROCEDURE finalised_jobs(IN jobID INT)
BEGIN

DECLARE @localUser TEXT;
DECLARE @localFinalGrade TEXT;
DECLARE @diff INT(4);
DECLARE @userCount INT(4);
DECLARE @gradeCount INT(4);

DECLARE finishedFlag INT;

DECLARE jobsCursor CURSOR FOR
SELECT empl_username, grade
FROM evaluationresult WHERE job_ID = jobID AND (grade!=0)
ORDER BY grade DESC;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET finishedFlag=1;

SET users = 0;
select count(empl_username) into users
from evaluationresult where job_ID = jobID;

SET grades = 0;
select count(grade) into grades
from evaluationresult where job_ID = jobID;

IF (users = 0) THEN
SELECT "There are not any candIDates for this job";

ELSE

	IF (users = grades)  THEN
	SELECT "Finalised tables";

	OPEN jobsCursor;
	SET finishedFlag=0;
	WHILE(finishedFlag=0) DO
	FETCH jobsCursor INTO userr, grade;
	end while;

	ELSE

	OPEN jobsCursor;
	SET finishedFlag = 0;
	WHILE(finishedFlag=0) DO
	FETCH jobsCursor INTO userr, grade;
	END while;

	SET diff = (users - grades);

	SELECT "Ongoing evaluation";
	SELECT diff;
	SELECT "evaluations remaining";

	END IF;

END IF;
END;

END$

DELIMITER ;

/********************************************************** ***********************************************/
/* TRIGGERS */

CREATE TRIGGER IF NOT EXISTS companyTrigger
BEFORE UPDATE ON company
FOR EACH ROW
BEGIN
  IF NEW.AFM != OLD.AFM THEN
    SET NEW.AFM = OLD.AFM;
  ELSEIF NEW.DOY != OLD.DOY THEN
    SET NEW.DOY = OLD.DOY;
  ELSEIF NEW.name != OLD.name THEN
    SET NEW.name = OLD.name;
  END IF;
END;




/* BEGIN STORED PROCEDURES FOR GUI */

STORED PROCEDURE managerCompanyUpdate(IN managerName, IN companyName, IN newPhone, IN newStreet, IN newStreet_num, IN newCity, IN newCountry)
BEGIN
  UPDATE companies
   SET
    phone = newPhone
    , street = newStreet
    , street_num = newStreet_num
    , city = newCity
    , country = newCountry
   WHERE
    companies.manager = managerName AND companies.name = companyName
   ;
END

STORED PROCEDURE managerUserUpdate (IN managerName, IN newPassword, IN newEmail)
BEGIN
  UPDATE users
   SET
    users.password = newPassword
    , users.email = newEmail
   WHERE
    user.username = manager_username
   ;
END

STORED PROCEDURE managerSalaryUpdate (IN managerName, IN newSalary)
BEGIN
  DECLARE @localAfm INT;
  @AFM = SELECT AFM FROM companies WHERE manager = managerName;
  UPDATE positions
   SET
    positions.salary = newSalary
   WHERE
    positions.company_AFM = @localAfm
   ;
END

STORED PROCEDURE viewEvaluations (IN companyAfm)
BEGIN
  DECLARE

END

*/
