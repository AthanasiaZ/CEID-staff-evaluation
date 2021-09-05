CREATE TABLE IF NOT EXISTS company
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
);

CREATE TABLE IF NOT EXISTS user
(
  username VARCHAR(12)
  , password VARCHAR(10)
  , name VARCHAR(25)
  , surname VARCHAR(35)
  , reg_date DATETIME
  , email VARCHAR(30)
  , PRIMARY KEY(username)
);

CREATE TABLE IF NOT EXISTS manager
(
  managerUsername VARCHAR(12)
  , experience TINYINT(4)
  , firm CHAR(9)
  , PRIMARY KEY(managerUsername)
  , CONSTRAINT MNGRUSR
  FOREIGN KEY (managerUsername)
  REFERENCES user(username)
  ON DELETE CASCADE
  ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS employee
(
  username VARCHAR(12)
  , resume TEXT
  , sistatikes VARCHAR(35)
  , certificates VARCHAR(35)
  , awards VARCHAR(35)
  , employeeID INT(10)
  , PRIMARY KEY(username)
  , CONSTRAINT EMPLUSR
  FOREIGN KEY (username)
  REFERENCES user(username)
  ON DELETE CASCADE
  ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS languages
(
  employee VARCHAR(12)
  , language SET('EN','FR','SP','GR')
  , CONSTRAINT LANGEMPL
  FOREIGN KEY (employee)
  REFERENCES employee(username)
  ON DELETE CASCADE
  ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS degree
(
  title VARCHAR(50)
  , institution VARCHAR(40)
  , bathmida ENUM('LYKEIO','UNI','MASTER','PHD')
  , PRIMARY KEY(title, institution)
);

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
  ON UPDATE CASCADE
  , CONSTRAINT HASDEGRINST
  FOREIGN KEY (institution)
  REFERENCES degree(institution)
  ON DELETE RESTRICT
  ON UPDATE CASCADE
  , CONSTRAINT HASDEGREMPL
  FOREIGN KEY (emplUsername)
  REFERENCES employee(username)
  ON DELETE CASCADE
  ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS project
(
  employee VARCHAR(12)
  , num INT AUTO_INCREMENT
  , descr TEXT
  , url VARCHAR(60)
  , PRIMARY KEY (num, employee)
  , CONSTRAINT PROJEMPL
  FOREIGN KEY (employee)
  REFERENCES employee(username)
  ON DELETE CASCADE
  ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS evaluator
(
  username VARCHAR(12)
  , experience TINYINT(4)
  , firm CHAR(9)
  , evaluatorID INT(10)
  , PRIMARY KEY (username)
  , CONSTRAINT EMPLEVAL
  FOREIGN KEY (username)
  REFERENCES user(username)
  ON DELETE CASCADE
  ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS job
(
      ID INT(4)
      , startDate DATE
      , salary FLOAT(6,1)
      , position VARCHAR(40)
      , edra VARCHAR(45)
      , evaluator VARCHAR(12)
      , announcement_date DATETIME
      , expiration_date DATETIME
      , PRIMARY KEY (ID_num)
      , CONSTRAINT JOBEVAL
      FOREIGN KEY (evaluator)
      REFERENCES evaluator(username)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS needs
(
      jobID INT(4)
      , fieldTitle VARCHAR(36)
      , PRIMARY KEY (jobID, fieldTitle)
      , CONSTRAINT NEEDSJOB
      FOREIGN KEY (jobID)
      REFERENCES job(ID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
      , CONSTRAINT NEEDSANTIKEIM
      FOREIGN KEY (fieldTitle)
      REFERENCES antikeim(title)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS antikeim
(
  title VARCHAR(36)
  , descr TINYTEXT
  , parentField VARCHAR(36)
  , PRIMARY KEY(title)
  , CONSTRAINT ANTIKEIMANTIKEIM
  FOREIGN KEY (title)
  REFERENCES antikeim(title)
  ON DELETE RESTRICT
  ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS request_evaluation
(
  emplUsername VARCHAR(12)
  , jobID INT(4)
  , PRIMARY KEY(emplUsername,jobID)
  , CONSTRAINT REQEVALEMPL
  FOREIGN KEY (emplUsername)
  REFERENCES employee(username)
  ON DELETE CASCADE
  ON UPDATE CASCADE
  , CONSTRAINT REQEVALJOB
  FOREIGN KEY (jobID)
  REFERENCES job(ID)
  ON DELETE CASCADE
  ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS evaluation
(
  evaluationID INT(4)
  , emplUsername VARCHAR(12)
  , jobID INT(4)
  , interviewGrade INT(1) DEFAULT 0
  , reportGrade INT(1) DEFAULT 0
  , recGrade INT(1) DEFAULT 0
  , finalGrade INT(2) DEFAULT 0
  , comments VARCHAR(255)
  , PRIMARY KEY(evaluationID,emplUsername)
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
);

CREATE TABLE IF NOT EXISTS logs
(
  username VARCHAR(12)
  , xronos DATETIME
  , successful BOOLEAN
  , action_type VARCHAR(15)
  , PRIMARY KEY(username,xronos)
  , CONSTRAINT LOGUSR
  FOREIGN KEY (username)
  REFERENCES user(username)
  ON DELETE CASCADE
  ON UPDATE CASCADE
);
