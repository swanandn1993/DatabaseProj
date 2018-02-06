use Northwind;
--1. Give a count of how many products are supplied by each supplier. Be sure to include suppliers who do not supply us any products. In other words, their product count will be zero.
select	Suppliers.SupplierID,
		Suppliers.CompanyName,
		count(products.productId) as NoOfProducts
from products
right join Suppliers on Products.SupplierID = Suppliers.SupplierID
group by Suppliers.SupplierID,
		Suppliers.CompanyName
order by Suppliers.SupplierID
;


--2. Give a list of products that have not appeared on any order. Use the common form to accomplish this: LEFT JOIN where IS NULL. Do not use COUNT to do this.

select	products.ProductID,
		Products.ProductName,
		[Order Details].OrderID
from products
left join [Order Details] on Products.ProductID = [Order Details].ProductID
 where [Order Details].OrderID is null
order by products.ProductID,
		Products.ProductName
;

--3. Give a list of customers who have not placed an order. Use LEFT JOIN where IS NULL.

select	Customers.CustomerID,
		Orders.OrderID
from Customers
left join orders on orders.CustomerID = customers.customerId
where Orders.OrderID is null
order by Customers.CustomerID
;
--4. Give a list of Products, and their category name. Where a product is not in a category, still list the product, just show NULL for the category name.

select	products.productID,
		products.productName,
		categories.categoryId,
		Categories.CategoryName
from Products
left join categories on products.CategoryID = Categories.CategoryID
order by products.productID
;

--5. Give all details of the highest price product.

select * 
from Products
where products.unitPrice = (	select max(unitPrice)
								from Products)
;

--6. Give the productname and categoryname of all products that have an above-average unitprice.

select	products.productName,
		categories.categoryName,
		Products.UnitPrice
from Products
join Categories on Products.CategoryID = Categories.CategoryID
where products.unitprice > (	select avg(UnitPrice)
								from Products)
order by products.productName
;
--7. For each product, show its name, its unitprice, and the average unit price of products in the same category. A common table expression would work well for this, or a correlated subquery.


Select a.ProductID,
		a.ProductName,
		a.UnitPrice, 
		b.CategoryName, 
		b.categoryId, 
		(select avg(c.unitPrice) as e
				from products as c
				join Categories as d on c.CategoryID = d.CategoryID
				where d.CategoryID = b.CategoryID
				group by d.categoryID
				)
from Products as a
join Categories as b on a.CategoryID = b.CategoryID
order by b.categoryId
;


--8. Give a list of Products with their supplier. Also give most units of that product sold on an order in 1997.
-- if order id is required keep it, else we can remove it and have desired result
select	distinct
		d.ProductID,
		d.ProductName,
		Suppliers.SupplierID,
		Suppliers.CompanyName,
		a.OrderID,
		a.quantity as MaxOrderin1997
from products as d
join Suppliers on d.supplierId = Suppliers.SupplierID
join [Order Details] as a on a.ProductID = d.ProductID
where a.quantity = (	select max(b.quantity)
									from [Order Details] as b
									join Products as c on b.ProductID = c.ProductID
									join Orders on orders.orderId = b.OrderID
									where c.ProductID = d.productId
									and year(orders.OrderDate) = 1997
									)
order by d.ProductID
;

select * from orders;
--9. Give a list of employees and their immediate reportees.

select	a.EmployeeID as ImdEmployeeID,
		a.FirstName as ImdReporteeFName,
		a.LastName as ImdReporteeLName ,
		b.EmployeeID as EmpEmployeeID,
		b.FirstName as EmpFName, 
		b.LastName as EmpLName 
from Employees as a
join employees as b on a.ReportsTo= b.EmployeeID
order by a.employeeID

;


--10. Give a list of employees and their boss.

select	a.EmployeeID as BossEmployeeID,
		a.FirstName as BossFName,
		a.LastName as BossLName ,
		b.EmployeeID  as EmpEmployeeID,
		b.FirstName as EmpFName,
		b.LastName as EmpLName 
from Employees as a
join employees as b on a.EmployeeID= b.ReportsTo
order by a.employeeID
;