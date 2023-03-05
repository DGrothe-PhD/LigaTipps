USE [Bundesliga]
GO

/****** Object:  Table [dbo].[tb_Team]    Script Date: 05.03.2023 19:26:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tb_Team](
	[TeamID] [int] IDENTITY(1,1) NOT NULL,
	[Team] [nvarchar](20) NOT NULL,
	[AnzahlSpiele] [int] NOT NULL,
	[Platz] [int] NOT NULL,
	[Punkte] [int] NOT NULL,
	[Tore] [int] NOT NULL,
	[Gegentore] [int] NOT NULL,
 CONSTRAINT [PK_tb_Team] PRIMARY KEY CLUSTERED 
(
	[TeamID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

