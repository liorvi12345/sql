use adventureworks2019
--כתבו שאילתה המציגה את פרטי10 הלקוחות שביצעו את מספר הרב ביותר של הזמנות 
--הציגו
--Customerid, FirstName, LastName
-- ומספר הזמנות שביצעו הלקוחות ממוינות בסדר יורד.
select top 10  *
from(
select distinct t3.CustomerID,
		firstname,
		lastname,
		count(t3.CustomerID) over(partition by t3.customerid order by t3.customerid ) as ordernumbers
from  [Sales].[Customer] t1 ,[Person].[Person] t2,[Sales].[SalesOrderHeader] t3
where t1.PersonID=t2.BusinessEntityID
and t1.CustomerID=t3.CustomerID
and PersonType not in ('em','sp') 
)t1
order by ordernumbers desc
