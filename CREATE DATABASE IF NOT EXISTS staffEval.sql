CREATE DATABASE IF NOT EXISTS staffEval

USE staffEval

CREATE TABLE IF NOT EXISTS companies
(
      'afm' INT,
      'doy' VARCHAR,
      'phone' INT(10),
      'street' VARCHAR,          /*  did not use separate table for office location to avoid some unwanted complexity  */
      'street_num' INT,
      'city' VARCHAR,
      'country' VARCHAR,
      PRIMARY KEY(afm),

)

CREATE TABLE IF NOT EXISTS users
(
      'username' VARCHAR,
      'password' VARCHAR,
      'email' VARCHAR,
      'reg_date' DATE,
      PRIMARY KEY(username)
)

CREATE TABLE IF NOT EXISTS managers
(
      'manager_username' VARCHAR,
      'company' VARCHAR,
      'experience' INT,
      PRIMARY KEY(manager_username),
      CONSTRAINT USRMNGR
      FOREIGN KEY (manager_username)
      REFERENCES users(username)
      ON DELETE CASCADE
      ON UPDATE CASCADE
)

CREATE TABLE IF NOT EXISTS employees
(
      'empl_username' VARCHAR,
      'employee_ID_number' INT,
      'company_AFM' INT,
      'experience' INT,
      'resume' VARCHAR,
      'certifications' VARCHAR,
      'praises' VARCHAR,
      PRIMARY KEY(empl_username),
      /* user reference */
      CONSTRAINT EMPLUSR
      FOREIGN KEY (empl_username)
      REFERENCES users(username)
      ON DELETE CASCADE
      ON UPDATE CASCADE
      /* company reference */
      CONSTRAINT EMPLCOMP
      FOREIGN KEY (company_AFM)
      REFERENCES companies(afm)
      ON DELETE RESTRICT
      ON UPDATE CASCADE
)

CREATE TABLE IF NOT EXISTS languages
(
      'employee' VARCHAR,
      'language' VARCHAR,
      CONSTRAINT LANG
      FOREIGN KEY (employee)
      REFERENCES employee(empl_username)
      ON DELETE CASCADE
      ON UPDATE CASCADE
)

CREATE TABLE IF NOT EXISTS degrees
(
      'title' VARCHAR,
      'institution' VARCHAR,
      'employee' VARCHAR,
      'grad_year' INT(4),
      'grade' INT,
      PRIMARY KEY(title, institution),
      CONSTRAINT EMPLDEGR
      FOREIGN KEY (employee)
      REFERENCES employee(empl_username)
      ON DELETE CASCADE
      ON UPDATE CASCADE
)

CREATE TABLE IF NOT EXISTS projects
(
     'description' VARCHAR,
     'url' VARCHAR,
     'num' INT AUTO INCREMENT,
     'employee' VARCHAR,
     PRIMARY KEY (num, employee),
     CONSTRAINT EMPLPROJ
     FOREIGN KEY (employee)
     REFERENCES employee(empl_username)
     ON DELETE CASCADE
     ON UPDATE CASCADE
)

CREATE TABLE IF NOT EXISTS evaluators
(
      'eval_username' VARCHAR,
      'comp_afm' INT,
      'eval_number' INT,
      PRIMARY KEY (eval_number),
      CONSTRAINT EMPLEVAL
      FOREIGN KEY (eval_username)
      REFERENCES users(username)
      ON DELETE CASCADE
      ON UPDATE CASCADE
)

CREATE TABLE IF NOT EXISTS position
(
      'ID_num' INT,
      'title' VARCHAR,
      'street' VARCHAR,
      'announcement_date' DATE,
      'expiration_date' DATE,
      PRIMARY KEY (ID_num)
)

CREATE TABLE IF NOT EXISTS field
(
      'title' VARCHAR,
      'parent_field' VARCHAR,
      PRIMARY KEY (title)
)

CREATE TABLE IF NOT EXISTS references
(
      'position_ID' INT,
      'field_title' VARCHAR,
      PRIMARY KEY (position_ID, field_title)
      /* position reference */
      CONSTRAINT POSREF
      FOREIGN KEY (position_ID)
      REFERENCES position(ID_num)
      ON DELETE CASCADE
      ON UPDATE CASCADE
      /* field reference */
      CONSTRAINT FIELDREF
      FOREIGN KEY (field_title)
      REFERENCES field(title)
      ON DELETE CASCADE
      ON UPDATE CASCADE
)

CREATE TABLE IF NOT EXISTS evaluation
(
      'employee' VARCHAR,
      'evaluator' VARCHAR,
      'interview_grade' INT(1) DEFAULT 0,
      'report_grade' INT(1) DEFAULT 0,
      'education_grade' INT(1) DEFAULT 0,
      'final_grade' INT(2) DEFAULT 0,
      'evaluator_comments' VARCHAR,
      PRIMARY KEY(employee,evaluator),
      /* employee reference */
      CONSTRAINT EVALEMPL
      FOREIGN KEY (employee)
      REFERENCES employees(empl_username)
      ON DELETE CASCADE
      ON UPDATE CASCADE
      /* evaluator reference */
      CONSTRAINT EVALEVAL
      FOREIGN KEY (evaluator)
      REFERENCES evaluators(eval_username)
      ON DELETE CASCADE
      ON UPDATE CASCADE

)

CREATE TABLE IF NOT EXISTS applications
(
      'employee' VARCHAR,
      'company' VARCHAR,
      'position' VARCHAR,
      /* employee reference */
      CONSTRAINT APPLEMPL
      FOREIGN KEY(employee)
      REFERENCES employees(empl_username)
      ON DELETE CASCADE
      ON UPDATE CASCADE
      /* company reference */
      CONSTRAINT APPLCOMP
      FOREIGN KEY(company)
      REFERENCES company(afm)
      ON DELETE CASCADE
      ON UPDATE CASCADE
)

CREATE TABLE IF NOT EXISTS logs
(
      'username' VARCHAR,
      'time' DATETIME,
      'successful' BOOLEAN,
      'action_type' VARCHAR,
      'table' VARCHAR,
      /* user reference */
      CONSTRAINT LOGUSR
      FOREIGN KEY (username)
      REFERENCES users(username)
      ON DELETE CASCADE
      ON UPDATE CASCADE
)

#BEGIN INSERT COMMANDS FOR DATABASE
