-- 1.  Write a query to return all category names with their descriptions from the Categories table.
SELECT CategoryName, Description FROM Categories

-- 2.  Write a query to return the contact name, customer id, company name and city name of all Customers in London
SELECT ContactName, CustomerID, CompanyName, City FROM Customers WHERE City = 'London'

-- 3.  Write a query to return all available columns in the Suppliers tables for the marketing managers and sales representatives that have a FAX number 
SELECT * FROM Suppliers WHERE ContactTitle IN('Marketing Manager', 'Sales Representative') AND Fax IS NOT NULL

-- 4.  Write a query to return a list of customer id's from the Orders table with required dates between Jan 1, 1997 and Dec 31, 1997 and with freight under 100 units.
SELECT CustomerID FROM Orders WHERE RequiredDate BETWEEN '1997-01-01' and '1997-12-31' and Freight < 100

-- 5.  Write a query to return a list of company names and contact names of all customers from Mexico, Sweden and Germany.
SELECT CompanyName, ContactName FROM Customers WHERE Country IN('Mexico', 'Sweden', 'Germany')

-- 6.  Write a query to return a count of the number of discontinued products in the Products table.
SELECT COUNT(ProductID) FROM Products WHERE Discontinued = 1

-- 7.  Write a query to return a list of category names and descriptions of all categories beginning with 'Co' from the Categories table.
SELECT CategoryName, Description FROM Categories WHERE CategoryName LIKE 'Co%'

-- 8.  Write a query to return all the company names, city, country and postal code from the Suppliers table with the word 'rue' in their address. The list should ordered alphabetically by company name.
SELECT CompanyName, City, Country, PostalCode FROM Suppliers WHERE Address LIKE '%rue%' ORDER BY CompanyName

-- 9.  Write a query to return the product id and the quantity ordered for each product labelled as 'Quantity Purchased' in the Order Details table ordered by the Quantity Purchased in descending order.
SELECT ProductID, Quantity as 'Quantity Purchased' FROM [Order Details] ORDER BY [Quantity Purchased] DESC

-- 10. Write a query to return the company name, address, city, postal code and country of all customers with orders that shipped using Speedy Express, along with the date that the order was made.
SELECT CompanyName, Address, City, PostalCode, Country, o.OrderDate FROM Customers c
	INNER JOIN Orders o
	ON c.CustomerID = o.CustomerID
	WHERE o.ShipVia = 1

-- 11. Write a query to return a list of Suppliers containing company name, contact name, contact title and region description.
SELECT CompanyName, ContactName, ContactTitle, Region FROM Suppliers

-- 12. Write a query to return all product names from the Products table that are condiments.
SELECT ProductName FROM Products p INNER JOIN Categories c ON p.CategoryID = c.CategoryID WHERE c.CategoryName = 'Condiments'

-- 13. Write a query to return a list of customer names who have no orders in the Orders table.
SELECT ContactName FROM Customers c 
	LEFT JOIN Orders o
	ON c.CustomerID = o.CustomerID
	WHERE o.OrderID IS NULL

-- 14. Write a query to add a shipper named 'Amazon' to the Shippers table using SQL.
INSERT INTO Shippers (CompanyName) VALUES ('Amazon') 

-- 15. Write a query to change the company name from 'Amazon' to 'Amazon Prime Shipping' in the Shippers table using SQL. 
UPDATE Shippers SET CompanyName = 'Amazon Prime Shipping' WHERE CompanyName = 'Amazon'

-- 16. Write a query to return a complete list of company names from the Shippers table. Include freight totals rounded to the nearest whole number for each shipper from the Orders table for those shippers with orders.
SELECT CompanyName, CAST(ROUND(SUM(o.Freight), 0) AS int) AS 'Freight Total' FROM Shippers s 
	LEFT JOIN Orders o 
	ON s.ShipperID = o.ShipVia
	GROUP BY CompanyName
	ORDER BY [Freight Total] DESC

-- 17. Write a query to return all employee first and last names from the Employees table by combining the 2 columns aliased as 'DisplayName'. The combined format should be 'LastName, FirstName'.
SELECT LastName + ', ' + FirstName AS DisplayName FROM Employees

-- 18. Write a query to add yourself to the Customers table with an order for 'Grandma's Boysenberry Spread'.
INSERT INTO Customers (CustomerID, CompanyName, ContactName) VALUES ('OCAKM', 'OCA', 'Katie')

INSERT INTO Orders (CustomerID) VALUES ('OCAKM')

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
	SELECT OrderID, p.productID, p.UnitPrice, 1, 0
		FROM Orders
		INNER JOIN Products p
		ON CustomerID = 'OCAKM' and p.ProductName = 'Grandma''s Boysenberry Spread'

-- 19. Write a query to remove yourself and your order from the database.
DELETE FROM [Order Details]
WHERE EXISTS
  (SELECT * FROM Orders
   WHERE [Order Details].OrderID = Orders.OrderID
   AND Orders.CustomerID = 'OCAKM');

DELETE FROM Orders WHERE CustomerID = 'OCAKM'

DELETE FROM Customers WHERE CustomerID = 'OCAKM'

-- 20. Write a query to return a list of products from the Products table along with the total units in stock for each product. Include only products with TotalUnits greater than 100.
SELECT ProductName, UnitsInStock FROM Products WHERE UnitsInStock > 100