---- 1b
SELECT job, count(*) AS count FROM Employee GROUP BY job ORDER BY job ASC;


---- 1e
SELECT deptID FROM Employee where job = 'engineer' GROUP BY deptID having count(*) = (SELECT max(eng_count) FROM (SELECT deptID, count(*) AS eng_count FROM Employee where job = 'engineer' GROUP BY deptID ) as MAXCOUNT);


---- 1g
SELECT empID FROM Employee where salary = ((SELECT distinct salary FROM Employee ORDER by salary desc limit 2) except (SELECT distinct salary FROM Employee ORDER by salary desc limit 1));


---- 2a
SELECT empName, empID FROM Employee where empID not in (SELECT empID FROM Assigned);


---- 2e
(SELECT projID, sum(salary) AS projectSalary FROM (Employee inner join Assigned using (empID)) GROUP BY projID) union all (SELECT null as projID, sum(salary) AS projectSalary FROM Employee WHERE empID NOT IN (SELECT empID FROM Assigned));


---- 3a
update Employee set salary = salary*1.1 where empID in (SELECT empID FROM Assigned where projID in (SELECT projID FROM Project WHERE title='compiler'));


---- 3b
update Employee set salary = salary* (case when deptID in (SELECT deptID FROM Department WHERE location='Waterloo') then 1.08 when job = 'janitor' then 1.05 else 1 end);


---- 3c
alter TABLE Employee add shift VARCHAR(5);


---- 3d
update Employee set shift = (case when empID not in (SELECT empID FROM Assigned) then 'N.A.' when empID % 2 =0 then 'DAY' else 'NIGHT' end);
