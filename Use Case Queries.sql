/* Use Case Queries for Relational and NoSQL Databases CIS2017-N Module ICA 1
NAME: SI THU ZAW 	NRIC: 	Teesside ID: T7177793	Batch Code: BTID11701A	Lecturer Name: Dr. Loo Poh Kok
Management Development Institute of Singapore / Teesside University UK*/

--The following queries are the queries mentioned in the report. 
--Numbering corresponds with the documentation in the report.

-- 5.1.1. Add New Aircraft
INSERT INTO Aircraft ([A_ID], [A_Name], [A_Cat]) VALUES ('CA1962', 'Piper Tripacer', 2);

-- 5.1.2. Read Aircraft
SELECT A_ID AS 'Registration No.', 
A_Name AS 'Name', 
Cat_Name AS 'Aircraft Category' 
FROM (Aircraft inner join Aircraft_Category on A_Cat = Cat_ID);

-- 5.1.3. Update Aircraft
UPDATE [Aircraft] SET [A_Name] = 'Cessna 189' WHERE [A_ID] = 'CA1962';

-- 5.1.4. Delete Aircraft
DELETE FROM [Aircraft] WHERE [A_ID] = 'CA1962';

-- 5.2.1.1 Read Independent Student
SELECT P_Name AS 'Name', P_DOB AS 'Date of Birth', 
CASE P_Gender WHEN 1 THEN 'Male' WHEN 0 THEN 'Female' END As Gender, 
CASE P_Member WHEN 1 THEN 'Yes' WHEN 0 THEN 'No' END As 'Member?' 
FROM [Pilot];

-- 5.2.1.2 Read Sponsored Student
SELECT P_Name AS 'Name', P_DOB AS 'Date of Birth', 
SP_Sponsor AS 'Sponsor Name', 
SP_Ref AS 'Sponsor Reference No.', 
CASE P_Gender WHEN 1 THEN 'Male' WHEN 0 THEN 'Female' END AS Gender, 
CASE P_Member WHEN 1 THEN 'Yes' WHEN 0 THEN 'No' END AS 'Member?' 
FROM (Pilot INNER JOIN Pilot_S ON Pilot.P_ID = Pilot_S.P_ID);
	--OR
SELECT * FROM [Sponsored Pilot];

-- 5.2.2 Update Student
UPDATE [Pilot] SET [P_Member] = 1 WHERE [P_Name] = 'Halla Frye';

-- 5.2.3 Delete Student
DELETE FROM [Pilot] WHERE P_ID = 1;

-- 5.3 Add Long Term Instructor
EXEC dbo.newlongterminstructor @ID = 'LT005', 
@Name = 'Bob', 
@DOB = '1982-04-11', 
@Gender = '1', 
@Liexpire = '2020-12-02', 
@LiJoinDate = '2017-01-22'

-- 5.4 Add Short Term Instructor
EXEC dbo.newshortterminstructor 
@ID = 'ST002',
@Name = 'Dave', 
@DOB = '1982-04-11', 
@Gender = '1', 
@Liexpire = '2020-12-02', 
@SI_ConStart = '2016-06-25', 
@SI_ConEnd = '2018-06-25'

-- 5.5 Update Student Record
UPDATE [Pilot] SET [P_Member] = 1 WHERE [P_Name] = 'Halla Frye';

-- 5.6 Update Training Record
UPDATE [Schedule] SET [S_End] = '2018-03-29 16:00:00.000' WHERE S_ID = 7; SELECT * FROM [Flight Lesson];

-- 5.7 Record Payments
INSERT INTO Payment ([Pay_Pilot], [Pay_Course], [Pay_Date], [Pay_Amount]) 
VALUES (8, 8, '2017-09-09', 15000.00);

-- 5.8 Register Independent Pilot
INSERT INTO Pilot([P_Name], [P_DOB], [P_Member], [P_Gender]) 
VALUES ('Dylan Rosa','2000-12-16',1,1);

-- 5.9 Register Sponsored Pilot
EXEC dbo.newsponsoredpilot 
@Name ='Halla Frye', 
@DOB ='1980-11-30', 
@Gender ='0', 
@Member ='0', 
@Sponsor ='RyanAir', 
@SponsorRef ='30582617'

-- 5.10 Book Course
 INSERT INTO Enrollment ([En_P_ID], [En_C_ID], [En_Start_date])
 VALUES (10, 1, '2017-10-07');
 
-- 5.11 Confirm Medical Status
UPDATE [Enrolment] SET [En_Checkup] = 0 WHERE [En_P_ID] = 2;

-- 5.12 Print Lesson Schedule
SELECT S_Start AS 'Start Time', 
S_End AS 'End Time', 
I_Name AS 'Instructor',
P_Name AS 'Pilot', CASE 
S_Type WHEN 1 THEN 'Flight Lesson' WHEN 2 THEN 'Class Lesson' WHEN 3 THEN 'Flight Test' WHEN 4 THEN 'Class Test' END AS 'Type' 
FROM ((Schedule INNER JOIN Instructor ON S_I = I_ID) 
INNER JOIN Pilot ON P_ID = S_P) WHERE S_Start BETWEEN '2018-03-01' AND '2018-09-01';

-- 5.13 Print Pilot Record
EXEC dbo.retrievepilotrecord @PilotID = 6

-- 5.14 Check Instructor Schedule
SELECT 
CASE S_Type WHEN 1 THEN 'Class Lesson' WHEN 2 THEN 'Flight Lesson' WHEN 3 THEN 'Class Test' WHEN 4 THEN 'Flight Test' END AS 'Type', 
P_Name AS 'Pilot Assigned', 
S_Start AS 'Starting Time', 
S_End AS 'Ending Time' 
FROM (Schedule INNER JOIN Pilot ON S_P = P_ID) WHERE S_I = 'LT007';

-- 5.15 Record Test Result
UPDATE [Exam] SET [E_Result] = 86 WHERE [E_ID] = 11;

-- 5.16 Book Flight Lesson
EXEC dbo.newflightlesson 
@Start ='2018-03-19 10:00:00.000', 
@End ='2018-03-19 13:00:00.000', 
@Instructor ='LT003', 
@Pilot ='5', 
@Note ='Flying practice', 
@Aircraft ='YS3680'

-- 5.17 Book Class Lesson
EXEC dbo.newclasslesson 
@Start ='2018-03-16 18:00:00.000', 
@End ='2018-03-16 19:00:00.000', 
@Instructor ='LT003', 
@Pilot ='5', 
@Note ='Radio Telephony theory', 
@Room ='1'

-- 5.18 Book Class Test
EXEC dbo.newclasstest 
@Start ='2018-09-12 14:00:00.000', 
@End ='2018-09-12 15:30:00.000', 
@Instructor ='LT003', 
@Pilot ='5',
@Test ='13', 
@Room ='4'

-- 5.19 Book Flight Test
EXEC dbo.newflighttest 
@Start ='2018-09-15 11:00:00.000', 
@End ='2018-09-15 14:30:00.000', 
@Instructor ='LT003', 
@Pilot ='5', 
@Test ='12', 
@Aircraft ='YS3680'