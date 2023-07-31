use adventureworks2019
-- כתבו שאילתה המציגה את סכום  הקניה בהזמנה היקרה ביותר בכל שנה,
--יש להציג לאילו לקוחות שייכים הזמנות אלו. הציגו
--שנת תאריך הזמנה, מספר הזמנה, שם משפחה ושם פרטי של לקוח, ועמודת
--TOTAL=UnitPrice*(1- UnitPriceDiscount)*OrderQty  

select  salesorderid,
		years,
		FirstName,
		LastName,
		total
from(
select *,
		max(sums) over (partition by years) as total
from(
select 
		distinct t3.SalesOrderID as salesorderid,
		sum(LineTotal) over(partition by t3.SalesOrderID,orderdate order by year(orderdate)) as sums,
		year(OrderDate) as years,
		FirstName,
		LastName
from  [Sales].[Customer] t1 ,[Person].[Person] t2,[Sales].[SalesOrderHeader] t3,[Sales].[SalesOrderDetail] t4
where t1.PersonID=t2.BusinessEntityID
and t1.CustomerID=t3.CustomerID
and t3.SalesOrderID=t4.SalesOrderID
and PersonType not in ('em','sp'))t0)t5
where sums=total
order by years