CREATE DATABASE [Transaction]

USE [Transaction]

DROP DATABASE [Transaction]

CREATE TABLE StaffLaundry(
	StaffId CHAR(10) PRIMARY KEY NOT NULL 
		CHECK(StaffId LIKE 'ST[0-9][0-9][0-9]'),
	StaffName VARCHAR(50) NOT NULL,
	StaffGender VARCHAR(10),
		CHECK(StaffGender LIKE 'Male' OR StaffGender LIKE 'Female'),
	StaffAddress VARCHAR(100),
	StaffSalary INT
		CHECK(StaffSalary BETWEEN 1500000 AND 3000000)
)

CREATE TABLE MaterialPurchased(
	MaterialId CHAR(10) PRIMARY KEY NOT NULL
		CHECK(MaterialId LIKE 'MA[0-9][0-9][0-9]'),
	MaterialName VARCHAR(50),
	MaterialType VARCHAR(50)
		CHECK(MaterialType LIKE 'Equipment' OR MaterialType LIKE'Supplies'),
	MaterialPrice INT
)

CREATE TABLE Vendor(
	VendorId CHAR(10) PRIMARY KEY NOT NULL
		CHECK(VendorId LIKE 'VE[0-9][0-9][0-9]'),
	VendorName VARCHAR(100),
	VendorAddress VARCHAR(100)
		CHECK(LEN(VendorAddress) > 10),
	VendorPhone VARCHAR(13)
)

CREATE TABLE CustomerInformation(
	CustomerId CHAR(10) PRIMARY KEY NOT NULL
		CHECK(CustomerId LIKE 'CU[0-9][0-9][0-9]'),
	CustomerName VARCHAR(50) NOT NULL,
	CustomerAddress VARCHAR(100) NOT NULL,
	CustomerGender VARCHAR(10) NOT NULL,
	CustomerDOB DATE
)

CREATE TABLE Clothes(
	ClothesId CHAR(10) PRIMARY KEY NOT NULL
		CHECK(ClothesId LIKE'CL[0-9][0-9][0-9]'),
	ClothesName VARCHAR(50) NOT NULL,
	ClothesType VARCHAR(20) NOT NULL
		CHECK(ClothesType LIKE 'Cotton' OR ClothesType LIKE 'Viscose' OR ClothesType LIKE 'Polyester' OR ClothesType LIKE 'Linen' OR ClothesType LIKE 'Wool')
)

CREATE TABLE ServiceTransaction(
	StaffId CHAR(10) NOT NULL REFERENCES StaffLaundry(StaffId),
	CustomerId CHAR(10) NOT NULL REFERENCES CustomerInformation(CustomerId),
	ServiceId CHAR(10) PRIMARY KEY NOT NULL
		CHECK(ServiceId LIKE 'SR[0-9][0-9][0-9]'),
	ServiceDate DATE,
	ServiceType VARCHAR(100)
		CHECK(ServiceType LIKE 'Laundry Service' OR ServiceType LIKE 'Dry Cleaning Only' OR ServiceType LIKE 'Ironing Service'),
	ServicePrice INT,
)

CREATE TABLE DetailServiceTransaction(
	ServiceId CHAR(10) NOT NULL REFERENCES ServiceTransaction(ServiceId),
	ClothesId CHAR(10) NOT NULL REFERENCES Clothes(ClothesId),
	QuantityItem INT
)
CREATE TABLE PurchaseTransaction(
	PurchaseId CHAR(10) PRIMARY KEY NOT NULL
		CHECK(PurchaseId LIKE 'PU[0-9][0-9][0-9]'),
	StaffId CHAR(10) NOT NULL
		REFERENCES StaffLaundry(StaffId)
		ON UPDATE CASCADE ON DELETE CASCADE,
	VendorId CHAR(10) NOT NULL
		REFERENCES Vendor(VendorId)
		ON UPDATE CASCADE ON DELETE CASCADE,
	PurchaseDate DATE,
		--CHECK(YEAR(PurchaseDate)),
	MaterialId CHAR(10) NOT NULL
		REFERENCES MaterialPurchased(MaterialId)
		ON UPDATE CASCADE ON DELETE CASCADE,
	QuantityItem INT,
)

INSERT INTO StaffLaundry VALUES ('ST001','Budi','Male','Kemayoran',1500000),
('ST002','Budu','Male','Kemanggisan',1700000),
('ST003','Siti','Female','Karang Anyar',2000000),
('ST004','Fransesca','Female','Puri',2100000),
('ST005','Robert','Male','Gading',2900000)

INSERT INTO MaterialPurchased VALUES 
('MA001','Palu','Equipment',1500000),
('MA002','Surti','Equipment',1700000),
('MA003','Jamilah','Supplies',2000000),
('MA004','Valerie','Supplies',2100000),
('MA005','Giselle','Equipment',1000000)

INSERT INTO DetailServiceTransaction VALUES
('SR001','CL001',20),
('SR002','CL002',10),
('SR003','CL003',30),
('SR004','CL004',40),
('SR005','CL005',50)

INSERT INTO Vendor VALUES ('VE001','Vendor1','Pluit Utara','08123456789'),
('VE002','Vendor2','Kemanggisan Barat','082347898765'),
('VE003','Vendor3','Kemayoran Pusat','082347890654'),
('VE004','Vendor4','PIK Tenggara','081272580977'),
('VE005','Vendor5','Sunter Timur','085235476199')
INSERT INTO Vendor VALUES 
('VE006','PT. Vendor6','Sunter Timur','085235476199'),
('VE007','PT. Vendor7','Sunter Utara','085235476199'),
('VE008','PT. Vendor8','Sunter Barat','085235476199')

INSERT INTO CustomerInformation VALUES
('CU002', 'Johe', 'Sunter', 'Male', '2000-05-18'),
('CU003', 'Febriani', 'Kelapa Gading', 'Female', '2002-11-17'),
('CU004', 'Yudhi', 'Bogor', 'Male', '1998-05-14'),
('CU005', 'Celine', 'Bekasi', 'Female', '2000-12-22')
INSERT INTO CustomerInformation VALUES
('CU001', 'Putu', 'Bali', 'Male', '2000-05-18')

INSERT INTO Clothes VALUES
('CL001', 'Zara', 'Cotton'),
('CL002', 'HnM', 'Polyester'),
('CL003', 'Dior', 'Linen'),
('CL004', 'Gucci', 'Viscose'),
('CL005', 'Bape', 'Cotton')

INSERT INTO ServiceTransaction VALUES
('ST001','CU002','SR001','2012-11-12','Laundry Service',120000),
('ST003','CU004','SR002','2012-11-13','Dry Cleaning Only',140000),
('ST001','CU005','SR003','2012-11-14','Laundry Service',120000),
('ST002','CU003','SR004','2014-11-12','Ironing Service',90000),
('ST005','CU001','SR005','2015-11-12','Ironing Service',120000)

INSERT INTO PurchaseTransaction VALUES
('PU001','ST001','VE001','2003-11-12','MA001',20),
('PU002','ST002','VE002','2013-11-12','MA002',25),
('PU003','ST003','VE003','2004-1-12','MA005',50),
('PU004','ST004','VE004','2005-8-12','MA004',20),
('PU005','ST001','VE003','2015-11-23','MA004',20)
INSERT INTO PurchaseTransaction VALUES
('PU007','ST001','VE006','2015-11-25','MA003',20),
('PU008','ST003','VE006','2015-11-25','MA003',20),
('PU009','ST002','VE007','2015-11-25','MA003',20),
('PU010','ST002','VE008','2015-10-10','MA004',13),
('PU011','ST004','VE008','2015-11-11','MA005',1),
('PU012','ST005','VE008','2015-11-12','MA002',7)
INSERT INTO PurchaseTransaction VALUES
('PU013','ST005','VE007','2015-07-27','MA002',3),
('PU014','ST003','VE006','2015-07-20','MA003',4)

--1
SELECT ci.CustomerId, CustomerName, [TotalServicePrice] = SUM(ServicePrice)
FROM CustomerInformation ci JOIN ServiceTransaction st 
ON ci.CustomerId = st.CustomerId
WHERE DATEPART(MONTH, ServiceDate) = 7 AND CustomerGender = 'Male'
GROUP BY ci.CustomerId, CustomerName

--2
SELECT StaffName, PurchaseDate, [TotalTransaction] = COUNT(PurchaseId)
FROM StaffLaundry sl JOIN PurchaseTransaction pt 
ON sl.StaffId = pt.StaffId
WHERE StaffName LIKE '%o%'
GROUP BY StaffName, PurchaseDate
HAVING COUNT(PurchaseId) > 1

--3
SELECT VendorName, [PurchaseDate] = CONVERT(VARCHAR,PurchaseDate,107), [TotalTransaction] = COUNT(PurchaseId), [TotalPurchasePrice] = SUM(QuantityItem * MaterialPrice)
FROM 
	Vendor v JOIN PurchaseTransaction pt ON v.VendorId = pt.VendorId
	JOIN MaterialPurchased mp ON pt.MaterialId = mp.MaterialId
WHERE VendorName LIKE 'PT. %' AND DATEPART(day, PurchaseDate) % 2 != 0
GROUP BY VendorName, PurchaseDate

--4
SELECT StaffName, MaterialName, [TotalTransaction] = COUNT(PurchaseId), [TotalQuantity] = CAST(SUM(QuantityItem) AS VARCHAR(100)) + ' pcs'
FROM 
	StaffLaundry sl JOIN PurchaseTransaction pt ON sl.StaffId = pt.StaffId
	JOIN MaterialPurchased mp ON pt.MaterialId = mp.MaterialId
WHERE DATEPART(MONTH, PurchaseDate) = 7
GROUP BY StaffName, MaterialName
HAVING SUM(QuantityItem) < 9

--5
SELECT [MaterialId] = REPLACE(pt.MaterialId, 'MA', 'Material '), MaterialName, PurchaseDate, QuantityItem
FROM
	PurchaseTransaction pt JOIN MaterialPurchased mp ON pt.MaterialId = mp.MaterialId,
	(SELECT AVG(QuantityItem) AS AverageQty FROM PurchaseTransaction) [GetAverage]
WHERE MaterialType = 'Supplies' AND QuantityItem > [GetAverage].AverageQty
ORDER BY pt.MaterialId ASC

--6
SELECT StaffName, CustomerName, [ServiceDate] = CONVERT(VARCHAR, ServiceDate, 106)
FROM
	ServiceTransaction st JOIN CustomerInformation ci ON st.CustomerId = ci.CustomerId
	JOIN StaffLaundry sl ON st.StaffId = sl.StaffId,
	(SELECT AVG(StaffSalary) AS AverageSalary FROM StaffLaundry) [GetAverage]
WHERE StaffSalary > [GetAverage].AverageSalary AND StaffName NOT LIKE '% %'

--7
SELECT ClothesName, [TotalTransaction] = CAST(COUNT(st.ServiceId) AS VARCHAR(100)) + ' transaction', [ServiceType] = SUBSTRING(ServiceType, 0, CHARINDEX(' ', ServiceType, 0))
FROM
	ServiceTransaction st JOIN DetailServiceTransaction dst ON st.ServiceId = dst.ServiceId
	JOIN Clothes c ON dst.ClothesId = c.ClothesId,
	(SELECT AVG(ServicePrice) AS AveragePrice FROM ServiceTransaction)[GetAverage]
WHERE ClothesType = 'Cotton' AND ServicePrice < [GetAverage].AveragePrice
GROUP BY ClothesName, ServiceType

--8
SELECT [StaffFirstName] = SUBSTRING(StaffName, 0, CHARINDEX(' ', StaffName, 0)), VendorName, [VendorPhoneNumber] = REPLACE(VendorPhone, '08', '+628'), [TotalTransaction] = COUNT(PurchaseId)
FROM
	PurchaseTransaction pt JOIN StaffLaundry sl ON pt.StaffId = sl.StaffId
	JOIN Vendor v ON pt.VendorId = v.VendorId,
	(SELECT AVG(QuantityItem) AS AverageQty FROM PurchaseTransaction)[GetAverage]
WHERE QuantityItem > [GetAverage].AverageQty AND StaffName LIKE '% %'
GROUP BY StaffName, VendorName, VendorPhone

--9
GO
CREATE VIEW ViewMaterialPurchase AS
SELECT MaterialName, [MaterialPrice] = 'Rp. ' + CAST(CAST(MaterialPrice AS money) AS varchar), [TotalTransaction] = COUNT(PurchaseId), [TotalPrice] = SUM(QuantityItem * MaterialPrice)
FROM PurchaseTransaction pt JOIN MaterialPurchased mp ON pt.MaterialId = mp.MaterialId
WHERE MaterialType = 'Supplies'
GROUP BY MaterialName, MaterialPrice
HAVING COUNT(PurchaseId) > 2

--10
GO
CREATE VIEW ViewMaleCustomerTransaction AS
SELECT CustomerName, ClothesName, [TotalTransaction] = COUNT(st.ServiceId), [TotalPrice] = SUM(ServicePrice)
FROM
	ServiceTransaction st JOIN DetailServiceTransaction dst ON st.ServiceId = dst.ServiceId
	JOIN Clothes c ON dst.ClothesId = c.ClothesId
	JOIN CustomerInformation ci ON st.CustomerId = ci.CustomerId
WHERE ClothesType IN ('Wool', 'Linen') AND CustomerGender = 'Male'
GROUP BY CustomerName, ClothesName