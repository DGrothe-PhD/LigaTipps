/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) 
      ROW_NUMBER() 
	     OVER (ORDER BY [Punkte] DESC, [Diff.] DESC, [Tore] DESC ) 
      AS [Platz]
      ,[Team]
      ,[AnzahlSpiele]
      ,[Tore]
      ,[Gegentore]
      ,[Punkte]
      ,[Diff.]
  FROM [Bundesliga].[dbo].[View_LigatabelleMitDifferenz]