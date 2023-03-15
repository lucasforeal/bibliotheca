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
  zip CHAR(5) NOT NULL
);

CREATE TABLE department(
  dept_name VARCHAR(25) NOT NULL PRIMARY KEY,
  head CHAR(10) REFERENCES member ON DELETE SET NULL
);

CREATE TABLE doctor(
  doctor_id CHAR(10) NOT NULL PRIMARY KEY REFERENCES member ON DELETE CASCADE,
  alma_mater VARCHAR(50),
  dept_name VARCHAR(25) NOT NULL REFERENCES department ON DELETE CASCADE,
  ssn CHAR(9) NOT NULL UNIQUE
);
  
CREATE TABLE nurse(
  nurse_id CHAR(10) NOT NULL PRIMARY KEY REFERENCES member ON DELETE CASCADE,
  /* Refer to link at the bottom of this file for the level_of_education codes */
  level_of_education SMALLINT NOT NULL CHECK(level_of_education BETWEEN 0 AND 22),
  dept_name VARCHAR(25) NOT NULL REFERENCES department ON DELETE CASCADE,
  ssn CHAR(9) NOT NULL UNIQUE

);
  
CREATE TABLE secretary(
  secretary_id CHAR(10) NOT NULL PRIMARY KEY REFERENCES member ON DELETE CASCADE,
  is_senior BOOLEAN NOT NULL,
  dept_name VARCHAR(25) NOT NULL REFERENCES department ON DELETE CASCADE,
  ssn CHAR(9) NOT NULL UNIQUE

);
  
CREATE TABLE patient(
  patient_id CHAR(10) NOT NULL PRIMARY KEY REFERENCES member ON DELETE CASCADE,
  /* Undocumented patients will have the SSN of 000-00-0000, hence this is not a
     candidate key by default for person_type. */
  ssn CHAR(9) NOT NULL,
  blood_group VARCHAR(3) NOT NULL CHECK(
    blood_group IN ('A+', 'B+', 'AB+', 'O+', 'A-', 'B-', 'AB-', 'O-')
  )
);

CREATE TABLE visit(
  patient_id CHAR (10) NOT NULL REFERENCES patient ON DELETE CASCADE,
  datetime_in TIMESTAMP NOT NULL,
  datetime_out TIMESTAMP NOT NULL,
  doctor_id CHAR(10) REFERENCES doctor ON DELETE SET NULL,
  nurse_id CHAR(10) REFERENCES nurse ON DELETE SET NULL,
                                        
  /* Whether or not the following six attributes are jotted down varies by
     visit, and reason for visit, hence NULLs are welcome */
  notes VARCHAR(30),

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
	weight SMALLINT CHECK (weight BETWEEN 50 AND 450)
);
  
CREATE TABLE phone_number(
  id CHAR(10) NOT NULL REFERENCES member ON DELETE CASCADE,
  type VARCHAR(6) NOT NULL CHECK(
    type IN ('MOBILE', 'HOME', 'WORK', 'SCHOOL', 'MAIN')), 
  availability VARCHAR(10) CHECK(
    availability IN ('MORNING', 'AFTERNOON', 'EVENING', 'ON-CALL')
    OR availability IS NULL),
  number CHAR(10) NOT NULL,
  PRIMARY KEY (id, number)
);
	
CREATE TABLE email_address(  
  id CHAR(10) NOT NULL REFERENCES member ON DELETE CASCADE,
  email VARCHAR(345) NOT NULL CHECK(
  
  /* This will ensure that emails have at least one character before the "@,"
     and at least two characters before and after the "." */
    email LIKE '%_@__%.__%'),
  PRIMARY KEY (id, email)
);

/********************************CREATING VIEWS***********************************
We can think of many different view restrictions for a hospital database, but
since we were not asked to list such as non-functional requirements back in
assignment one, we will only incorporate the non-functional requirements there
(which are enough for the scope of this project). The only view mentioned there is
NF requirement D, which among the triggers below will be the only view
Implemented. NF Requirements C and F, however, will not be implemented, since we
are no longer keeping track of rooms, and money, per feedback */

CREATE TRIGGER one_patient_at_a_time
BEFORE INSERT ON visit
REFERENCING NEW AS n
FOR EACH ROW

/* There cannot be two visits for different patients where the times overlap and
   they they are seeing the same doctor */
WHEN(EXISTS(
  SELECT 1
  FROM visit v
  WHERE v.doctor_id = n.doctor_id
    AND v.datetime_in <= n.datetime_out
    AND n.datetime_in <= v.datetime_out
    AND v.patient_id <> n.patient_id
))
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'ERROR: DOCTOR CANNOT SEE BOTH PATIENTS SIMULTANEOUSLY';

CREATE TRIGGER no_workaholic_doctors
BEFORE INSERT ON VISIT
REFERENCING NEW AS n
FOR EACH ROW

/* Insert visit only thrives if its length plus the number of total hours its
   doctor has already worked this week number (ISO), this year, is lesser than 40
  */
WHEN(
   40 < HOUR(n.datetime_in - n.datetime_out) +
          (SELECT SUM(HOUR(datetime_out - datetime_in)) AS total_week_hours
	  FROM visit
	  WHERE doctor_id = n.doctor_id
	    AND YEAR(n.datetime_in) = YEAR(datetime_in)
      AND WEEK_ISO(n.datetime_in) = WEEK_ISO(datetime_in)
	  GROUP BY datetime_in))
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'ERROR: DOCTORS CANNOT GO OVER 40-HOUR-WEEKS';

/* Merely just a subset of the views we could implement, if this was a bigger
   project */
CREATE VIEW medical_secretary_insertable_view_on_visit AS
SELECT patient_id, datetime_in, datetime_out, doctor_id, nurse_id
FROM visit;

CREATE TRIGGER no_same_day_appointments
BEFORE INSERT ON visit
REFERENCING NEW AS n
FOR EACH ROW
WHEN(EXISTS(
  SELECT 1
	FROM visit
	WHERE DATE(n.datetime_in) IN(
	  SELECT DATE(datetime_in)
		FROM visit)))
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'ERROR: NO SAME-DAY APPOINTMENTS';

CREATE TRIGGER no_minors
BEFORE INSERT ON member
REFERENCING NEW AS n
FOR EACH ROW
WHEN(YEAR(CURRENT DATE - n.dob) < 18)
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'ERROR: THIS IS AN ADULT-ONLY MEDICAL CENTER';

/* Note how this is (1) an update trigger, not an insert one, and (2) how this is
   a requirement not origally in our non-functional requirements document */
CREATE TRIGGER patients_cannot_be_dept_head
BEFORE INSERT ON department
REFERENCING NEW AS n
FOR EACH ROW
WHEN(
  n.head IN(
  	SELECT DISTINCT patient_id
	  FROM patient))
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'ERROR: PATIENTS CANNOT BE DEPARTMENT HEAD';

/***********************************APPENDIX**************************************
Easy codes to categorize nurse.level_of_education:
-- https://help.nfc.usda.gov/publications/EPICWEB/6592.htm#:~:text=Education%20Level%20Table%20%20%20%20Code%20,graduate.%20Hig%20...%20%2019%20more%20rows%20
*/
