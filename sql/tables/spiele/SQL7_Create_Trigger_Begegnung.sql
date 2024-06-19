USE [Bundesliga]
GO

/****** Object:  Trigger [dbo].[tr_TeamPoints]    Script Date: 19.06.2024 11:07:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE OR ALTER   TRIGGER [dbo].[tr_TeamPoints] 
   ON  [dbo].[tb_Begegnung]
   AFTER UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @TeamTore int;
	DECLARE @TeamGegentore int;
	DECLARE @TeamPunkte int;
	DECLARE @TeamAnzahlSpiele int;

	DECLARE @HeimID int; DECLARE @AuswaertsID int;
	DECLARE @SpielTore int;
	DECLARE @SpielGegentore int;
    -- Insert statements for trigger here

	-- Gather information.
	SELECT @SpielTore = Tore, @SpielGegentore = Gegentore,
	       @HeimID = HeimID, @AuswaertsID = AuswaertsID
	FROM inserted;
	
	------ PART 1 --------------------
	-- Gather host team's score before this match
	SELECT @TeamTore = ISNULL(Tore,0),      @TeamGegentore = ISNULL(Gegentore,0),
	       @TeamPunkte = ISNULL(Punkte,0),  @TeamAnzahlSpiele = ISNULL(AnzahlSpiele,0)
	FROM [dbo].[tb_Team]
	WHERE TeamID = @HeimID;

	-- Count and add match result
	SET @TeamAnzahlSpiele += 1;
	SET @TeamTore += @SpielTore;
	SET @TeamGegentore += @SpielGegentore;
	SET @TeamPunkte += CASE 
	    WHEN @SpielTore > @SpielGegentore   THEN 3
		WHEN @SpielTore = @SpielGegentore   THEN 1
		ELSE 0 END;
    
	-- Update team's results
	UPDATE [dbo].[tb_Team]
    SET AnzahlSpiele = @TeamAnzahlSpiele,
	    Punkte = @TeamPunkte,
	    Tore = @TeamTore,
		Gegentore = @TeamGegentore
    WHERE TeamID = @HeimID; 

	------ PART 2 --------------------
    -- Gather guest team's score before this match
	SELECT @TeamTore = ISNULL(Tore,0),      @TeamGegentore = ISNULL(Gegentore,0),
	       @TeamPunkte = ISNULL(Punkte,0),  @TeamAnzahlSpiele = ISNULL(AnzahlSpiele,0)
	FROM [dbo].[tb_Team]
	WHERE TeamID = @AuswaertsID;

	-- Count and add match result
	SET @TeamAnzahlSpiele += 1;
	SET @TeamTore += @SpielGegentore;
	SET @TeamGegentore += @SpielTore;
	SET @TeamPunkte += CASE 
	    WHEN @SpielTore < @SpielGegentore   THEN 3
		WHEN @SpielTore = @SpielGegentore   THEN 1
		ELSE 0 END;
    
	-- Update team's results
	UPDATE [dbo].[tb_Team]
    SET AnzahlSpiele = @TeamAnzahlSpiele,
	    Punkte = @TeamPunkte,
	    Tore = @TeamTore,
		Gegentore = @TeamGegentore
    WHERE TeamID = @AuswaertsID; 

END
GO

ALTER TABLE [dbo].[tb_Begegnung] ENABLE TRIGGER [tr_TeamPoints]
GO


