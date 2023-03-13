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
CREATE TABLE member(
  id CHAR(10) NOT NULL PRIMARY KEY,
  first_name VARCHAR(25) NOT NULL,
  middle_name VARCHAR(25) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  sex CHAR(1) NOT NULL CHECK(
    sex = 'M'
    OR sex = 'F'),
  dob DATE NOT NULL,
  street_address VARCHAR(25) NOT NULL,
  city VARCHAR(25) NOT NULL,
  stateAb CHAR(2) NOT NULL,
  zip CHAR(5) NOT NULL);

CREATE TABLE department(
  dept_name VARCHAR(10) NOT NULL PRIMARY KEY,
  head CHAR(10) REFERENCES member CHECK(

  /* Ensure department head is not a patient */
    head NOT IN (
      SELECT DISTINCT patient_id
      FROM patient)));

CREATE TABLE doctor(
  doctor_id CHAR(10) NOT NULL PRIMARY KEY REFERENCES member,
  dept_name VARCHAR(25) NOT NULL REFERENCES department,
  alma_mater VARCHAR(50),
  ssn CHAR(9) NOT NULL UNIQUE);
  
CREATE TABLE nurse(
  nurse_id CHAR(10) NOT NULL PRIMARY KEY REFERENCES member,
  /* Refer to link at the bottom of this file for the level_of_education codes */
  level_of_education SMALLINT NOT NULL CHECK(level_of_education BETWEEN 0 AND 22),
  dept_name VARCHAR(25) NOT NULL REFERENCES department,
  ssn CHAR(9) NOT NULL UNIQUE);
  
CREATE TABLE secretary(
  secretary_id CHAR(10) NOT NULL PRIMARY KEY REFERENCES member,
  is_senior BOOLEAN NOT NULL,
  dept_name VARCHAR(25) NOT NULL REFERENCES department,
  ssn CHAR(9) NOT NULL UNIQUE);
  
CREATE TABLE patient(
  patient_id CHAR(10) NOT NULL PRIMARY KEY REFERENCES member,
  /* Undocumented patients will have the SSN of 000-00-0000, hence this is not a
     candidate key by default for person_type. */
  ssn CHAR(9) NOT NULL,
  blood_group VARCHAR(3) NOT NULL CHECK(
    blood_group IN ('A+', 'B+', 'AB+', 'O+', 'A-', 'B-', 'AB-', 'O-')));

CREATE TABLE visit(
  patient_id CHAR (10) NOT NULL REFERENCES patient,
  datetime_in TIMESTAMP NOT NULL,
  datetime_out TIMESTAMP NOT NULL,
  doctor_id CHAR(10) REFERENCES doctor CHECK,
  nurse_id CHAR(10) NOT NULL REFERENCES nurse,
                                        
  /* Whether or not the following six attributes are jotted down varies by
     visit, and reason for visit, hence NULLs are welcome */
  notes VARCHAR(30000),

  /* To save time typing  when using this database, the official abbreviations for
	   the following have been used, respectively: systolic blood pressure,
		 diastolic BP, heart rate, temperature, and oxygen level */
  sbp SMALLINT CHECK(
	  sbp BETWEEN 0 AND 200
		OR sbp IS NULL),
	dbp SMALLINT CHECK(
	  dbp BETWEEN 0 AND 150
		OR dbp IS NULL),
  hr SMALLINT CHECK(
	  hr BETWEEN 0 AND 250
		OR hr IS NULL),
  t DECIMAL(4, 1) CHECK(
	  t BETWEEN 75 AND 125
		OR t IS NULL),
  sp_o2 DECIMAL(3, 2) CHECK(
	  sp_o2 BETWEEN 0.00 AND 1.00
		OR sp_o2 IS NULL),
  PRIMARY KEY (patient_id, datetime_in),

  /* This is an adult clinic, anything out of the two ranges below is a clear
	   type-out */
	height SMALLINT CHECK (height BETWEEN 100 AND 300),
	weight SMALLINT CHECK (weight BETWEEN 50 AND 450);
  
CREATE TABLE phone_number(
  id CHAR(10) NOT NULL REFERENCES member,
  type VARCHAR(6) NOT NULL CHECK(
    type IN ('MOBILE', 'HOME', 'WORK', 'SCHOOL', 'MAIN')), 
  availability VARCHAR(10) CHECK(
    availability IN ('MORNING', 'AFTERNOON', 'EVENING', 'ON-CALL')
    OR availability IS NULL),
  number CHAR(10) NOT NULL,
  PRIMARY KEY (id, number));
	
CREATE TABLE email_address(  
  id CHAR(10) NOT NULL REFERENCES member,
  email VARCHAR(345) NOT NULL CHECK(
  
  /* This will ensure that emails have at least one character before the "@,"
     and at least two characters before and after the "." */
    email LIKE '%_@__%.__%'),
  PRIMARY KEY (id, email));

/********************************CREATING VIEWS**********************************/
CREATE TRIGGER one_patient_at_a_time
BEFORE INSERT ON visit
REFERENCING NEW AS n
FOR EACH ROW

/* There cannot be two visits for different patients where the times overlap and
   they they are seeing the same doctor */
WHEN (EXISTS (
  SELECT 1
  FROM visit v
  WHERE v.doctor_id = n.doctor_id
    AND v.datetime_in <= n.datetime_out
    AND n.datetime_in <= v.datetime_out
    AND v.patient_id <> n.patient_id
))
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'ERROR: DOCTOR CANNOT SEE BOTH PATIENTS SIMULTANEOUSLY';

/***********************************APPENDIX**************************************
Easy codes to categorize nurse.level_of_education:
-- https://help.nfc.usda.gov/publications/EPICWEB/6592.htm#:~:text=Education%20Level%20Table%20%20%20%20Code%20,graduate.%20Hig%20...%20%2019%20more%20rows%20
*/
