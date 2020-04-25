--------------
/* SUBTOTAL */

select OrderId, ProductId, UnitPrice, Quantity, Discount, UnitPrice * Quantity as Subtotal
	from [Order Details]

--------------
/* CURRENT PRODUCTS FOR SALE */

select * from products
	where Discontinued = 0

--------------
/* TOTAL PRICE */

select OrderId, ProductId, UnitPrice, Quantity, Discount, UnitPrice * Quantity * (case when Discount = 0 then 1 else Discount end) as Subtotal
	from [Order Details]

--------------
/* TOTAL SALES */

select c.CategoryID, CategoryName, ProductId, ProductName, UnitsOnOrder 
from products as p
left join Categories as c
	on c.CategoryID = p.CategoryID
where UnitsOnOrder > 0
order by CategoryName
-- ? What's the difference for this data between amount sold over all time and total number of items sold?

--------------
/* TOP TEN MOST EXPENSIVE PRODUCTS */

select top 10 * from products
order by UnitPrice desc

--------------
/* REVENUE */

select datepart(Year,Orderdate) as Year, datepart(Quarter,Orderdate) as Quarter, 
SUM (UnitPrice * Quantity * (case when Discount = 0 then 1 else Discount end)) as Subtotal
	from [Order Details] as od
	left join orders as ord
	on od.OrderID = ord.OrderId
	where datepart(Year,Orderdate) = 1997
group by datepart(Year, OrderDate), datepart(Quarter,OrderDate)
order by datepart(Year, OrderDate), datepart(Quarter,OrderDate) desc

-- ? how to format as money???

--------------
/* PRODUCTS HIGHER THAN AVERAGE */

select AVG (UnitPrice) from products --28.866

select * from products
where UnitPrice > 28.866
order by UnitPrice desc
