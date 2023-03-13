INSERT INTO member VALUES ('0000000001', 'John', 'J', 'Doe', 'M', '1990-01-01', '123 Main St', 'Anytown', 'CA', '12345');
INSERT INTO member VALUES ('0000000002', 'Jane', 'A', 'Doe', 'F', '1995-05-05', '456 Second St', 'Othertown', 'NY', '67890');
INSERT INTO member VALUES ('0000000003', 'Bob', 'K', 'Smith', 'M', '1980-08-08', '789 Third St', 'Somewhere', 'TX', '54321');
INSERT INTO member VALUES ('0000000004', 'Alice', 'M', 'Johnson', 'F', '1985-11-11', '101 Fourth Ave', 'Anywhere', 'FL', '09876');
INSERT INTO member VALUES ('0000000005', 'Mike', 'R', 'Brown', 'M', '1993-04-03', '111 Fifth St', 'Nowhere', 'IL', '13579');
INSERT INTO member VALUES ('0000000006', 'Karen', 'L', 'Davis', 'F', '1982-07-07', '222 Sixth St', 'Here', 'MA', '24680');
INSERT INTO member VALUES ('0000000007', 'Tom', 'N', 'Wilson', 'M', '1975-12-12', '333 Seventh St', 'There', 'WA', '86420');
INSERT INTO member VALUES ('0000000008', 'Amy', 'P', 'Miller', 'F', '1978-02-14', '444 Eighth St', 'Everywhere', 'NC', '97531');
INSERT INTO member VALUES ('0000000009', 'Steve', 'S', 'Jones', 'M', '1999-09-09', '555 Ninth St', 'Anywhere', 'NJ', '64257');
INSERT INTO member VALUES ('0000000010', 'Lisa', 'T', 'Taylor', 'F', '1997-06-06', '666 Tenth St', 'Somewhere', 'OH', '75391');
INSERT INTO member VALUES ('0000000011', 'David', 'G', 'Lee', 'M', '1989-03-15', '777 Eleventh St', 'Nowhere', 'AK', '86429');
INSERT INTO member VALUES ('0000000012', 'Sara', 'B', 'Garcia', 'F', '1992-09-18', '888 Twelfth St', 'Somewhere', 'AZ', '13579');
INSERT INTO member VALUES ('0000000013', 'Chris', 'E', 'Baker', 'M', '1977-01-20', '999 Thirteenth St', 'There', 'CO', '24680');
INSERT INTO member VALUES ('0000000014', 'Maggie', 'F', 'Wu', 'F', '1986-12-31', '1010 Fourteenth St', 'Here', 'CT', '97531');
INSERT INTO member VALUES ('0000000015', 'Alex', 'H', 'Nguyen', 'M', '1994-08-05', '1111 Fifteenth St', 'Anywhere', 'GA', '64257');
INSERT INTO member VALUES ('0000000016', 'Rachel', 'I', 'Kim', 'F', '1984-07-14', '1212 Sixteenth St', 'Somewhere', 'HI', '75391');
INSERT INTO member VALUES ('0000000017', 'Kevin', 'J', 'Chen', 'M', '1979-05-19', '1313 Seventeenth St', 'Nowhere', 'IA', '86429');
INSERT INTO member VALUES ('0000000018', 'Emily', 'K', 'Lopez', 'F', '1991-02-23', '1414 Eighteenth St', 'Somewhere', 'KS', '13579');
INSERT INTO member VALUES ('0000000019', 'Andrew', 'L', 'Rivera', 'M', '1983-11-30', '1515 Nineteenth St', 'There', 'KY', '24680');
INSERT INTO member VALUES ('0000000020', 'Olivia', 'M', 'Gonzalez', 'F', '1998-04-07', '1616 Twentieth St', 'Anywhere', 'LA', '97531');

INSERT INTO department VALUES ('Cardiology', '0000000001');
INSERT INTO department VALUES ('Gynecology', '0000000002');
INSERT INTO department VALUES ('Pediatrics', '0000000003');
INSERT INTO department VALUES ('Neurology', '0000000004');
INSERT INTO department VALUES ('Orthopedics', '0000000005');
INSERT INTO department VALUES ('Oncology', '0000000006');
INSERT INTO department VALUES ('Radiology', '0000000007');
INSERT INTO department VALUES ('Dermatology', '0000000008');
INSERT INTO department VALUES ('Psychiatry', '0000000009');
INSERT INTO department VALUES ('Urology', '0000000010');

INSERT INTO doctor VALUES ('0000000001', 'Harvard Medical School', 'Cardiology', '987654321');
INSERT INTO doctor VALUES ('0000000002', 'Johns Hopkins University School of Medicine', 'Gynecology', '123456789');
INSERT INTO doctor VALUES ('0000000003', 'Stanford University School of Medicine', 'Pediatrics', '456789123');
INSERT INTO doctor VALUES ('0000000004', 'Gordon College', 'Neurology', '111222333');
INSERT INTO doctor VALUES ('0000000005', 'University of California', 'Orthopedics', '999888777');

INSERT INTO nurse VALUES ('0000000006', 12, 'Oncology', '555444333');
INSERT INTO nurse VALUES ('0000000007', 14, 'Radiology', '777888999');
INSERT INTO nurse VALUES ('0000000008', 10, 'Dermatology', '654321987');
INSERT INTO nurse VALUES ('0000000009', 16, 'Psychiatry', '246813579');
INSERT INTO nurse VALUES ('0000000010', 18, 'Urology', '369258147');

INSERT INTO patient VALUES ('0000000011', '777777777', 'A+');
INSERT INTO patient VALUES ('0000000012', '888888888', 'O-');
INSERT INTO patient VALUES ('0000000013', '222222222', 'B+');
INSERT INTO patient VALUES ('0000000014', '444444444', 'AB-');
INSERT INTO patient VALUES ('0000000015', '666666666', 'A-');

INSERT INTO secretary VALUES ('0000000016', false, 'Cardiology', '101010101');
INSERT INTO secretary VALUES ('0000000017', false, 'Gynecology', '121212121');
INSERT INTO secretary VALUES ('0000000018', true, 'Pediatrics', '314159265');
INSERT INTO secretary VALUES ('0000000019', false, 'Orthopedics', '271828182');
INSERT INTO secretary VALUES ('0000000020', false, 'Psychiatry', '777777700');

INSERT INTO visit VALUES ('0000000011', '2023-04-12 12:00:00', '2023-04-12 13:00:00', '0000000001', '0000000006', 'no note', 10, 12, 101, 76, 0.5, 150, 55);
INSERT INTO visit VALUES ('0000000012', '2023-04-13 12:00:00', '2023-04-13 13:00:00', '0000000002', '0000000007', 'no note', 11, 13, 112, 76, 0.5, 150, 55);
INSERT INTO visit VALUES ('0000000013', '2023-04-14 12:00:00', '2023-04-14 13:00:00', '0000000003', '0000000008', 'no note', 12, 14, 114, 76, 0.5, 150, 55);
INSERT INTO visit VALUES ('0000000014', '2023-04-15 12:00:00', '2023-04-15 13:00:00', '0000000004', '0000000009', 'no note', 13, 15, 132, 76, 0.5, 150, 55);
INSERT INTO visit VALUES ('0000000015', '2023-04-16 12:00:00', '2023-04-16 13:00:00', '0000000005', '0000000010', 'no note', 14, 16, 111, 76, 0.5, 150, 55);

INSERT INTO phone_number VALUES ('0000000001', 'MOBILE', 'MORNING', '9788674500');
INSERT INTO phone_number VALUES ('0000000001', 'HOME', 'AFTERNOON', '9788674000');
INSERT INTO phone_number VALUES ('0000000006', 'WORK', 'MORNING', '9788674444');
INSERT INTO phone_number VALUES ('0000000011', 'SCHOOL', 'EVENING', '9788673333');
INSERT INTO phone_number VALUES ('0000000016', 'MAIN', 'ON-CALL', '9788671111');

INSERT INTO email_address VALUES ('0000000005', 'random@random.com');
INSERT INTO email_address VALUES ('0000000005', 'random2@random.com');
INSERT INTO email_address VALUES ('0000000010', 'nurse@random.com');
INSERT INTO email_address VALUES ('0000000015', 'patient@random.com');
INSERT INTO email_address VALUES ('0000000020', 'secretary@random.com');