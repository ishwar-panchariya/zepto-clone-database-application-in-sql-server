-- 1. USER TABLE
CREATE TABLE Users (
	UserID INT IDENTITY(1,1) PRIMARY KEY,
	FullName NVARCHAR(100) NOT NULL,
	Email NVARCHAR(100) UNIQUE NOT NULL,
	PhoneNumber NVARCHAR(15),
	CreatedAt DATETIME DEFAULT GETDATE()
);

-- 2. Addresses Table
CREATE TABLE Addresses (
	AddressID INT IDENTITY(1,1) PRIMARY KEY,
	UserID INT FOREIGN KEY REFERENCES Users(UserID),
	AddressLine NVARCHAR(255),
	City NVARCHAR(50),
	State NVARCHAR(50),
	Pincode NVARCHAR(10),
	CreatedAt DATETIME DEFAULT GETDATE()
);

-- 3. Vendors Table
CREATE TABLE Vendors (
	VendorID INT IDENTITY(1,1) PRIMARY KEY,
	VendorName NVARCHAR(100),
	ContactEmail NVARCHAR(100),
	CreatedAt DATETIME DEFAULT GETDATE()
);

-- 4. ProductCategories Table
CREATE TABLE ProductCategories (
	CategoryID INT IDENTITY(1,1) PRIMARY KEY,
	CategoryName NVARCHAR(100) NOT NULL
);

-- 5. Products Table
CREATE TABLE Products (
	ProductID INT IDENTITY(1,1) PRIMARY KEY,
	Name NVARCHAR(100) NOT NULL,
	Description NVARCHAR(255),
	CategoryID INT FOREIGN KEY 
	REFERENCES ProductCategories(CategoryID),
	Price DECIMAL(10,2),
	CreatedAt DATETIME DEFAULT GETDATE()
);

-- 6. Inventory Table
CREATE TABLE Inventory (
	InventoryID INT IDENTITY(1,1) PRIMARY KEY,
	VendorID INT FOREIGN KEY REFERENCES Vendors(VendorID),
	ProductID INT FOREIGN KEY REFERENCES Products(ProductID),
	QuantityAvailable INT,
	LastUpdated DATETIME DEFAULT GETDATE()
);

-- 7. Orders Table
CREATE TABLE Orders (
	OrderID INT IDENTITY(1,1) PRIMARY KEY,
	UserID INT FOREIGN KEY REFERENCES Users(UserID),
	VendorID INT FOREIGN KEY REFERENCES Vendors(VendorID),
	OrderDate DATETIME DEFAULT GETDATE(),
	TotalAmount DECIMAL(10,2),
);

-- 8. OrderItems Table
CREATE TABLE OrderItems (
	OrderItemID INT IDENTITY(1,1) PRIMARY KEY,
	OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
	ProductID INT FOREIGN KEY REFERENCES Products(ProductID),
	Quantity INT,
	Price DECIMAL(10,2)
);

-- 9. Payments Table
CREATE TABLE Payments (
	PaymentID INT IDENTITY(1,1) PRIMARY KEY,
	OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
	PaymentMode NVARCHAR(50),
	PaymentStatus NVARCHAR(50),
	PaidAt DATETIME DEFAULT GETDATE()
);

-- 10. DeliveryPartners Table
CREATE TABLE DeliveryPartners (
	PartnerID INT IDENTITY(1,1) PRIMARY KEY,
	FullName NVARCHAR(100),
	PhoneNumber NVARCHAR(15)
);

-- 11. Status Table
CREATE TABLE Status (
	StatusID INT IDENTITY(1,1) PRIMARY KEY,
	StatusName NVARCHAR(50)
);

-- 12. DeliveryStatus Table
CREATE TABLE DeliveryStatus (
	DeliveryID INT IDENTITY(1,1) PRIMARY KEY,
	OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
	StatusID INT FOREIGN KEY REFERENCES Status(StatusID),
	UpdatedAt DATETIME DEFAULT GETDATE()
);

-- 13. Reviews Table
CREATE TABLE Reviews (
	ReviewID INT IDENTITY(1,1) PRIMARY KEY,
	UserID INT FOREIGN KEY REFERENCES Users(UserID),
	ProductID INT FOREIGN KEY REFERENCES Products(ProductID),
	Rating INT CHECK (Rating BETWEEN 1 AND 5),
	Comment NVARCHAR(255),
	CreatedAt DATETIME DEFAULT GETDATE()
);



































