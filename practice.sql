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
