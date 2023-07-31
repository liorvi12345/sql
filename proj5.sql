use adventureworks2019
--כתבו שאילתה המציגה עבור כל לקוח את תאריך הזמנה אחרונה
--שביצע ותאריך הזמנה לפני האחרונה שביצע
--הציגו
--SalesOrderID,CustomerID,LastName , FirstName  
--תאריך הזמנה אחרונה, ואחד שלפניו
select SalesOrderID,
		CustomerID,
		LastName,
		FirstName,
		lastorder,
		previosorder,
		rownum
from(
select t3.SalesOrderID,
		t1.CustomerID,
		t2.LastName,
		t2.FirstName,
		max(OrderDate) over(partition by t1.CustomerID order by t3.orderdate) as lastorder,
		lag(orderdate) over (partition by t1.CustomerID order by t3.orderdate) as previosorder,
		row_number() over(partition by t1.CustomerID order by t3.orderdate desc) rownum
from  [Sales].[Customer] t1 ,[Person].[Person] t2,[Sales].[SalesOrderHeader] t3
where t1.PersonID=t2.BusinessEntityID
and t1.CustomerID=t3.CustomerID
and PersonType not in ('em','sp')) t3
where rownum =  1 
order by customerid 

