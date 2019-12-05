/* Create Database Query for Relational and NoSQL Databases CIS2017-N Module ICA 1
NAME: SI THU ZAW 	NRIC: 		Teesside ID: T7177793	Batch Code: BTID11701A	Lecturer Name: Dr. Loo Poh Kok
Management Development Institute of Singapore / Teesside University UK*/

CREATE DATABASE [Aviation_School];   --Create database
GO
USE [Aviation_School];		-- Select database
GO
CREATE TABLE Pilot(		--Create table queries
	[P_ID] int identity(1,1) NOT NULL,
	[P_Name] nvarchar(100) NOT NULL,
	[P_DOB] date NOT NULL,
	[P_Gender] bit NOT NULL,
	[P_Member] bit NOT NULL,
	[P_Type] bit NOT NULL DEFAULT 0,
	CONSTRAINT PK_Pilot PRIMARY KEY (P_ID),
);
GO
CREATE TABLE Pilot_S(
	[P_ID] int NOT NULL,
	[SP_Sponsor] nvarchar(100) NOT NULL,
	[SP_Ref] nvarchar(50),
	CONSTRAINT PK_SP PRIMARY KEY (P_ID),
	CONSTRAINT FK_SP FOREIGN KEY (P_ID) REFERENCES Pilot(P_ID) ON DELETE CASCADE
);
GO
CREATE TABLE Aircraft_Category(
	[Cat_ID] int identity(1,1) NOT NULL,
	[Cat_Name] nvarchar(50) NOT NULL,
	CONSTRAINT PK_AC_Cat PRIMARY KEY (Cat_ID)
);
GO
CREATE TABLE Aircraft(
	[A_ID] char(10) NOT NULL,
	[A_Name] nvarchar(50) NOT NULL,
	[A_Cat] int NOT NULL,
	CONSTRAINT PK_AC PRIMARY KEY (A_ID),
	CONSTRAINT FK_AC_Cat FOREIGN KEY (A_Cat) REFERENCES Aircraft_Category(Cat_ID)
);
GO
CREATE TABLE Room(
	[Room_ID] int identity(1,1) NOT NULL,
	[Room_Name] nvarchar(50) NOT NULL,
	CONSTRAINT PK_Room PRIMARY KEY (Room_ID)
);
GO
CREATE TABLE Course(
	[C_ID] int identity(1,1) NOT NULL,
	[C_Name] nvarchar(50) NOT NULL,
	[C_Duration] nvarchar(20) NOT NULL,
	[C_MRequired] nvarchar(20) NOT NULL,
	CONSTRAINT PK_Course PRIMARY KEY (C_ID)
);
GO
CREATE TABLE Test(
	[Test_ID] int identity(1,1) NOT NULL,
	[Test_Course] int NOT NULL,
	[Test_Name] nvarchar(50),
	CONSTRAINT PK_Test PRIMARY KEY (Test_ID),
	CONSTRAINT FK_Test_Course FOREIGN KEY (Test_Course) REFERENCES Course(C_ID) ON DELETE CASCADE
);
GO
CREATE TABLE Servicing(
	[Sv_ID] int identity(1,1) NOT NULL,
	[Sv_Date] datetime NOT NULL DEFAULT GETDATE(),
	[Sv_AC] char(10) NOT NULL,
	[Sv_Note] nvarchar(MAX) NOT NULL,
	CONSTRAINT PK_Sv PRIMARY KEY (Sv_ID),
	CONSTRAINT FK_Sv_AC FOREIGN KEY (Sv_AC) REFERENCES Aircraft(A_ID) ON DELETE CASCADE
);
GO
CREATE TABLE Instructor(
	[I_ID] char(10) NOT NULL,
	[I_Name] nvarchar(50) NOT NULL,
	[I_DOB] date NOT NULL,
	[I_Gender] bit NOT NULL,
	[I_liexpire] date NOT NULL,
	[I_type] bit NOT NULL,
	CONSTRAINT PK_Inst PRIMARY KEY (I_ID),
);
GO
CREATE TABLE LT_Instructor(
	[LI_ID] char(10) NOT NULL,
	[LI_JoinDate] date NOT NULL,
	CONSTRAINT PK_LI PRIMARY KEY (LI_ID),
	CONSTRAINT FK_LI FOREIGN KEY (LI_ID) REFERENCES Instructor(I_ID)
);
GO
CREATE TABLE ST_Instructor(
	[SI_ID] char(10) NOT NULL,
	[SI_ConEnd] date NOT NULL,
	[SI_ConStart] date NOT NULL,
	CONSTRAINT PK_SI PRIMARY KEY (SI_ID),
	CONSTRAINT FK_SI FOREIGN KEY (SI_ID) REFERENCES Instructor(I_ID)
);
GO
CREATE TABLE Enrolment(
	[En_P_ID] int NOT NULL,
	[En_C_ID] int NOT NULL,
	[En_Start_Date] datetime NOT NULL,
	[En_Checkup] bit NOT NULL DEFAULT 1,
	CONSTRAINT PK1_Enroll PRIMARY KEY (En_P_ID, En_C_ID),
	CONSTRAINT FK1_Enroll_Pilot FOREIGN KEY (En_P_ID) REFERENCES Pilot(P_ID) ON DELETE CASCADE,
	CONSTRAINT FK2_Enroll_Course FOREIGN KEY (En_C_ID) REFERENCES Course(C_ID) ON DELETE CASCADE
);
GO
CREATE TABLE AC_Qualification(
	[Inst_ID] char(10) NOT NULL,
	[Cat_ID] int NOT NULL,
	CONSTRAINT PK1_Qual PRIMARY KEY (Inst_ID, Cat_ID),
	CONSTRAINT FK1_Qual_Inst FOREIGN KEY (Inst_ID) REFERENCES Instructor(I_ID),
	CONSTRAINT FK3_Qual_Cat FOREIGN KEY (Cat_ID) REFERENCES Aircraft_Category(Cat_ID)
);
GO
CREATE TABLE Schedule(
	[S_ID]	int identity(1,1) NOT NULL,
	[S_Start] datetime NOT NULL,
	[S_End] datetime NOT NULL,
	[I_Hours] AS DATEDIFF(HOUR, S_Start, S_End),
	[S_I] char(10) NOT NULL,
	[S_P] int NOT NULL,
	[S_Type] tinyint NOT NULL,
	CONSTRAINT PK_Sche PRIMARY KEY (S_ID),
	CONSTRAINT FK1_Sche_Inst FOREIGN KEY (S_I) REFERENCES Instructor(I_ID),
	CONSTRAINT FK2_Sche_Pilot FOREIGN KEY (S_P) REFERENCES Pilot(P_ID) ON DELETE CASCADE
);
GO
CREATE TABLE Lesson(
	[L_ID] int identity(1,1) NOT NULL,
	[L_Sche] int NOT NULL,
	[L_Note] nvarchar(max), 
	CONSTRAINT PK_Lesson PRIMARY KEY (L_ID),
	CONSTRAINT FK_Lesson_Sche FOREIGN KEY (L_Sche) REFERENCES Schedule(S_ID) ON DELETE CASCADE
);
GO
CREATE TABLE Flight_Lesson(
	[FL_ID] int NOT NULL,
	[FL_AC] char(10) NOT NULL,
	CONSTRAINT PK_FL PRIMARY KEY (FL_ID),
	CONSTRAINT FK1_FL_L FOREIGN KEY (FL_ID) REFERENCES Lesson(L_ID) ON DELETE CASCADE,
	CONSTRAINT FK2_FL_AC FOREIGN KEY (FL_AC) REFERENCES Aircraft(A_ID)
);
GO
CREATE TABLE Class_Lesson(
	[CL_ID] int NOT NULL,
	[CL_Room] int NOT NULL,
	CONSTRAINT PK_CL PRIMARY KEY (CL_ID),
	CONSTRAINT FK1_CL_L FOREIGN KEY (CL_ID) REFERENCES Lesson(L_ID) ON DELETE CASCADE,
	CONSTRAINT FK2_CL_R FOREIGN KEY (CL_Room) REFERENCES Room(Room_ID)
);
GO
CREATE TABLE Exam(
	[E_ID] int identity(1,1) NOT NULL,
	[E_Sche] int NOT NULL,
	[E_Test] int NOT NULL,
	[E_Result] int ,
	CONSTRAINT PK_Exam PRIMARY KEY (E_ID),
	CONSTRAINT FK1_Exam_Sche FOREIGN KEY (E_Sche) REFERENCES Schedule(S_ID) ON DELETE CASCADE,
	CONSTRAINT FK2_Exam_Test FOREIGN KEY (E_Test) REFERENCES Test(Test_ID),
	CONSTRAINT [
	
	The test result value must be between 0 and 100
	
	] CHECK (E_Result >= 0 AND E_Result <=100)
);
GO
CREATE TABLE Flight_Test(
	[FT_ID] int NOT NULL,
	[FT_AC] char(10) NOT NULL,
	[FT_Time] datetime NOT NULL,
	CONSTRAINT PK_FT PRIMARY KEY (FT_ID),
	CONSTRAINT FK_FT_Exam FOREIGN KEY (FT_ID) REFERENCES Exam(E_ID) ON DELETE CASCADE,
	CONSTRAINT FK_FT_AC FOREIGN KEY (FT_AC) REFERENCES Aircraft(A_ID)
);
GO
CREATE TABLE Class_Test(
	[CT_ID] int NOT NULL,
	[CT_Room] int NOT NULL,
	CONSTRAINT PK_CT PRIMARY KEY (CT_ID),
	CONSTRAINT FK1_CT_Exam FOREIGN KEY (CT_ID) REFERENCES Exam(E_ID) ON DELETE CASCADE,
	CONSTRAINT FK2_CT_Room FOREIGN KEY (CT_Room) REFERENCES Room(Room_ID)
);
GO	
CREATE TABLE Payment(
	[Pay_ID] int identity(1,1) NOT NULL,
	[Pay_Date] datetime DEFAULT GETDATE(),
	[Pay_Course] int NOT NULL,
	[Pay_Pilot] int NOT NULL,
	[Pay_Amount] money NOT NULL,
	CONSTRAINT PK_Pay PRIMARY KEY (Pay_ID),
	CONSTRAINT FK1_Pay_Course FOREIGN KEY (Pay_Course) REFERENCES Course(C_ID),
	CONSTRAINT FK2_Pay_Pilot FOREIGN KEY (Pay_Pilot) REFERENCES Pilot(P_ID) ON DELETE CASCADE,
	CONSTRAINT [
	
	A negative value is entered for the amount paid. Please check entered value.
	
	]CHECK (Pay_Amount > 0.0099999)
);
GO

CREATE INDEX Index_Pilot		-- Create Index queries
ON Pilot (P_ID, P_Name, P_DOB, P_Gender, P_Member, P_Type)
;
CREATE INDEX Index_Pilot_S
ON Pilot_S (P_ID, SP_Sponsor, SP_Ref)
;
CREATE INDEX Index_Aircraft_Category
ON Aircraft_Category (Cat_ID, Cat_Name)
;
CREATE INDEX Index_Aircraft
ON Aircraft (A_ID, A_Name, A_Cat)
;
CREATE INDEX Index_Room
ON Room (Room_ID, Room_Name)
;
CREATE INDEX Index_Course
ON Course (C_ID, C_Name, C_Duration, C_MRequired)
;
CREATE INDEX Index_Test
ON Test (Test_ID, Test_Name, Test_Course)
;
CREATE INDEX Index_Servicing
ON Servicing (Sv_ID, Sv_Date, Sv_AC)
;
CREATE INDEX Index_Instructor
ON Instructor (I_ID, I_Name, I_DOB, I_Gender, I_liexpire, I_type)
;
CREATE INDEX Index_LT_Instructor
ON LT_Instructor (LI_ID, LI_JoinDate)
;
CREATE INDEX Index_ST_Instructor
ON ST_Instructor (SI_ID, SI_ConStart, SI_ConEnd)
;
CREATE INDEX Index_Enrolment
ON Enrolment (En_P_ID, En_C_ID, En_Start_Date, En_Checkup)
;
CREATE INDEX Index_AC_Qualification
ON AC_Qualification (Inst_ID, Cat_ID)
;
CREATE INDEX Index_Schedule
ON Schedule (S_ID, S_Start, S_End, I_Hours, S_I, S_P, S_Type)
;
CREATE INDEX Index_Lesson
ON Lesson (L_ID, L_Sche)
;
CREATE INDEX Index_Flight_Lesson
ON Flight_Lesson (FL_ID, FL_AC)
;
CREATE INDEX Index_Class_Lesson
ON Class_Lesson (CL_ID, CL_Room)
;
CREATE INDEX Index_Exam
ON Exam (E_ID, E_Sche, E_Test, E_Result)
;
CREATE INDEX Index_Flight_Test
ON Flight_Test (FT_ID, FT_AC, FT_Time)
;
CREATE INDEX Index_Class_Test
ON Class_Test (CT_ID, CT_Room)
;
CREATE INDEX Index_Payment
ON Payment (Pay_ID, Pay_Date, Pay_Course, Pay_Pilot, Pay_Amount)
;
GO

CREATE VIEW [Sponsored Pilot] AS		--Create View Queries
SELECT 
Pilot.P_ID AS 'ID',
P_Name AS 'Name',
P_DOB AS 'Date of Birth',
SP_Sponsor AS 'Sponsor Name',
SP_Ref AS 'Sponsor Reference No.',
CASE P_Gender WHEN 1 THEN 'Male' WHEN 0 THEN 'Female' END AS Gender,
CASE P_Member WHEN 1 THEN 'Yes' WHEN 0 THEN 'No' END AS 'Member?'
FROM (Pilot INNER JOIN Pilot_S ON Pilot.P_ID = Pilot_S.P_ID);
GO

CREATE VIEW [Long Term Instructor] AS 
SELECT 
Instructor.I_ID AS 'ID',
Instructor.I_Name AS 'Name',
Instructor.I_DOB AS 'Date of Birth',
CASE I_Gender WHEN 1 THEN 'Male' WHEN 0 THEN 'Female' END As Gender,
Instructor.I_liexpire AS 'Licence Expiration Date',
LT_Instructor.LI_JoinDate AS 'Join Date'
FROM (Instructor inner join LT_Instructor on I_ID = LI_ID);
GO 

CREATE VIEW [Short Term Instructor] AS 
SELECT 
Instructor.I_ID AS 'Instructor ID',
Instructor.I_Name AS 'Name',
Instructor.I_DOB AS 'Date of Birth',
CASE I_Gender WHEN 1 THEN 'Male' WHEN 0 THEN 'Female' END As 'Gender',
Instructor.I_liexpire AS 'Licence Expiration Date',
ST_Instructor.SI_ConStart AS 'Contract Starting Date',
ST_Instructor.SI_ConEnd AS 'Contract Ending Date'
FROM (Instructor inner join ST_Instructor on I_ID = SI_ID);
GO 

CREATE VIEW [Flight Lesson] AS 
SELECT 
S_ID AS 'Event ID',
S_Start AS 'Start Time',
S_End AS 'Ending Time',
I_Name AS 'Instructor',
P_Name AS 'Pilot',
L_Note AS 'Lesson Notes',
FL_AC AS 'Aircraft' 
FROM 
((((Schedule INNER JOIN Lesson ON S_ID = L_Sche) 
INNER JOIN Flight_Lesson ON L_ID = FL_ID) 
INNER JOIN Pilot ON S_P = P_ID)
INNER JOIN Instructor ON S_I = I_ID);
GO

CREATE VIEW [Class Lesson] AS 
SELECT 
S_ID AS 'Event ID',
S_Start AS 'Start Time',
S_End AS 'Ending Time',
I_Name AS 'Instructor',
P_Name AS 'Pilot',
L_Note AS 'Lesson Notes',
Room_Name AS 'Room' 
FROM 
(((((Schedule INNER JOIN Lesson ON S_ID = L_Sche) 
INNER JOIN Class_Lesson ON L_ID = CL_ID) 
INNER JOIN Pilot ON S_P = P_ID)
INNER JOIN Instructor ON S_I = I_ID)
INNER JOIN Room ON CL_Room = Room_ID);
GO

CREATE VIEW [Class Test] AS 
SELECT 
S_ID AS 'Event ID',
S_Start AS 'Start Time',
S_End AS 'Ending Time',
I_Name AS 'Instructor',
P_Name AS 'Pilot',
Test_Name AS 'Test Name',
Room_Name AS 'Room',
E_Result AS 'Result'
FROM 
((((((Schedule INNER JOIN Exam ON S_ID = E_Sche) 
INNER JOIN Class_Test ON E_ID = CT_ID) 	
INNER JOIN Test ON Test.Test_ID=E_Test)
INNER JOIN Instructor ON S_I = I_ID)
INNER JOIN Pilot ON P_ID = S_P)
INNER JOIN Room ON CT_Room = Room_ID);
GO

CREATE VIEW [Flight Test] AS 
SELECT 
S_ID AS 'Event ID',
S_Start AS 'Start Time',
S_End AS 'Ending Time',
I_Name AS 'Instructor',
P_Name AS 'Pilot',
Test_Name AS 'Test Name',
FT_AC AS 'Aircraft',
FT_Time AS 'Test Starting Time',
E_Result AS 'Result'
FROM 
(((((Schedule INNER JOIN Exam ON S_ID = E_Sche) 
INNER JOIN Flight_Test ON E_ID = FT_ID) 
INNER JOIN Test ON Test.Test_ID=E_Test)
INNER JOIN Instructor ON S_I = I_ID)
INNER JOIN Pilot ON P_ID = S_P);
GO