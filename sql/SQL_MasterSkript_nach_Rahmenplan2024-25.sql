USE [master]
GO
/****** Object:  Database [Bundesliga]    Script Date: 19.06.2024 11:51:17 ******/
CREATE DATABASE [Bundesliga]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Bundesliga', FILENAME = N'C:\SQL-Kurs\DB\Bundesliga\Bundesliga.mdf' , SIZE = 10240KB , MAXSIZE = UNLIMITED, FILEGROWTH = 20%)
 LOG ON 
( NAME = N'Bundesliga_log', FILENAME = N'C:\SQL-Kurs\DB\Bundesliga\Bundesliga_log.ldf' , SIZE = 12416KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [Bundesliga] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Bundesliga].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Bundesliga] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Bundesliga] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Bundesliga] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Bundesliga] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Bundesliga] SET ARITHABORT OFF 
GO
ALTER DATABASE [Bundesliga] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Bundesliga] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Bundesliga] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Bundesliga] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Bundesliga] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Bundesliga] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Bundesliga] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Bundesliga] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Bundesliga] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Bundesliga] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Bundesliga] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Bundesliga] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Bundesliga] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Bundesliga] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Bundesliga] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Bundesliga] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Bundesliga] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Bundesliga] SET RECOVERY FULL 
GO
ALTER DATABASE [Bundesliga] SET  MULTI_USER 
GO
ALTER DATABASE [Bundesliga] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Bundesliga] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Bundesliga] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Bundesliga] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Bundesliga] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Bundesliga] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Bundesliga] SET QUERY_STORE = OFF
GO
USE [Bundesliga]
GO
/****** Object:  UserDefinedFunction [dbo].[sf_Zeitstempel]    Script Date: 19.06.2024 11:51:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	Die Funktion generiert so was: 20210105-105151150
-- =============================================
CREATE   FUNCTION [dbo].[sf_Zeitstempel] 
(
)
RETURNS char(18)
AS
BEGIN
	-- Variante 1 --
	--DECLARE @Zeitstempel char(18);

	--SET @Zeitstempel = CONVERT(VARCHAR(20), GETDATE(), 112) + 
	--	'-' + 
	--	REPLACE(CONVERT(VARCHAR(40), GETDATE(), 114),':','');

	---- Return the result of the function
	--RETURN @Zeitstempel;
			
	-- Variante 2 --
	--RETURN (SELECT CONVERT(VARCHAR(8), GETDATE(), 112) + 
	--	'-' + 
	--	REPLACE(CONVERT(VARCHAR(12), GETDATE(),114),':','')); 
	
		
	-- Variante 3 ---
	RETURN FORMAT(GETDATE(), 'yyyyMMdd-HHmmssfff');
	
-- https://www.sqlservercentral.com/articles/using-format-for-dates
-- https://docs.microsoft.com/en-us/sql/t-sql/functions/format-transact-sql?view=sql-server-ver15

END
GO
/****** Object:  Table [dbo].[tb_Team]    Script Date: 19.06.2024 11:51:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_Team](
	[TeamID] [int] IDENTITY(1,1) NOT NULL,
	[Team] [nvarchar](20) NOT NULL,
	[AnzahlSpiele] [int] NOT NULL,
	[Punkte] [int] NOT NULL,
	[Tore] [int] NOT NULL,
	[Gegentore] [int] NOT NULL,
 CONSTRAINT [PK_tb_Team] PRIMARY KEY CLUSTERED 
(
	[TeamID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[View_LigatabelleMitDifferenz]    Script Date: 19.06.2024 11:51:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_LigatabelleMitDifferenz]
AS
SELECT Team, AnzahlSpiele, Tore, Gegentore, Punkte, Tore - Gegentore AS [Diff.]
FROM     dbo.tb_Team
GO
/****** Object:  Table [dbo].[tb_Begegnung]    Script Date: 19.06.2024 11:51:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_Begegnung](
	[BegegnungID] [int] IDENTITY(1,1) NOT NULL,
	[HeimID] [int] NULL,
	[AuswaertsID] [int] NULL,
	[Tore] [int] NULL,
	[Gegentore] [int] NULL,
	[Spieltag] [int] NOT NULL,
	[Datum] [date] NULL,
	[Zeit] [time](7) NULL,
 CONSTRAINT [PK_tb_Begegnung] PRIMARY KEY CLUSTERED 
(
	[BegegnungID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_Spieltage]    Script Date: 19.06.2024 11:51:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_Spieltage](
	[SpieltagID] [int] IDENTITY(1,1) NOT NULL,
	[Spieltag] [int] NOT NULL,
	[Beginn] [date] NOT NULL,
	[Ende] [date] NULL,
 CONSTRAINT [PK_tb_Spieltage] PRIMARY KEY CLUSTERED 
(
	[SpieltagID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[View_Spieltag]    Script Date: 19.06.2024 11:51:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_Spieltag]
AS
SELECT dbo.tb_Spieltage.Spieltag, dbo.tb_Begegnung.Datum, dbo.tb_Begegnung.Zeit, dbo.tb_Begegnung.Tore, dbo.tb_Begegnung.Gegentore, dbo.tb_Team.Team AS Heim, tb_Team_1.Team AS Gast
FROM     dbo.tb_Spieltage INNER JOIN
                  dbo.tb_Begegnung ON dbo.tb_Spieltage.SpieltagID = dbo.tb_Begegnung.Spieltag INNER JOIN
                  dbo.tb_Team ON dbo.tb_Begegnung.HeimID = dbo.tb_Team.TeamID INNER JOIN
                  dbo.tb_Team AS tb_Team_1 ON dbo.tb_Begegnung.AuswaertsID = tb_Team_1.TeamID
GO
/****** Object:  Table [dbo].[tb_Tipper]    Script Date: 19.06.2024 11:51:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_Tipper](
	[TipperID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](30) NOT NULL,
	[EMail] [varchar](50) NULL,
	[Nickname] [nchar](10) NULL,
	[Telefon] [varchar](20) NULL,
	[Mobil] [varchar](20) NULL,
 CONSTRAINT [PK_tb_Tipper] PRIMARY KEY CLUSTERED 
(
	[TipperID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_Wertung]    Script Date: 19.06.2024 11:51:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_Wertung](
	[WertungID] [int] IDENTITY(1,1) NOT NULL,
	[Beschreibung] [nvarchar](50) NOT NULL,
	[Punkte] [smallint] NOT NULL,
 CONSTRAINT [PK_tb_Wertung] PRIMARY KEY CLUSTERED 
(
	[WertungID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_Zeiten]    Script Date: 19.06.2024 11:51:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_Zeiten](
	[ZeitID] [smallint] IDENTITY(1,1) NOT NULL,
	[FriendlyName] [nvarchar](20) NOT NULL,
	[Wochentag] [nvarchar](10) NOT NULL,
	[Uhrzeit] [time](7) NOT NULL,
 CONSTRAINT [PK_Zeiten] PRIMARY KEY CLUSTERED 
(
	[ZeitID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[tb_Spieltage] ON 

INSERT [dbo].[tb_Spieltage] ([SpieltagID], [Spieltag], [Beginn], [Ende]) VALUES (6, 1, CAST(N'2024-08-23' AS Date), CAST(N'2024-08-25' AS Date))
INSERT [dbo].[tb_Spieltage] ([SpieltagID], [Spieltag], [Beginn], [Ende]) VALUES (8, 2, CAST(N'2024-08-30' AS Date), CAST(N'2024-09-01' AS Date))
INSERT [dbo].[tb_Spieltage] ([SpieltagID], [Spieltag], [Beginn], [Ende]) VALUES (9, 3, CAST(N'2024-09-13' AS Date), CAST(N'2024-09-15' AS Date))
INSERT [dbo].[tb_Spieltage] ([SpieltagID], [Spieltag], [Beginn], [Ende]) VALUES (10, 4, CAST(N'2024-09-20' AS Date), CAST(N'2024-09-22' AS Date))
INSERT [dbo].[tb_Spieltage] ([SpieltagID], [Spieltag], [Beginn], [Ende]) VALUES (11, 5, CAST(N'2024-09-27' AS Date), CAST(N'2024-09-29' AS Date))
INSERT [dbo].[tb_Spieltage] ([SpieltagID], [Spieltag], [Beginn], [Ende]) VALUES (12, 6, CAST(N'2024-10-04' AS Date), CAST(N'2024-10-06' AS Date))
INSERT [dbo].[tb_Spieltage] ([SpieltagID], [Spieltag], [Beginn], [Ende]) VALUES (13, 7, CAST(N'2024-10-18' AS Date), CAST(N'2024-10-20' AS Date))
INSERT [dbo].[tb_Spieltage] ([SpieltagID], [Spieltag], [Beginn], [Ende]) VALUES (14, 8, CAST(N'2024-10-25' AS Date), CAST(N'2024-10-27' AS Date))
INSERT [dbo].[tb_Spieltage] ([SpieltagID], [Spieltag], [Beginn], [Ende]) VALUES (15, 9, CAST(N'2024-11-01' AS Date), CAST(N'2024-11-03' AS Date))
INSERT [dbo].[tb_Spieltage] ([SpieltagID], [Spieltag], [Beginn], [Ende]) VALUES (16, 10, CAST(N'2024-11-08' AS Date), CAST(N'2024-11-10' AS Date))
INSERT [dbo].[tb_Spieltage] ([SpieltagID], [Spieltag], [Beginn], [Ende]) VALUES (17, 11, CAST(N'2024-11-22' AS Date), CAST(N'2024-11-24' AS Date))
INSERT [dbo].[tb_Spieltage] ([SpieltagID], [Spieltag], [Beginn], [Ende]) VALUES (18, 12, CAST(N'2024-11-29' AS Date), CAST(N'2024-12-01' AS Date))
INSERT [dbo].[tb_Spieltage] ([SpieltagID], [Spieltag], [Beginn], [Ende]) VALUES (19, 13, CAST(N'2024-12-06' AS Date), CAST(N'2024-12-08' AS Date))
INSERT [dbo].[tb_Spieltage] ([SpieltagID], [Spieltag], [Beginn], [Ende]) VALUES (20, 14, CAST(N'2024-12-13' AS Date), CAST(N'2024-12-15' AS Date))
INSERT [dbo].[tb_Spieltage] ([SpieltagID], [Spieltag], [Beginn], [Ende]) VALUES (21, 15, CAST(N'2024-12-20' AS Date), CAST(N'2024-12-22' AS Date))
INSERT [dbo].[tb_Spieltage] ([SpieltagID], [Spieltag], [Beginn], [Ende]) VALUES (22, 16, CAST(N'2025-01-10' AS Date), CAST(N'2025-01-12' AS Date))
INSERT [dbo].[tb_Spieltage] ([SpieltagID], [Spieltag], [Beginn], [Ende]) VALUES (23, 17, CAST(N'2025-01-14' AS Date), CAST(N'2025-01-15' AS Date))
INSERT [dbo].[tb_Spieltage] ([SpieltagID], [Spieltag], [Beginn], [Ende]) VALUES (24, 18, CAST(N'2025-01-17' AS Date), CAST(N'2025-01-19' AS Date))
INSERT [dbo].[tb_Spieltage] ([SpieltagID], [Spieltag], [Beginn], [Ende]) VALUES (26, 19, CAST(N'2025-01-24' AS Date), CAST(N'2025-01-26' AS Date))
INSERT [dbo].[tb_Spieltage] ([SpieltagID], [Spieltag], [Beginn], [Ende]) VALUES (27, 20, CAST(N'2025-01-31' AS Date), CAST(N'2025-02-02' AS Date))
INSERT [dbo].[tb_Spieltage] ([SpieltagID], [Spieltag], [Beginn], [Ende]) VALUES (28, 21, CAST(N'2025-02-07' AS Date), CAST(N'2025-02-09' AS Date))
INSERT [dbo].[tb_Spieltage] ([SpieltagID], [Spieltag], [Beginn], [Ende]) VALUES (29, 22, CAST(N'2025-02-14' AS Date), CAST(N'2025-02-16' AS Date))
INSERT [dbo].[tb_Spieltage] ([SpieltagID], [Spieltag], [Beginn], [Ende]) VALUES (30, 23, CAST(N'2025-02-21' AS Date), CAST(N'2025-02-23' AS Date))
INSERT [dbo].[tb_Spieltage] ([SpieltagID], [Spieltag], [Beginn], [Ende]) VALUES (31, 24, CAST(N'2025-02-28' AS Date), CAST(N'2025-03-02' AS Date))
INSERT [dbo].[tb_Spieltage] ([SpieltagID], [Spieltag], [Beginn], [Ende]) VALUES (32, 25, CAST(N'2025-03-07' AS Date), CAST(N'2025-03-09' AS Date))
INSERT [dbo].[tb_Spieltage] ([SpieltagID], [Spieltag], [Beginn], [Ende]) VALUES (33, 26, CAST(N'2025-03-14' AS Date), CAST(N'2025-03-16' AS Date))
INSERT [dbo].[tb_Spieltage] ([SpieltagID], [Spieltag], [Beginn], [Ende]) VALUES (34, 27, CAST(N'2025-03-28' AS Date), CAST(N'2025-03-30' AS Date))
INSERT [dbo].[tb_Spieltage] ([SpieltagID], [Spieltag], [Beginn], [Ende]) VALUES (35, 28, CAST(N'2025-04-04' AS Date), CAST(N'2025-04-06' AS Date))
INSERT [dbo].[tb_Spieltage] ([SpieltagID], [Spieltag], [Beginn], [Ende]) VALUES (36, 29, CAST(N'2025-04-11' AS Date), CAST(N'2025-04-13' AS Date))
INSERT [dbo].[tb_Spieltage] ([SpieltagID], [Spieltag], [Beginn], [Ende]) VALUES (37, 30, CAST(N'2025-04-19' AS Date), CAST(N'2025-04-20' AS Date))
INSERT [dbo].[tb_Spieltage] ([SpieltagID], [Spieltag], [Beginn], [Ende]) VALUES (38, 31, CAST(N'2025-04-25' AS Date), CAST(N'2025-04-27' AS Date))
INSERT [dbo].[tb_Spieltage] ([SpieltagID], [Spieltag], [Beginn], [Ende]) VALUES (39, 32, CAST(N'2025-05-02' AS Date), CAST(N'2025-05-04' AS Date))
INSERT [dbo].[tb_Spieltage] ([SpieltagID], [Spieltag], [Beginn], [Ende]) VALUES (40, 33, CAST(N'2025-05-09' AS Date), CAST(N'2025-05-11' AS Date))
INSERT [dbo].[tb_Spieltage] ([SpieltagID], [Spieltag], [Beginn], [Ende]) VALUES (41, 34, CAST(N'2025-05-17' AS Date), CAST(N'2025-05-17' AS Date))
SET IDENTITY_INSERT [dbo].[tb_Spieltage] OFF
GO
SET IDENTITY_INSERT [dbo].[tb_Team] ON 

INSERT [dbo].[tb_Team] ([TeamID], [Team], [AnzahlSpiele], [Punkte], [Tore], [Gegentore]) VALUES (3, N'Bayer Leverkusen', 0, 0, 0, 0)
INSERT [dbo].[tb_Team] ([TeamID], [Team], [AnzahlSpiele], [Punkte], [Tore], [Gegentore]) VALUES (4, N'Bayern München', 0, 0, 0, 0)
INSERT [dbo].[tb_Team] ([TeamID], [Team], [AnzahlSpiele], [Punkte], [Tore], [Gegentore]) VALUES (5, N'VfB Stuttgart', 0, 0, 0, 0)
INSERT [dbo].[tb_Team] ([TeamID], [Team], [AnzahlSpiele], [Punkte], [Tore], [Gegentore]) VALUES (6, N'RB Leipzig', 0, 0, 0, 0)
INSERT [dbo].[tb_Team] ([TeamID], [Team], [AnzahlSpiele], [Punkte], [Tore], [Gegentore]) VALUES (7, N'Borussia Dortmund', 0, 0, 0, 0)
INSERT [dbo].[tb_Team] ([TeamID], [Team], [AnzahlSpiele], [Punkte], [Tore], [Gegentore]) VALUES (8, N'Eintracht Frankfurt', 0, 0, 0, 0)
INSERT [dbo].[tb_Team] ([TeamID], [Team], [AnzahlSpiele], [Punkte], [Tore], [Gegentore]) VALUES (9, N'SC Freiburg', 0, 0, 0, 0)
INSERT [dbo].[tb_Team] ([TeamID], [Team], [AnzahlSpiele], [Punkte], [Tore], [Gegentore]) VALUES (10, N'FC Augsburg', 0, 0, 0, 0)
INSERT [dbo].[tb_Team] ([TeamID], [Team], [AnzahlSpiele], [Punkte], [Tore], [Gegentore]) VALUES (11, N'1899 Hoffenheim', 0, 0, 0, 0)
INSERT [dbo].[tb_Team] ([TeamID], [Team], [AnzahlSpiele], [Punkte], [Tore], [Gegentore]) VALUES (13, N'1. FC Heidenheim', 0, 0, 0, 0)
INSERT [dbo].[tb_Team] ([TeamID], [Team], [AnzahlSpiele], [Punkte], [Tore], [Gegentore]) VALUES (14, N'Werder Bremen', 0, 0, 0, 0)
INSERT [dbo].[tb_Team] ([TeamID], [Team], [AnzahlSpiele], [Punkte], [Tore], [Gegentore]) VALUES (15, N'Borussia M.gladbach', 0, 0, 0, 0)
INSERT [dbo].[tb_Team] ([TeamID], [Team], [AnzahlSpiele], [Punkte], [Tore], [Gegentore]) VALUES (16, N'VfL Wolfsburg', 0, 0, 0, 0)
INSERT [dbo].[tb_Team] ([TeamID], [Team], [AnzahlSpiele], [Punkte], [Tore], [Gegentore]) VALUES (17, N'1. FC Union Berlin', 0, 0, 0, 0)
INSERT [dbo].[tb_Team] ([TeamID], [Team], [AnzahlSpiele], [Punkte], [Tore], [Gegentore]) VALUES (18, N'1. FSV Mainz 05', 0, 0, 0, 0)
INSERT [dbo].[tb_Team] ([TeamID], [Team], [AnzahlSpiele], [Punkte], [Tore], [Gegentore]) VALUES (19, N'Fortuna Düsseldorf', 0, 0, 0, 0)
INSERT [dbo].[tb_Team] ([TeamID], [Team], [AnzahlSpiele], [Punkte], [Tore], [Gegentore]) VALUES (20, N'FC St. Pauli', 0, 0, 0, 0)
INSERT [dbo].[tb_Team] ([TeamID], [Team], [AnzahlSpiele], [Punkte], [Tore], [Gegentore]) VALUES (21, N'Holstein Kiel', 0, 0, 0, 0)
SET IDENTITY_INSERT [dbo].[tb_Team] OFF
GO
SET IDENTITY_INSERT [dbo].[tb_Wertung] ON 

INSERT [dbo].[tb_Wertung] ([WertungID], [Beschreibung], [Punkte]) VALUES (1, N'Exakt richtig', 5)
INSERT [dbo].[tb_Wertung] ([WertungID], [Beschreibung], [Punkte]) VALUES (2, N'Richtige Differenz', 4)
INSERT [dbo].[tb_Wertung] ([WertungID], [Beschreibung], [Punkte]) VALUES (3, N'Richtige Tendenz', 3)
SET IDENTITY_INSERT [dbo].[tb_Wertung] OFF
GO
SET IDENTITY_INSERT [dbo].[tb_Zeiten] ON 

INSERT [dbo].[tb_Zeiten] ([ZeitID], [FriendlyName], [Wochentag], [Uhrzeit]) VALUES (1, N'Freitagabend', N'Freitag', CAST(N'20:30:00' AS Time))
INSERT [dbo].[tb_Zeiten] ([ZeitID], [FriendlyName], [Wochentag], [Uhrzeit]) VALUES (2, N'Samstagnachmittag', N'Samstag', CAST(N'15:30:00' AS Time))
INSERT [dbo].[tb_Zeiten] ([ZeitID], [FriendlyName], [Wochentag], [Uhrzeit]) VALUES (3, N'Samstagabend', N'Samstag', CAST(N'18:30:00' AS Time))
INSERT [dbo].[tb_Zeiten] ([ZeitID], [FriendlyName], [Wochentag], [Uhrzeit]) VALUES (4, N'Sonntagnachmittag', N'Sonntag', CAST(N'15:30:00' AS Time))
INSERT [dbo].[tb_Zeiten] ([ZeitID], [FriendlyName], [Wochentag], [Uhrzeit]) VALUES (5, N'Sonntagabend', N'Sonntag', CAST(N'17:30:00' AS Time))
INSERT [dbo].[tb_Zeiten] ([ZeitID], [FriendlyName], [Wochentag], [Uhrzeit]) VALUES (6, N'Sonntagabend2', N'Sonntag', CAST(N'19:30:00' AS Time))
SET IDENTITY_INSERT [dbo].[tb_Zeiten] OFF
GO
/****** Object:  Index [Keine2AuswaertsSelbenTag]    Script Date: 19.06.2024 11:51:18 ******/
CREATE NONCLUSTERED INDEX [Keine2AuswaertsSelbenTag] ON [dbo].[tb_Begegnung]
(
	[AuswaertsID] ASC,
	[Spieltag] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Keine2HeimspieleSelbenTag]    Script Date: 19.06.2024 11:51:18 ******/
CREATE UNIQUE NONCLUSTERED INDEX [Keine2HeimspieleSelbenTag] ON [dbo].[tb_Begegnung]
(
	[HeimID] ASC,
	[Spieltag] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [SpielIndex]    Script Date: 19.06.2024 11:51:18 ******/
CREATE UNIQUE NONCLUSTERED INDEX [SpielIndex] ON [dbo].[tb_Begegnung]
(
	[HeimID] ASC,
	[AuswaertsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tb_Begegnung]  WITH CHECK ADD  CONSTRAINT [FK_tb_Begegnung_tb_Spieltage] FOREIGN KEY([Spieltag])
REFERENCES [dbo].[tb_Spieltage] ([SpieltagID])
GO
ALTER TABLE [dbo].[tb_Begegnung] CHECK CONSTRAINT [FK_tb_Begegnung_tb_Spieltage]
GO
ALTER TABLE [dbo].[tb_Begegnung]  WITH CHECK ADD  CONSTRAINT [FK_tb_Begegnung_tb_Team] FOREIGN KEY([HeimID])
REFERENCES [dbo].[tb_Team] ([TeamID])
GO
ALTER TABLE [dbo].[tb_Begegnung] CHECK CONSTRAINT [FK_tb_Begegnung_tb_Team]
GO
ALTER TABLE [dbo].[tb_Begegnung]  WITH CHECK ADD  CONSTRAINT [FK_tb_Begegnung_tb_Team1] FOREIGN KEY([AuswaertsID])
REFERENCES [dbo].[tb_Team] ([TeamID])
GO
ALTER TABLE [dbo].[tb_Begegnung] CHECK CONSTRAINT [FK_tb_Begegnung_tb_Team1]
GO
/****** Object:  StoredProcedure [dbo].[pr_BegegnungEintragen]    Script Date: 19.06.2024 11:51:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE     PROCEDURE [dbo].[pr_BegegnungEintragen]
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
/****** Object:  StoredProcedure [dbo].[sp_Backup_BuLi_mit_Zeitstempel]    Script Date: 19.06.2024 11:51:18 ******/
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
/****** Object:  Trigger [dbo].[tr_TeamPoints]    Script Date: 19.06.2024 11:51:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE     TRIGGER [dbo].[tr_TeamPoints] 
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
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[7] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tb_Team"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 253
               Right = 260
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_LigatabelleMitDifferenz'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_LigatabelleMitDifferenz'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tb_Spieltage"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 170
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_Begegnung"
            Begin Extent = 
               Top = 7
               Left = 290
               Bottom = 271
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "tb_Team"
            Begin Extent = 
               Top = 11
               Left = 594
               Bottom = 252
               Right = 788
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tb_Team_1"
            Begin Extent = 
               Top = 101
               Left = 904
               Bottom = 264
               Right = 1098
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Spieltag'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Spieltag'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Spieltag'
GO
USE [master]
GO
ALTER DATABASE [Bundesliga] SET  READ_WRITE 
GO
