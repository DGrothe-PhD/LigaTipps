USE [Bundesliga]
GO

/****** Object:  Index [Keine2AuswaertsSelbenTag]    Script Date: 25.04.2024 19:56:55 ******/
CREATE NONCLUSTERED INDEX [Keine2AuswaertsSelbenTag] ON [dbo].[tb_Begegnung]
(
	[AuswaertsID] ASC,
	[Spieltag] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

