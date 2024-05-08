USE [Bundesliga]
GO

DECLARE @RC int;
DECLARE @Erfolg bit;
DECLARE @Feedback varchar(max);
DECLARE @TestResult varchar(max);

EXECUTE @RC = [dbo].[pr_BegegnungEintragen] 
   2
   , '05.05.2024'
   , '19:30'
   , 'Heidenh'
   , 'Mainz'
   , @Erfolg OUTPUT
   , @Feedback OUTPUT -- Fehlermeldungen etc.

PRINT @Feedback;