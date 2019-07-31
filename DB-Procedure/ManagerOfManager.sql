USE [ProdCodeTables]
GO

/****** Object:  StoredProcedure [dbo].[ManagerOfManager]    Script Date: 31/07/2019 10:57:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Daniel Gregory
-- Create date: 13/02/2019
-- Description:	Retrieve manager information for employee
-- =============================================
CREATE PROCEDURE [dbo].[ManagerOfManager] 
	@managerEmail as varchar(255)
AS
BEGIN
	SET NOCOUNT ON;

    SELECT top(1) [managerEmail] as manager2Email
			 , [ManagerName] as manager2Name
    FROM ProdPayroll.dbo.MngrInfoFromEMPemail(@managerEmail)
    
END
GO

