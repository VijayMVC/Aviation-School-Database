/* Populate Database Query for Relational and NoSQL Databases CIS2017-N ICA 1
NAME: SI THU ZAW 	NRIC: 	Teesside ID: T7177793	Batch Code: BTID11701A	Lecturer Name: Dr. Loo Poh Kok
Management Development Institute of Singapore / Teesside University UK*/

USE [Aviation_School];
GO
INSERT INTO Pilot([P_Name],[P_DOB],[P_Member], [P_Gender]) 
VALUES
('Jana Trevino','1973-09-08',1,0),
('Stacey Strickland','1996-03-15',0,0),
('Stone Ryan','1982-11-21',0,1),
('Elliott Taylor','1981-06-06',1,1),
('Kelsie Fry','1997-10-11',0,0),
('Nasim Macdonald','1984-07-23',0,1),
('Katell Hobbs','1989-09-17',0,1),
('Yael Richards','1969-10-13',0,1),
('Susan Stokes','1993-07-10',1,0),
('Dylan Rosa','2000-12-16',1,1),
('Lester Haley','1980-05-14',1,1),
('Caryn Sampson','1978-06-27',0,1),
('Kylee Gilbert','1998-10-30',1,0),
('Colette Dickerson','1974-12-20',1,0),
('Baxter Ratliff','1978-11-22',0,1),
('Callum Orr','1968-02-24',0,1),
('Susan Gardner','1983-08-31',0,0),
('Pascale Mcmillan','1980-01-25',0,1),
('Hayfa Phelps','1996-08-22',1,1),
('Michelle Kidd','1991-12-02',0,0),
('Xandra Burris','1996-07-19',1,0),
('Carly Buckley','1998-01-14',0,0),
('Ali Adkins','1996-09-20',1,1),
('Cassidy Hale','1981-10-30',0,0)
;
GO
EXEC dbo.newsponsoredpilot 
       @Name                 ='Halla Frye',
       @DOB					 ='1980-11-30',
       @Gender      	     ='0', 
       @Member				 ='0',
	   @Sponsor				 ='RyanAir',
	   @SponsorRef			 ='30582617'
;

EXEC dbo.newsponsoredpilot
       @Name                 ='Rigel Rivas',
       @DOB					 ='1992-01-20',
       @Gender      	     ='1', 
       @Member				 ='0',
	   @Sponsor				 ='SilkAir',
	   @SponsorRef			 ='23379265'
;
GO
INSERT INTO Aircraft_Category ([Cat_Name])
VALUES
('Ultralight'),
('Light 2 Seater-Single-Engine'),
('Light 4 Setaer-Single-Engine'),
('Aerobatic Sport-Single-Engine'),
('Medium Two-Engine')
;
GO
INSERT INTO Aircraft ([A_ID], [A_Name], [A_Cat]) 
VALUES
('U001', 'Aerolite 103', 1),
('U002', 'Aerolite 103', 1),
('U003', 'Aerolite 103', 1),
('U004', 'RX550 Beaver', 1),
('U005', 'RX550 Beaver', 1),
('U006', 'RX550 Beaver', 1),
('CA3413', 'Piper Tripacer', 2),
('CA5013', 'Piper Super Cub', 2),
('CA1246', 'Beechcraft Bonanza Model 35D', 2),
('CA5023', 'Mooney M20C', 2),
('CA2931', 'Piper J-3 Cub', 2),
('CA7214', 'Cessna 182', 3),
('CA1027', 'Cessna 210', 3),
('CA1838', 'Cessna 172', 3),
('CA9310', 'Cirrus SR22 G2', 3),
('CA5184', 'Cessna T182 Turbo Skylane', 3),
('CA7032', 'Cessna 172', 3),
('AW2350', 'Extra 230', 4),
('AW2134', 'Extra 230', 4),
('SC6427', 'Czech Sport PS-28 Cruiser', 4),
('DE9483', 'Yak-52', 4),
('YS3680', 'Zenith Zodiac 601XL', 4),
('BA0245', 'Cessna 414', 5),
('TD1573', 'Beechcraft Baron A55', 5),
('YN7932', 'Baron Beechcraft BE55', 5),
('IN6429', 'Beech Duke B60', 5)
;
GO
INSERT INTO Room ([Room_Name]) 
VALUES
('Apple'),
('Banana'),
('Citrus'),
('Durian'),
('Flight Simulator 1'),
('Flight Simulator 2')
;
GO
INSERT INTO Course ([C_Name], [C_Duration], [C_MRequired])
VALUES
('FAA PPL Preparatory Programme', '3 Months', 'Class A'),
('Acclerated FAA PPL Prepatatory Programme', '14 Days', 'Class A'),
('Basic Flight & Ground Knowledge Programme', '2 Days', 'None'),
('U.K. Private Pilot Licence', '6 Months', 'Class A'),
('European Private Pilot Licence', '6 Months', 'Class B'),
('IMC Instrument Flying Rating', '3 Months', 'None'),
('Night Flying Qualifications', '3 Months', 'Class B'),
('Commercial Pilot Licence', '6 Months', 'Class C'),
('Flying Instructor Qualification', '3 Months', 'None')
;
GO
INSERT INTO Test([Test_Course], [Test_Name])
VALUES
(1, 'PPL Initial Knowledge Test'),
(1, 'PPL Knowledge Test'),
(1, 'PPL Practical Test'),
(1, 'Accelerated PPL Initial Knowledge Test'),
(2, 'Accelerated PPL Knowledge Test'),
(2, 'Accelerated PPL Practical Test'),
(3, 'Basic Knowledge Test'),
(3, 'Basic Radio Communication Test'),
(3, 'Basic Terminology Test'),
(4, 'UK PPL Theoratical Knowledge Examination'),
(4, 'UK PPL Practial Skills Test'),
(5, 'EU PPL Flight Test'),
(5, 'EU PPL Theoratical Test'),
(6, 'IMC Rating Theoratical Test'),
(6, 'IMC Rating Practical Test'),
(7, 'Night Rating Theoratical Test'),
(7, 'Night Rating Practical Test'),
(8, 'CPL Theoratical Test'),
(8, 'CPL Simulator Test'),
(8, 'CPL Flight Test'),
(9, 'Instructor Theoratical Test'),
(9, 'Instructor Practical Test')
;
GO
INSERT INTO Servicing ([Sv_Date], [Sv_AC], [Sv_Note])
VALUES
('2017-03-11', 'U003', 'Replaced propellor'),
('2017-04-10', 'CA1027', 'Engine Overhaul'),
('2017-05-16', 'IN6429', 'General Maintainence'),
('2017-06-19', 'DE9483', 'Engine Overhaul'),
('2017-06-02', 'SC6427', 'Control Column Fix'),
('2017-11-06', 'CA5023', 'Left wheel replaced'),
('2017-12-27', 'BA0245', 'Instrument panel overhaul'),
('2018-02-15', 'AW2134', 'Engine Overhaul'),
('2018-02-10', 'CA3413', 'Door lock replaced'),
('2018-03-23', 'AW2350', 'Engine Overhaul'),
('2018-04-14', 'TD1573', 'Engine Overhaul')
;
GO
EXEC dbo.newlongterminstructor
	@ID = 'LT001',
	@Name = 'Forrest',
	@DOB = '1977-01-19',
	@Gender = '1',
	@Liexpire = '2021-12-02',
	@LiJoinDate = '2016-02-25'
;
EXEC dbo.newlongterminstructor
	@ID = 'LT002',
	@Name = 'Hermione',
	@DOB = '1990-03-15',
	@Gender = '0',
	@Liexpire = '2021-10-02',
	@LiJoinDate = '2017-03-15'
;	
EXEC dbo.newlongterminstructor
	@ID = 'LT003',
	@Name = 'Zac',
	@DOB = '1982-04-11',
	@Gender = '1',
	@Liexpire = '2022-07-02',
	@LiJoinDate = '2017-06-12'
;	
EXEC dbo.newlongterminstructor
	@ID = 'LT004',
	@Name = 'Picard',
	@DOB = '1982-04-11',
	@Gender = '1',
	@Liexpire = '2021-11-14',
	@LiJoinDate = '2016-12-25'
;	
EXEC dbo.newlongterminstructor
	@ID = 'LT005',
	@Name = 'Oleg',
	@DOB = '1967-06-30',
	@Gender = '1',
	@Liexpire = '2020-09-19',
	@LiJoinDate = '2017-07-29'
;	
EXEC dbo.newlongterminstructor
	@ID = 'LT006',
	@Name = 'Brock',
	@DOB = '1988-05-20',
	@Gender = '1',
	@Liexpire = '2020-11-20',
	@LiJoinDate = '2016-08-05'
;	
EXEC dbo.newlongterminstructor
	@ID = 'LT007',
	@Name = 'Silas',
	@DOB = '1984-08-17',
	@Gender = '1',
	@Liexpire = '2022-03-10',
	@LiJoinDate = '2016-06-10'
;	
EXEC dbo.newlongterminstructor
	@ID = 'LT008',
	@Name = 'Duncan',
	@DOB = '1972-09-30',
	@Gender = '1',
	@Liexpire = '2021-11-30',
	@LiJoinDate = '2016-05-12';
	
EXEC dbo.newshortterminstructor
	@ID = 'ST001',
	@Name = 'Amy',
	@DOB = '1970-04-11',
	@Gender = '0',
	@Liexpire = '2022-02-08',
	@SI_ConStart = '2016-06-25',
	@SI_ConEnd = '2017-11-05'
;
EXEC dbo.newshortterminstructor
	@ID = 'ST002',
	@Name = 'Kibo',
	@DOB = '1967-11-08',
	@Gender = '1',
	@Liexpire = '2020-06-10',
	@SI_ConStart = '2016-01-23',
	@SI_ConEnd = '2018-06-25'
;
EXEC dbo.newshortterminstructor
	@ID = 'ST003',
	@Name = 'Joel',
	@DOB = '1965-07-01',
	@Gender = '1',
	@Liexpire = '2022-04-12',
	@SI_ConStart = '2016-02-28',
	@SI_ConEnd = '2018-08-28'
;

EXEC dbo.newshortterminstructor
	@ID = 'ST004',
	@Name = 'Ella',
	@DOB = '1977-03-17',
	@Gender = '0',
	@Liexpire = '2021-12-15',
	@SI_ConStart = '2017-02-08',
	@SI_ConEnd = '2019-02-08'
;
GO
INSERT INTO Enrolment ([En_P_ID], [En_C_ID], [En_Start_date])
VALUES
(1, 1, '2017-01-22'),
(2, 2, '2017-02-05'),
(3, 3, '2017-02-09'),
(4, 4, '2017-03-12'),
(5, 5, '2017-04-01'),
(6, 6, '2017-05-29'),
(7, 7, '2017-06-24'),
(8, 8, '2017-08-16'),
(9, 9, '2017-09-10'),
(10, 1, '2017-10-07'),
(11, 2, '2017-11-11'),
(12, 3, '2017-11-15'),
(13, 4, '2017-11-22'),
(14, 5, '2017-12-30'),
(15, 6, '2018-01-03'),
(16, 7, '2018-02-26'),
(17, 8, '2018-03-13'),
(18, 9, '2018-03-02'),
(19, 1, '2018-04-09'),
(20, 2, '2018-04-05'), 
(21, 3, '2018-04-11'),
(22, 4, '2018-05-23'),
(23, 5, '2018-06-20'),
(24, 6, '2018-06-17'),
(25, 8, '2018-07-17'),
(26, 8, '2018-07-17')
;
GO
INSERT INTO AC_Qualification([Inst_ID], [Cat_ID])
VALUES
('LT001', 1),
('LT001', 2),
('LT001', 3),
('LT002', 2),
('LT002', 3),
('LT003', 2),
('LT003', 3),
('LT003', 4),
('LT004', 2),
('LT004', 3),
('LT004', 4),
('LT004', 5),
('LT005', 1),
('LT005', 4),
('LT005', 5),
('LT006', 4),
('LT006', 5),
('LT007', 2),
('LT007', 3),
('LT007', 4),
('LT007', 5),
('LT008', 1),
('LT008', 2),
('LT008', 3),
('LT008', 4),
('LT008', 5),
('ST001', 5),
('ST002', 4),
('ST003', 4),
('ST004', 5)
;
GO
INSERT INTO Payment ([Pay_Pilot], [Pay_Course], [Pay_Date], [Pay_Amount])
VALUES
(1, 1, '2017-04-22', 7000.00),
(2, 2, '2017-07-05', 8000.00),
(3, 3, '2017-09-09', 2000.00),
(4, 4, '2017-09-09', 9000.00),
(5, 5, '2017-09-09', 9000.00),
(6, 6, '2017-09-09', 5000.00),
(7, 7, '2017-09-09', 5000.00),
(8, 8, '2017-09-09', 15000.00),
(9, 9, '2017-09-09', 7000.00),
(10, 1, '2017-09-09', 7000.00),
(11, 2, '2017-09-09', 8000.00),
(12, 3, '2017-09-09', 2000.00),
(13, 4, '2017-09-09', 9000.00),
(14, 5, '2017-09-09', 9000.00),
(15, 6, '2017-09-09', 5000.00),
(16, 7, '2017-09-09', 5000.00),
(17, 8, '2017-09-09', 15000.00),
(18, 9, '2017-09-09', 7000.00),
(19, 1, '2018-09-09', 7000.00),
(20, 2, '2018-09-09', 8000.00),
(21, 3, '2018-09-09', 2000.00),
(22, 4, '2018-09-09', 9000.00),
(23, 5, '2018-09-09', 9000.00),
(24, 6, '2018-09-09', 5000.00),
(25, 8, '2018-09-09', 14000.00),
(26, 8, '2018-09-09', 14000.00)
;
GO
	   
EXEC dbo.newclasslesson 
       @Start                ='2018-01-13 12:00:00.000',
       @End					 ='2018-01-13 15:00:00.000',
       @Instructor           ='LT001', 
       @Pilot				 ='1',
	   @Note				 ='Theory Lesson',
	   @Room				 ='1'

EXEC dbo.newclasslesson 
       @Start                ='2018-02-21 16:00:00.000',
       @End					 ='2018-02-21 19:00:00.000',
       @Instructor           ='LT008', 
       @Pilot				 ='4',
	   @Note				 ='Radio Telephony theory',
	   @Room				 ='2'
	   
EXEC dbo.newclasslesson 
       @Start                ='2018-03-16 18:00:00.000',
       @End					 ='2018-03-16 19:00:00.000',
       @Instructor           ='LT003', 
       @Pilot				 ='5',
	   @Note				 ='Radio Telephony theory',
	   @Room				 ='1'
	   
EXEC dbo.newclasslesson 
       @Start                ='2018-04-05 09:00:00.000',
       @End					 ='2018-04-05 12:00:00.000',
       @Instructor           ='ST001', 
       @Pilot				 ='26',
	   @Note				 ='Multi-engine aircraft theory',
	   @Room				 ='2'
	   
EXEC dbo.newclasslesson 
       @Start                ='2018-05-23 11:00:00.000',
       @End					 ='2018-05-23 13:00:00.000',
       @Instructor           ='LT007', 
       @Pilot				 ='6',
	   @Note				 ='Night flying theory',
	   @Room				 ='4'
	   
	   
	   
EXEC dbo.newflightlesson 
       @Start                ='2018-02-19 09:00:00.000',
       @End					 ='2018-02-19 12:00:00.000',
       @Instructor           ='LT001', 
       @Pilot				 ='1',
	   @Note				 ='Practiced aircraft handling',
	   @Aircraft			 ='CA3413'
	   
EXEC dbo.newflightlesson 
       @Start                ='2018-03-29 12:00:00.000',
       @End					 ='2018-03-29 15:00:00.000',
       @Instructor           ='LT008', 
       @Pilot				 ='4',
	   @Note				 ='Takeoff and landing',
	   @Aircraft			 ='CA5184'	  

	   
EXEC dbo.newflightlesson 
       @Start                ='2018-03-19 10:00:00.000',
       @End					 ='2018-03-19 13:00:00.000',
       @Instructor           ='LT003', 
       @Pilot				 ='5',
	   @Note				 ='Flying practice',
	   @Aircraft			 ='YS3680'	  

	   
EXEC dbo.newflightlesson 
       @Start                ='2018-04-26 09:00:00.000',
       @End					 ='2018-04-26 13:00:00.000',
       @Instructor           ='ST001', 
       @Pilot				 ='26',
	   @Note				 ='Stall recovery practice',
	   @Aircraft			 ='TD1573'	  

	   
EXEC dbo.newflightlesson 
       @Start                ='2018-05-25 18:00:00.000',
       @End					 ='2018-05-25 20:00:00.000',
       @Instructor           ='LT007', 
       @Pilot				 ='6',
	   @Note				 ='Night flying practice',
	   @Aircraft			 ='IN6429'	  

	   
	   
EXEC dbo.newclasstest 
       @Start                ='2018-03-09 20:00:00.000',
       @End					 ='2018-03-09 21:00:00.000',
       @Instructor           ='LT001', 
       @Pilot				 ='1',
	   @Test				 ='2',
	   @Room				 ='1'
	   
EXEC dbo.newclasstest 
       @Start                ='2018-08-01 14:00:00.000',
       @End					 ='2018-08-01 15:30:00.000',
       @Instructor           ='LT008', 
       @Pilot				 ='4',
	   @Test				 ='10',
	   @Room				 ='2'
	   
EXEC dbo.newclasstest 
       @Start                ='2018-09-12 14:00:00.000',
       @End					 ='2018-09-12 15:30:00.000',
       @Instructor           ='LT003', 
       @Pilot				 ='5',
	   @Test				 ='13',
	   @Room				 ='4'
	   
EXEC dbo.newclasstest 
       @Start                ='2018-10-17 13:00:00.000',
       @End					 ='2018-10-17 14:30:00.000',
       @Instructor           ='ST001', 
       @Pilot				 ='26',
	   @Test				 ='18',
	   @Room				 ='1'
	   
EXEC dbo.newclasstest 
       @Start                ='2018-08-11 20:00:00.000',
       @End					 ='2018-08-11 22:00:00.000',
       @Instructor           ='LT007', 
       @Pilot				 ='6',
	   @Test				 ='14',
	   @Room				 ='3'
	   
	   
	   
EXEC dbo.newflighttest 
       @Start                ='2018-03-11 20:00:00.000',
       @End					 ='2018-03-11 21:00:00.000',
       @Instructor           ='LT001', 
       @Pilot				 ='1',
	   @Test				 ='3',
	   @Aircraft			 ='CA3413'
	   
EXEC dbo.newflighttest 
       @Start                ='2018-08-03 12:00:00.000',
       @End					 ='2018-08-03 15:30:00.000',
       @Instructor           ='LT008', 
       @Pilot				 ='4',
	   @Test				 ='11',
	   @Aircraft			 ='CA5184'
	   
EXEC dbo.newflighttest 
       @Start                ='2018-09-15 11:00:00.000',
       @End					 ='2018-09-15 14:30:00.000',
       @Instructor           ='LT003', 
       @Pilot				 ='5',
	   @Test				 ='12',
	   @Aircraft			 ='YS3680'
	   
EXEC dbo.newflighttest 
       @Start                ='2018-10-20 14:00:00.000',
       @End					 ='2018-10-20 17:30:00.000',
       @Instructor           ='ST001', 
       @Pilot				 ='26',
	   @Test				 ='20',
	   @Aircraft			 ='TD1573'	   
	   
EXEC dbo.newflighttest 
       @Start                ='2018-08-15 18:00:00.000',
       @End					 ='2018-08-15 22:30:00.000',
       @Instructor           ='LT007', 
       @Pilot				 ='6',
	   @Test				 ='15',
	   @Aircraft			 ='IN6429'
GO

UPDATE [Exam] 
SET 
[E_Result] = 65
WHERE
[E_ID] = 1; 

UPDATE [Exam] 
SET 
[E_Result] = 67
WHERE
[E_ID] = 2; 

UPDATE [Exam] 
SET 
[E_Result] = 82
WHERE
[E_ID] = 3; 

UPDATE [Exam] 
SET 
[E_Result] = 71
WHERE
[E_ID] = 4; 

UPDATE [Exam] 
SET 
[E_Result] = 83
WHERE
[E_ID] = 5; 

UPDATE [Exam] 
SET 
[E_Result] = 78
WHERE
[E_ID] = 6; 

UPDATE [Exam] 
SET 
[E_Result] = 58
WHERE
[E_ID] = 7; 

UPDATE [Exam] 
SET 
[E_Result] = 91
WHERE
[E_ID] = 8; 

UPDATE [Exam] 
SET 
[E_Result] = 59
WHERE
[E_ID] = 9; 

UPDATE [Exam] 
SET 
[E_Result] = 85
WHERE
[E_ID] = 10; 

Select * FROM Pilot;
Select * FROM Pilot_S;
Select * FROM Aircraft_Category;
Select * FROM Aircraft;
Select * FROM Room;
Select * FROM Course;
Select * FROM Test;
Select * FROM Servicing;
Select * FROM Instructor;
Select * FROM LT_Instructor;
Select * FROM ST_Instructor;
Select * FROM AC_Qualification;
Select * FROM Enrolment;
Select * FROM Payment;
Select * FROM Schedule;
Select * FROM Lesson;
Select * FROM Flight_Lesson;
Select * FROM Class_Lesson;
Select * FROM Exam;
Select * FROM Flight_Test;
Select * FROM Class_Test;
Select * FROM [Sponsored Pilot];
Select * FROM [Long Term Instructor];
Select * FROM [Short Term Instructor];
Select * FROM [Flight Lesson];
Select * FROM [Class Lesson];
Select * FROM [Flight Test];
Select * FROM [Class Test];
GO