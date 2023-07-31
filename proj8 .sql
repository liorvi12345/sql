use adventureworks2019
--כתבו שאילתה המציגה סכום  ההזמנות עבור כל חודש בשנה וגם את סכום מצטבר בכל שנה.
-- יש להציג שורה המדגישה את סיכום השנה
--
--
SELECT t1.years,
	   ISNULL(t1.months, 13) AS months,
	   t1.sums,
	   SUM(t2.sums) OVER (PARTITION BY t2.years ORDER BY t2.months) AS Money
from(
	select YEAR(OrderDate) as years,
		   MONTH(orderdate) as months,
		   SUM(totaldue) as sums
	from Sales.SalesOrderHeader
	group by ROLLUP (YEAR(OrderDate), MONTH(orderdate))) t1 
left join (select  
			    YEAR(OrderDate) as years,
				MONTH(orderdate) as months,
				SUM(totaldue) as sums
			from Sales.SalesOrderHeader
			group by YEAR(OrderDate), MONTH(orderdate)) t2
ON t1.years = t2.years
and t1.months = t2.months
WHERE t1.years is not null
order by years,months

