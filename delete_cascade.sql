--Cascading Deletes:
--If a member who is a department head is deleted, then the department head is set to null:
INSERT INTO member VALUES ('0000001234', 'John', 'J', 'Doe', 'M', '1990-01-01', '123 Main St', 'Anytown', 'CA', '12345');
INSERT INTO department VALUES ('Cardiologdeyy', '0000001234');
insert into nurse values('0000001234', 13, 'Cardiologdeyy', '938133589');
delete from member where id = '0000001234';

INSERT INTO member VALUES ('0000881234', 'Joe', 'J', 'Jay', 'M', '1990-01-01', '123 Main St', 'Anytown', 'CA', '12345');
INSERT INTO department VALUES ('Therapyd', '0000881234');
insert into doctor values('0000881234', 'Gordon Conwell', 'Therapyd', '935031289');
delete from member where id = '0000881234';

INSERT INTO member VALUES ('0000991234', 'Jane', 'J', 'Doe', 'F', '1990-01-01', '123 Main St', 'Anytown', 'CA', '12345');
INSERT INTO department VALUES ('Psychologyd', '0000991234');
insert into secretary values('0000991234', true, 'Psychologyd', '137448399');
delete from member where id = '0000991234';

--If a member is deleted by ID, then the corresponding entity (doctor, patient, nurse, or secretary) is also deleted:
--Doctor:
insert into member values('2111111231', 'Stevena', 'Herbert', 'Wonder', 'M', '12-6-1956', '123 Sir Duke st', 'Groovetown', 'CA', '02818');
insert into doctor values('2111111231', 'Gordon Conwell', 'Orthopedics', '938135680');
delete from member where id = '2111111231';

--Patient:
insert into member values('2113711232', 'Patient', 'H', 'Random', 'M', '12-6-1956', '123 Sir Duke st', 'Groovetown', 'CA', '02818');
insert into patient values('2113711232', '425438269', 'A+');
delete from member where id = '2113711232';

--Nurse:
insert into member values('9993711232', 'Nurse', 'H', 'Random', 'F', '12-6-1956', '123 Sir Duke st', 'Groovetown', 'CA', '02818');
insert into nurse values('9993711232', 13, 'Radiology', '938135689');
delete from member where id = '9993711232';

--Secretary:
insert into member values('9989711232', 'Secretary', 'H', 'Random', 'F', '12-6-1956', '123 Sir Duke st', 'Groovetown', 'CA', '02818');
insert into secretary values('9989711232', true, 'Urology', '137448399');
delete from member where id = '9989711232';

--If a department is deleted, then the employees affiliated with the department are also deleted:

INSERT INTO member VALUES ('1234641234', 'John', 'J', 'Doe', 'M', '1990-01-01', '123 Main St', 'Anytown', 'CA', '12345');
INSERT INTO department VALUES ('Cardiologdey', '1234641234');
insert into nurse values('1234641234', 13, 'Cardiologdey', '938133589');

INSERT INTO member VALUES ('0043121299', 'Joe', 'J', 'Jay', 'M', '1990-01-01', '123 Main St', 'Anytown', 'CA', '12345');
insert into doctor values('0043121299', 'Gordon Conwell', 'Cardiologdey', '935441289');
INSERT INTO member VALUES ('0000998734', 'Jane', 'J', 'Doe', 'F', '1990-01-01', '123 Main St', 'Anytown', 'CA', '12345');
insert into secretary values('0000998734', true, 'Cardiologdey', '137440099');

delete from department where dept_name = 'Cardiologdey';

--If a patient is deleted, then the visits affiliated with the patient are deleted, and when the doctors and nurses are deleted, their values in visit is set to null:

insert into member values('1111118888', 'Steven', 'Herbert', 'Wonder', 'M', '12-6-1956', '123 Sir Duke st', 'Groovetown', 'CA', '02818');
insert into patient values('1111118888', '425444009', 'A+');

insert into member values('3333339999', 'John', 'Swing', 'Mayer', 'M', '9-1-1986', '123 Neon blvd', 'Smoothtown', 'RI', '09223');
insert into nurse values('3333339999', 13, 'Radiology', '008100689');

insert into member values('2222224444', 'Lizzy', 'Grace', 'McAlpine', 'F', '2-5-1996', '123 Doomsday rd', 'Indietown', 'AL', '00093');
insert into doctor values('2222224444', 'Gordon Conwell', 'Orthopedics', '115011789');

insert into visit values('1111118888','2053-03-12 12:00:00', '2053-03-12 13:00:00', '2222224444', '3333339999', 'no note', 10, 12, 101, 76, 0.5, 150, 55);

delete from member where id = '2222224444';
delete from member where id = '3333339999';

--#Check at this point for the doctor and nurse value for visit at this point#

delete from member where id = '1111118888';

--If a member is deleted, then the phone numbers and email addresses are also deleted:

insert into member values('1112318888', 'Phone', 'Herbert', 'Test', 'M', '12-6-1956', '123 Sir Duke st', 'Groovetown', 'CA', '02818');
INSERT INTO phone_number VALUES ('1112318888', 'MOBILE', 'MORNING', '1238674500');
INSERT INTO phone_number VALUES ('1112318888', 'HOME', 'AFTERNOON', '3218674000');
INSERT INTO email_address VALUES ('1112318888', 'Herbert@random.com');
INSERT INTO email_address VALUES ('1112318888', 'Herbert2@random.com');

delete from member where id = '1112318888';
