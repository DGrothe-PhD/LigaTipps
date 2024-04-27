/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [Spieltag]
      ,FORMAT([Datum], 'dd.MM.yyyy') AS Datum
      ,FORMAT(CAST([Zeit] AS DATETIME),'HH:mm') AS Zeit
      ,[Heim]
      ,[Gast]
	  ,CONCAT_WS(':',[Tore],[Gegentore]) AS 'Ergebnis'
  FROM [Bundesliga].[dbo].[View_Spieltag]