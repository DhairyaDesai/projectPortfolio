-- @author: Aidan Gallagher
-- @author: Dhairya Desai
-- @author: Ryan Dockman
-- Assignmet: First Draft - SQL Script
-- Date: April 19, 2020 
-- Title: CollegeRentals Database Script

-- NOTE: We have update our ERD by changing the name of the rentalData table to rentals and adding a studentRentals table. 
--       We have made changes according to the feedback for our revised ERD assignment. 

USE master 
GO

-- Object: Database CollegeRentals 
IF DB_ID('CollegeRentals') IS NOT NULL
        DROP DATABASE CollegeRentals
GO 

CREATE DATABASE CollegeRentals 
GO 

USE CollegeRentals 
GO 

-- Objects: Table Students
CREATE TABLE Students (
    studentId	    	INT				NOT NULL	PRIMARY KEY		IDENTITY,
    firstName			VARCHAR(30)		NOT NULL,
	lastName			VARCHAR(30)		NOT NULL,
	phoneNumber			VARCHAR(15)		NOT NULL,
	email				VARCHAR(70)		NOT NULL,
    dateOfBirth      	DATE            NULL, 
    studentYear     	INT             NOT NULL,
    emergencyContact 	VARCHAR(10)    	NOT NULL,
	isDeleted			BIT				NOT NULL	DEFAULT(0)
)
GO

-- Objects: Table Properties
CREATE TABLE Properties (
    propertyId          	INT             NOT NULL    PRIMARY KEY		IDENTITY, 
    address             	VARCHAR(200)  	NOT NULL, 
    propertyName        	VARCHAR(70)     NOT NULL, 
    bedrooms            	INT             NOT NULL, 
    bathrooms           	INT             NOT NULL, 
	maxNumberOfOccupants 	INT 			NOT NULL, 
    numberOfOccupants   	INT             NOT NULL, 
    squareFootage       	INT             NOT NULL,
	isDeleted				BIT				NOT NULL	DEFAULT(0)
) 
GO

-- Objects: Table Leases
CREATE TABLE Leases (
    leaseId	    		INT				NOT NULL	PRIMARY KEY		IDENTITY,
    studentId			INT				NOT NULL	FOREIGN KEY REFERENCES Students(studentId),
	deposit				FLOAT			NOT NULL,
	totalCost			FLOAT				NOT NULL,
	leaseStart			DATETIME		NOT NULL,
	leaseEnd			DATETIME		NOT NULL,
	isDamaged			BIT				NOT NULL,
	isDeleted			BIT				NOT NULL	DEFAULT(0)
) 
GO

-- Objects: Table StudentRentals
CREATE TABLE RentalData (
    propertyId	    INT				NOT NULL	FOREIGN KEY REFERENCES Properties(propertyId),
	leaseId			INT				NOT NULL	FOREIGN KEY REFERENCES Leases(leaseId),
	PRIMARY KEY  								(propertyId, leaseId)
)
GO

-- Objects: Table Payments
CREATE TABLE Payments (	
    paymentId	    	INT				NOT NULL	PRIMARY KEY			IDENTITY,
	studentId	        INT				NOT NULL	FOREIGN KEY REFERENCES Students(studentId),
	leaseId	        	INT				NOT NULL	FOREIGN KEY REFERENCES Leases(leaseId),
	paymentType		    VARCHAR(30)		NOT NULL,
	paymentDate		    DATETIME		NOT NULL,
	paymentAmount		FLOAT			NOT NULL,
	isDeleted			BIT				NOT NULL	DEFAULT(0)
)
GO

-- Objects: Table Owner
CREATE TABLE Owners (
    ownerId				INT				NOT NULL	PRIMARY KEY			IDENTITY,
	companyName			VARCHAR(70)		NOT NULL,
	firstName			VARCHAR(70)		NOT NULL,
	lastName			VARCHAR(70)		NOT NULL,
	phoneNumber			VARCHAR(15)		NOT NULL,
	email				VARCHAR(70)		NOT NULL,
	officeLocation		VARCHAR(70)		NOT NULL,
	isDeleted			BIT				NOT NULL	DEFAULT(0)
) 
GO 

-- Objects: Table PropertyOwners
CREATE TABLE PropertyOwners (
    propertyId	    INT				NOT NULL	FOREIGN KEY REFERENCES Properties(propertyId),
	ownerId			INT				NOT NULL	FOREIGN KEY REFERENCES Owners(ownerId),
	PRIMARY KEY  								(propertyId, ownerId)
)
GO

SET IDENTITY_INSERT Students ON
insert into Students (studentId, firstName, lastName, phoneNumber, email, dateOfBirth, studentYear, emergencyContact, isDeleted) values (1, 'Parry', 'Duthie', '5316056547', 'pduthie0@instagram.com', '12/18/2000', 3, '6429018085', 0);
insert into Students (studentId, firstName, lastName, phoneNumber, email, dateOfBirth, studentYear, emergencyContact, isDeleted) values (2, 'Iormina', 'Britton', '7385927062', 'ibritton1@feedburner.com', '11/23/1999', 3, '7649428014', 0);
insert into Students (studentId, firstName, lastName, phoneNumber, email, dateOfBirth, studentYear, emergencyContact, isDeleted) values (3, 'Aindrea', 'Ferdinand', '8617292197', 'aferdinand2@edublogs.org', '1/8/2001', 4, '8856731080', 0);
insert into Students (studentId, firstName, lastName, phoneNumber, email, dateOfBirth, studentYear, emergencyContact, isDeleted) values (4, 'Birgitta', 'Bunclark', '1175995682', 'bbunclark3@go.com', '1/4/2000', 2, '2391447127', 0);
insert into Students (studentId, firstName, lastName, phoneNumber, email, dateOfBirth, studentYear, emergencyContact, isDeleted) values (5, 'Jarred', 'Whaites', '8741823184', 'jwhaites4@vinaora.com', '11/15/1999', 3, '1682274355', 0);
insert into Students (studentId, firstName, lastName, phoneNumber, email, dateOfBirth, studentYear, emergencyContact, isDeleted) values (6, 'Tull', 'Drewet', '9226653500', 'tdrewet5@squidoo.com', '2/3/2000', 2, '1209140864', 0);
insert into Students (studentId, firstName, lastName, phoneNumber, email, dateOfBirth, studentYear, emergencyContact, isDeleted) values (7, 'Natalina', 'Rielly', '8525075540', 'nrielly6@constantcontact.com', '3/5/1999', 2, '6522374418', 0);
insert into Students (studentId, firstName, lastName, phoneNumber, email, dateOfBirth, studentYear, emergencyContact, isDeleted) values (8, 'Dian', 'Denington', '2756917149', 'ddenington7@bloglovin.com', '11/7/1998', 2, '7286561167', 0);
insert into Students (studentId, firstName, lastName, phoneNumber, email, dateOfBirth, studentYear, emergencyContact, isDeleted) values (9, 'Leyla', 'Wolfers', '8575360905', 'lwolfers8@who.int', '3/28/1999', 3,'4901478698', 0);
insert into Students (studentId, firstName, lastName, phoneNumber, email, dateOfBirth, studentYear, emergencyContact, isDeleted) values (10, 'Kylie', 'McCrisken', '2867203121', 'kmccrisken9@orange.fr', '10/25/1999', 4, '3876280656', 0);
insert into Students (studentId, firstName, lastName, phoneNumber, email, dateOfBirth, studentYear, emergencyContact, isDeleted) values (11, 'Esdras', 'Eustace', '7567456361', 'eeustacea@msn.com', '4/14/1999', 4, '5079892413', 0);
insert into Students (studentId, firstName, lastName, phoneNumber, email, dateOfBirth, studentYear, emergencyContact, isDeleted) values (12, 'Joceline', 'Evers', '4897268952', 'jeversb@noaa.gov', '9/23/1998', 1, '2955618873', 0);
insert into Students (studentId, firstName, lastName, phoneNumber, email, dateOfBirth, studentYear, emergencyContact, isDeleted) values (13, 'Tyrone', 'Benito', '3084039335', 'tbenitoc@washington.edu', '7/8/2000', 2, '9110487700', 0);
insert into Students (studentId, firstName, lastName, phoneNumber, email, dateOfBirth, studentYear, emergencyContact, isDeleted) values (14, 'Dorian', 'Brisard', '7284821078', 'dbrisardd@biglobe.ne.jp', '3/7/1999', 1, '3527270649', 0);
insert into Students (studentId, firstName, lastName, phoneNumber, email, dateOfBirth, studentYear, emergencyContact, isDeleted) values (15, 'Silvana', 'Sange', '4185027009', 'ssangee@tiny.cc', '12/21/2000', 4, '9143486727', 0);
insert into Students (studentId, firstName, lastName, phoneNumber, email, dateOfBirth, studentYear, emergencyContact, isDeleted) values (16, 'Glen', 'Northwood', '6678601000', 'gnorthwoodf@macromedia.com', '6/30/1999', 1, '9447513566', 0);
insert into Students (studentId, firstName, lastName, phoneNumber, email, dateOfBirth, studentYear, emergencyContact, isDeleted) values (17, 'Arlie', 'Roust', '9588224092', 'aroustg@narod.ru', '6/16/1999', 2, '1860998398', 0);
insert into Students (studentId, firstName, lastName, phoneNumber, email, dateOfBirth, studentYear, emergencyContact, isDeleted) values (18, 'Dareen', 'Hathway', '8727344129', 'dhathwayh@youtube.com', '6/12/2000', 2, '3772753568', 0);
insert into Students (studentId, firstName, lastName, phoneNumber, email, dateOfBirth, studentYear, emergencyContact, isDeleted) values (19, 'Editha', 'Ferrers', '8095430265', 'eferrersi@tmall.com', '4/1/2001', 1, '2277570907', 0);
insert into Students (studentId, firstName, lastName, phoneNumber, email, dateOfBirth, studentYear, emergencyContact, isDeleted) values (20, 'Anjanette', 'Marcroft', '1153446149', 'amarcroftj@ning.com', '4/5/2001', 2, '7907017505', 0);
insert into Students (studentId, firstName, lastName, phoneNumber, email, dateOfBirth, studentYear, emergencyContact, isDeleted) values (21, 'Marget', 'Middlebrook', '7258655617', 'mmiddlebrookk@nba.com', '7/2/2000', 4, '8933773817', 0);
insert into Students (studentId, firstName, lastName, phoneNumber, email, dateOfBirth, studentYear, emergencyContact, isDeleted) values (22, 'Erl', 'Cupper', '6832460195', 'ecupperl@nifty.com', '5/19/2000', 3, '5539239973', 0);
insert into Students (studentId, firstName, lastName, phoneNumber, email, dateOfBirth, studentYear, emergencyContact, isDeleted) values (23, 'Donall', 'Duckit', '1404526604', 'dduckitm@twitter.com', '2/18/1999', 3, '9348912146', 0);
insert into Students (studentId, firstName, lastName, phoneNumber, email, dateOfBirth, studentYear, emergencyContact, isDeleted) values (24, 'Gunter', 'Matityahu', '8794452275', 'gmatityahun@arstechnica.com', '3/5/2000', 3, '7237287827', 0);
insert into Students (studentId, firstName, lastName, phoneNumber, email, dateOfBirth, studentYear, emergencyContact, isDeleted) values (25, 'Glendon', 'Guenther', '5754518307', 'gguenthero@studiopress.com', '7/9/2000', 4, '2367706854', 0);
insert into Students (studentId, firstName, lastName, phoneNumber, email, dateOfBirth, studentYear, emergencyContact, isDeleted) values (26, 'Annabella', 'Birks', '6503129701', 'abirksp@yelp.com', '10/7/1998', 2, '6349001259', 0);
insert into Students (studentId, firstName, lastName, phoneNumber, email, dateOfBirth, studentYear, emergencyContact, isDeleted) values (27, 'Link', 'Badger', '4391045767', 'lbadgerq@wikipedia.org', '8/19/2000', 1, '7513198878', 0);
insert into Students (studentId, firstName, lastName, phoneNumber, email, dateOfBirth, studentYear, emergencyContact, isDeleted) values (28, 'Rogerio', 'FitzGibbon', '7065340004', 'rfitzgibbonr@booking.com', '3/14/2001', 3, '9458665227', 0);
insert into Students (studentId, firstName, lastName, phoneNumber, email, dateOfBirth, studentYear, emergencyContact, isDeleted) values (29, 'Aharon', 'Gobolos', '7182009067', 'agoboloss@weibo.com', '4/17/2001', 4, '5197031961', 0);
insert into Students (studentId, firstName, lastName, phoneNumber, email, dateOfBirth, studentYear, emergencyContact, isDeleted) values (30, 'Tam', 'Gossart', '9610368326', 'tgossartt@twitpic.com', '4/5/1999', 4, '1746647083', 0);
insert into Students (studentId, firstName, lastName, phoneNumber, email, dateOfBirth, studentYear, emergencyContact, isDeleted) values (31, 'Selina', 'Edgerley', '1548786582', 'sedgerleyu@eepurl.com', '3/9/2000', 3, '4504131478', 1);
insert into Students (studentId, firstName, lastName, phoneNumber, email, dateOfBirth, studentYear, emergencyContact, isDeleted) values (32, 'Fidela', 'Warrender', '7985795922', 'fwarrenderv@amazon.de', '10/29/2000', 4, '3176390602', 1);
insert into Students (studentId, firstName, lastName, phoneNumber, email, dateOfBirth, studentYear, emergencyContact, isDeleted) values (33, 'Hedwiga', 'Conaghan', '7888240213', 'hconaghanw@dagondesign.com', '10/21/2000', 1, '2864717230', 1);
insert into Students (studentId, firstName, lastName, phoneNumber, email, dateOfBirth, studentYear, emergencyContact, isDeleted) values (34, 'Michel', 'Seakes', '1420943214', 'mseakesx@toplist.cz', '7/3/1998', 4, '2250673174', 1);
GO
SET IDENTITY_INSERT Students OFF
SET IDENTITY_INSERT Properties ON
insert into Properties (propertyId, address, propertyName, bedrooms, bathrooms, numberOfOccupants, maxNumberOfOccupants, squareFootage, isDeleted) values (1, '6898 Del Mar Avenue', 'Ralina', 1, 3, 1, 3, 1552, 0);
insert into Properties (propertyId, address, propertyName, bedrooms, bathrooms, numberOfOccupants, maxNumberOfOccupants, squareFootage, isDeleted) values (2, '76 Melody Drive', 'Elihu', 1, 1, 3, 3, 1037, 0);
insert into Properties (propertyId, address, propertyName, bedrooms, bathrooms, numberOfOccupants, maxNumberOfOccupants, squareFootage, isDeleted) values (3, '61590 Hoffman Street', 'Loralee', 2, 3, 3, 3, 814, 0);
insert into Properties (propertyId, address, propertyName, bedrooms, bathrooms, numberOfOccupants, maxNumberOfOccupants, squareFootage, isDeleted) values (4, '40852 Emmet Trail', 'Spence', 3, 1, 2, 4, 1905, 0);
insert into Properties (propertyId, address, propertyName, bedrooms, bathrooms, numberOfOccupants, maxNumberOfOccupants, squareFootage, isDeleted) values (5, '909 5th Center', 'Fey', 4, 1, 2, 3, 1702, 0);
insert into Properties (propertyId, address, propertyName, bedrooms, bathrooms, numberOfOccupants, maxNumberOfOccupants, squareFootage, isDeleted) values (6, '9 Shasta Avenue', 'Maisie', 4, 1, 3, 4, 1638, 0);
insert into Properties (propertyId, address, propertyName, bedrooms, bathrooms, numberOfOccupants, maxNumberOfOccupants, squareFootage, isDeleted) values (7, '7571 Hauk Park', 'Symon', 2, 1, 2, 4, 965, 0);
insert into Properties (propertyId, address, propertyName, bedrooms, bathrooms, numberOfOccupants, maxNumberOfOccupants, squareFootage, isDeleted) values (8, '0 Mallory Hill', 'Evelina', 2, 2, 1, 3, 1114, 1);
insert into Properties (propertyId, address, propertyName, bedrooms, bathrooms, numberOfOccupants, maxNumberOfOccupants, squareFootage, isDeleted) values (9, '79020 Drewry Drive', 'Pammi', 3, 3, 1, 4, 1737, 1);
insert into Properties (propertyId, address, propertyName, bedrooms, bathrooms, numberOfOccupants, maxNumberOfOccupants, squareFootage, isDeleted) values (10, '714 Jay Place', 'Cori', 4, 1, 2, 4, 1447, 0);
insert into Properties (propertyId, address, propertyName, bedrooms, bathrooms, numberOfOccupants, maxNumberOfOccupants, squareFootage, isDeleted) values (11, '14 Westend Junction', 'Salvatore', 2, 3, 3, 3, 1970, 0);
insert into Properties (propertyId, address, propertyName, bedrooms, bathrooms, numberOfOccupants, maxNumberOfOccupants, squareFootage, isDeleted) values (12, '901 Tomscot Parkway', 'Darrell', 4, 1, 3, 3, 1771, 0);
insert into Properties (propertyId, address, propertyName, bedrooms, bathrooms, numberOfOccupants, maxNumberOfOccupants, squareFootage, isDeleted) values (13, '485 Myrtle Trail', 'Cullan', 4, 2, 2, 3, 1973, 0);
insert into Properties (propertyId, address, propertyName, bedrooms, bathrooms, numberOfOccupants, maxNumberOfOccupants, squareFootage, isDeleted) values (14, '34 Macpherson Street', 'Micheline', 2, 1, 3, 3, 1532, 0);
insert into Properties (propertyId, address, propertyName, bedrooms, bathrooms, numberOfOccupants, maxNumberOfOccupants, squareFootage, isDeleted) values (15, '28625 Debra Plaza', 'Nelson', 3, 3, 1, 4, 1149, 0);
insert into Properties (propertyId, address, propertyName, bedrooms, bathrooms, numberOfOccupants, maxNumberOfOccupants, squareFootage, isDeleted) values (16, '16 Mifflin Hill', 'Sonia', 2, 3, 3, 4, 1754, 0);
insert into Properties (propertyId, address, propertyName, bedrooms, bathrooms, numberOfOccupants, maxNumberOfOccupants, squareFootage, isDeleted) values (17, '3 Springview Park', 'Odessa', 4, 3, 1, 3, 1533, 0);
insert into Properties (propertyId, address, propertyName, bedrooms, bathrooms, numberOfOccupants, maxNumberOfOccupants, squareFootage, isDeleted) values (18, '9 Basil Lane', 'Waldon', 2, 3, 3, 4, 953, 0);
insert into Properties (propertyId, address, propertyName, bedrooms, bathrooms, numberOfOccupants, maxNumberOfOccupants, squareFootage, isDeleted) values (19, '8 Reindahl Point', 'Mahmoud', 2, 3, 1, 3, 915, 0);
insert into Properties (propertyId, address, propertyName, bedrooms, bathrooms, numberOfOccupants, maxNumberOfOccupants, squareFootage, isDeleted) values (20, '6 Dovetail Parkway', 'Meryl', 4, 1, 3, 4, 1451, 1);
insert into Properties (propertyId, address, propertyName, bedrooms, bathrooms, numberOfOccupants, maxNumberOfOccupants, squareFootage, isDeleted) values (21, '25 Anthes Park', 'Omar', 2, 2, 1, 3, 875, 0);
insert into Properties (propertyId, address, propertyName, bedrooms, bathrooms, numberOfOccupants, maxNumberOfOccupants, squareFootage, isDeleted) values (22, '3 Dunning Parkway', 'Cybil', 3, 3, 2, 4, 1209, 0);
insert into Properties (propertyId, address, propertyName, bedrooms, bathrooms, numberOfOccupants, maxNumberOfOccupants, squareFootage, isDeleted) values (23, '14 Fremont Parkway', 'Maud', 1, 2, 3, 4, 1245, 0);
insert into Properties (propertyId, address, propertyName, bedrooms, bathrooms, numberOfOccupants, maxNumberOfOccupants, squareFootage, isDeleted) values (24, '7768 Buell Trail', 'Kat', 2, 3, 3, 4, 1816, 0);
insert into Properties (propertyId, address, propertyName, bedrooms, bathrooms, numberOfOccupants, maxNumberOfOccupants, squareFootage, isDeleted) values (25, '0489 Village Green Lane', 'Alanah', 1, 1, 1, 3, 1956, 0);
insert into Properties (propertyId, address, propertyName, bedrooms, bathrooms, numberOfOccupants, maxNumberOfOccupants, squareFootage, isDeleted) values (26, '5 Graceland Way', 'King', 3, 3, 1, 3, 1731, 0);
insert into Properties (propertyId, address, propertyName, bedrooms, bathrooms, numberOfOccupants, maxNumberOfOccupants, squareFootage, isDeleted) values (27, '72 Mesta Pass', 'Katrinka', 1, 1, 2, 3, 1752, 0);
insert into Properties (propertyId, address, propertyName, bedrooms, bathrooms, numberOfOccupants, maxNumberOfOccupants, squareFootage, isDeleted) values (28, '6815 Farwell Lane', 'Michaella', 4, 3, 2, 4, 1666, 0);
insert into Properties (propertyId, address, propertyName, bedrooms, bathrooms, numberOfOccupants, maxNumberOfOccupants, squareFootage, isDeleted) values (29, '80546 Troy Plaza', 'Arleta', 3, 3, 2, 3, 844, 0);
insert into Properties (propertyId, address, propertyName, bedrooms, bathrooms, numberOfOccupants, maxNumberOfOccupants, squareFootage, isDeleted) values (30, '12518 Sunfield Junction', 'Roana', 2, 2, 2, 4, 1630, 0);
insert into Properties (propertyId, address, propertyName, bedrooms, bathrooms, numberOfOccupants, maxNumberOfOccupants, squareFootage, isDeleted) values (31, '010 Reindahl Drive', 'Latrina', 1, 3, 3, 4, 1141, 0);
insert into Properties (propertyId, address, propertyName, bedrooms, bathrooms, numberOfOccupants, maxNumberOfOccupants, squareFootage, isDeleted) values (32, '757 Vermont Way', 'Sherm', 3, 2, 3, 3, 1834, 0);
insert into Properties (propertyId, address, propertyName, bedrooms, bathrooms, numberOfOccupants, maxNumberOfOccupants, squareFootage, isDeleted) values (33, '4 Homewood Court', 'Bearnard', 3, 2, 3, 3, 1322, 1);
insert into Properties (propertyId, address, propertyName, bedrooms, bathrooms, numberOfOccupants, maxNumberOfOccupants, squareFootage, isDeleted) values (34, '9 Cody Parkway', 'Antonio', 4, 1, 1, 3, 1170, 0);
GO
SET IDENTITY_INSERT Properties OFF
SET IDENTITY_INSERT Leases ON
insert into Leases (leaseId, studentId, deposit, totalCost, leaseStart, leaseEnd, isDamaged, isDeleted) values (1, 1, 816, 2015, '10/21/2019', '5/22/2021', 0, 0);
insert into Leases (leaseId, studentId, deposit, totalCost, leaseStart, leaseEnd, isDamaged, isDeleted) values (2, 2, 812, 1598, '2/25/2020', '5/19/2021', 0, 0);
insert into Leases (leaseId, studentId, deposit, totalCost, leaseStart, leaseEnd, isDamaged, isDeleted) values (3, 3, 600, 2169, '9/3/2019', '2/18/2022', 0, 0);
insert into Leases (leaseId, studentId, deposit, totalCost, leaseStart, leaseEnd, isDamaged, isDeleted) values (4, 4, 798, 2045, '6/8/2019', '1/5/2022', 0, 0);
insert into Leases (leaseId, studentId, deposit, totalCost, leaseStart, leaseEnd, isDamaged, isDeleted) values (5, 5, 527, 2056, '12/6/2019', '4/28/2022', 0, 0);
insert into Leases (leaseId, studentId, deposit, totalCost, leaseStart, leaseEnd, isDamaged, isDeleted) values (6, 6, 702, 1275, '10/30/2019', '9/13/2021', 0, 0);
insert into Leases (leaseId, studentId, deposit, totalCost, leaseStart, leaseEnd, isDamaged, isDeleted) values (7, 7, 639, 1996, '2/21/2020', '2/13/2022', 0, 0);
insert into Leases (leaseId, studentId, deposit, totalCost, leaseStart, leaseEnd, isDamaged, isDeleted) values (8, 8, 908, 2382, '3/24/2020', '3/7/2022', 0, 0);
insert into Leases (leaseId, studentId, deposit, totalCost, leaseStart, leaseEnd, isDamaged, isDeleted) values (9, 9, 976, 1192, '8/1/2019', '12/22/2021', 0, 0);
insert into Leases (leaseId, studentId, deposit, totalCost, leaseStart, leaseEnd, isDamaged, isDeleted) values (10, 10, 905, 1531, '6/26/2019', '3/8/2022', 0, 0);
insert into Leases (leaseId, studentId, deposit, totalCost, leaseStart, leaseEnd, isDamaged, isDeleted) values (11, 11, 626, 2649, '11/26/2019', '8/10/2021', 0, 0);
insert into Leases (leaseId, studentId, deposit, totalCost, leaseStart, leaseEnd, isDamaged, isDeleted) values (12, 12, 879, 2448, '3/6/2020', '7/18/2021', 0, 0);
insert into Leases (leaseId, studentId, deposit, totalCost, leaseStart, leaseEnd, isDamaged, isDeleted) values (13, 13, 844, 1610, '7/23/2019', '9/30/2021', 0, 0);
insert into Leases (leaseId, studentId, deposit, totalCost, leaseStart, leaseEnd, isDamaged, isDeleted) values (14, 14, 820, 1399, '12/7/2019', '12/6/2021', 0, 0);
insert into Leases (leaseId, studentId, deposit, totalCost, leaseStart, leaseEnd, isDamaged, isDeleted) values (15, 15, 745, 2332, '9/16/2019', '2/4/2022', 0, 0);
insert into Leases (leaseId, studentId, deposit, totalCost, leaseStart, leaseEnd, isDamaged, isDeleted) values (16, 16, 917, 2893, '10/28/2019', '3/31/2022', 0, 0);
insert into Leases (leaseId, studentId, deposit, totalCost, leaseStart, leaseEnd, isDamaged, isDeleted) values (17, 17, 981, 1238, '6/14/2019', '2/13/2022', 0, 0);
insert into Leases (leaseId, studentId, deposit, totalCost, leaseStart, leaseEnd, isDamaged, isDeleted) values (18, 18, 768, 1713, '12/10/2019', '5/9/2021', 0, 0);
insert into Leases (leaseId, studentId, deposit, totalCost, leaseStart, leaseEnd, isDamaged, isDeleted) values (19, 19, 569, 2119, '1/28/2020', '1/28/2022', 0, 0);
insert into Leases (leaseId, studentId, deposit, totalCost, leaseStart, leaseEnd, isDamaged, isDeleted) values (20, 20, 645, 1128, '3/16/2020', '3/29/2022', 0, 0);
insert into Leases (leaseId, studentId, deposit, totalCost, leaseStart, leaseEnd, isDamaged, isDeleted) values (21, 21, 672, 1027, '3/24/2020', '11/22/2021', 0, 0);
insert into Leases (leaseId, studentId, deposit, totalCost, leaseStart, leaseEnd, isDamaged, isDeleted) values (22, 22, 656, 1310, '12/14/2019', '9/4/2021', 0, 0);
insert into Leases (leaseId, studentId, deposit, totalCost, leaseStart, leaseEnd, isDamaged, isDeleted) values (23, 23, 646, 1705, '3/23/2020', '5/28/2021', 0, 0);
insert into Leases (leaseId, studentId, deposit, totalCost, leaseStart, leaseEnd, isDamaged, isDeleted) values (24, 24, 885, 1627, '10/31/2019', '9/2/2021', 0, 0);
insert into Leases (leaseId, studentId, deposit, totalCost, leaseStart, leaseEnd, isDamaged, isDeleted) values (25, 25, 743, 1316, '8/9/2019', '4/25/2022', 0, 0);
insert into Leases (leaseId, studentId, deposit, totalCost, leaseStart, leaseEnd, isDamaged, isDeleted) values (26, 26, 942, 1024, '4/10/2020', '5/2/2022', 0, 0);
insert into Leases (leaseId, studentId, deposit, totalCost, leaseStart, leaseEnd, isDamaged, isDeleted) values (27, 27, 897, 2743, '10/13/2019', '6/11/2021', 0, 0);
insert into Leases (leaseId, studentId, deposit, totalCost, leaseStart, leaseEnd, isDamaged, isDeleted) values (28, 28, 677, 1624, '8/9/2019', '2/7/2022', 0, 0);
insert into Leases (leaseId, studentId, deposit, totalCost, leaseStart, leaseEnd, isDamaged, isDeleted) values (29, 29, 612, 1675, '2/24/2020', '11/19/2021', 0, 0);
insert into Leases (leaseId, studentId, deposit, totalCost, leaseStart, leaseEnd, isDamaged, isDeleted) values (30, 30, 721, 1622, '7/8/2019', '1/17/2022', 0, 0);
insert into Leases (leaseId, studentId, deposit, totalCost, leaseStart, leaseEnd, isDamaged, isDeleted) values (31, 31, 881, 1713, '2/24/2020', '6/11/2021', 0, 0);
insert into Leases (leaseId, studentId, deposit, totalCost, leaseStart, leaseEnd, isDamaged, isDeleted) values (32, 32, 820, 1903, '11/3/2019', '9/7/2021', 0, 0);
insert into Leases (leaseId, studentId, deposit, totalCost, leaseStart, leaseEnd, isDamaged, isDeleted) values (33, 33, 598, 2497, '5/19/2019', '6/13/2021', 0, 0);
insert into Leases (leaseId, studentId, deposit, totalCost, leaseStart, leaseEnd, isDamaged, isDeleted) values (34, 34, 564, 1531, '5/12/2019', '2/23/2022', 0, 0);
GO
SET IDENTITY_INSERT Leases OFF
SET IDENTITY_INSERT Owners ON
insert into Owners (ownerId, companyName, firstName, lastName, phoneNumber, email, officeLocation, isDeleted) values (1, 'Graham-Gerlach', 'Eugenia', 'Pietri', '196-438-4446', 'epietri0@mayoclinic.com', '6466 Bayside Trail', 0);
insert into Owners (ownerId, companyName, firstName, lastName, phoneNumber, email, officeLocation, isDeleted) values (2, 'Waelchi, Rohan and Witting', 'Delmore', 'Keller', '145-898-5293', 'dkeller1@shutterfly.com', '63255 Dennis Street', 0);
insert into Owners (ownerId, companyName, firstName, lastName, phoneNumber, email, officeLocation, isDeleted) values (3, 'Wunsch-Denesik', 'Leone', 'Wentworth', '904-400-5880', 'lwentworth2@state.tx.us', '4956 Old Shore Pass', 0);
insert into Owners (ownerId, companyName, firstName, lastName, phoneNumber, email, officeLocation, isDeleted) values (4, 'Walsh, Connelly and Lang', 'Rene', 'Jerromes', '387-992-6348', 'rjerromes3@yellowbook.com', '75 Carey Parkway', 0);
insert into Owners (ownerId, companyName, firstName, lastName, phoneNumber, email, officeLocation, isDeleted) values (5, 'Macejkovic-Gleason', 'Maje', 'Warrener', '596-736-9918', 'mwarrener4@webmd.com', '0 Miller Street', 0);
insert into Owners (ownerId, companyName, firstName, lastName, phoneNumber, email, officeLocation, isDeleted) values (6, 'Feil Inc', 'Delinda', 'Mar', '692-135-1001', 'dmar5@unicef.org', '5 Blue Bill Park Hill', 0);
insert into Owners (ownerId, companyName, firstName, lastName, phoneNumber, email, officeLocation, isDeleted) values (7, 'Kuvalis Inc', 'Karen', 'Buscombe', '788-738-3521', 'kbuscombe6@utexas.edu', '82832 Michigan Center', 0);
insert into Owners (ownerId, companyName, firstName, lastName, phoneNumber, email, officeLocation, isDeleted) values (8, 'Witting Inc', 'Rosalie', 'Boshers', '324-285-1993', 'rboshers7@tripadvisor.com', '4 Steensland Way', 0);
insert into Owners (ownerId, companyName, firstName, lastName, phoneNumber, email, officeLocation, isDeleted) values (9, 'Cole Group', 'Claus', 'Jennemann', '523-152-7513', 'cjennemann8@studiopress.com', '3 6th Trail', 0);
insert into Owners (ownerId, companyName, firstName, lastName, phoneNumber, email, officeLocation, isDeleted) values (10, 'D''Amore, Konopelski and Boehm', 'Malynda', 'Dodson', '356-594-6427', 'mdodson9@timesonline.co.uk', '1 Crowley Drive', 0);
insert into Owners (ownerId, companyName, firstName, lastName, phoneNumber, email, officeLocation, isDeleted) values (11, 'Heidenreich, Nienow and Nicolas', 'Kermie', 'Espinos', '694-908-9541', 'kespinosa@goodreads.com', '45 Shopko Road', 0);
insert into Owners (ownerId, companyName, firstName, lastName, phoneNumber, email, officeLocation, isDeleted) values (12, 'Nikolaus LLC', 'Donall', 'Nickolls', '301-881-6039', 'dnickollsb@google.ru', '07761 Bobwhite Alley', 0);
insert into Owners (ownerId, companyName, firstName, lastName, phoneNumber, email, officeLocation, isDeleted) values (13, 'Tremblay LLC', 'Elbert', 'Sollas', '488-373-2680', 'esollasc@nps.gov', '6 Boyd Point', 0);
insert into Owners (ownerId, companyName, firstName, lastName, phoneNumber, email, officeLocation, isDeleted) values (14, 'O''Conner and Sons', 'Artemus', 'Sollam', '685-385-8809', 'asollamd@zdnet.com', '97 Basil Avenue', 0);
insert into Owners (ownerId, companyName, firstName, lastName, phoneNumber, email, officeLocation, isDeleted) values (15, 'Mohr-Stanton', 'Shermie', 'Kennagh', '424-253-6504', 'skennaghe@photobucket.com', '54 Corscot Parkway', 0);
insert into Owners (ownerId, companyName, firstName, lastName, phoneNumber, email, officeLocation, isDeleted) values (16, 'Kshlerin Group', 'Casandra', 'Shanley', '325-878-6478', 'cshanleyf@wikimedia.org', '330 Bartillon Pass', 0);
insert into Owners (ownerId, companyName, firstName, lastName, phoneNumber, email, officeLocation, isDeleted) values (17, 'Metz-Bode', 'Willie', 'Kesten', '475-303-4771', 'wkesteng@army.mil', '960 Beilfuss Road', 0);
insert into Owners (ownerId, companyName, firstName, lastName, phoneNumber, email, officeLocation, isDeleted) values (18, 'Nolan-Wilderman', 'Nichole', 'Pocknoll', '577-248-6325', 'npocknollh@ed.gov', '7 Harbort Trail', 0);
insert into Owners (ownerId, companyName, firstName, lastName, phoneNumber, email, officeLocation, isDeleted) values (19, 'Nikolaus-Howell', 'Brand', 'Verling', '919-112-1542', 'bverlingi@jimdo.com', '1196 Tennessee Parkway', 0);
insert into Owners (ownerId, companyName, firstName, lastName, phoneNumber, email, officeLocation, isDeleted) values (20, 'Barton, Lubowitz and Moen', 'Beltran', 'Dutson', '867-894-5176', 'bdutsonj@soundcloud.com', '2 Mockingbird Junction', 0);
insert into Owners (ownerId, companyName, firstName, lastName, phoneNumber, email, officeLocation, isDeleted) values (21, 'Ankunding, Runolfsson and Kihn', 'Libbi', 'Jenkins', '458-461-6153', 'ljenkinsk@slideshare.net', '8941 Stuart Trail', 0);
insert into Owners (ownerId, companyName, firstName, lastName, phoneNumber, email, officeLocation, isDeleted) values (22, 'Mayert Group', 'Halli', 'Martini', '496-750-0714', 'hmartinil@canalblog.com', '276 Lakeland Avenue', 0);
insert into Owners (ownerId, companyName, firstName, lastName, phoneNumber, email, officeLocation, isDeleted) values (23, 'Leffler and Sons', 'Matty', 'Pinnock', '214-449-9321', 'mpinnockm@cafepress.com', '2777 Loomis Crossing', 0);
insert into Owners (ownerId, companyName, firstName, lastName, phoneNumber, email, officeLocation, isDeleted) values (24, 'Grimes Group', 'Sergent', 'Bolletti', '172-324-8730', 'sbollettin@msu.edu', '334 Lighthouse Bay Trail', 0);
insert into Owners (ownerId, companyName, firstName, lastName, phoneNumber, email, officeLocation, isDeleted) values (25, 'Mayert-McClure', 'Dewain', 'David', '283-730-6497', 'ddavido@sciencedirect.com', '1178 Clove Circle', 0);
insert into Owners (ownerId, companyName, firstName, lastName, phoneNumber, email, officeLocation, isDeleted) values (26, 'Lowe, Hansen and Purdy', 'Ephraim', 'Stuck', '815-383-2371', 'estuckp@netlog.com', '04855 Spohn Court', 0);
insert into Owners (ownerId, companyName, firstName, lastName, phoneNumber, email, officeLocation, isDeleted) values (27, 'Collins LLC', 'Fitz', 'Boyett', '396-763-0312', 'fboyettq@patch.com', '167 Anzinger Court', 0);
insert into Owners (ownerId, companyName, firstName, lastName, phoneNumber, email, officeLocation, isDeleted) values (28, 'Reichel Group', 'Maisey', 'Dudlestone', '181-391-7797', 'mdudlestoner@huffingtonpost.com', '13 Stoughton Trail', 0);
insert into Owners (ownerId, companyName, firstName, lastName, phoneNumber, email, officeLocation, isDeleted) values (29, 'Schiller Group', 'Dacy', 'Pedrick', '170-292-5531', 'dpedricks@virginia.edu', '65333 Thierer Alley', 0);
insert into Owners (ownerId, companyName, firstName, lastName, phoneNumber, email, officeLocation, isDeleted) values (30, 'Berge Group', 'Nico', 'Whitlam', '678-368-8455', 'nwhitlamt@salon.com', '2 Jenifer Place', 0);
insert into Owners (ownerId, companyName, firstName, lastName, phoneNumber, email, officeLocation, isDeleted) values (31, 'Volkman-Grady', 'Merell', 'Metheringham', '486-875-9115', 'mmetheringhamu@nyu.edu', '70437 Village Lane', 0);
insert into Owners (ownerId, companyName, firstName, lastName, phoneNumber, email, officeLocation, isDeleted) values (32, 'Rosenbaum, Crooks and Watsica', 'Dylan', 'Keary', '345-245-0308', 'dkearyv@edublogs.org', '33 Logan Alley', 0);
insert into Owners (ownerId, companyName, firstName, lastName, phoneNumber, email, officeLocation, isDeleted) values (33, 'Mosciski-Heidenreich', 'Silvie', 'Whittleton', '511-483-3773', 'swhittletonw@google.pl', '0411 Morrow Avenue', 0);
insert into Owners (ownerId, companyName, firstName, lastName, phoneNumber, email, officeLocation, isDeleted) values (34, 'Jenkins, Streich and Rosenbaum', 'Mignon', 'Jiras', '983-320-7245', 'mjirasx@yale.edu', '2 Leroy Trail', 0);
GO 
SET IDENTITY_INSERT Owners OFF
SET IDENTITY_INSERT Payments ON

insert into Payments (paymentId, studentId, leaseId, paymentType, paymentDate, paymentAmount, isDeleted) values (1, 1, 1, 'Eamon', '3/8/2020', 181, 0);
insert into Payments (paymentId, studentId, leaseId, paymentType, paymentDate, paymentAmount, isDeleted) values (2, 2, 2, 'Finn', '10/26/2019', 583, 0);
insert into Payments (paymentId, studentId, leaseId, paymentType, paymentDate, paymentAmount, isDeleted) values (3, 3, 3, 'Ki', '8/10/2019', 635, 0);
insert into Payments (paymentId, studentId, leaseId, paymentType, paymentDate, paymentAmount, isDeleted) values (4, 4, 4, 'Lorain', '8/28/2019', 600, 0);
insert into Payments (paymentId, studentId, leaseId, paymentType, paymentDate, paymentAmount, isDeleted) values (5, 5, 5, 'Ola', '8/14/2019', 309, 0);
insert into Payments (paymentId, studentId, leaseId, paymentType, paymentDate, paymentAmount, isDeleted) values (6, 6, 6, 'Jennine', '8/27/2019', 597, 0);
insert into Payments (paymentId, studentId, leaseId, paymentType, paymentDate, paymentAmount, isDeleted) values (7, 7, 7, 'Tobey', '10/24/2019', 410, 0);
insert into Payments (paymentId, studentId, leaseId, paymentType, paymentDate, paymentAmount, isDeleted) values (8, 8, 8, 'Arlan', '6/11/2019', 718, 0);
insert into Payments (paymentId, studentId, leaseId, paymentType, paymentDate, paymentAmount, isDeleted) values (9, 9, 9, 'Pat', '1/1/2020', 364, 0);
insert into Payments (paymentId, studentId, leaseId, paymentType, paymentDate, paymentAmount, isDeleted) values (10, 10, 10, 'Mady', '10/1/2019', 526, 0);
insert into Payments (paymentId, studentId, leaseId, paymentType, paymentDate, paymentAmount, isDeleted) values (11, 11, 11, 'Tiffi', '4/19/2020', 738, 0);
insert into Payments (paymentId, studentId, leaseId, paymentType, paymentDate, paymentAmount, isDeleted) values (12, 12, 12, 'Kalie', '9/13/2019', 461, 0);
insert into Payments (paymentId, studentId, leaseId, paymentType, paymentDate, paymentAmount, isDeleted) values (13, 13, 13, 'Ardelia', '10/3/2019', 460, 0);
insert into Payments (paymentId, studentId, leaseId, paymentType, paymentDate, paymentAmount, isDeleted) values (14, 14, 14, 'Beltran', '8/21/2019', 689, 0);
insert into Payments (paymentId, studentId, leaseId, paymentType, paymentDate, paymentAmount, isDeleted) values (15, 15, 15, 'Cesaro', '11/29/2019', 103, 0);
insert into Payments (paymentId, studentId, leaseId, paymentType, paymentDate, paymentAmount, isDeleted) values (16, 16, 16, 'Wylie', '1/31/2020', 477, 0);
insert into Payments (paymentId, studentId, leaseId, paymentType, paymentDate, paymentAmount, isDeleted) values (17, 17, 17, 'Idalina', '8/30/2019', 165, 0);
insert into Payments (paymentId, studentId, leaseId, paymentType, paymentDate, paymentAmount, isDeleted) values (18, 18, 18, 'Harland', '12/26/2019', 321, 0);
insert into Payments (paymentId, studentId, leaseId, paymentType, paymentDate, paymentAmount, isDeleted) values (19, 19, 19, 'Woodrow', '11/18/2019', 547, 0);
insert into Payments (paymentId, studentId, leaseId, paymentType, paymentDate, paymentAmount, isDeleted) values (20, 20, 20, 'Pierce', '1/13/2020', 401, 0);
insert into Payments (paymentId, studentId, leaseId, paymentType, paymentDate, paymentAmount, isDeleted) values (21, 21, 21, 'Ekaterina', '3/29/2020', 170, 0);
insert into Payments (paymentId, studentId, leaseId, paymentType, paymentDate, paymentAmount, isDeleted) values (22, 22, 22, 'Page', '7/17/2019', 643, 0);
insert into Payments (paymentId, studentId, leaseId, paymentType, paymentDate, paymentAmount, isDeleted) values (23, 23, 23, 'Doreen', '11/28/2019', 248, 0);
insert into Payments (paymentId, studentId, leaseId, paymentType, paymentDate, paymentAmount, isDeleted) values (24, 24, 24, 'Kristian', '2/24/2020', 354, 0);
insert into Payments (paymentId, studentId, leaseId, paymentType, paymentDate, paymentAmount, isDeleted) values (25, 25, 25, 'Dolores', '11/14/2019', 501, 0);
insert into Payments (paymentId, studentId, leaseId, paymentType, paymentDate, paymentAmount, isDeleted) values (26, 26, 26, 'Katharina', '9/10/2019', 533, 0);
insert into Payments (paymentId, studentId, leaseId, paymentType, paymentDate, paymentAmount, isDeleted) values (27, 27, 27, 'Mirella', '6/14/2019', 204, 0);
insert into Payments (paymentId, studentId, leaseId, paymentType, paymentDate, paymentAmount, isDeleted) values (28, 28, 28, 'Artemus', '5/28/2019', 201, 0);
insert into Payments (paymentId, studentId, leaseId, paymentType, paymentDate, paymentAmount, isDeleted) values (29, 29, 29, 'Marlo', '8/26/2019', 626, 0);
insert into Payments (paymentId, studentId, leaseId, paymentType, paymentDate, paymentAmount, isDeleted) values (30, 30, 30, 'Esther', '2/4/2020', 482, 0);
insert into Payments (paymentId, studentId, leaseId, paymentType, paymentDate, paymentAmount, isDeleted) values (31, 31, 31, 'Clarence', '9/6/2019', 134, 0);
insert into Payments (paymentId, studentId, leaseId, paymentType, paymentDate, paymentAmount, isDeleted) values (32, 32, 32, 'Elvina', '8/28/2019', 156, 0);
insert into Payments (paymentId, studentId, leaseId, paymentType, paymentDate, paymentAmount, isDeleted) values (33, 33, 33, 'Constancy', '6/1/2019', 674, 0);
insert into Payments (paymentId, studentId, leaseId, paymentType, paymentDate, paymentAmount, isDeleted) values (34, 34, 34, 'Roz', '9/5/2019', 769, 0);
SET IDENTITY_INSERT Payments OFF
insert into PropertyOwners (propertyId, ownerId) values (1, 1);
insert into PropertyOwners (propertyId, ownerId) values (2, 2);
insert into PropertyOwners (propertyId, ownerId) values (3, 3);
insert into PropertyOwners (propertyId, ownerId) values (4, 4);
insert into PropertyOwners (propertyId, ownerId) values (5, 5);
insert into PropertyOwners (propertyId, ownerId) values (6, 6);
insert into PropertyOwners (propertyId, ownerId) values (7, 7);
insert into PropertyOwners (propertyId, ownerId) values (8, 8);
insert into PropertyOwners (propertyId, ownerId) values (9, 9);
insert into PropertyOwners (propertyId, ownerId) values (10, 10);
insert into PropertyOwners (propertyId, ownerId) values (11, 11);
insert into PropertyOwners (propertyId, ownerId) values (12, 12);
insert into PropertyOwners (propertyId, ownerId) values (13, 13);
insert into PropertyOwners (propertyId, ownerId) values (14, 14);
insert into PropertyOwners (propertyId, ownerId) values (15, 15);
insert into PropertyOwners (propertyId, ownerId) values (16, 16);
insert into PropertyOwners (propertyId, ownerId) values (17, 17);
insert into PropertyOwners (propertyId, ownerId) values (18, 18);
insert into PropertyOwners (propertyId, ownerId) values (19, 19);
insert into PropertyOwners (propertyId, ownerId) values (20, 20);
insert into PropertyOwners (propertyId, ownerId) values (21, 21);
insert into PropertyOwners (propertyId, ownerId) values (22, 22);
insert into PropertyOwners (propertyId, ownerId) values (23, 23);
insert into PropertyOwners (propertyId, ownerId) values (24, 24);
insert into PropertyOwners (propertyId, ownerId) values (25, 25);
insert into PropertyOwners (propertyId, ownerId) values (26, 26);
insert into PropertyOwners (propertyId, ownerId) values (27, 27);
insert into PropertyOwners (propertyId, ownerId) values (28, 28);
insert into PropertyOwners (propertyId, ownerId) values (29, 29);
insert into PropertyOwners (propertyId, ownerId) values (30, 30);
insert into PropertyOwners (propertyId, ownerId) values (31, 31);
insert into PropertyOwners (propertyId, ownerId) values (32, 32);
insert into PropertyOwners (propertyId, ownerId) values (33, 33);
insert into PropertyOwners (propertyId, ownerId) values (34, 34);
insert into RentalData (propertyId, leaseId) values (32, 1);
insert into RentalData (propertyId, leaseId) values (11, 2);
insert into RentalData (propertyId, leaseId) values (31, 3);
insert into RentalData (propertyId, leaseId) values (7, 4);
insert into RentalData (propertyId, leaseId) values (29, 5);
insert into RentalData (propertyId, leaseId) values (10, 6);
insert into RentalData (propertyId, leaseId) values (5, 7);
insert into RentalData (propertyId, leaseId) values (3, 8);
insert into RentalData (propertyId, leaseId) values (5, 9);
insert into RentalData (propertyId, leaseId) values (29, 10);
insert into RentalData (propertyId, leaseId) values (14, 11);
insert into RentalData (propertyId, leaseId) values (15, 12);
insert into RentalData (propertyId, leaseId) values (24, 13);
insert into RentalData (propertyId, leaseId) values (13, 14);
insert into RentalData (propertyId, leaseId) values (16, 15);
insert into RentalData (propertyId, leaseId) values (21, 16);
insert into RentalData (propertyId, leaseId) values (1, 17);
insert into RentalData (propertyId, leaseId) values (9, 18);
insert into RentalData (propertyId, leaseId) values (27, 19);
insert into RentalData (propertyId, leaseId) values (23, 20);
insert into RentalData (propertyId, leaseId) values (21, 21);
insert into RentalData (propertyId, leaseId) values (23, 22);
insert into RentalData (propertyId, leaseId) values (6, 23);
insert into RentalData (propertyId, leaseId) values (8, 24);
insert into RentalData (propertyId, leaseId) values (20, 25);
insert into RentalData (propertyId, leaseId) values (31, 26);
insert into RentalData (propertyId, leaseId) values (4, 27);
insert into RentalData (propertyId, leaseId) values (12, 28);
insert into RentalData (propertyId, leaseId) values (10, 29);
insert into RentalData (propertyId, leaseId) values (33, 30);
insert into RentalData (propertyId, leaseId) values (6, 31);
insert into RentalData (propertyId, leaseId) values (4, 32);
insert into RentalData (propertyId, leaseId) values (22, 33);
insert into RentalData (propertyId, leaseId) values (20, 34);
GO 
/************************************************************************************************************  
											CREATE VIEWS
*************************************************************************************************************/

CREATE VIEW vwProperties AS 
	SELECT propertyId, address, propertyName, numberOfOccupants
	FROM Properties
	WHERE isDeleted = 0 
GO

CREATE VIEW vwOwner AS 
	SELECT ownerId, companyName, phoneNumber, email, officeLocation
	FROM Owners
	WHERE isDeleted = 0
GO

CREATE VIEW vwStudents AS 
	SELECT studentId, firstName, lastName, email, phoneNumber
	FROM Students
	WHERE isDeleted = 0
GO

CREATE VIEW vwPayments AS 
	SELECT paymentId, studentId, leaseId, paymentType, paymentDate, paymentAmount
	FROM Payments
	WHERE isDeleted = 0
GO

CREATE VIEW vwLeases AS 
	SELECT leaseId, studentId, deposit, totalCost, leaseStart, leaseEnd
	FROM Leases
	WHERE isDeleted = 0
GO

/************************************************************************************************************  
										CREATE STORED PROCEDURES
*************************************************************************************************************/
/* =====================================================================

	Name:           spAddUpdateDeleteStudent
	Purpose:        Adds/Updates/Deletes a student to/from the database.

======================================================================== */
CREATE PROCEDURE spAddUpdateDeleteStudent
    @studentId	    	INT,
    @firstName			VARCHAR(30),
	@lastName			VARCHAR(30),
	@phoneNumber		VARCHAR(10),
	@email				VARCHAR(30),
    @dateOfBirth     	DATE, 
    @studentYear     	INT,
    @emergencyContact 	VARCHAR(10),
	@isDeleted			BIT,
	@delete				BIT
AS BEGIN

	BEGIN TRY
		IF(@studentId = 0) BEGIN			-- ADD STUDENT
			
			INSERT	INTO 	Students(firstName, lastName, phoneNumber, email, dateOfBirth, studentYear, emergencyContact) 
					VALUES 			(@firstName, @lastName, @phoneNumber, @email, @dateOfBirth, @studentYear, @emergencyContact)

			SELECT	@@IDENTITY AS studentId,
					[success] = CAST(1 AS BIT)

		END ELSE IF(@delete = 1) BEGIN	-- DELETE STUDENT

			IF NOT EXISTS (SELECT NULL FROM Students WHERE studentId = @studentId) BEGIN
				SELECT	[message] = 'Student does not exist.', 
						[success] = CAST(0 AS BIT)
			END ELSE BEGIN

				DELETE FROM Students WHERE studentId = @studentId
				SELECT	0 AS studentId,
						[success] = CAST(1 AS BIT)

			END

		END ELSE BEGIN					-- UPDATE Student

			IF NOT EXISTS (SELECT NULL FROM Students WHERE studentId = @studentId) BEGIN
				SELECT	[message] = 'That student does not exist.', 
						[success] = CAST(0 AS BIT)
			END ELSE BEGIN
	
				UPDATE Students
				SET firstName = @firstName,
					lastName = @lastName,
					phoneNumber = @phoneNumber,
					email = @email,
					dateOfBirth = @dateOfBirth,
					studentYear = @studentYear,
					emergencyContact = @emergencyContact,
					isDeleted = @isDeleted
				WHERE studentId = @studentId
				SELECT	@studentId AS studentId,
						[success] = CAST(1 AS BIT)

			END
		END

	END TRY BEGIN CATCH

		IF(@@TRANCOUNT > 0) ROLLBACK TRAN

	END CATCH

	IF(@@TRANCOUNT > 0) COMMIT TRAN

END
GO

/* =====================================================================

	Name:           spAddUpdateDeleteProperty
	Purpose:        Adds/Updates/Deletes a property to/from the database.

======================================================================== */
CREATE PROCEDURE spAddUpdateDeleteProperty
    @propertyId          INT, 
    @address             VARCHAR(200), 
    @propertyName        VARCHAR(30), 
    @bedrooms            INT, 
    @bathrooms           INT, 
    @numberOfOccupants   INT, 
    @squareFootage       INT,
	@isDeleted			 BIT,
	@delete				 BIT
AS BEGIN

	BEGIN TRY
		IF(@propertyId = 0) BEGIN			-- ADD PROPERTY
			
			INSERT	INTO Properties(propertyId, address, propertyName, bedrooms, bathrooms, numberOfOccupants, squareFootage) 
					VALUES (@propertyId, @address, @propertyName, @bedrooms, @bathrooms, @numberOfOccupants, @squareFootage)

			SELECT	@@IDENTITY AS propertyId,
					[success] = CAST(1 AS BIT)

		END ELSE IF(@delete = 1) BEGIN	-- DELETE PROPERTY

			IF NOT EXISTS (SELECT NULL FROM Properties WHERE propertyId = @propertyId) BEGIN
				SELECT	[message] = 'Property does not exist.', 
						[success] = CAST(0 AS BIT)
			END ELSE BEGIN

				DELETE FROM Properties WHERE propertyId = @propertyId
				SELECT	0 AS propertyId,
						[success] = CAST(1 AS BIT)

			END

		END ELSE BEGIN					-- UPDATE PROPERTY

			IF NOT EXISTS (SELECT NULL FROM Properties WHERE propertyId = @propertyId) BEGIN
				SELECT	[message] = 'Property does not exist.', 
						[success] = CAST(0 AS BIT)
			END ELSE BEGIN

				UPDATE Properties
				SET address = @address,
					propertyName = @propertyName,
					bedrooms = @bedrooms,
					bathrooms = @bathrooms,
					numberOfOccupants = @numberOfOccupants,
					squareFootage = @squareFootage,
					isDeleted = @isDeleted
				WHERE propertyId = @propertyId
				SELECT	@propertyId AS propertyId,
						[success] = CAST(1 AS BIT)

			END
		END

	END TRY BEGIN CATCH

		IF(@@TRANCOUNT > 0) ROLLBACK TRAN

	END CATCH

	IF(@@TRANCOUNT > 0) COMMIT TRAN

END
GO

/* =====================================================================

	Name:           spAddUpdateDeleteOwner
	Purpose:        Adds/Updates/Deletes an owner to/from the database.

======================================================================== */
CREATE PROCEDURE spAddUpdateDeleteOwner
    @ownerId			INT,
	@companyName		VARCHAR(30),
	@firstName			VARCHAR(30),
	@lastName			VARCHAR(30),
	@phoneNumber		VARCHAR(10),
	@email				VARCHAR(30),
	@officeLocation		VARCHAR(30),
	@isDeleted			BIT,
	@delete				BIT
AS BEGIN

	BEGIN TRY
		IF(@ownerId = 0) BEGIN			-- ADD OWNER
			
			INSERT	INTO Owners(ownerId, companyName, firstName, lastName, phoneNumber, email, officeLocation) 
					VALUES (@ownerId, @companyName, @firstName, @lastName, @phoneNumber, @email, @officeLocation)

			SELECT	@@IDENTITY AS ownerId,
					[success] = CAST(1 AS BIT)

		END ELSE IF(@delete = 1) BEGIN	-- DELETE OWNER

			IF NOT EXISTS (SELECT NULL FROM Owners WHERE ownerId = @ownerId) BEGIN
				SELECT	[message] = 'Owner does not exist.', 
						[success] = CAST(0 AS BIT)
			END ELSE BEGIN

				DELETE FROM Owners WHERE ownerId = @ownerId
				SELECT	0 AS ownerId,
						[success] = CAST(1 AS BIT)

			END

		END ELSE BEGIN					-- UPDATE Owner

			IF NOT EXISTS (SELECT NULL FROM Owners WHERE ownerId = @ownerId) BEGIN
				SELECT	[message] = 'Owner does not exist.', 
						[success] = CAST(0 AS BIT)
			END ELSE BEGIN

				UPDATE Owners
				SET companyName = @companyName,
					firstName = @firstName,
					lastName = @lastName,
					phoneNumber = @phoneNumber,
					email = @email,
					officeLocation = @officeLocation,
					isDeleted = @isDeleted
				WHERE ownerId = @ownerId
				SELECT	@ownerId AS ownerId,
						[success] = CAST(1 AS BIT)

			END
		END

	END TRY BEGIN CATCH

		IF(@@TRANCOUNT > 0) ROLLBACK TRAN

	END CATCH

	IF(@@TRANCOUNT > 0) COMMIT TRAN

END
GO

/* =====================================================================

	Name:           spAddUpdateDeletePayment
	Purpose:        Adds/Updates/Deletes a payment to/from the database.

======================================================================== */
CREATE PROCEDURE spAddUpdateDeletePayment
    @paymentId				INT,
	@studentId				INT,
	@leaseId				INT,
	@paymentType		    VARCHAR(30),
	@paymentDate		    DATETIME,
	@paymentAmount			FLOAT,
	@isDeleted				BIT,
	@delete					BIT
AS BEGIN

	BEGIN TRY
		IF(@paymentId = 0) BEGIN			-- ADD PAYMENT
			
			INSERT	INTO Payments(paymentId, studentId, leaseId, paymentType, paymentDate, paymentAmount) 
					VALUES (@paymentId, @studentId, @leaseId, @paymentType, @paymentDate, @paymentAmount)

			SELECT	@@IDENTITY AS paymentId,
					[success] = CAST(1 AS BIT)

		END ELSE IF(@delete = 1) BEGIN	-- DELETE PAYMENT

			IF NOT EXISTS (SELECT NULL FROM Payments WHERE paymentId = @paymentId) BEGIN
				SELECT	[message] = 'Payment does not exist.', 
						[success] = CAST(0 AS BIT)
			END ELSE BEGIN

				DELETE FROM Payments WHERE paymentId = @paymentId
				SELECT	0 AS paymentId,
						[success] = CAST(1 AS BIT)

			END

		END ELSE BEGIN					-- UPDATE PAYMENT

			IF NOT EXISTS (SELECT NULL FROM Payments WHERE paymentId = @paymentId) BEGIN
				SELECT	[message] = 'Payment does not exist.', 
						[success] = CAST(0 AS BIT)
			END ELSE BEGIN

				UPDATE Payments
				SET studentId = @studentId,
					leaseId = @leaseId,
					paymentType = @paymentType,
					paymentDate = @paymentDate,
					paymentAmount = @paymentAmount,
					isDeleted = @isDeleted
				WHERE paymentId = @paymentId
				SELECT	@paymentId AS paymentId,
						[success] = CAST(1 AS BIT)

			END
		END

	END TRY BEGIN CATCH

		IF(@@TRANCOUNT > 0) ROLLBACK TRAN

	END CATCH

	IF(@@TRANCOUNT > 0) COMMIT TRAN

END
GO

/* =====================================================================

	Name:           spAddUpdateDeleteLeases
	Purpose:        Adds/Updates/Deletes a lease to/from the database.

======================================================================== */
CREATE PROCEDURE spAddUpdateDeleteLeases
    @leaseId		INT,
    @studentId		INT,
	@deposit		FLOAT,
	@totalCost		FLOAT,
	@leaseStart		DATETIME,
	@leaseEnd		DATETIME,
	@isDamaged		BIT,
	@isDeleted		BIT,
	@delete			BIT
AS BEGIN

	BEGIN TRY
		IF(@leaseId = 0) BEGIN			-- ADD PAYMENT
			
			INSERT	INTO Leases(studentId, deposit, totalCost, leaseStart, leaseEnd, isDamaged) 
					VALUES (@studentId, @deposit, @totalCost, @leaseStart, @leaseEnd, @isDamaged)

			SELECT	@@IDENTITY AS studentId,
					[success] = CAST(1 AS BIT)

		END ELSE IF(@delete = 1) BEGIN	-- DELETE PAYMENT

			IF NOT EXISTS (SELECT NULL FROM Leases WHERE leaseId = @leaseId) BEGIN
				SELECT	[message] = 'Lease does not exist.', 
						[success] = CAST(0 AS BIT)
			END ELSE BEGIN

				DELETE FROM Leases WHERE leaseId = @leaseId
				SELECT	0 AS leaseId,
						[success] = CAST(1 AS BIT)

			END

		END ELSE BEGIN					-- UPDATE PAYMENT

			IF NOT EXISTS (SELECT NULL FROM Leases WHERE leaseId = @leaseId) BEGIN
				SELECT	[message] = 'Lease does not exist.', 
						[success] = CAST(0 AS BIT)
			END ELSE BEGIN

				UPDATE Leases
				SET	studentId = @studentId,
					deposit = @deposit,
					totalCost = @totalCost,
					leaseStart = @leaseStart,
					leaseEnd = @leaseEnd,
					isDamaged = @isDamaged,
					isDeleted = @isDeleted
				SELECT	@leaseId AS leaseId,
						[success] = CAST(1 AS BIT)

			END
		END

	END TRY BEGIN CATCH

		IF(@@TRANCOUNT > 0) ROLLBACK TRAN

	END CATCH

	IF(@@TRANCOUNT > 0) COMMIT TRAN

END
GO

/* =====================================================================

	Name:           spGetPropertyByStudent
	Purpose:        Returns the properties that a student is leasing given the student ID

======================================================================== */
CREATE PROCEDURE spGetPropertyByStudent 
    @studentId      INT

AS BEGIN
    
    BEGIN TRY 
        IF NOT EXISTS (SELECT NULL FROM Students WHERE studentId = @studentId) BEGIN
        SELECT	[message] = 'Student does not exist.', 
				[success] = CAST(0 AS BIT)
        END ELSE BEGIN 
            SELECT [Property ID] = sr.propertyId, [Student ID] = s.studentId FROM Students s
			INNER JOIN Leases l
			ON s.studentId = l.studentId
			INNER JOIN RentalData sr
			ON sr.leaseId = l.leaseId
			WHERE s.studentId = @studentId
        END 
    END TRY BEGIN CATCH 
        IF(@@TRANCOUNT > 0) ROLLBACK TRAN

	END CATCH

	IF(@@TRANCOUNT > 0) COMMIT TRAN
END

GO
/* =====================================================================

	Name:           spGetStudentByProperty
	Purpose:        Returns the properties that a student is leasing given the property ID

======================================================================== */
CREATE PROCEDURE spGetStudentByProperty
    @propertyId      INT

AS BEGIN
    
    BEGIN TRY 
        IF NOT EXISTS (SELECT NULL FROM Properties WHERE propertyId = @propertyId) BEGIN
        SELECT	[message] = 'Property does not exist.', 
				[success] = CAST(0 AS BIT)
        END ELSE BEGIN 
            SELECT [Property ID] = sr.propertyId, [Student ID] = s.studentId FROM Students s
			INNER JOIN Leases l
			ON s.studentId = l.studentId
			INNER JOIN RentalData sr
			ON sr.leaseId = l.leaseId
			WHERE propertyId = @propertyId 
        END 
    END TRY BEGIN CATCH 
        IF(@@TRANCOUNT > 0) ROLLBACK TRAN

	END CATCH

	IF(@@TRANCOUNT > 0) COMMIT TRAN
END

GO

/* =====================================================================

	Name:           spGetOwnerByProperty
	Purpose:        Returns the properties that a owner owns given the property ID

======================================================================== */
CREATE PROCEDURE spGetOwnerByProperty
    @propertyId      INT

AS BEGIN
    
    BEGIN TRY 
        IF NOT EXISTS (SELECT NULL FROM Properties WHERE propertyId = @propertyId) BEGIN
        SELECT	[message] = 'Property does not exist.', 
				[success] = CAST(0 AS BIT)
        END ELSE BEGIN 
            SELECT [Property ID] = propertyId, [Owner ID] = ownerId FROM PropertyOwners
			WHERE @propertyId = propertyId
        END 
    END TRY BEGIN CATCH 
        IF(@@TRANCOUNT > 0) ROLLBACK TRAN

	END CATCH

	IF(@@TRANCOUNT > 0) COMMIT TRAN
END

GO

/* =====================================================================

	Name:           spPaymentsMadeByStudent
	Purpose:        Returns a list of payments made on each property given a student id.

======================================================================== */
CREATE PROCEDURE spPaymentsMadeByStudent
	@studentId		INT
AS BEGIN
	SELECT CONCAT(s.firstName, ' ', s.lastName) AS studentName , prop.address, p.paymentAmount, p.paymentType, p.paymentDate
	FROM Payments p
		JOIN Students s ON p.studentId = s.studentId 
		JOIN RentalData rd On p.leaseId = rd.leaseId
		JOIN Properties prop ON prop.propertyId = rd.propertyId
	WHERE p.studentId = @studentId
	ORDER BY prop.address
END
GO

GO
/* =====================================================================

	Name:           spGiveRefund
	Purpose:        Accounts for administrative errors by providing a refund 
					to student(s) affected by those errors.

======================================================================== */
CREATE PROCEDURE spGiveRefund 
    @studentId      INT, 
    @leaseId        INT, 
    @paymentType    VARCHAR(30), 
    @paymentDate    DATETIME, 
    @paymentAmount 	FLOAT

AS BEGIN
    
    BEGIN TRY 
        IF NOT EXISTS (SELECT NULL FROM Students WHERE studentId = @studentId) BEGIN 
        SELECT	[message] = 'Student does not exist.', 
				[success] = CAST(0 AS BIT)
        END ELSE IF NOT EXISTS (SELECT NULL FROM Leases WHERE leaseId = @leaseId) BEGIN 
        SELECT	[message] = 'Lease does not exist.', 
				[success] = CAST(0 AS BIT)
        END ELSE BEGIN
            INSERT INTO Payments (studentId, leaseId, paymentType, paymentDate, paymentAmount)
                        VALUES   (@studentId, @leaseId, @paymentType, @paymentDate, @paymentAmount)
            SELECT	@@IDENTITY AS paymentId,
					[success] = CAST(1 AS BIT)
        END 
    END TRY BEGIN CATCH 
        IF(@@TRANCOUNT > 0) ROLLBACK TRAN

	END CATCH

	IF(@@TRANCOUNT > 0) COMMIT TRAN
END
GO 

/* =====================================================================

	Name:           spSetPropertyDamaged 
	Purpose:        Given a lease id, flags the current rental as damaged 
                    (aka the student will no longer receive their security deposit)

======================================================================== */
CREATE PROCEDURE spSetPropertyDamaged 
    @leaseId INT

AS BEGIN 
    
    BEGIN TRY 
        IF NOT EXISTS (SELECT NULL FROM Leases WHERE leaseId = @leaseId) BEGIN 
        SELECT	[message] = 'Lease does not exist.', 
				[success] = CAST(0 AS BIT)
        END  ELSE BEGIN 
            UPDATE Leases
            SET isDamaged = CAST(1 AS BIT)
            SELECT	@leaseId AS leaseId,
						[success] = CAST(1 AS BIT)
        END
    
    END TRY BEGIN CATCH 
        IF(@@TRANCOUNT > 0) ROLLBACK TRAN

	END CATCH

	    IF(@@TRANCOUNT > 0) COMMIT TRAN
END
GO 

/* =====================================================================

	Name:           spGetVacancies 
	Purpose:        Given a property id, compares number of current rentals to the maximum occupants 
                    and returns how many vacant spots are on a property 

======================================================================== */
CREATE PROCEDURE spGetVacancies
    @propertyId INT 

AS BEGIN 

    BEGIN TRY 
        IF NOT EXISTS (SELECT NULL FROM Properties WHERE propertyId = @propertyId) BEGIN 
        SELECT	[message] = 'Property does not exist.', 
				[success] = CAST(0 AS BIT)
        END  ELSE BEGIN 
            SELECT [Vacancies] = maxNumberOfOccupants - numberOfOccupants, 
            [success] = CAST(1 AS BIT) FROM Properties WHERE propertyId = @propertyId 
        END
    END TRY BEGIN CATCH 
        IF(@@TRANCOUNT > 0) ROLLBACK TRAN

	END CATCH

	    IF(@@TRANCOUNT > 0) COMMIT TRAN
END
GO  

-- Expected output success = 1 - Add
EXEC spAddUpdateDeleteStudent 0, 'First', 'Last', '1234567890','email@gmail.com','1/1/1999',2,'0987654321',0,0
-- Expected output success = 1 - Update
EXEC spAddUpdateDeleteStudent 3, 'NewFirst', 'NewLast', '1233437890','email@gm324ail.com','1/1/1999',2,'0987654321',0,0
-- Expected output success = 1 - Delete
EXEC spAddUpdateDeleteStudent 5, 'NewFirst', 'NewLast', '1233437890','email@gm324ail.com','1/1/1999',2,'0987654321',0,1

-- Expected output success = 1 - Add
EXEC spAddUpdateDeleteProperty 0,'21 Main', 'Rose Manor', 3,2,4,132,0,0
-- Expected output success = 1 - Update
EXEC spAddUpdateDeleteProperty 6,'1032 New Main', 'Rose House', 3,2,4,13342,0,0
-- Expected output success = 1 - Delete
EXEC spAddUpdateDeleteProperty 9,'1032 New Main', 'Rose House', 3,2,4,13342,0,1

-- Expected output success = 1 - Add
EXEC spAddUpdateDeleteOwner 0, 'Comp name', 'firl', 'lasl', '1234567890', 'emial@mail./com','123414 Mian',0,0
-- Expected output success = 1 - Update
EXEC spAddUpdateDeleteOwner 6,'Comp naawme', 'fdairl', 'lddasl', '12335465690', 'emial@mail./com','1414 Mian',0,0
-- Expected output success = 1 - Delete
EXEC spAddUpdateDeleteOwner 31,'Comp name', 'firl', 'lasl', '1234567890', 'emial@mail./com','123414 Mian',0,1


-- Expected output: Property ID = 7
EXEC spGetPropertyByStudent @studentId = 4
-- Expected output: Property ID = 23
EXEC spGetPropertyByStudent @studentId = 22
-- Expected output: Student ID does not exist
EXEC spGetPropertyByStudent @studentId = 420

-- Expected outputs: Student ID(s) 7, 9
EXEC spGetStudentByProperty @propertyId = 5
-- Expected outputs: Student ID(s) 25, 34
EXEC spGetStudentByProperty @propertyId = 20
-- Expected outputs: Student ID(s) No output
EXEC spGetStudentByProperty @propertyId = 2

-- Expected output: 2
EXEC spGetOwnerByProperty @propertyId = 2
-- Expected output: 30
EXEC spGetOwnerByProperty @propertyId = 30
-- Expected output: Property does not exist
EXEC spGetOwnerByProperty @propertyId = 200

-- Expected output: Success = 1
EXEC spSetPropertyDamaged @leaseId = 3
-- Expected output: Success = 1
EXEC spSetPropertyDamaged @leaseId = 8
-- Expected output: Lease does not exist
EXEC spSetPropertyDamaged @leaseId = 100

-- Expected output: 0
EXEC spGetVacancies @propertyId = 14
-- Expected output: 2
EXEC spGetVacancies @propertyId = 10
-- Expected output: Property does not exist
EXEC spGetVacancies @propertyId = 100

-- Expected Output: Birgitta Bunclark 7571 Hauk Park 600 Lorain 2019-08-28
EXEC spPaymentsMadeByStudent @studentId = 4
