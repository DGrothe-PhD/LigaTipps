USE [Bundesliga]
GO

/****** Object:  Index [SpielIndex]    Script Date: 25.04.2024 19:59:24 ******/
CREATE UNIQUE NONCLUSTERED INDEX [SpielIndex] ON [dbo].[tb_Begegnung]
(
	[HeimID] ASC,
	[AuswaertsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
