use adventureworks2019
-- כתבו שאילתה המציגה את מידע על מוצרים שלא נרכשו בטבלת הזמנות
--Productid,name(Productname),Color,ListPrice,Size 

select  t1.ProductID,
		t1.name,
		t1.Color,
		t1.ListPrice,
		t1.Size
from [Production].[Product] t1 left join [Sales].[SalesOrderDetail] t2
on t1.productid=t2.productid
where SalesOrderID is null
order by t1.productid