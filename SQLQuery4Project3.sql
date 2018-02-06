use FMIS555ssn6259DB;




--UNIVERSITY

--TABLE 1

drop table yearWiseLog;
drop table universityInfo;

Create Table universityInfo(
ID int not null Identity(-2000,1),
formalName varchar(120) not null,
	CHECK( formalName like'[a-z][a-z]%'),
stateName varchar(2) not null,
	CHECK( formalName like'[a-z][a-z]'),
acronym varchar(10) not null,
informalName varchar(250),
yearOfEstablishment smallint not null,
motto varchar(250),
basicClassification varchar(20) not null,
	CHECK (basicClassification in ('Doctorate', 'Master', 'Associates', 'Special Focus', 'Tribal', 'Unclassified')),
geolocation geography not null,
consideredLandGrant tinyint not null,
	CHECK (consideredLandGrant in (0,1)),
websiteAddress varchar(2083),
	CHECK ( websiteAddress like 'www.%'),
settingType varchar(20) not null,
	CHECK ( settingType in ('urban', 'suburban', 'rural')),
timeOfUpdate timestamp,
Primary Key (ID)
);
 

--TABLE 2

Create TABLE yearWiseLog (
universityID int not null,
logYear smallint not null,
graduateEnrollment int not null,
undergraduateEnrollment int not null,
annualBudget float not null,
currentPercentageFemaleStudents float not null,
	CHECK(currentPercentageFemaleStudents <=100),
	CHECK(currentPercentageFemaleStudents >= 0),
currentPercentageMaleStudents float not null,
	CHECK(currentPercentageMaleStudents <=100),
	CHECK(currentPercentageMaleStudents >= 0),
bachelorDegreesOffered smallint not null,
mastersDegreesOffered smallint not null, 
doctoralDegreesOffered smallint not null,
timeOfUpdate timestamp,
Primary Key (universityID, logYear),
Foreign Key (universityID) references universityInfo(ID)
);



--WINE
drop table wineBatchInfo;
drop table wineInfo;



--Table 1

Create TABLE wineInfo (

ID int Identity(-2000,1),
wineName varchar(120) not null,
wineryName varchar(120) not null,
country varchar(20) not null,
	CHECK( country like'[a-z][a-z]'),
region varchar(30) not null,
	CHECK( region like'[a-z][a-z]'),
alcoholVolume float not null,
	CHECK(alcoholVolume <100),
	CHECK(alcoholVolume > 0),
styleOfWine varchar(20) not null,
majorGrape varchar(10) not null,
containsSulfites tinyint not null,
	CHECK (containsSulfites in (0,1)),
timeOfUpdate timestamp,
Primary Key(ID)
);

--Table 2

Create Table wineBatchInfo(

wineID int not null,
yearOfWine smallint not null,
numberOfBottles int not null,
	CHECK(currentPrice > 0),
currentPrice float not null,
	CHECK(currentPrice > 0),
timeOfUpdate timestamp,
Primary Key(wineID, yearOfWine),
Foreign Key(wineID) references wineInfo(ID)
);
