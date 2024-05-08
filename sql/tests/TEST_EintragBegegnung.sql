-- This is a handmade unit test on the procedure BegegnungEintragen.

-- Prerequisites
USE [Bundesliga]
GO

DECLARE @TestName varchar(30);
DECLARE @RC int;
DECLARE @Erfolg bit;
DECLARE @Feedback varchar(max);
DECLARE @TestResult varchar(max);

DECLARE @Test_Spieltag int = 3;
-- this is for testing purposes only.
-- A separate entry for the test matches avoids double key conflicts.

-- Tests
SET @TestName = 'Test 1: Not existing team'
EXECUTE @RC = [dbo].[pr_BegegnungEintragen] 
   @Test_Spieltag
   , '04.05.1911'
   , '15:30'
   , 'xyz123'
   , 'abc456'
   , @Erfolg OUTPUT
   , @Feedback OUTPUT -- Fehlermeldungen etc.

SET @TestResult = CONCAT(@TestName, --': Successful'
    CASE WHEN @Feedback LIKE 'Verein xyz123 nicht gefunden.%'
	THEN ': Successful' ELSE 'Failed' END )
PRINT @TestResult;

SET @TestName = 'Test 2: Successful entry '
SET @Feedback = '_empty_'
EXECUTE @RC = [dbo].[pr_BegegnungEintragen] 
   @Test_Spieltag
   , '01.01.1911'
   , '01:11'
   , 'RB Leipzig'
   , 'Stuttgart'
   , @Erfolg OUTPUT
   , @Feedback OUTPUT -- Fehlermeldungen etc.

print @Feedback;
SET @TestResult = CONCAT(@TestName, --': Successful'
    CASE WHEN @Feedback LIKE '_empty_'
	THEN ': Successful' ELSE 'Failed' END )
PRINT @TestResult;


SET @TestName = 'Test 3: Ambiguous string'
EXECUTE @RC = [dbo].[pr_BegegnungEintragen] 
   @Test_Spieltag
   , '11.01.1911'
   , '15:30'
   , 'burg'-- should be ambiguous
   , 'abc456'
   , @Erfolg OUTPUT
   , @Feedback OUTPUT -- Fehlermeldungen etc.

SET @TestResult = CONCAT(@TestName, --': Successful'
    CASE WHEN @Feedback LIKE 'Angabe burg mehrdeutig%'
	THEN ': Successful' ELSE 'Failed' END )
PRINT @TestResult;


SET @TestName = 'Test 4: More than 1 team name starts with a string'
EXECUTE @RC = [dbo].[pr_BegegnungEintragen] 
   3
   , '11.01.1911'
   , '15:30'
   , 'Bayer'-- should be ambiguous
   , 'abc456'
   , @Erfolg OUTPUT
   , @Feedback OUTPUT -- Fehlermeldungen etc.

SET @TestResult = CONCAT(@TestName, --': Successful'
    CASE WHEN @Feedback LIKE 'Angabe Bayer mehrdeutig%'
	THEN ': Successful' ELSE 'Failed' END )
PRINT @TestResult;

-- Sweep database from test
DELETE FROM tb_Begegnung WHERE year(Datum) = 1911;
GO