--Nonfunctional requirements:
--Use insert.sql to prep the tables with the required data to see the triggers function.

--No two (or more) visits may be scheduled for the same time period for the same doctor:
--Trigger One patient at a time:
INSERT INTO visit VALUES ('0000000011', '2023-07-12 12:00:00', '2023-07-12 13:00:00', '0000000001', '0000000006', 'no note', 10, 12, 101, 76, 0.5, 150, 55);
--This next statement should trigger an error because two visits are scheduled for the same starting time.
INSERT INTO visit VALUES ('0000000012', '2023-07-12 12:00:00', '2023-07-12 13:00:00', '0000000001', '0000000007', 'no note', 11, 13, 112, 76, 0.5, 150, 55);

--A doctor may not be scheduled for visits totaling more than 40 hours per work-week:
--Trigger No workaholic doctors:
--This next statement should trigger an error beacuse a doctor is scheduled for visits totaling more than 40 hours in a work week.
INSERT INTO visit VALUES ('0000000011', '2023-05-15 12:00:00', '2023-05-19 13:00:00', '0000000001', '0000000006', 'no note', 10, 12, 101, 76, 0.5, 150, 55);

--A patient may not schedule a back-to-back appointment:
--Trigger No same day appointments:
INSERT INTO visit VALUES ('0000000011', '2023-03-12 10:00:00', '2023-03-12 11:00:00', '0000000001', '0000000006', 'no note', 10, 12, 101, 76, 0.5, 150, 55);
--This next statement should trigger an error because the same patient is trying to be scheduled for a visit on the same day.
INSERT INTO visit VALUES ('0000000011', '2023-03-12 12:00:00', '2023-03-12 13:00:00', '0000000001', '0000000007', 'no note', 11, 13, 112, 76, 0.5, 150, 55);

--Minors may not be input as patients (adult only medical center):
--Trigger No Minors:
--This statement should trigger an error because a minor is trying to be registered as a member in an all adult hospital.
insert into member values('1111111111', 'Steven', 'Herbert', 'Wonder', 'M', '12-6-2020', '123 Sir Duke st', 'Groovetown', 'CA', '02818');

--Patients cannot be assigned to be a department head:
--Trigger Patients cannot be department head:
insert into member values('1111111111', 'Steven', 'Herbert', 'Wonder', 'M', '12-6-1956', '123 Sir Duke st', 'Groovetown', 'CA', '02818');
insert into patient values('1111111111', '425438269', 'A+');
--This next statement should trigger an error because the patient is trying to be assigned as a department head.
Insert into department values ('Cardiology', '1111111111');
