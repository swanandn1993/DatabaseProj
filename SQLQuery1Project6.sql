
use FMIS555ssn6259DB;

drop table tblPersonRoles;

drop table validPersonRoles;

drop table validPeopleTypes;

drop table tblPerson;

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblPerson](
   [PersonID] [int] IDENTITY(10000,1) NOT NULL,
   [UnivIDNumOld] [char](9) NULL,
   [LastName] [varchar](50) NULL,
   [FirstName] [varchar](30) NULL,
   [MiddleName] [varchar](30) NULL,
   [UnivEmailOld] [varchar](20) NULL,
   [DesiredEmailOLD] [varchar](75) NULL,
   [Nickname] [varchar](25) NULL,
   [MaidenName] [varchar](30) NULL,
   [PasswordChangeNeeded] [bit] NOT NULL CONSTRAINT [DF_tblPerson_perPasswordChangeNeeded]  DEFAULT ((1)),
   [ImageExists] [bit] NULL CONSTRAINT [DF_tblPerson_perImage]  DEFAULT ((0)),
   [PhoneCell] [varchar](15) NULL,
   [UnivIDCheckNeeded] [bit] NULL CONSTRAINT [DF_tblPerson_PerUnivIDCheck]  DEFAULT ((0)),
   [publicPermission] [bit] NULL CONSTRAINT [DF_tblPerson_publicPermission]  DEFAULT ((0)),
   [dateAdded] [datetime] NULL CONSTRAINT [DF_tblPerson_dateAdded]  DEFAULT (getdate()),
   [pwd2] [varbinary](20) NULL,
 CONSTRAINT [PK_Person_DMK] PRIMARY KEY CLUSTERED 
(
   [PersonID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[tblPerson] ON
SET IDENTITY_INSERT [dbo].[tblPerson] OFF
/****** Object:  Table [dbo].[validPeopleTypes]    Script Date: 10/27/2010 09:35:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[validPeopleTypes](
   [roleTypeID] [tinyint] IDENTITY(1,1) NOT NULL,
   [roleTypeDesc] [varchar](20) NULL,
 CONSTRAINT [PK_validPeopleTypes] PRIMARY KEY CLUSTERED 
(
   [roleTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[validPeopleTypes] ON
INSERT [dbo].[validPeopleTypes] ([roleTypeID], [roleTypeDesc]) VALUES (1, N'Student/Alumni')
INSERT [dbo].[validPeopleTypes] ([roleTypeID], [roleTypeDesc]) VALUES (2, N'Employee')
INSERT [dbo].[validPeopleTypes] ([roleTypeID], [roleTypeDesc]) VALUES (3, N'Student Worker')
INSERT [dbo].[validPeopleTypes] ([roleTypeID], [roleTypeDesc]) VALUES (4, N'Volunteer')
INSERT [dbo].[validPeopleTypes] ([roleTypeID], [roleTypeDesc]) VALUES (5, N'Donor')
INSERT [dbo].[validPeopleTypes] ([roleTypeID], [roleTypeDesc]) VALUES (6, N'Parent')
INSERT [dbo].[validPeopleTypes] ([roleTypeID], [roleTypeDesc]) VALUES (7, N'Reference')
SET IDENTITY_INSERT [dbo].[validPeopleTypes] OFF
/****** Object:  Table [dbo].[validPersonRoles]    Script Date: 10/27/2010 09:35:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[validPersonRoles](
   [roleID] [int] NOT NULL,
   [roleDesc] [varchar](40) NULL,
   [roleCollegeID] [tinyint] NULL CONSTRAINT [DF_validPersonRoles_roleCollegeID]  DEFAULT ((1)),
   [roleTypeID] [tinyint] NULL,
   [roleVitaAppear] [bit] NULL CONSTRAINT [DF_validPersonRoles_roleVitaAppear]  DEFAULT ((1)),
 CONSTRAINT [PK_tblPersonType] PRIMARY KEY CLUSTERED 
(
   [roleID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[validPersonRoles] ([roleID], [roleDesc], [roleCollegeID], [roleTypeID], [roleVitaAppear]) VALUES (1, N'Student/Alumni', 1, 1, 0)
INSERT [dbo].[validPersonRoles] ([roleID], [roleDesc], [roleCollegeID], [roleTypeID], [roleVitaAppear]) VALUES (2, N'Student Visitor', 1, 1, 0)
INSERT [dbo].[validPersonRoles] ([roleID], [roleDesc], [roleCollegeID], [roleTypeID], [roleVitaAppear]) VALUES (11, N'Reference', 1, 7, 0)
INSERT [dbo].[validPersonRoles] ([roleID], [roleDesc], [roleCollegeID], [roleTypeID], [roleVitaAppear]) VALUES (21, N'Parent-Mother', 1, 6, 0)
INSERT [dbo].[validPersonRoles] ([roleID], [roleDesc], [roleCollegeID], [roleTypeID], [roleVitaAppear]) VALUES (22, N'Parent-Father', 1, 6, 0)
INSERT [dbo].[validPersonRoles] ([roleID], [roleDesc], [roleCollegeID], [roleTypeID], [roleVitaAppear]) VALUES (24, N'MSA Employer', 1, 6, 0)
INSERT [dbo].[validPersonRoles] ([roleID], [roleDesc], [roleCollegeID], [roleTypeID], [roleVitaAppear]) VALUES (25, N'MSA Advisory', 1, 4, 0)
INSERT [dbo].[validPersonRoles] ([roleID], [roleDesc], [roleCollegeID], [roleTypeID], [roleVitaAppear]) VALUES (26, N'ISOM Advisory', 1, 4, 0)
INSERT [dbo].[validPersonRoles] ([roleID], [roleDesc], [roleCollegeID], [roleTypeID], [roleVitaAppear]) VALUES (27, N'Banking Advisory', 1, 4, 0)
INSERT [dbo].[validPersonRoles] ([roleID], [roleDesc], [roleCollegeID], [roleTypeID], [roleVitaAppear]) VALUES (28, N'CSB Executive Board', 1, 4, 0)
INSERT [dbo].[validPersonRoles] ([roleID], [roleDesc], [roleCollegeID], [roleTypeID], [roleVitaAppear]) VALUES (30, N'Volunteer', 1, 4, 0)
INSERT [dbo].[validPersonRoles] ([roleID], [roleDesc], [roleCollegeID], [roleTypeID], [roleVitaAppear]) VALUES (31, N'CEN Mentor', 1, 4, 0)
INSERT [dbo].[validPersonRoles] ([roleID], [roleDesc], [roleCollegeID], [roleTypeID], [roleVitaAppear]) VALUES (32, N'CEN Applicant', 1, 4, 0)
INSERT [dbo].[validPersonRoles] ([roleID], [roleDesc], [roleCollegeID], [roleTypeID], [roleVitaAppear]) VALUES (33, N'CEN Exec Council', 1, 4, 0)
INSERT [dbo].[validPersonRoles] ([roleID], [roleDesc], [roleCollegeID], [roleTypeID], [roleVitaAppear]) VALUES (37, N'Guest Lecturer', 1, 4, 0)
INSERT [dbo].[validPersonRoles] ([roleID], [roleDesc], [roleCollegeID], [roleTypeID], [roleVitaAppear]) VALUES (41, N'RAP Consultant', 1, 4, 0)
INSERT [dbo].[validPersonRoles] ([roleID], [roleDesc], [roleCollegeID], [roleTypeID], [roleVitaAppear]) VALUES (46, N'Bus Week Presenter', 1, 4, 0)
INSERT [dbo].[validPersonRoles] ([roleID], [roleDesc], [roleCollegeID], [roleTypeID], [roleVitaAppear]) VALUES (89, N'Grad Asst', 1, 1, 0)
INSERT [dbo].[validPersonRoles] ([roleID], [roleDesc], [roleCollegeID], [roleTypeID], [roleVitaAppear]) VALUES (90, N'Employee', 1, 2, 0)
INSERT [dbo].[validPersonRoles] ([roleID], [roleDesc], [roleCollegeID], [roleTypeID], [roleVitaAppear]) VALUES (99, N'System Admin', 1, 2, 0)
/****** Object:  Table [dbo].[tblPersonRoles]    Script Date: 10/27/2010 09:35:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblPersonRoles](
   [perID] [int] NOT NULL,
   [roleID] [int] NOT NULL CONSTRAINT [DF_tblPersonStatus_perTypeID]  DEFAULT ((1)),
   [dateAdded] [datetime] NULL CONSTRAINT [DF_tblPersonStatus_dateAdded]  DEFAULT (getdate()),
   [active] [bit] NULL CONSTRAINT [DF_tblPersonStatus_active]  DEFAULT ((1)),
 CONSTRAINT [PK_tblPersonStatus] PRIMARY KEY CLUSTERED 
(
   [roleID] ASC,
   [perID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  ForeignKey [FK_tblPersonRoles_tblPerson]    Script Date: 10/27/2010 09:35:23 ******/
ALTER TABLE [dbo].[tblPersonRoles]  WITH CHECK ADD  CONSTRAINT [FK_tblPersonRoles_tblPerson] FOREIGN KEY([perID])
REFERENCES [dbo].[tblPerson] ([PersonID])
GO
ALTER TABLE [dbo].[tblPersonRoles] CHECK CONSTRAINT [FK_tblPersonRoles_tblPerson]
GO
/****** Object:  ForeignKey [FK_tblPersonRoles_validPersonRoles]    Script Date: 10/27/2010 09:35:23 ******/
ALTER TABLE [dbo].[tblPersonRoles]  WITH CHECK ADD  CONSTRAINT [FK_tblPersonRoles_validPersonRoles] FOREIGN KEY([roleID])
REFERENCES [dbo].[validPersonRoles] ([roleID])
GO
ALTER TABLE [dbo].[tblPersonRoles] CHECK CONSTRAINT [FK_tblPersonRoles_validPersonRoles]
GO
/****** Object:  ForeignKey [FK_validPersonRoles_validPeopleTypes]    Script Date: 10/27/2010 09:35:23 ******/
ALTER TABLE [dbo].[validPersonRoles]  WITH CHECK ADD  CONSTRAINT [FK_validPersonRoles_validPeopleTypes] FOREIGN KEY([roleTypeID])
REFERENCES [dbo].[validPeopleTypes] ([roleTypeID])
GO
ALTER TABLE [dbo].[validPersonRoles] CHECK CONSTRAINT [FK_validPersonRoles_validPeopleTypes]
GO


--1. Insert a new person whose name is Jennifer Crabtree, whose nickname is Jenny, and whose phone number is 216-867-5309. Use the safe form of the INSERT statement, where you specify every field that you will provide a value for (always use the safe form)

insert into tblPerson ( FirstName, LastName, Nickname, PhoneCell, PasswordChangeNeeded) values ('Jennifer', 'Crabtree', 'Jenny', '216-867-5309', 0) 

--2. Insert a new person whose name is Scarlett O'Hara.
insert into tblPerson ( FirstName, LastName, PasswordChangeNeeded) values ('Scarlett', 'O'' Hara', 0) 


--3. Update Scarlett, making her nickname Katie.

UPDATE tblPerson
SET Nickname = 'Katie'
WHERE FirstName = 'Scarlett' 
and LastName = 'O'' Hara';

--4. Give Jenny the student role.


insert into tblPersonRoles (perID, roleID, dateAdded, active)
	values ( 10000, 2,CURRENT_TIMESTAMP, 1);


--5. Give Katie the parent role.
insert into tblPersonRoles (perID, roleID, dateAdded, active)
	values ( 10001, 21,CURRENT_TIMESTAMP, 1);



--6. Give Katie the student/alumni role.


update tblPersonRoles
set roleID = 1
where perID = 10001;

--7. Enter a new person named Sean Thornton with nickname Trooper. He is an ISOM advisory board member26, a CEN mentor31, a Business Week presenter46, and a Guest Lecturer 41.

--select * from tblperson


insert into tblPerson ( FirstName, LastName, Nickname, PasswordChangeNeeded) values ('Sean', 'Thornton', 'Trooper', 0) 


insert into tblPersonRoles (perID, roleID, dateAdded, active)
	values ( 10002, 26,CURRENT_TIMESTAMP, 1),
		( 10002, 31,CURRENT_TIMESTAMP, 1),
		( 10002, 46,CURRENT_TIMESTAMP, 1),
		( 10002, 41,CURRENT_TIMESTAMP, 1);

--		select * from tblPersonRoles;



--8. Insert Ward Bond, Barry Fitzgerald, and Victor McLaglen, who should all have the actor role. Create the role (with person Type of volunteer), do the inserts, and give them those roles. Use multi-record statements wherever possible.


insert into validPersonRoles (roleID, roleDesc, roleCollegeID, roleTypeID)
	values ( 10,'Actor', 1, 4);


insert into tblPerson (FirstName, LastName, PasswordChangeNeeded)
Values ('Ward', 'Bond',0),  ('Barry',  'Fitzgerald',0), ('Victor', 'McLaglen',0);

insert into tblPersonRoles (perID, roleID, dateAdded, active)
	values ( 10003, 10,CURRENT_TIMESTAMP, 1),
	( 10004, 10,CURRENT_TIMESTAMP, 1),
	( 10005, 10,CURRENT_TIMESTAMP, 1)
	;


--9. Update all actors so that PasswordChangeNeeded =1.
--select * from validPersonRoles
--	where roleDesc = 'Actor';

update tblPerson
set PasswordChangeNeeded = 1
where tblPerson.PersonID in (select perID
								from tblPersonRoles
								where roleID =10)



--10. Give all actors the Student/Alumni role. Do this in a single INSERT statement.

--select * from validPersonRoles
--	where roleDesc = 'Actor';

insert into tblPersonRoles (perID, roleID, dateAdded, active)

	select perID, 1,CURRENT_TIMESTAMP, 1
			from tblPersonRoles
			where roleID = 10;
	
	




