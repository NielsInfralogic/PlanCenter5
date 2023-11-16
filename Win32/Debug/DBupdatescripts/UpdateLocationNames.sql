ALTER TABLE [dbo].[LocationNames] ADD CONSTRAINT [CK_LocationNames] CHECK (([Name]<>'' AND [RemoteFolder]<>''))
GO
ALTER TABLE [dbo].[LocationNames] ADD CONSTRAINT [IX_LocationNames] UNIQUE NONCLUSTERED  ([Name])
GO