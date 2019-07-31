USE [ProdCodeTables]
GO

/****** Object:  StoredProcedure [dbo].[ManagerInformationFromEMPemail]    Script Date: 31/07/2019 10:57:08 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Daniel Gregory
-- Create date: 05/02/2019
-- Description:	Retrieve manager information for employee
-- =============================================
CREATE PROCEDURE [dbo].[ManagerInformationFromEMPemail] 
	@email as varchar(255)
AS
BEGIN
	SET NOCOUNT ON;

    SELECT *
    FROM ProdPayroll.dbo.MngrInfoFromEMPemail(@email)
    
END
GO

