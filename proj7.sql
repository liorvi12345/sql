use adventureworks2019
--הציגו באמצעות מטריצה מספר  הזמנות שנעשו  בכל חודש בשנה.
select *
from(
select  month(OrderDate) as month,
		year(OrderDate) as year,
		salesorderid
from [Sales].[SalesOrderHeader]) pvt
pivot(count (salesorderid) for year in ([2011],[2012],[2013],[2014])) piv
order by month

