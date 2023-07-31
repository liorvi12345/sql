use adventureworks2019
--כתבו שאילתה המציגה מידע על עובדים ותפקידים שלהם
--FirstName,  LastName, JobTitle, HireDate הציגו
--ומספר העובדים הנמצאים באותו התפקיד שהעובד נמצא בו
select t2.FirstName,
	t2.LastName,
	t1.JobTitle,
	t1.HireDate,
	count(jobtitle) over (partition by jobtitle order by JobTitle ) as countoftitle
from [HumanResources].[Employee] t1 left join 
person.person t2
on t1.BusinessEntityID=t2.BusinessEntityID
order by JobTitle