use CPApp


CREATE TABLE SiteProducts (PNO varchar(6),
                       PNAME varchar(30),
					   DIMENSIONS varchar (10),
					   MEDIUM varchar(50),
	                       PRIMARY KEY (PNO));



Insert into SiteProducts values('abc' , 'def', 'ghi', 'jkl');

Insert into SiteProducts values('abc1' , 'def1', 'ghi1', 'jkl1');

Insert into SiteProducts values('abc2' , 'def2', 'ghi2', 'jkl2');

						   Select * from SiteProducts