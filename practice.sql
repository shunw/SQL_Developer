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
