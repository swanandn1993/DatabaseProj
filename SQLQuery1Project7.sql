USE [FMIS555ssn6259DB]
GO
/****** Object:  Table [dbo].[Meeting]    Script Date: 10/3/2016 3:37:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Meeting](
	[meetingID] [int] IDENTITY(1,1) NOT NULL,
	[requesterID] [int] NOT NULL,
	[timeSlotID] [int] NOT NULL,
	[occurred] [bit] NOT NULL,
	[timestamp] [timestamp] NOT NULL,
 CONSTRAINT [PK_Meeting] PRIMARY KEY CLUSTERED 
(
	[meetingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Requester]    Script Date: 10/3/2016 3:37:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Requester](
	[requesterID] [int] IDENTITY(1,1) NOT NULL,
	[userID] [int] NOT NULL,
	[timeSlotSetID] [int] NOT NULL,
	[creationDate] [datetime2](7) NOT NULL,
	[timestamp] [timestamp] NOT NULL,
 CONSTRAINT [PK_Requester] PRIMARY KEY CLUSTERED 
(
	[requesterID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TimeSlot]    Script Date: 10/3/2016 3:37:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TimeSlot](
	[timeSlotID] [int] IDENTITY(1,1) NOT NULL,
	[timeSlotSetID] [int] NOT NULL,
	[beginTime] [datetime2](7) NOT NULL,
	[endTime] [datetime2](7) NOT NULL,
	[timestamp] [timestamp] NOT NULL,
 CONSTRAINT [PK_TimeSlot] PRIMARY KEY CLUSTERED 
(
	[timeSlotID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TimeSlotSet]    Script Date: 10/3/2016 3:37:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TimeSlotSet](
	[timeSlotSetID] [int] IDENTITY(1,1) NOT NULL,
	[ownerUserID] [int] NOT NULL,
	[title] [varchar](50) NOT NULL,
	[description] [varchar](300) NULL,
	[active] [bit] NOT NULL,
	[timestamp] [timestamp] NOT NULL,
 CONSTRAINT [PK_TimeSlotSet] PRIMARY KEY CLUSTERED 
(
	[timeSlotSetID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[User]    Script Date: 10/3/2016 3:37:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[User](
	[userID] [int] IDENTITY(1,1) NOT NULL,
	[userName] [varchar](20) NOT NULL,
	[firstName] [varchar](50) NULL,
	[lastName] [varchar](50) NULL,
	[password] [varchar](20) NULL,
	[email] [varchar](256) NOT NULL,
	[timestamp] [timestamp] NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[userID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Meeting] ADD  CONSTRAINT [DF_Meeting_occurred]  DEFAULT ((0)) FOR [occurred]
GO
ALTER TABLE [dbo].[Requester] ADD  CONSTRAINT [DF_Requester_creationDate]  DEFAULT (getdate()) FOR [creationDate]
GO
ALTER TABLE [dbo].[TimeSlotSet] ADD  CONSTRAINT [DF_TimeSlotSet_active]  DEFAULT ((1)) FOR [active]
GO
ALTER TABLE [dbo].[Meeting]  WITH CHECK ADD  CONSTRAINT [FK_Meeting_Requester] FOREIGN KEY([requesterID])
REFERENCES [dbo].[Requester] ([requesterID])
GO
ALTER TABLE [dbo].[Meeting] CHECK CONSTRAINT [FK_Meeting_Requester]
GO
ALTER TABLE [dbo].[Meeting]  WITH CHECK ADD  CONSTRAINT [FK_Meeting_TimeSlot] FOREIGN KEY([timeSlotID])
REFERENCES [dbo].[TimeSlot] ([timeSlotID])
GO
ALTER TABLE [dbo].[Meeting] CHECK CONSTRAINT [FK_Meeting_TimeSlot]
GO
ALTER TABLE [dbo].[Requester]  WITH CHECK ADD  CONSTRAINT [FK_Requester_TimeSlotSet] FOREIGN KEY([timeSlotSetID])
REFERENCES [dbo].[TimeSlotSet] ([timeSlotSetID])
GO
ALTER TABLE [dbo].[Requester] CHECK CONSTRAINT [FK_Requester_TimeSlotSet]
GO
ALTER TABLE [dbo].[Requester]  WITH CHECK ADD  CONSTRAINT [FK_Requester_User] FOREIGN KEY([userID])
REFERENCES [dbo].[User] ([userID])
GO
ALTER TABLE [dbo].[Requester] CHECK CONSTRAINT [FK_Requester_User]
GO
ALTER TABLE [dbo].[TimeSlot]  WITH CHECK ADD  CONSTRAINT [FK_TimeSlot_TimeSlotSet] FOREIGN KEY([timeSlotSetID])
REFERENCES [dbo].[TimeSlotSet] ([timeSlotSetID])
GO
ALTER TABLE [dbo].[TimeSlot] CHECK CONSTRAINT [FK_TimeSlot_TimeSlotSet]
GO
ALTER TABLE [dbo].[TimeSlotSet]  WITH CHECK ADD  CONSTRAINT [FK_TimeSlotSet_User] FOREIGN KEY([ownerUserID])
REFERENCES [dbo].[User] ([userID])
GO
ALTER TABLE [dbo].[TimeSlotSet] CHECK CONSTRAINT [FK_TimeSlotSet_User]
GO
ALTER TABLE [dbo].[TimeSlot]  WITH CHECK ADD  CONSTRAINT [CK_TimeSlot_beginTime] CHECK  (([beginTime]>'19491231' AND [beginTime]<'21000101'))
GO
ALTER TABLE [dbo].[TimeSlot] CHECK CONSTRAINT [CK_TimeSlot_beginTime]
GO
ALTER TABLE [dbo].[TimeSlot]  WITH CHECK ADD  CONSTRAINT [CK_TimeSlot_beginTime_lessThan_endTime] CHECK  (([beginTime]<=[endTime]))
GO
ALTER TABLE [dbo].[TimeSlot] CHECK CONSTRAINT [CK_TimeSlot_beginTime_lessThan_endTime]
GO
ALTER TABLE [dbo].[TimeSlot]  WITH CHECK ADD  CONSTRAINT [CK_TimeSlot_endTime] CHECK  (([endTime]>'19491231' AND [endTime]<'21000101'))
GO
ALTER TABLE [dbo].[TimeSlot] CHECK CONSTRAINT [CK_TimeSlot_endTime]
GO
ALTER TABLE [dbo].[TimeSlotSet]  WITH CHECK ADD  CONSTRAINT [CK_TimeSlotSet_title] CHECK  (([title] like '_%'))
GO
ALTER TABLE [dbo].[TimeSlotSet] CHECK CONSTRAINT [CK_TimeSlotSet_title]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [CK_User_email] CHECK  (([email] like '_%@_%._%'))
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [CK_User_email]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [CK_User_firstName] CHECK  (([firstName] like '[a-z]%'))
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [CK_User_firstName]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [CK_User_lastName] CHECK  (([lastName] like '[a-z]%'))
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [CK_User_lastName]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [CK_User_password] CHECK  (([password] like '______%'))
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [CK_User_password]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [CK_User_UserName] CHECK  (([userName] like '[^0-9]____%'))
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [CK_User_UserName]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'must have an @ and a period, in that order' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'User', @level2type=N'CONSTRAINT',@level2name=N'CK_User_email'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'starts with a letter, at least one letter' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'User', @level2type=N'CONSTRAINT',@level2name=N'CK_User_firstName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'at least one letter, must start alpha' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'User', @level2type=N'CONSTRAINT',@level2name=N'CK_User_lastName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'at least 6 characters' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'User', @level2type=N'CONSTRAINT',@level2name=N'CK_User_password'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'at least 5 characters, can''t start with a number' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'User', @level2type=N'CONSTRAINT',@level2name=N'CK_User_UserName'
GO




drop view AllTimeSlotSets;
drop view AllCalendarRequesters;
drop view AllMeetings;

--1. 
Create view AllTimeSlotSets as 

	select	TimeSlotSet.ownerUserID,
			TimeSlotSet.timeSlotSetID,
			TimeSlotSet.title,
			TimeSlotSet.active,
			TimeSlotSet.timestamp as [tssTimeStamp],
			TimeSlot.timeSlotID,
			TimeSlot.beginTime,
			TimeSlot.endTime,
			TimeSlot.timestamp as tsTimeStamp
	from TimeSlotSet 
		join TimeSlot on TimeSlotSet.timeSlotSetID = TimeSlot.timeSlotSetID;




--2.
create view AllCalendarRequesters as
	select	TimeSlotSet.ownerUserID,
			TimeSlotSet.timeSlotSetID,
			TimeSlotSet.title,
			TimeSlotSet.active,
			TimeSlotSet.timestamp as tssTimeSlot,
			Requester.requesterID,
			Requester.userID,
			Requester.timestamp as rTimeSlot,
			[User].firstName,
			[User].lastName,
			[User].email
	from TimeSlotSet
		join Requester on TimeSlotSet.timeSlotSetID = Requester.timeSlotSetID
		join [User] on [User].userID = Requester.userID;

--3.
Create View AllMeetings as
	select TimeSlotSet.ownerUserID,
			TimeSlotSet.timeSlotSetID,
			TimeSlotSet.title,
			TimeSlotSet.active,
			TimeSlotSet.timestamp as tssTimeStamp,
			TimeSlot.timeSlotID,
			TimeSlot.beginTime,
			TimeSlot.endTime,
			TimeSlot.timestamp  as tsTimeStamp,
			Meeting.meetingID,
			Meeting.requesterID as mRequesterID,
			Meeting.occurred,
			Meeting.timestamp  as mTimeStamp,
			Requester.requesterID as rRequesterID,
			Requester.userID,
			Requester.timestamp  as rTimeStamp,
			[User].firstName,
			[User].lastName,
			[User].email 

	from TimeSlotSet
		join TimeSlot on TimeSlotSet.timeSlotSetID = TimeSlot.timeSlotSetID
		join Meeting on Meeting.timeSlotID = TimeSlot.timeSlotID
		join Requester on TimeSlotSet.timeSlotSetID = Requester.timeSlotSetID
		join [User] on [User].userID = Requester.userID;





