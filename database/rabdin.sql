CREATE TABLE Faculty (
FacNo         CHAR(11)      NOT NULL,
FacFirstName  VARCHAR2(30)   NOT NULL,
FacLastName   VARCHAR2(30)   NOT NULL,
FacCity       VARCHAR2(30)   NOT NULL,
FacState      CHAR(2)       NOT NULL,
FacDept       CHAR(6)       NULL,
FacRank       CHAR(4)       NULL,
FacSalary     NUMBER(10,2) NULL,
FacSupervisor CHAR(11)      NULL,
FacHireDate   TIMESTAMP(3)      NULL,
FacZipCode    CHAR(10)      NOT NULL,
CONSTRAINT FacultyPK PRIMARY KEY (FacNo), 
CONSTRAINT SupervisorFK FOREIGN KEY (FacSupervisor) REFERENCES Faculty);

CREATE TABLE Course (
CourseNo      CHAR(6)       NOT NULL,
CrsDesc       VARCHAR2(50)   NOT NULL,
CrsUnits      NUMBER(10)       NULL,
CONSTRAINT CoursePK PRIMARY KEY (CourseNo) );

CREATE TABLE Offering (
OfferNo       NUMBER(10)       NOT NULL,
CourseNo      CHAR(6)       NOT NULL,
OffTerm       CHAR(6)       NOT NULL,
OffYear       NUMBER(10)       NOT NULL,
OffLocation   VARCHAR2(30)   NULL,
OffTime       VARCHAR2(10)   NULL,
FacNo         CHAR(11)      NULL,
OffDays       CHAR(4)       NULL,
CONSTRAINT OfferingPK PRIMARY KEY (OfferNo),
CONSTRAINT CourseFK FOREIGN KEY (CourseNo) REFERENCES Course,
CONSTRAINT FacultyFK FOREIGN KEY (FacNo) REFERENCES Faculty);

CREATE TABLE Student (
StdNo         CHAR(11)      NOT NULL,
StdFirstName  VARCHAR2(30)   NOT NULL,
StdLastName   VARCHAR2(30)   NOT NULL,
StdCity       VARCHAR2(30)   NOT NULL,
StdState      CHAR(2)       NOT NULL,
StdZip        CHAR(10)      NOT NULL,
StdMajor      CHAR(6)       NULL,
StdClass      CHAR(2)       NULL,
StdGPA        NUMBER(3,2)  NULL,
CONSTRAINT StudentPk PRIMARY KEY (StdNo) );

drop table Enrollment


CREATE TABLE Enrollment(
OfferNo       NUMBER(10)       NOT NULL,
StdNo         CHAR(11)      NOT NULL,
EnrGrade      NUMBER(3,2)  NULL,
CONSTRAINT EnrollmentPK PRIMARY KEY (OfferNo, StdNo),
CONSTRAINT OfferingFK FOREIGN KEY (OfferNo) REFERENCES Offering ON DELETE CASCADE,
CONSTRAINT StudentFK FOREIGN KEY (StdNo) REFERENCES Student ON DELETE CASCADE);

INSERT INTO Faculty VALUES ('543210987','VICTORIA','EMMANUEL','BOTHELL','WA','MS','PROF',120000.0,NULL,'1998-04-15 00:00:00.000','98011-2242');
