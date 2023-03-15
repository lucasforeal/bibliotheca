--TESTING FOREIGN KEYS FOR MEMBERS----------

--initial set up to ensure that reason for failure in successive inserts is not the lack of valid department
INSERT into member values('1000000001', 'placeholder patient', 'to allow', 'department creation', 'F', '12-3-1987', '123 address', 'town', 'MI', '98784');
INSERT into department values('ramdo', '1000000001');

--try to insert doctor with bogus member id
INSERT into doctor values('2000000002', 'Gordon Conwell', 'ramdo', '1213415');
--this should fail because we have not inserted a doctor with id 2000000002 into the member table

--try to insert nurse with bogus member id
INSERT into nurse values('2000000002', 12, 'ramdo', '1213415');
--this should fail because we have not inserted a nurse with id 2000000002 into the member table

--try to insert patient with bogus member id
INSERT into patient values('2000000002', '1213415', 'B+');
--this should fail because we have not inserted a patient with id 2000000002 into the member table

--try to insert secretary with bogus member id
INSERT into secretary values('2000000002', false, 'ramdo',  '1213415');
--this should fail because we have not inserted a secretary with id 2000000002 into the member table



--TESTING FOREIGN KEYS FOR DEPARTMENT----------
--initially we insert a member so that the successive tests don't fail for a lack of a valid member
INSERT into member values('3000000003', 'placeholder member', 'to allow', 'department tests', 'F',
	'12-3-1987', '123 address', 'town', 'MI', '98784');

--try to insert doctor with non-existent department
INSERT into doctor values('3000000003', 'Gordon Conwell', 'bogus_dept', '121341509');
--this should fail because we have not inserted bogus_dept into the department table

--try to insert nurse with non-existent department
INSERT into nurse values('3000000003', 12, ' bogus_dept', '121341509');
--this should fail because we have not inserted bogus_dept into the department table

--try to insert secretary with non-existent department
INSERT into secretary values('3000000003', false, ' bogus_dept',  '121341509');
--this should fail because we have not inserted bogus_dept into the department table





--TESTING FOREIGN KEY FOR DEPARTMENT HEAD----------
--try to insert new department with non-existent member id as head
INSERT into department values('theBestDepartment', '4000000004');
--this should fail because we never inserted a member with id '0000000004'


--TESTING FOREIGN KEYS FOR VISIT----------
--(NOTE: These tests assume that a department named ramdo exists)

--Testing non-existent doctor id
--first we must add a valid patient and nurse to ensure failure is not due to non-existent patient or nurse
INSERT into member values('5000000005', 'placeholder', 'patient', 'for tests', 'F', '12-3-1987',
	'123 address', 'town', 'MI', '98784');
INSERT into patient values('5000000005', '878657654', 'O-');

INSERT into member values('5000000012', 'placeholder', 'nurse', 'for tests', 'F', '12-3-1987',
	'123 address', 'town', 'MI', '98784');
INSERT into nurse values('5000000012', 12, 'ramdo', '878657654');

--now we insert visit with non-existent doctor id
INSERT into visit values('5000000005', '2025-04-12 12:00:00', '2025-04-12 13:00:00', 'r434200000', '5000000012', 'notes', 10, 12, 101, 76, 0.5, 150, 55);
--this should fail because there is no doctor with id 'r434200000'

----
--Testing bogus nurse id
--first we must add a valid patient and doctor to ensure failure is not due to non-existent patient or doctor
INSERT into member values('5000000006', 'placeholder', 'patient', 'for tests', 'F', '12-3-1987', '123 address', 'towm', 'MI', '98784');
INSERT into patient values('5000000006', '878657654', 'O-');

INSERT into member values('5000000007', 'placeholder', 'doctor', 'for tests', 'F', '12-3-1987', '123 address', 'town', 'MI', '98784');
INSERT into doctor values('5000000007', 'Endicott', 'ramdo', '878657654');

--now we insert visit with non-existent nurse id
INSERT into visit values('5000000006', '2027-04-12 12:00:00', '2027-04-12 13:00:00', '5000000007', 'L872100000', 'notes', 10, 12, 101, 76, 0.5, 150, 55);
--this should fail because there is no nurse with id 'L872100000'


----
--Testing bogus patient id
--first we must add a valid nurse and doctor to ensure failure is not due to non-existent nurse or doctor
INSERT into member values('5000000008', 'placeholder', 'doctor', 'for tests', 'F', '12-3-1987', '123 address', 'town', 'MI', '98784');
INSERT into doctor values('5000000008', 'Endicott', 'ramdo', '878657655');

INSERT into member values('5000000009', 'placeholder', 'nurse', 'for tests', 'F', '12-3-1987', '123 address', 'town', 'MI', '98784');
INSERT into nurse values('5000000009', 12, 'ramdo', '878657650');

--now we insert visit with non-existent patient id
INSERT into visit values('5000000010', '2029-04-12 12:00:00', '2029-04-12 13:00:00', '5000000008', '5000000009', 'notes', 10, 12, 101, 76, 0.5, 150, 55);
--this should fail because there is no patient with id '5000000010'


--TESTING FOREIGN KEYS FOR PHONE NUMBER----------

INSERT into phone_number values('5000000011', 'MOBILE', 'MORNING', '9788694500');
--this should fail because there is no member with id '5000000011'


--TESTING FOREIGN KEYS FOR EMAIL ADDRESS----------

INSERT into email_address values('5000000011', 'goest@oBeepy.gov');
--this should fail because there is no member with id '5000000011'