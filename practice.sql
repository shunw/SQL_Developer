--Object: to link two tables
--Tool: SQL developer

--replace: 
--Field1 // Field2 // Field1-in-tbl2
--Project.tblTABLE1 // Project.tblTABLE2
select Project.tblTABLE1."Field1", Project.tblTABLE1."Field2", "Field1-in-tbl2"
from Project.tblTABLE1, Project.tblTABLE2
where Project.tblTABLE1."key"=Project.tblTABLE2."key"
  and Project.tblTABLE1."Field2" like '%ABC%'
order by "any Field";


--Select all the data with all the Fields
select *
from Project.tblTABLE1, Project.tblTABLE2;

--Change one Field data and assign a "alias" name on it. 
--Only works on the data field. For the string field, still not sure how to set
select "Field1", "Field2", "Field3"+100 as "Field4"
from Project.tblTABLE1
;


--Obj: link three tables
--Link: tblTABLE1/ tblTABLE2/ tblTABLE3
select "Field1", "Field2","Field3", "Field4", "Field5", "Field5"-"Field4"+1 as "Field6"
from Project.tblTABLE1, Project.tblTABLE2, Project.tblTABLE3
where Project.tblTABLE1."Field7"=Project.tblTABLE2."Field7" 
  and Project.tblTABLE2."Field8"=Project.tblTABLE3."Field8"
  and Project.tblTABLE1."Field1" like '%-ABC-%';

--Obj: link three tables
--Link: tblTABLE1/ tblTABLE2/ tblTABLE3
--could add the short name for the long table name
select "Field1", "Field2","Field3", "Field4", "Field5", "Field5"-"Field4"+1 as "Field6"
from Project.tblTABLE1 T1, Project.tblTABLE2 T2, Project.tblTABLE3 T3
where T1."Field7"=T2."Field7" 
  and T2."Field8"=T3."Field8"
  and T1."Field1" like '%-ABC-%';
  
--#0417
--Obj: practice union
--this is to union all the elements
select "Field1" from Project.tblTABLE1
union all
select "Field1" from Project.tblTABLE2;

--Obj: practice union
--this is to sort and delete the duplicat ones
select "Field1" from Project.tblTABLE1
union all
select "Field1" from Project.tblTABLE2;


--#0421
--Obj: sub query/ realized the EXCEPT function with the sub query
--subquery to realized the EXCEPT function
select "Field1"
from Project.tblTABLE1
where "key" in (select "key" from Project.tblTABLE2 where "Field3"=1)
    and not "key" in (select "key" from Project.tblTABLE2 where "Field3"=17)
order by "Field1"
;


--#0423
--Obj: this is just the sample from Standford's online course
--To find the college in the same state. 
select cName, state
from College C1
where exists (select * from College C2
			where C2.state=C1.state and C1.cName<>C2.cName); 

--Obj: to find use the query and work with the same function as MAX
select cName
from College 1
where not exists (select * from College C2
				where C2.enrollment>C1.enrollment); 

--Obj: same, to find the MAX data
select sName, GPA
from Student
where GPA>=all(select GPA from Student); 


--#0424
--Obj: again to find the MAX data with any
select cName
from College S1
where not enrollment <=any(select enrollment from College S2
							where S2.cName<>S1.cName)

--Obj: to exclude the smallest ID
select sID, sName, sizeHS
from Student
where sizeHS > any (select sizeHS from Student); 

--Obj: to realized the same function as any
select sID, sName, sizeHS
from Student S1
where exists (select * from Student S2
			where S2.sizeHS <S1.sizeHS); 

--Obj: to make the subquery in the FROM clause
select *
from (select sID, sName, GPA, GPA*(sizeHS/1000.0) as scaledGPA
from Student) G
where abs(G.scaledGPA -GPA)>1.0

--05-07
--Obj: to make the subquery in the WHERE clause
select College.cName, state, GPA
from College, Apply, Student
where College.cName=Apply.cName
	and Apply.sID=Student.sID
	and GPA >= all
		(select GPA from Student, Apply
		 where Student.sID=Apply.sID
			and Apply.cName=College.cName); 

--Obj: to make the subquery in the SELECT clause
select cName, state, 
(select distinct GPA
from Apply, Student
where College.cName=Apply.cName
	and Apply.sID=Student.sID
	and GPA >= all
		(select GPA from Student, Apply
		 where Student.sID=Apply.sID
			and Apply.cName=College.cName)) as GPA
from College; 

--0518 joins
--inner join/ two relation example
select distinct sName, major
from Student inner join Apply
on Student.sID=Apply.sID;

--inner join/ two relation example
select sName, GPA
from Student join Apply
on Student.sID=Apply.sID
where/and sizeHS < 1000 and major='CS' and cName = 'Standford';

--inner join/ three relation example
select Apply.sID, sName, GPA, Apply.cName, enrollment
from (Apply join Student on Apply.sID=Student.sID) join College
on Apply.cName=College.cName;

--natual join/ two relation example
select distinct sName, major
from Student natural join Apply; 
