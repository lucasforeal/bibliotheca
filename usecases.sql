Database Design Project--Part f: SQL Use Cases

--Note in these statements, any id starting with a 1 is a patient, 2 is a doctor, 3 is a nurse, and 4 is a secretary

--As preliminary setup we need to make some doctors/nurses/secretaries and make some departments. 
insert into member values('2111111111', 'Stevena', 'Herbert', 'Wonder', 'M', '12-6-1956', '123 Sir Duke st', 'Groovetown', 'CA', '02818');
insert into member values('3111111111', 'Stevenb', 'Herbert', 'Wonder', 'M', '12-6-1956', '123 Sir Duke st', 'Groovetown', 'CA', '02818');
insert into member values('4111111111', 'Stevenc', 'Herbert', 'Wonder', 'M', '12-6-1956', '123 Sir Duke st', 'Groovetown', 'CA', '02818');
insert into department values('spleen-specialist', '2111111111');
insert into department values('general-nurse', '3111111111');
insert into department values('main-secretary', '4111111111');
insert into doctor values('2111111111', 'Gordon Conwell', 'spleen-specialist', '938135680');
insert into nurse values('3111111111', 13, 'general-nurse', '938135681');
insert into secretary values('4111111111', true, 'main-secretary', '938135682');

--Add patient (note that two inserts are needed for the separate tables)

insert into member values('1111111111', 'Steven', 'Herbert', 'Wonder', 'M', '12-6-1956', '123 Sir Duke st', 'Groovetown', 'CA', '02818');

insert into patient values('1111111111', '425438269', 'A+');

--Update/Edit patient (example--one of many possible updates)
update member
  set last_name = 'Ray Vaughan'
  where id = '1111111111';

--Add nurse (note that two inserts are needed for the separate tables)

insert into member values('3333333333', 'John', 'Swing', 'Mayer', 'M', '9-1-1986', '123 Neon blvd', 'Smoothtown', 'RI', '09223');

insert into nurse values('3333333333', 13, 'general-nurse', '938135689');

--Update/Edit nurse (example--one of many possible updates)
update member
  set first_name = 'Jonnhy'
  where id = '3333333333';

--Add doctor (note that two inserts are needed for the separate tables)
insert into member values('2222222222', 'Lizzy', 'Grace', 'McAlpine', 'F', '2-5-1996', '123 Doomsday rd', 'Indietown', 'AL', '00093');

insert into doctor values('2222222222', 'Gordon Conwell', 'spleen-specialist', '935038789');

--Update/Edit doctor (example--one of many possible updates)
update member
  set first_name = 'Rachel'
  where id = '2222222222';

--Testing the add visit use case
insert into visit values('1111111111','2023-03-12 12:00:00', '2023-03-12 13:00:00', '2222222222', '3333333333', 'no note', 10, 12, 101, 76, 0.5, 150, 55);

--Access visit info
select *
from visit;
--optionally add where id = 'someID' AND datetime_in = 'someDateTime' if you want a
     --particular instance of a visit

--Take notes use case for Doctor/Nurse
update visit
  set notes = 'someNotes'
  where patient_id = '1111111111' AND datetime_in = '2023-03-12 12:00:00';

--Drop patient
delete from member where id = '1111111111';

--Drop doctor
delete from member where id = '2222222222';

--Drop nurse
delete from member where id = '3333333333';

--Add secretary (note that two inserts are needed for the separate tables)
insert into member values('4444444444', 'Fats', 'Blues', 'Domino', 'M', '8-8-1942', '123 Blueberry Hill rd', 'Pianotown', 'TN', '75937');

insert into secretary values('4444444444', true, 'main-secretary', '137448399');

--Update/Edit secretary (example--one of many possible updates)
update member
  set street_address = '123 Aint pkwy'
  where id = '4444444444';

--Drop secretary
delete from member where id = '4444444444';

--Access patient info
select *
from member JOIN patient ON id = patient_id;
--optionally add where id = 'someID' if you want a particular patient

--Access doctor info
select *
from member JOIN doctor ON id = doctor_id;
--optionally add where id = 'someID' if you want a particular doctor



--Access nurse info
select *
from member JOIN nurse ON id = nurse_id;
--optionally add where id = 'someID' if you want a particular nurse

--Access secretary info
select *
from member JOIN secretary ON id = secretary_id;
--optionally add where id = 'someID' if you want a particular secretary
