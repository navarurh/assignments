--q11

select
b.CrsDesc,
min(c.EnrGrade),
max(c.EnrGrade),
avg(c.EnrGrade),
avg(c.EnrGrade)*1.1
from Offering as a
left join Course as b
on a.CourseNo = b.CourseNo
left join Enrollment as c
on a.OfferNo = c.OfferNo
left join Student as d
on c.StdNo = d.StdNo
where d.StdMajor <> 'IS'
group by b.CrsDesc;

--q12

select
b.CrsDesc,
min(c.EnrGrade),
max(c.EnrGrade),
avg(c.EnrGrade),
avg(c.EnrGrade)*1.1
from Offering as a
left join Course as b
on a.CourseNo = b.CourseNo
left join Enrollment as c
on a.OfferNo = c.OfferNo
left join Student as d
on c.StdNo = d.StdNo
group by b.CrsDesc
having avg(c.EnrGrade) < 3.5;

--q13

select
b.CrsDesc,
min(c.EnrGrade),
max(c.EnrGrade),
avg(c.EnrGrade),
avg(c.EnrGrade)*1.1
from Offering as a
left join Course as b
on a.CourseNo = b.CourseNo
left join Enrollment as c
on a.OfferNo = c.OfferNo
left join Student as d
on c.StdNo = d.StdNo
where d.StdMajor <> 'IS'
group by b.CrsDesc
having avg(c.EnrGrade) > 3;

--q14

select * from Student as a
cross join Offering as b
cross join Enrollment as c
cross join Course as d
cross join Faculty as e;

--q15

select
b.OfferNo,
c.OfferNo,
a.StdNo,
c.StdNo,
b.FacNo,
e.FacNo,
b.CourseNo,
d.CourseNo
from Student as a
cross join Offering as b
cross join Enrollment as c
cross join Course as d
cross join Faculty as e;

--q16

select
b.OfferNo,
c.OfferNo,
a.StdNo,
c.StdNo,
b.FacNo,
e.FacNo,
b.CourseNo,
d.CourseNo
from Student as a
cross join Offering as b
cross join Enrollment as c
cross join Course as d
cross join Faculty as e
where b.OfferNo = c.OfferNo
and a.StdNo = c.StdNo
and b.FacNo = e.FacNo
and b.CourseNo = d.CourseNo;

--q17

-- cross product syntax for inner join
select * from Student as a
cross join Offering as b
cross join Enrollment as c
cross join Course as d
cross join Faculty as e
where b.OfferNo = c.OfferNo
and a.StdNo = c.StdNo
and b.FacNo = e.FacNo
and b.CourseNo = d.CourseNo;

-- join operator syntax for inner join
select * from Offering as b
inner join Enrollment as c
on b.OfferNo = c.OfferNo
inner join Student as a
on a.StdNo = c.StdNo
inner join Course as d
on b.CourseNo = d.CourseNo
inner join Faculty as e
on b.FacNo = e.FacNo;

--q18

select
d.CourseNo,
b.OfferNo,
avg(c.EnrGrade)
from Offering as b
inner join Enrollment as c
on b.OfferNo = c.OfferNo
inner join Student as a
on a.StdNo = c.StdNo
inner join Course as d
on b.CourseNo = d.CourseNo
inner join Faculty as e
on b.FacNo = e.FacNo
where a.StdMajor = 'IS'
group by d.CourseNo,b.OfferNo
having count(a.StdNo) > 1;

--q19
select
a.*
from Student as a
inner join Faculty as b
on a.StdFirstName = b.FacFirstName
and a.StdLastName = b.FacLastName;

--q20
select
a.FacNo,
a.FacFirstName,
a.FacLastName,
a.FacSalary,
b.FacNo as Supervisor_FacNo,
b.FacFirstName as Supervisor_FacFirstName,
b.FacLastName as Supervisor_FacLastName,
b.FacSalary as Supervisor_FacSalary
from Faculty as a
inner join Faculty as b
on a.FacSupervisor = b.FacNo
where a.FacSalary > b.FacSalary;