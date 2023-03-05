USE [Bundesliga]
GO

/****** Object:  Table [dbo].[tb_Zeiten]    Script Date: 05.03.2023 19:17:03 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

