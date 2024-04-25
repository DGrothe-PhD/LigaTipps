USE [Bundesliga]
GO

/****** Object:  StoredProcedure [dbo].[sp_Backup_BuLi_mit_Zeitstempel]    Script Date: 25.04.2024 19:34:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Daniela Grothe
-- Create date: 13.02.2023
-- Description:	Einfache Prozedur zum Backup.
-- Aufrufsyntax ist wie bei SELECT, ohne Klammern!
-- =============================================
CREATE   PROCEDURE [dbo].[sp_Backup_BuLi_mit_Zeitstempel] 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @bpath NVARCHAR(MAX);
	SET @bpath = 'C:\SQL-Kurs\DB\Bundesliga\BACKUPS\Bundesliga-'+
	dbo.sf_Zeitstempel()+
	'.bak';

	BACKUP DATABASE [Bundesliga] TO DISK = @bpath;
    -- Insert statements for procedure here
END
GO

