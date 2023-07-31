use adventureworks2019
--כתבו שאילתה המציגה מידע על לקוחות שלא ביצעו אף הזמנה.
-- Customerid, LastName, FirstName הציגו
--– של הלקוח ומיינו  את הדוח עפ"י  
--בסדר יורד Customerid 
--אם ללקוח אין שם ושם משפחה תשימו 
--Unknown בשניהם
SELECT T2.SalesOrderID,
	   T1.CustomerID,
       CASE
	   WHEN T3.LastName IS NULL 
	   THEN 'Unknown'
	   ELSE T3.LastName
	   END AS 'LastName',
	   CASE
	   WHEN T3.FirstName IS NULL 
	   THEN 'Unknown'
	   ELSE T3.FirstName
	   END AS 'FirstName'
FROM Sales.Customer T1
LEFT JOIN (SELECT CustomerID,
                  SalesOrderID
           FROM Sales.SalesOrderHeader) T2
ON T1.CustomerID = T2.CustomerID
LEFT JOIN (SELECT FirstName,
                  LastName,
				  BusinessEntityID
           FROM Person.Person) T3
ON T1.PersonID = T3.BusinessEntityID
WHERE T2.SalesOrderID IS NULL
ORDER BY T1.CustomerID;