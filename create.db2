/*********************************CREATING TABLES********************************/
/* Two notes:
   (1) Assumption when using VARCHAR throughout: our database uses UTF-8 to store
   characters (otherwise the specified number of VARCHAR bytes would not equate 
   the number of characters. I.e. VARCHAR(50) lets department.dept_name be up to 
   10 characters long, but if the database did not use UTF-8, the maximum number 
   of characters could be lesser)
	 (2) Non-existent middle names will be denoted as empty strings, not NULL or
	 "NMN"
*/

CREATE TABLE department(
  dept_name VARCHAR(10) NOT NULL PRIMARY KEY,
  head CHAR(10)); -- Not sure how to implement this one:
                  -- (1) It should be an FK to an employee's ID, such that if the
                  --     employee is fired, then the department.head entry is
                  --     deleted
                  -- (2) It has the same issue as phone_number.id and
                  --     email_address.id*

CREATE TABLE doctor(
  doctor_id CHAR(10) NOT NULL PRIMARY KEY,
  alma_mater VARCHAR(50),
  dept_name VARCHAR(25) NOT NULL REFERENCES department,
  first_name VARCHAR(25) NOT NULL,
  middle_name VARCHAR(25) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  sex CHAR(1) NOT NULL CHECK(
    sex = 'M'
    OR sex = 'F'),
  dob DATE NOT NULL,
  street_address VARCHAR(25) NOT NULL,
  city VARCHAR(25) NOT NULL,
  state CHAR(2) NOT NULL,
  zip CHAR(5) NOT NULL,
  ssn CHAR(9) NOT NULL UNIQUE,
  occupation VARCHAR(25) NOT NULL);
  
CREATE TABLE nurse(
  nurse_id CHAR(10) NOT NULL PRIMARY KEY,
  
  /* Refer to link at the bottom of this file for the level_of_education codes */
  level_of_education SMALLINT NOT NULL CHECK(level_of_education BETWEEN 0 AND 22),
  dept_name VARCHAR(25) NOT NULL REFERENCES department,
  first_name VARCHAR(25) NOT NULL,
  middle_name VARCHAR(25) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  sex CHAR(1) NOT NULL CHECK(
    sex = 'M'
    OR sex = 'F'),
  dob DATE NOT NULL,
  street_address VARCHAR(25) NOT NULL,
  city VARCHAR(25) NOT NULL,
  state CHAR(2) NOT NULL,
  zip CHAR(5) NOT NULL,
  ssn CHAR(9) NOT NULL UNIQUE,
  occupation VARCHAR(25) NOT NULL);
  
CREATE TABLE secretary(
  secretary_id CHAR(10) NOT NULL PRIMARY KEY,
  is_senior BOOLEAN NOT NULL,
  dept_name VARCHAR(25) NOT NULL REFERENCES department,
  first_name VARCHAR(25) NOT NULL,
  middle_name VARCHAR(25) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  sex CHAR(1) NOT NULL CHECK(
    sex = 'M'
    OR sex = 'F'),
  dob DATE NOT NULL,
  street_address VARCHAR(25) NOT NULL,
  city VARCHAR(25) NOT NULL,
  state CHAR(2) NOT NULL,
  zip CHAR(5) NOT NULL,
  ssn CHAR(9) NOT NULL UNIQUE,
  occupation VARCHAR(25) NOT NULL);
  
CREATE TABLE patient(
  patient_id CHAR(10) NOT NULL PRIMARY KEY,
  first_name VARCHAR(25) NOT NULL,
  middle_name VARCHAR(25) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  sex CHAR(1) NOT NULL CHECK(
    sex = 'M'
    OR sex = 'F'),
  dob DATE NOT NULL,
  street_address VARCHAR(25) NOT NULL,
  city VARCHAR(25) NOT NULL,
  state CHAR(2) NOT NULL,
  zip CHAR(5) NOT NULL,
  
  /* Undocumented patients will have the SSN of 000-00-0000, hence this is not a
     candidate key by default for person_type. */
  ssn CHAR(9) NOT NULL,
  height_in_cm SMALLINT CHECK(height_in_cm BETWEEN 0 AND 300),
  blood_group VARCHAR(3) NOT NULL CHECK(
    blood_group IN ('A+', 'B+', 'AB+', 'O+', 'A-', 'B-', 'AB-', 'O-')));

CREATE TABLE visit(
  patient_id CHAR (10) NOT NULL REFERENCES patient,
  datetime_in TIMESTAMP NOT NULL,
  datetime_out TIMESTAMP,               -- Is this the projected datetime_out or
  doctor_id CHAR(10) REFERENCES doctor, -- the actual one? The latter case 
  nurse_id CHAR(10) NOT NULL REFERENCES nurse,   
                                        -- requires this attribute to be NULL,
                                        -- until the visit is over with.
                                        
  /* Whether or not the following five attributes are jotted down varies by
     visit, and reason for visit, hence NULLs are welcome */
  notes VARCHAR(30000),
  blood_pressure SMALLINT,
  heart_rate SMALLINT,
  temperature DECIMAL(4, 1),
  oxygen_level DECIMAL(3, 2),
  PRIMARY KEY (patient_id, datetime_in));
  
CREATE TABLE phone_number(
  id CHAR(10) NOT NULL,           -- Not sure how to make this an FK to multiple  
  type VARCHAR(6) NOT NULL CHECK( -- possible employee/patient tables. The same
                                  -- issue applies to the table below
    type IN ('MOBILE', 'HOME', 'WORK', 'SCHOOL', 'MAIN')), 
  availability VARCHAR(10) CHECK(
    availability IN ('MORNING', 'AFTERNOON', 'EVENING', 'ON-CALL')
    OR availability IS NULL),
  number CHAR(10) NOT NULL,
  PRIMARY KEY (id, number)); -- I assume this should be the PK, although the 
                             -- schema diagram did not specify it. Ditto for the
CREATE TABLE email_address(  -- table below
  id CHAR(10) NOT NULL,
  email VARCHAR(345) NOT NULL CHECK(
  
  /* This will ensure that emails have at least one character before the "@,"
     and at least two characters before and after the "." */
    email LIKE '%_@__%.__%'),
  PRIMARY KEY (id, email));

/********************************CREATING VIEWS**********************************/


/***********************************APPENDIX**************************************
Easy codes to categorize nurse.level_of_education:
https://help.nfc.usda.gov/publications/EPICWEB/6592.htm#:~:text=Education%20Level%20Table%20%20%20%20Code%20,graduate.%20Hig%20...%20%2019%20more%20rows%20
*/
