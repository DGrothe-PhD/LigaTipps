USE [Bundesliga]
GO

/****** Object:  Table [dbo].[tb_Spieltage]    Script Date: 05.03.2023 19:22:07 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

