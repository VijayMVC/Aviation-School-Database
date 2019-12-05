/* Create Procedures Query for Relational and NoSQL Databases CIS2017-N Module ICA 1
NAME: SI THU ZAW 	NRIC: 		Teesside ID: T7177793	Batch Code: BTID11701A	Lecturer Name: Dr. Loo Poh Kok
Management Development Institute of Singapore / Teesside University UK*/

USE [Aviation_School]
GO
CREATE PROCEDURE dbo.newsponsoredpilot 
       @Name        nvarchar(50) = NULL, 
       @DOB                 date = NULL, 
       @Gender               bit = NULL,
	   @Member				 bit = NULL,
	   @Sponsor	   nvarchar(100) = NULL,
	   @SponsorRef			 int = NULL
AS 
IF (@DOB > GETDATE())	
BEGIN
	(SELECT 'Date of Birth can not be in the future' AS 'ERROR'); 
	RETURN
END
ELSE
BEGIN
	BEGIN TRANSACTION
	BEGIN TRY
		SET NOCOUNT ON 

		INSERT INTO dbo.Pilot
			(                    
				P_Name          ,
				P_DOB           ,
				P_Gender		,
				P_Member		,
				P_type              
			) 
		VALUES 
			( 
				@Name,
				@DOB,
				@Gender,
				@Member,
				'1'
			);
		INSERT INTO dbo.Pilot_S
			(
				P_ID,
				SP_Sponsor,
				SP_Ref
			)
		VALUES
			(
				@@IDENTITY,
				@Sponsor,
				@SponsorRef
			)
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH

		SELECT ERROR_MESSAGE()'Error Message';
		ROLLBACK TRANSACTION

	END CATCH
END
GO

CREATE PROCEDURE dbo.newlongterminstructor
       @ID              char(10) = NULL, 
       @Name        nvarchar(50) = NULL, 
       @DOB                 date = NULL, 
       @Gender               bit = NULL,
	   @Liexpire			date = NULL,
	   @LiJoinDate			date = NULL 
AS 
IF (@Liexpire <= GETDATE())	
BEGIN
	(SELECT 'Licence has passed its expiration date' AS 'ERROR'); 
	RETURN
END
IF (@DOB > GETDATE())	
BEGIN
	(SELECT 'Date of Birth can not be in the future' AS 'ERROR'); 
	RETURN
END
ELSE
BEGIN
	BEGIN TRANSACTION
	BEGIN TRY
		SET NOCOUNT ON 

		INSERT INTO dbo.Instructor
			(                    
				I_ID            ,
				I_Name          ,
				I_DOB           ,
				I_Gender		,
				I_liexpire		,
				I_type              
			) 
		VALUES 
			( 
				@ID,
				@Name,
				@DOB,
				@Gender,
				@Liexpire,
				'1'
			);
		INSERT INTO dbo.LT_Instructor
			(
				LI_ID,
				LI_JoinDate 
			)
		VALUES
			(
				@ID,
				@LiJoinDate
			)
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH

		SELECT ERROR_MESSAGE()'Error Message';
	ROLLBACK TRANSACTION

	END CATCH
END
GO

CREATE PROCEDURE dbo.newshortterminstructor 
       @ID              char(10) = NULL, 
       @Name        nvarchar(50) = NULL, 
       @DOB                 date = NULL, 
       @Gender               bit = NULL,
	   @Liexpire			date = NULL,
	   @SI_ConStart			date = NULL,
	   @SI_ConEnd			date = NULL
AS 
IF (@Liexpire <= GETDATE())	
BEGIN
	(SELECT 'Licence has passed its expiration date' AS 'ERROR'); 
	RETURN
END
IF (@DOB > GETDATE())	
BEGIN
	(SELECT 'Date of Birth can not be in the future' AS 'ERROR'); 
	RETURN
END
ELSE
BEGIN
	BEGIN TRANSACTION
	BEGIN TRY
		SET NOCOUNT ON 

		INSERT INTO dbo.Instructor
			(                    
				I_ID            ,
				I_Name          ,
				I_DOB           ,
				I_Gender		,
				I_liexpire		,
				I_type              
			) 
		VALUES 
			( 
				@ID,
				@Name,
				@DOB,
				@Gender,
				@Liexpire,
				'0'
			);
		INSERT INTO dbo.ST_Instructor
			(
				SI_ID		,
				SI_ConStart ,
				SI_ConEnd    
			)
		VALUES
			(
				@ID,
				@SI_ConStart,
				@SI_ConEnd
			)
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH

		SELECT ERROR_MESSAGE()'Error Message';
		ROLLBACK TRANSACTION

	END CATCH
END
GO

CREATE PROCEDURE dbo.newflightlesson 
       @Start                datetime = NULL, 
       @End					 datetime = NULL, 
       @Instructor           char(10) = NULL, 
       @Pilot					  int = NULL,
	   @Note			nvarchar(max) = NULL,
	   @Aircraft			 char(10) = NULL,	
	   @ID						  int = NULL
AS

IF EXISTS(SELECT * FROM schedule WHERE (S_Start BETWEEN @Start AND @END) OR (S_End BETWEEN @START AND @END) AND (S_I = @Instructor))
BEGIN
	(SELECT 'Another event exists for selected instructor in the time selected' AS 'Error');
	RETURN
END
IF 	((SELECT I_liexpire FROM Instructor WHERE I_ID=@Instructor) < @Start)
BEGIN
	(SELECT 'Entered instructor"s licence expires before the event starting time' AS 'Error');
	RETURN
END
ELSE
BEGIN 
BEGIN TRANSACTION
BEGIN TRY
     SET NOCOUNT ON 

     INSERT INTO dbo.Schedule
          (                    
            S_Start         ,
            S_End           ,
            S_I      		,
			S_P				,
			S_Type
          ) 
		  VALUES
          ( 
            @start,
            @end,
            @Instructor,
            @Pilot,
			'1'
          );
	SET @ID = SCOPE_IDENTITY();
	INSERT INTO dbo.Lesson
		(
			L_Sche,
			L_Note  
		)
	VALUES
		(
			@ID,
			@Note
		);
	SET @ID = SCOPE_IDENTITY();
	INSERT INTO dbo.Flight_Lesson
		(
			FL_ID,
			FL_AC
		)
	VALUES
		(	
			@ID,
			@Aircraft
		);
	COMMIT TRANSACTION
END TRY
BEGIN CATCH

SELECT ERROR_MESSAGE()'Error Message';
ROLLBACK TRANSACTION

END CATCH
END
GO

CREATE PROCEDURE dbo.newclasslesson 
       @Start                datetime = NULL, 
       @End					 datetime = NULL, 
       @Instructor           char(10) = NULL, 
       @Pilot					  int = NULL,
	   @Note			nvarchar(max) = NULL,
	   @Room				 char(10) = NULL,	
	   @ID						  int = NULL
AS
IF EXISTS(SELECT * FROM ((schedule INNER JOIN exam ON S_ID = E_Sche) INNER JOIN class_lesson ON E_ID = CL_ID)WHERE (S_Start BETWEEN @Start AND @END) OR (S_End BETWEEN @START AND @END) AND (CL_Room = @Room))
BEGIN
	(SELECT 'The selected room is in use in the given time' AS 'Error');
	RETURN
END
IF EXISTS(SELECT * FROM schedule WHERE (S_Start BETWEEN @Start AND @END) OR (S_End BETWEEN @START AND @END) AND (S_I = @Instructor))
BEGIN
	(SELECT 'Another event exists for selected instructor in the time selected' AS 'Error');
	RETURN
END
IF 	((SELECT I_liexpire FROM Instructor WHERE I_ID=@Instructor) < @Start)
BEGIN
	(SELECT 'Entered instructor"s licence expires before the event starting time' AS 'Error');
	RETURN
END
ELSE
BEGIN 
BEGIN TRANSACTION
BEGIN TRY
     SET NOCOUNT ON 

     INSERT INTO dbo.Schedule
          (                    
            S_Start         ,
            S_End           ,
            S_I      		,
			S_P     		,
			S_Type		    
          ) 
		  VALUES
          ( 
            @start,
            @end,
            @Instructor,
            @Pilot,
			'2'
          );
	SET @ID = SCOPE_IDENTITY();
	INSERT INTO dbo.Lesson
		(
			L_Sche,
			L_Note  
		)
	VALUES
		(
			@ID,
			@Note
		);
	SET @ID = SCOPE_IDENTITY();
	INSERT INTO dbo.Class_Lesson
		(
			CL_ID,
			CL_Room
		)
	VALUES
		(	
			@ID,
			@Room
		);
	COMMIT TRANSACTION
END TRY
BEGIN CATCH

SELECT ERROR_MESSAGE()'Error Message';
ROLLBACK TRANSACTION

END CATCH
END
GO

CREATE PROCEDURE dbo.newclasstest 
       @Start                datetime = NULL, 
       @End					 datetime = NULL, 
       @Instructor           char(10) = NULL, 
       @Pilot					  int = NULL,
	   @Test					  int = NULL,
	   @Room				      int = NULL,	
	   @ID						  int = NULL
AS
IF EXISTS(SELECT * FROM ((schedule INNER JOIN exam ON S_ID = E_Sche) INNER JOIN class_test ON E_ID = CT_ID)WHERE (S_Start BETWEEN @Start AND @END) OR (S_End BETWEEN @START AND @END) AND (CT_Room = @Room))
BEGIN
	(SELECT 'The selected room is in use in the given time' AS 'Error');
	RETURN
END
IF EXISTS(SELECT * FROM schedule WHERE (S_Start BETWEEN @Start AND @END) OR (S_End BETWEEN @START AND @END) AND (S_I = @Instructor))
BEGIN
	(SELECT 'Another event exists for selected instructor in the time selected' AS 'Error');
	RETURN
END
IF 	((SELECT I_liexpire FROM Instructor WHERE I_ID=@Instructor) < @Start)
BEGIN
	(SELECT 'Entered instructor"s licence expires before the event starting time' AS 'Error');
	RETURN
END
ELSE
BEGIN 
BEGIN TRANSACTION
BEGIN TRY
     SET NOCOUNT ON 

     INSERT INTO dbo.Schedule
          (                    
            S_Start         ,
            S_End           ,
            S_I      		,
			S_P     		,
			S_Type
          ) 
		  VALUES
          ( 
            @start,
            @end,
            @Instructor,
            @Pilot,
			'3'
          );
	SET @ID = SCOPE_IDENTITY();
	INSERT INTO dbo.Exam
		(
			E_Sche,
			E_Test  
		)
	VALUES
		(
			@ID,
			@Test
		);
	SET @ID = SCOPE_IDENTITY();
	INSERT INTO dbo.Class_Test
		(
			CT_ID,
			CT_Room
		)
	VALUES
		(	
			@ID,
			@Room
		);
		COMMIT TRANSACTION
END TRY
BEGIN CATCH

SELECT ERROR_MESSAGE()'Error Message';
ROLLBACK TRANSACTION

END CATCH
END
GO

CREATE PROCEDURE dbo.newflighttest 
       @Start                datetime = NULL, 
       @End					 datetime = NULL, 
       @Instructor           char(10) = NULL, 
       @Pilot					  int = NULL,
	   @Test					  int = NULL,
	   @Aircraft				  char(10) = NULL,	
	   @ID						  int = NULL,
	   @starttime			 datetime = NULL
AS
IF EXISTS(SELECT * FROM schedule WHERE (S_Start BETWEEN @Start AND @END) OR (S_End BETWEEN @START AND @END) AND (S_I = @Instructor))
BEGIN
	(SELECT 'Another event exists for selected instructor in the time selected' AS 'Error');
	RETURN
END
IF 	((SELECT I_liexpire FROM Instructor WHERE I_ID=@Instructor) < @Start)
BEGIN
	(SELECT 'Entered instructor"s licence expires before the event starting time' AS 'Error');
	RETURN
END
ELSE
BEGIN 	
BEGIN TRANSACTION
BEGIN TRY
     SET NOCOUNT ON 

     INSERT INTO dbo.Schedule
          (                    
            S_Start         ,
            S_End           ,
            S_I      		,
			S_P     		,
			S_Type
          ) 
		  VALUES
          ( 
            @start,
            @end,
            @Instructor,
            @Pilot,
			'4'
          );
	SET @ID = SCOPE_IDENTITY();
	SET @starttime = DATEADD(HOUR, 1, @Start);
	INSERT INTO dbo.Exam
		(
			E_Sche,
			E_Test  
		)
	VALUES
		(
			@ID,
			@Test
		);
	SET @ID = SCOPE_IDENTITY();
	INSERT INTO dbo.Flight_Test
		(
			FT_ID,
			FT_AC,
			FT_Time
		)
	VALUES
		(	
			@ID,
			@Aircraft,
			@starttime
		);
		COMMIT TRANSACTION
END TRY
BEGIN CATCH

SELECT ERROR_MESSAGE()'Error Message';
ROLLBACK TRANSACTION

END CATCH
END
GO

CREATE PROCEDURE dbo.retrievepilotrecord
       @PilotID		int = NULL
AS
BEGIN
SELECT P_Name AS 'Name',
P_DOB AS 'Date of Birth',
CASE P_Gender WHEN 1 THEN 'Male' WHEN 0 THEN 'Female' END As Gender,
CASE P_Type WHEN 1 THEN 'Sponsored' WHEN 0 THEN 'Independent' END AS 'Pilot Type',
CASE P_Member WHEN 1 THEN 'Yes' WHEN 0 THEN 'No' END As 'Member?' 
FROM Pilot WHERE P_ID = @PilotID; 
SELECT 
C_Name AS 'Course',
En_Start_Date AS 'Course Start Date',
CASE En_Checkup WHEN 1 THEN 'Pending' WHEN 0 THEN 'Confirmed' END AS 'Medical Status'
FROM (Enrolment INNER JOIN Course ON En_C_ID = C_ID) WHERE En_P_ID = @PilotID;
SELECT * FROM [Class Lesson] WHERE Pilot = (Select P_Name FROM Pilot WHERE P_ID = @PilotID);
SELECT * FROM [Flight Lesson] WHERE Pilot = (Select P_Name FROM Pilot WHERE P_ID = @PilotID);
SELECT * FROM [Class Test] WHERE Pilot = (Select P_Name FROM Pilot WHERE P_ID = @PilotID);
SELECT * FROM [Flight Test] WHERE Pilot = (Select P_Name FROM Pilot WHERE P_ID = @PilotID);
END
GO