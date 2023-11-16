ALTER TABLE [dbo].[PublicationNames] ADD
[EmailRecipient] [varchar] (100) NULL CONSTRAINT [DF_PublicationNames_EmailRecipient] DEFAULT (''),
[EmailCC] [varchar] (100) NULL CONSTRAINT [DF_PublicationNames_EmailCC] DEFAULT (''),
[EmailSubject] [varchar] (200) NULL CONSTRAINT [DF_PublicationNames_EmailSubject] DEFAULT (''),
[EmailBody] [varchar] (500) NULL CONSTRAINT [DF_PublicationNames_EmailBody] DEFAULT (''),
[UploadFolder] [varchar] (260) NULL CONSTRAINT [DF_PublicationNames_UploadFolder] DEFAULT ('')
GO