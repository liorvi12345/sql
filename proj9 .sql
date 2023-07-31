use adventureworks2019
--כתבו שאילתה המציגה את העובדים עפ"י סדר 
-- קבלתם לעבודה  בכל מחלקה מהעובד החדש ביותר לעובד הוותיק ביותר
--הציגו את העמודות שם מחלקה מס' עובד, שמו המלא, תאריך העסקתו ,הוותק שלו בחברה בחודשים, שם מלא 
--תאריך העסקה של העובד שהתקבל לפניו לעבודה, ומספר הימים שחלפו בין תאריך העסקת העובד לעובד שלפניו. 
select  DEPARTMENTNAME,
		BusinessEntityID,
		employees_fullname,
		hiredate,
		seniority,
		lag(employees_fullname) over (PARTITION BY DEPARTMENTNAME ORDER BY hiredate ASC) AS PREV_NAME,
		LAGGER,
		DATEDIFF(d, t0.Lagger, t0.hiredate) AS Diff
from (
select t1.*
from(
select  d.Name AS DEPARTMENTNAME,
		e.BusinessEntityID,
		concat(p.FirstName,' ',p.LastName) as employees_fullname,
		e.hiredate,
		datediff(m,HireDate,getdate()) as seniority,
		LAG(hiredate) OVER(PARTITION BY [Name] ORDER BY hiredate ASC) AS Lagger
from  [HumanResources].[Employee]  e left join 
(select *
from [HumanResources].[EmployeeDepartmentHistory]  
where enddate is null) edh
on e.BusinessEntityID=edh.BusinessEntityID
join [HumanResources].[Department] d
on edh.DepartmentID=d.DepartmentID
join person.person p
on e.BusinessEntityID=p.BusinessEntityID) t1)t0





