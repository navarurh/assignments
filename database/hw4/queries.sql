--q11
select
a.FacLastName,
a.FacFirstName,
c.CourseNo
from Faculty as a
left join Faculty as b
on a.FacSupervisor = b.FacNo
left join Offering as c
on a.FacNo= c.FacNo
left join Offering as d
on b.FacNo = d.FacNo
where c.OffYear = 2013
and c.CourseNo = d.CourseNo;

--q12
select *
from Course as a
left join Offering as b
on a.CourseNo = b.CourseNo;

--q13
select
b.OffYear,
b.OffTerm,
b.CourseNo,
b.OfferNo,
a.FacLastName,
a.FacFirstName
from Faculty as a
right join Offering as b
on a.FacNo = b.FacNo;

--q14
select
distinct
a.OfferNo,
a.CourseNo,
a.OffTerm,
d.CrsDesc,
c.FacNo,
c.FacFirstName,
c.FacLastName
from Offering as a
inner join Enrollment as b
on a.OfferNo = b.OfferNo
left join Faculty as c
on a.FacNo = c.FacNo
left join Course as d
on a.CourseNo = d.CourseNo
where a.CourseNo like 'IS%'
and a.OffYear = 2013

--q15
select
StdNo,
StdFirstName,
StdLastName,
StdCity,
StdState
from Student
union all
select
FacNo,
FacFirstName,
FacLastName,
FacCity,
FacState
from Faculty;

select
StdNo,
StdFirstName,
StdLastName,
StdCity,
StdState
from Student
union
select
FacNo,
FacFirstName,
FacLastName,
FacCity,
FacState
from Faculty;

--q16

select
a.StdLastName,
a.StdFirstName,
a.StdMajor
from Student as a
inner join Enrollment as b
on a.StdNo = b.StdNo
where b.EnrGrade >= 3.5
and b.OfferNo in (select OfferNo from Offering where OffTerm = 'FALL' and OffYear = 2012);

--q17
select
a.StdLastName,
a.StdFirstName,
a.StdMajor
from Student as a
inner join Enrollment as b
on a.StdNo = b.StdNo
where b.EnrGrade >= 3.5
and b.OfferNo in 
(select OfferNo from Offering where OffTerm = 'WINTER' and OffYear = 2013 and FacNO not in 
	(select FacNo from Faculty where FacFirstName = 'LEONARD' and FacLastName = 'VINCE'));

--q18
select
a.FacLastName,
a.FacFirstName
from Faculty as a
where not exists (select * from Student where StdNo = a.FacNo);

--q19
select
FacLastName,
FacFirstName 
from Faculty
where FacNo in (select FacNo from Offering where CourseNo like 'IS%' and OffTerm = 'FALL' and OffYear = '2012');

--q20
select
a.CourseNo,
a.CrsDesc,
count(b.OfferNo) as num_of_offerings,
avg(coalesce(c.enr_count,0)) as avg_enr_across_offerings
from Course as a 
left join Offering as b
on a.CourseNo = b.CourseNo
left join (select OfferNo, count(StdNo) as enr_count from Enrollment group by OfferNo) as c 
on b.OfferNo = c.OfferNo 
group by a.CourseNo, a.CrsDesc;