USE [Bundesliga]
GO

DECLARE @TestName varchar(30);
DECLARE @RC int;
DECLARE @Erfolg bit;
DECLARE @Feedback varchar(max);
DECLARE @TestResult varchar(max);

-- Tests
SET @TestName = 'Test 1: Not existing team'
EXECUTE @RC = [dbo].[pr_BegegnungEintragen] 
   2
   , '04.05.2024'
   , '15:30'
   , 'Bremen'
   , 'gladbach'
   , @Erfolg OUTPUT
   , @Feedback OUTPUT -- Fehlermeldungen etc.

PRINT @Feedback;