USE [ProdPayroll]
GO

/****** Object:  UserDefinedFunction [dbo].[MngrInfoFromEMPemail]    Script Date: 31/07/2019 10:58:25 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		Daniel Gregory
-- Create date: 30/01/2019
-- Description:	Return manger information for the supplied employees email address
--				if there is only 1 then ruturn with a name value of 1
--				else return with name starting at 2, pick list in Frimstep
--				form set to default to 1 and be read only if 1 otherwise be
--				a pick list to select the relevant manager.
-- =============================================
CREATE FUNCTION [dbo].[MngrInfoFromEMPemail] 
(	@email as varchar(255)
)
RETURNS @return_variable TABLE (display varchar(620)
			,name int
			,managerEmail varchar(256)
			,managerName varchar(255))
AS
BEGIN
	DECLARE @checkNo as int
			,@name as int
    
    SELECT @checkNo = COUNT(ManagerEmailAddress)
    FROM (SELECT DISTINCT ManagerEmailAddress
			FROM [dbo].[EmployeeDetailsFromEBS]
			WHERE [EmailAddress] = @email) SNG
    
    IF @checkNo > 1
    BEGIN
		INSERT INTO @return_variable(display
								,name
								,managerEmail
								,managerName)
		SELECT SUBSTRING([Position], CHARINDEX('.',[Position]) + 1, LEN([Position]) - CHARINDEX('.',[Position])) 
			   + ' - ' + [ManagerName] as display
			  , ROW_NUMBER() OVER(ORDER BY ManagerName ASC) + 1 as name
			  ,[ManagerEmailAddress] as managerEmail
			  ,[ManagerName]
		  FROM [dbo].[EmployeeDetailsFromEBS]
		  WHERE [EmailAddress] = @email;
	END
	ELSE
    BEGIN
		INSERT INTO @return_variable(display
								,name
								,managerEmail
								,managerName)
		SELECT TOP (1) SUBSTRING([Position], CHARINDEX('.',[Position]) + 1, LEN([Position]) - CHARINDEX('.',[Position])) 
			   + ' - ' + [ManagerName] as display
			  , 1 as name
			  ,[ManagerEmailAddress] as managerEmail
			  ,[ManagerName]
		  FROM [dbo].[EmployeeDetailsFromEBS]
		  WHERE [EmailAddress] = @email;
	END
	
RETURN
END



GO

