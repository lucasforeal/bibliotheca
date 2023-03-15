--TESTING FOREIGN KEYS FOR MEMBERS----------

--initial set up to ensure that reason for failure in successive inserts is not the lack of valid department
INSERT into member values('a1234', 'placeholder patient', 'to allow', 'department creation', 'F', 	'12-3-1987', '123 address', 'MI', '98784');
INSERT into department values('Cardiology', 'a1234');

--try to insert doctor with bogus member id
INSERT into doctor values('z7777', 'Gordon Conwell', 'Cardiology', '1213415');
--this should fail because we have not inserted a doctor with id z7777 into the member table

--try to insert nurse with bogus member id
INSERT into nurse values('z7777', 'MBA', 'Cardiology', '1213415');
--this should fail because we have not inserted a nurse with id z7777 into the member table

--try to insert patient with bogus member id
INSERT into patient values('z7777', 'B+', '1213415');
--this should fail because we have not inserted a patient with id z7777 into the member table

--try to insert secretary with bogus member id
INSERT into secretary values('z7777', 'False', 'Cardiology',  '1213415');
--this should fail because we have not inserted a secretary with id z7777 into the member table



--TESTING FOREIGN KEYS FOR DEPARTMENT----------
--initially we insert a member so that the successive tests don't fail for a lack of a valid member
INSERT into member values('b1098', 'placeholder member', 'to allow', 'department tests', 'F',
	'12-3-1987', '123 address', 'MI', '98784');

--try to insert doctor with non-existent department
INSERT into doctor values('b1098', 'Gordon Conwell', 'bogus_dept', '121341509');
--this should fail because we have not inserted bogus_dept into the department table

--try to insert nurse with non-existent department
INSERT into nurse values(' b1098', 'MBA', ' bogus_dept', '121341509');
--this should fail because we have not inserted bogus_dept into the department table

--try to insert secretary with non-existent department
INSERT into secretary values('b1098', 'False', ' bogus_dept',  '121341509');
--this should fail because we have not inserted bogus_dept into the department table





--TESTING FOREIGN KEY FOR DEPARTMENT HEAD----------
--try to insert new department with non-existent member id as head
INSERT into department values('theBestDepartment', 'n5656');
--this should fail because we never inserted a member with id 'n5656'


--TESTING FOREIGN KEYS FOR VISIT----------
--(NOTE: These tests assume that a department named Cardiology exists)

--Testing non-existent doctor id
--first we must add a valid patient and nurse to ensure failure is not due to non-existent patient or nurse
INSERT into member values('x8767', 'placeholder', 'patient', 'for tests', 'F', '12-3-1987',
	'123 address', 'MI', '98784');
INSERT into patient values('x8767', 'O-', '878657654');

INSERT into member values('x0098', 'placeholder', 'nurse', 'for tests', 'F', '12-3-1987',
	'123 address', 'MI', '98784');
INSERT into nurse values('x0098', 'high_school', 'Cardiology', '878657654');

--now we insert visit with non-existent doctor id
INSERT into visit values('x8767', 'someDateTime', 'someOtherDateTime', 'r4342', 'x0098', 'notes', 'dblood', 'sblood', 'good_heart_rate', '88 degrees', '0.95', '55 feet', '8lbs');
--this should fail because there is no doctor with id 'r4342'

----
--Testing bogus nurse id
--first we must add a valid patient and doctor to ensure failure is not due to non-existent patient or doctor
INSERT into member values('x8937', 'placeholder', 'patient', 'for tests', 'F', '12-3-1987', '123 address', 'MI', '98784');
INSERT into patient values('x8937', 'O-', '878657654');

INSERT into member values('x0043', 'placeholder', 'doctor', 'for tests', 'F', '12-3-1987', '123 address', 'MI', '98784');
INSERT into doctor values('x0043', 'Endicott', 'Cardiology', '878657654');

--now we insert visit with non-existent nurse id
INSERT into visit values('x8937', 'someDateTime', 'someOtherDateTime', 'x0043', 'L8721', 'notes', 'dblood', 'sblood', 'good_heart_rate', '88 degrees', '0.95', '55 feet', '8lbs');
--this should fail because there is no nurse with id 'L8721'


----
--Testing bogus patient id
--first we must add a valid nurse and doctor to ensure failure is not due to non-existent nurse or doctor
INSERT into member values('x2433', 'placeholder', 'doctor', 'for tests', 'F', '12-3-1987', '123 address', 'MI', '98784');
INSERT into doctor values('x2433', 'Endicott', 'Cardiology', '878657654');

INSERT into member values('x2533', 'placeholder', 'nurse', 'for tests', 'F', '12-3-1987', '123 address', 'MI', '98784');
INSERT into nurse values('x2533', 'college', 'Cardiology', '878657654');

--now we insert visit with non-existent patient id
INSERT into visit values('y1211', 'someDateTime', 'someOtherDateTime', 'x2433', 'x2533', 'notes', 'dblood', 'sblood', 'good_heart_rate', '88 degrees', '0.95', '55 feet', '8lbs');
--this should fail because there is no patient with id 'y1211'


--TESTING FOREIGN KEYS FOR PHONE NUMBER----------

INSERT into phone_number values('h4545', '401-665-4343', 'never call me', 'nokia');
--this should fail because there is no member with id 'h4545'


--TESTING FOREIGN KEYS FOR EMAIL ADDRESS----------

INSERT into email_address values('h4545', 'good.test@heepyBoBeepy.gov');
--this should fail because there is no member with id 'h4545'