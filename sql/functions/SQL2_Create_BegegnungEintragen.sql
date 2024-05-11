USE [Bundesliga]
GO

/****** Object:  StoredProcedure [dbo].[pr_BegegnungEintragen]    Script Date: 07.05.2024 20:16:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER   PROCEDURE [dbo].[pr_BegegnungEintragen]
	-- Add the parameters for the stored procedure here
	@Spieltag int, @Datum DATE, @Zeit TIME(0), @Heim NVARCHAR(20), @Gegner NVARCHAR(20),
	@Erfolg bit OUTPUT, -- geklappt oder nicht
	@Feedback VARCHAR(MAX) OUTPUT -- Fehlermeldungen etc.
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @HeimID int;
	DECLARE @AuswaertsID int;

	DECLARE @msg nvarchar(100);
	DECLARE @msg_nexist nvarchar(100);
	DECLARE @unn NVARCHAR(100);

	BEGIN TRY

	IF @Datum IS NULL
		THROW 50001, 'Bitte ein Datum eingeben!', 1;
	IF @Spieltag IS NULL
		THROW 50001, 'Bitte Spieltag eingeben!', 1;

	SET @msg = 'Bitte eindeutige Teambezeichnungen eingeben, etwa "Darmstadt".'
	IF @Heim IS NULL OR @Gegner IS NULL
		THROW 50001, @msg, 1;
	
	DECLARE @num int;

	-- (Try and) Find HeimID 
	SET @num = 0;
	SELECT @num +=1, @HeimID = TeamID, @unn = CONCAT_WS(', ', @unn, Team)
	FROM dbo.tb_Team
	WHERE CHARINDEX(LOWER(@Heim), LOWER(Team)) > 0

	-- Check if @Heim is unambiguous
	IF ISNULL(@num, 0) = 0
	BEGIN
		SET @msg_nexist = CONCAT_WS(' ','Verein', @Heim, 'nicht gefunden.');
		THROW 50003, @msg_nexist, 1;
	END
	ELSE IF @num > 1
	BEGIN
		SET @msg = CONCAT_WS(' ','Angabe', @Heim,'mehrdeutig,', @num, 'Teams gefunden:', 0x0d0a, @unn);
		THROW 50007, @msg, 1;
	END

	-- Check AuswaertsID
	SET @num = 0;
	SELECT @num += 1, @AuswaertsID = TeamID, @unn = CONCAT_WS(', ', @unn, Team)
	FROM tb_Team
	WHERE CHARINDEX(LOWER(@Gegner), LOWER(Team)) > 0

	IF ISNULL(@num, 0) = 0
	BEGIN
		SET @msg_nexist = CONCAT_WS(' ','Verein', @Gegner, 'nicht gefunden.');
		THROW 50003, @msg_nexist, 1;
	END
	
	IF @num > 1
	BEGIN
		SET @msg = CONCAT_WS(' ','Angabe', @Gegner,'mehrdeutig,', @num, 'Teams gefunden:', 0x0d0a, @unn);
		THROW 50007, @msg, 1;
	END

	-- inserting
	INSERT INTO tb_Begegnung (HeimID, AuswaertsID, Spieltag, Datum, Zeit)
	VALUES (@HeimID, @AuswaertsID, @Spieltag, @Datum, @Zeit)

	END TRY
	BEGIN CATCH
		SET @Erfolg = 0; -- nicht geklappt--
		-- 	@Feedback text OUTPUT --Fehlermeldungen etc.
		SET @Feedback = 
			ERROR_MESSAGE() + ' Fehler Nr. '+ CONVERT(varchar, ERROR_NUMBER())
							+ ' Prozedur: '  + ERROR_PROCEDURE()
							+ ' Zeile Nr.: ' + CONVERT(varchar,  ERROR_LINE());
	END CATCH
END
GO

