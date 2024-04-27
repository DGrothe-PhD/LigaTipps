USE [Bundesliga]
GO

/****** Object:  Table [dbo].[tb_Begegnung]    Script Date: 27.04.2024 19:08:06 ******/
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

