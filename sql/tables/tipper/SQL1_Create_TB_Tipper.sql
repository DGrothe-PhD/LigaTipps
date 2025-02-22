USE [Bundesliga]
GO

/****** Object:  Table [dbo].[tb_Tipper]    Script Date: 13.05.2024 21:44:44 ******/
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

