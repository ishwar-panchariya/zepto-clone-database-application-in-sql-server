-- 1. Get All Orders by a User (Customer or Vendor)
-- What we need: User table, Orders Table, Vendor Table
-- Customer Query
SELECT o.OrderID, o.OrderDate, o.TotalAmount, o.UserID, u.FullName
FROM Orders o JOIN Users u
ON o.UserID = u.UserID WHERE o.UserID = 2;

-- Vendor Query
SELECT o.OrderID, o.OrderDate, o.TotalAmount, o.UserID, v.VendorName
FROM Orders o JOIN Vendors v
ON o.VendorID = v.VendorID WHERE o.VendorID = 2;

-- 2. Order Summary with Items (Orders, OrderItems, Products)
SELECT o.OrderID, p.Name, oi.Quantity, oi.Price
FROM Orders o JOIN OrderItems oi 
ON o.OrderID = oi.OrderID
JOIN Products p
ON p.ProductID = oi.ProductID;

-- 3. Total Revenue Generated by Each Vendor
SELECT v.VendorName AS 'Vendor Name', SUM(o.TotalAmount) as 'Total Revenue'
FROM Orders o JOIN Vendors v
ON o.VendorID = v.VendorID
GROUP BY v.VendorName
ORDER BY 'Total Revenue' DESC;

-- 4. Top 5 Bestselling Products
SELECT TOP 5 p.Name, SUM(oi.Quantity) AS TotalSold 
FROM OrderItems oi JOIN Products p
ON oi.ProductID = p.ProductID
GROUP BY p.Name
ORDER BY TotalSold DESC;

SELECT p.Name, SUM(oi.Quantity) AS TotalSold 
FROM OrderItems oi JOIN Products p
ON oi.ProductID = p.ProductID
GROUP BY p.Name
ORDER BY TotalSold DESC
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY;

-- 5. Average Product Rating
SELECT p.Name, AVG(r.Rating) AS 'Avg. Rating'
FROM Reviews r JOIN Products p
ON r.ProductID = p.ProductID
GROUP BY p.Name
ORDER BY 'Avg. Rating';

-- 6. Delivery Status of a Particular Order
SELECT o.OrderID, s.StatusName, ds.UpdatedAt
FROM DeliveryStatus ds JOIN Status s
ON ds.StatusID = s.StatusID
JOIN Orders o
ON o.OrderID = ds.OrderID
WHERE o.OrderID = 4;

-- 7. Daily Order Count
SELECT CAST(OrderDate AS DATE) AS OrderDay, COUNT(*) AS TotalOrders FROM Orders
GROUP BY CAST(OrderDate AS DATE);

-- 8. Top Customers by Order Value
SELECT TOP 1 u.FullName, SUM(o.TotalAmount) AS TotalSpent
FROM Orders o JOIN Users u
ON o.UserID = u.UserID
GROUP BY u.FullName
ORDER BY TotalSpent DESC;

-- 9. Low Stock Products Per Vendor
SELECT v.VendorName, p.Name, i.QuantityAvailable
FROM Inventory i JOIN Vendors v
ON i.VendorID = v.VendorID
JOIN Products p 
ON i.ProductID = p.ProductID
WHERE i.QuantityAvailable < 20
ORDER BY i.QuantityAvailable;

-- 10. Search Products by Keyword (Flexible Query)
SELECT * FROM Products
WHERE Name LIKE '%milk%';
