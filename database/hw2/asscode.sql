--Retrieve the student last name, student first name, and GPA for all students with a GPA  (more than 2.2 and less than 2.7) OR (more than 3.2 and less than 3.8)
select
    StdLastName,
    StdFirstName,
    StdGPA
from
    Student
where
    (StdGPA > 2.2 and StdGPA < 2.7)
or    (StdGPA > 3.2 and StdGPA < 3.8);


--Retrieve the student last name, student first name, and GPA for all students with a GPA that is between 2.7 and 3.2 inclusive
select
    StdLastName,
    StdFirstName,
    StdGPA
from
    Student
where StdGPA between 2.7 and 3.2;


--Retrieve the offer number, course number, year, and faculty number from all course offerings that has not yet been assigned a Faculty 

select
b.OfferNo,
a.CourseNo,
b.OffYear,
c.FacNo
from Course as a
left join Offering as b
on a.CourseNo = b.CourseNo
left join Faculty as c
on b.FacNo = c.FacNo
where b.FacNo is null;

--Repeat query for course offerings that have been assigned a Faculty

select
b.OfferNo,
a.CourseNo,
b.OffYear,
c.FacNo
from Course as a
left join Offering as b
on a.CourseNo = b.CourseNo
left join Faculty as c
on b.FacNo = c.FacNo
where b.FacNo is not null;


--Retrieve the offer number, course number, location, year, and faculty number from all course offerings in location BLM302 

select
OfferNo,
CourseNo,
OffLocation,
OffYear,
FacNo
from Offering
where OffLocation = 'BLM302';

--Retrieve the offer number, course number, location, year, and faculty number from all course offerings in location BLM 3rd floo

select
OfferNo,
CourseNo,
OffLocation,
OffYear,
FacNo
from Offering
where OffLocation like 'BLM3%';


--Using a derived column in both the column list and the WHERE clause 
--Retrieve the student last name, student first name, and GPA plus 10% for all students with GPA plus 10% greater than 3

select
StdLastName,
StdFirstName,
StdGPA*1.1 as StdGPA_D
from Student
where StdGPA*1.1 > 3;


--Retrieving the number of rows from all of our tables 
--For each of our tables, retrieve the number of rows --Tables are Student, Faculty, Offering, Course, and Enrollment 
--(omit sorting, table aliases, and column aliases)

select count(*) as row_count from Student;
select count(*) as row_count from Faculty;
select count(*) as row_count from Offering;
select count(*) as row_count from Course;
select count(*) as row_count from Enrollment;


--Examining the effect of NULL values on aggregate functions
--Retrieve the number of rows in the Faculty table using COUNT(*) and COUNT(f.FacSupervisor) 
--How many rows does each one return?  Why?

select count(*) from Faculty;
select count(FacSupervisor) from Faculty;


--Aggregates on all rows of a table
--Retrieve the average GPA for all students

select avg(StdGPA) as AVG_GPA from Student;

--Aggregates on a subset of rows of a table (using a WHERE clause)
--Retrieve the minimum GPA, maximum GPA, average GPA, and average GPA plus 10% for freshman students

select
min(StdGPA) as minGPA,
max(StdGPA) as maxGPA,
avg(StdGPA) as avgGPA,
avg(StdGPA*1.1) as avgGPAtp
from Student
where StdClass = 'FR';

--Aggregates on a group of rows (using a GROUP BY clause)
--Retrieve the class name, minimum GPA, maximum GPA, average GPA, and average GPA plus 10% for each class

select
a.CrsDesc,
min(d.StdGPA) as minGPA,
max(d.StdGPA) as maxGPA,
avg(d.StdGPA) as avgGPA,
avg(d.StdGPA*1.1) as avgGPAtp
from
Course as a
left join Offering as b
on a.CourseNo = b.CourseNo
left join Enrollment as c
on c.OfferNo = b.OfferNo
left join Student as d
on d.StdNo = c.StdNo
where d.StdNo is not null
group by a.CrsDesc;

select
a.CrsDesc,
min(c.EnrGrade) as minGPA,
max(c.EnrGrade) as maxGPA,
avg(c.EnrGrade) as avgGPA,
avg(c.EnrGrade*1.1) as avgGPAtp
from
Course as a
left join Offering as b
on a.CourseNo = b.CourseNo
left join Enrollment as c
on c.OfferNo = b.OfferNo
group by a.CrsDesc;