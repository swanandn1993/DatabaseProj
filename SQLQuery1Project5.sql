use FMIS555ssn6259DB;

drop table Appointment;

drop table MeetingSeeker;

drop table AppAvailability;

drop table Calender;

drop table Person;

Create table Person(
ID int not null Identity(-2000,1),
FirstName varchar(20) not null,
	CHECK( FirstName like'[a-z][a-z]%'),
LastName varchar(20) not null,
	CHECK( LastName like'[a-z][a-z]%'),
Passcode varchar(50),
Primary Key (ID)
);


insert into Person (FirstName, LastName, Passcode)
Values( 'max', 'jones', 'batmanrocks'),
		( 'Dhaval', 'Chauhan', 'ironmansuxx'),
		( 'james', 'bond', 'fortknoxxx'),
		( 'james1', 'bond1', 'fortknoxxx1'),
		( 'james2', 'bond2', 'fortknoxxx2'),
		( 'james3', 'bond3', 'fortknoxxx3');
--select * from Person;

Create table Calender(
ID int not null Identity(-2000,1),
CalName varchar(120) not null,
	CHECK( CalName like'[a-z][a-z]%'),
ownerPersonID int not null
Primary Key(ID),
Foreign Key (ownerPersonID) references Person(ID)
);

insert into Calender (CalName,ownerPersonID)
	Values ('MaxCal', -2000),
		('DhavalCal', -1999), 
		('JamesCal', -1998), 
		('JamesCal1', -1998);


create table AppAvailability(
ID int not null Identity(-2000,1),
CID int,
Location varchar(120),
StartTime Time,
EndTime Time,
[TimeStamp] timestamp,
AvailableDays varchar(10),
Primary Key (ID, CID, location),
Foreign Key (CID) references Calender(ID),

);

--Select * from AppAvailability;
insert into AppAvailability (CID, Location, StartTime, EndTime, AvailableDays)
Values (-2000, 'CISLAB', convert(time,'10:00:00 AM'), convert(time,'2:00:00 PM'), 'MWR' ),
		(-1999, 'CISLAB', convert(time,'10:00:00 AM'), convert(time,'11:00:00 AM'), 'MWR' ),
		(-1999, 'CISLAB2', convert(time,'12:30:00 PM'), convert(time,'2:00:00 PM'), 'TF' ),
		(-1999, 'CISLAB3', convert(time,'2:00:00 PM'), convert(time,'3:00:00 PM'), 'MWR' ),
		(-1998, 'CISLAB', convert(time,'10:00:00 AM'), convert(time,'2:00:00 PM'), 'MWR' );




create table MeetingSeeker(
ID int not null Identity(-2000,1),
CalID int,
PersonID int,
[TimeStamp] timestamp,
Primary Key (CalID,ID),
Foreign Key (CalID) references Calender(ID),
Foreign Key (PersonID) references Person(ID)
);

--select * from Person;

insert into MeetingSeeker (CalID, PersonID)
Values (-2000, -1995),
		(-2000, -1998),
		(-2000, -1997),
		(-1998, -1995),
		(-1999, -1995);


create table Appointment(
ID bigint not null Identity(-2000,1),
CalID int,
startTime DateTime,
endTime DateTime,
seekerID int,
location varchar(120),
AppID int,
[TimeStamp] timestamp
Primary Key (ID),
Foreign Key (AppID, CalID, location) references AppAvailability(ID, CID, location),
Foreign Key (CalID,seekerID) references meetingSeeker(CalID,ID)
--Foreign Key (location) references AppAvailability(location)
);



--select * from AppAvailability;
--select * from meetingseeker;


insert into Appointment (CalID, startTime, endTime, seekerID,location,AppID)
values(-2000, convert(time,'10:00:00 AM'), convert(time,'11:00:00 AM'),  -1998, 'CISLAB', -2000),
		(-1999, convert(time,'1:00:00 PM'), convert(time,'2:00:00 PM'),  -1996, 'CISLAB2', -1998);


--select * from Appointment