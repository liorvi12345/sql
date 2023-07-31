use adventureworks2019
--כתבו שאילתה המציגה את פרטי עובדים
--אשר עובדים באותו המחלקה והתקבלו לעבודה באותו התאריך.
-- כל שם מלא יוצג עם 
--BusinessEntityID
SELECT 
    distinct HireDate, 
    DepartmentID,
    stuff((select ',' + cast(t0.BusinessEntityID as varchar(10)) + ' ' + FirstName + ' ' + LastName
            from (select *
				  FROM [HumanResources].[EmployeeDepartmentHistory]
				  WHERE EndDate IS NULL) t0
				  LEFT JOIN [HumanResources].[Employee] t1
				  ON t0.BusinessEntityID = t1.BusinessEntityID
				  LEFT JOIN [Person].[Person] t2
				  ON t1.BusinessEntityID = t2.BusinessEntityID
				  WHERE
				  t0.DepartmentID = t5.DepartmentID
				  AND t1.HireDate = t4.HireDate
				  FOR XML PATH('')),1,1,'') as a
from HumanResources.Employee as t4
left join (select *
		   from [HumanResources].[EmployeeDepartmentHistory] 
		   where enddate is null
		   ) t5
on t4.BusinessEntityID = t5.BusinessEntityID
order by 1,2