use Northwind

-- 1  For each product, show the categoryname, productname, unitprice and unitsOnOrder. Only include products that are not discontinued and have units on order.


Select products.ProductName,
	Categories.CategoryName,
	products.UnitPrice,
	products.UnitsOnOrder 

From products
JOIN Categories on products.CategoryID = Categories.CategoryID 

Where products.Discontinued = 0 
	and products.UnitsOnOrder!=0


-- 2  Show each category name, the number of products in the category, and the average unitprice. Only include products that are not discontinued.

select Categories.CategoryName,
	Count(Products.productID) as NoOfProducts,
	AVG(products.UnitPrice) as AvgUnitPrice

From products
JOIN Categories on products.CategoryID = Categories.CategoryID 

where products.Discontinued = 0

group by Categories.CategoryName,
		Categories.CategoryID


-- 3  For each product, show the supplier company name, the productname, and unitprice. Only include products that are under $20.

select Suppliers.CompanyName,
	Products.productName,
	Products.unitPrice

from Products
	Join Suppliers on Products.SupplierID = Suppliers.SupplierID

Where Products.UnitPrice<20

-- 4  For each suppliers, show the company name, Region, number of products supplied, and the average unitprice.

select suppliers.Companyname,
	suppliers.region,
	AVG(products.unitprice) as AveragePrice,
	Count(products.productid) as NumberOfProducts

from products
join suppliers on Products.SupplierID=Suppliers.SupplierID

group by suppliers.Companyname,
	suppliers.region,
	suppliers.SupplierID


-- 5  Give a list of suppliers that supply more than one product.

select suppliers.Companyname,
	Count(products.productName) as NoOfProducts

from products
join Suppliers on Products.SupplierID=Suppliers.SupplierID

group by suppliers.Companyname,
		suppliers.SupplierID

having Count(products.productName) > 1

order by suppliers.Companyname


-- 6  Give a list of categories that have average product unit price over $10.

select Categories.CategoryName,
	AVG(products.unitprice) as AvgUnitPrice

from products
join categories on Products.CategoryID = Categories.CategoryID

group by Categories.CategoryName,
		Categories.CategoryID

having AVG(products.unitprice)>10



-- 7  For each product, show the categoryName, supplier company name, productname, and unitprice.


select categories.categoryname,
	Suppliers.companyname,
	Products.ProductName,
	products.unitprice

from products
join categories on Products.CategoryID = Categories.CategoryID
join Suppliers on Products.SupplierID = Suppliers.SupplierID





-- 8  We want to see which categories each supplier has products for. Show the Supplier company name, the Category name, and the number of products in each Supplier/category combination.


select Suppliers.companyname,
	categories.categoryname,
	Count(Products.ProductName) as CountOfProducts

from products
join categories on Products.CategoryID = Categories.CategoryID
join Suppliers on Products.SupplierID = Suppliers.SupplierID

Group by Suppliers.companyname,
	categories.categoryname,
	Suppliers.supplierID,
	Categories.CategoryID

order by Suppliers.companyname,
	categories.categoryname


-- 9  We want pricing information for each category. Show each category name, the minimum, average, and maximum unitprice of all products in that category.
select Categories.CategoryName,
	Min(UnitPrice) as minimumUnitPrice,
	AVG(UnitPrice) as AverageUnitPrice,
	Max(UnitPrice) as MaximumUnitPrice

from products
join Categories on products.categoryid= categories.categoryid

group by Categories.CategoryName,
		Categories.CategoryID



-- 10 We want pricing information for products from each supplier. Show each supplier company name, the minimum, average, and maximum unitprice of all products from that supplier. Do not include products that have been discontinued

select Suppliers.CompanyName,
	Min(UnitPrice) as minimumUnitPrice,
	AVG(UnitPrice) as AverageUnitPrice,
	Max(UnitPrice) as MaximumUnitPrice

from products
join Suppliers on products.categoryid= Suppliers.SupplierID

where products.Discontinued = 0

group by Suppliers.CompanyName,
		Suppliers.SupplierID


