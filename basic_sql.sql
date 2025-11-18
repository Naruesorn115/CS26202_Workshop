--Student ID 67040249115
--Student Name นายนฤสรณ์ วิจิตร

-- *********แบบฝึกหัด Basic Query #1 ***************
--1. แสดงข้อมูลสินค้า 10 รายการแรก
   SELECT TOP 10 * 
   FROM Products;
--2. จงแสดงข้อมูล รหัสพนักงาน ชื่อ นามสกุล ของพนักงานทุกคน
    SELECT EmployeeID, FirstName, LastName 
    FROM Employees;
--3. แสดงรหัสพนักงาน ชื่อและนามสกุลต่อกัน อายุ ของพนักงานแต่ละคน
    SELECT EmployeeID, (FirstName + SPACE(3) + LastName) AS EmployeeName,
           YEAR(GETDATE()) - YEAR(BirthDate) AS Age 
    FROM Employees;
/*4. แสดงข้อมูลรหัสสินค้า ชื่อสินค้า ราคาต่อหน่วย จำนวนคงเหลือ รหัสประเภทสินค้า
จัดเรียงข้อมูลตามรหัสประเภทสินค้า จากน้อยไปหามาก และจำนวนคงเหลือจากมากไปหาน้อย */
    SELECT ProductID, ProductName, UnitPrice, UnitsInStock, CategoryID 
    FROM Products 
    ORDER BY CategoryID ASC, UnitsInStock DESC;
--5. แสดงจำนวนรายการสินค้าที่จัดอยู่ในประเภทสินค้ารหัส 1
    SELECT COUNT(*) AS NumberOfProducts 
    FROM Products 
    WHERE CategoryID = 1;
--6. แสดงจำนวนลูกค้าที่อยู่ในประเทศสหรัฐอเมริกา
    SELECT COUNT(*) AS NumberOfCustomers 
    FROM Customers 
    WHERE Country = 'USA';

--7. แสดงจำนวนใบสั่งซื้อที่จัดส่งไปยังประเทศฝรั่งเศส ในปี 1997
    SELECT COUNT(*) AS NumberOfOrders 
    FROM Orders 
    WHERE ShipCountry = 'France' 
      AND YEAR(OrderDate) = 1997;
--8. แสดงราคาต่อหน่วยของสินค้าที่แพงสุด และถูกที่สุด
    SELECT MAX(UnitPrice) AS MAX_Price,
           MIN(UnitPrice) AS MIN_Price
    FROM Products
-- แสดงข้อมูลสินค้าที่มีราคาต่อมหน่วยแพงที่สุด
    SELECT * 
    FROM Products 
    WHERE UnitPrice = (SELECT MAX(UnitPrice) FROM Products);
--9. จงแสดงอายุของพนักงานที่มากสุดและอายุน้อยสุด
    SELECT MAX(YEAR(GETDATE()) - YEAR(BirthDate)) AS MAX_Age,
           MIN(YEAR(GETDATE()) - YEAR(BirthDate)) AS MIN_Age
    FROM Employees;

--10. แสดงรหัสสินค้า ราคาต่อหน่วย จำนวนที่ซื้อ ราคารวม ของรายการสั่งซื้อที่อยู่ในใบสั่งซื้อหมายเลข10248
    SELECT ProductID, UnitPrice, Quantity,
           (UnitPrice * Quantity) AS SumPrice
    FROM [Order Details]
    WHERE OrderID = 10248;

--11. แสดงยอดสั่งซื้อรวมของใบสั่งซื้อหมายเลข 10248
    SELECT SUM(UnitPrice * Quantity) AS totalOrderPrice
    FROM [Order Details]
    WHERE OrderID = 10248;

--12. แสดงอายุเฉลี่ยของพนักงาน
SELECT AVG(YEAR(GETDATE()) - YEAR(BirthDate)) AS Average_Age
FROM Employees;
--13. แสดงรหัสประเภทสินค้าและจำนวนรายการสินค้าในแต่ละประเภท
SELECT CategoryID, COUNT(ProductID) AS NumberOfProducts
FROM Products
GROUP BY CategoryID;

/*14. แสดงรหัสประเภทสินค้าและจำนวนรายการสินค้าในแต่ละประเภท 
เฉพาะประเภทสินค้าที่มีรายการสินค้าอยู่ในประเภทนั้น 10 รายการขึ้นไป */
SELECT CategoryID, COUNT(ProductID) AS NumberOfProducts
FROM Products
GROUP BY CategoryID
HAVING COUNT(ProductID) >= 10;


--15. แสดงชื่อประเทศและจำนวนลูกค้าที่อยู่ในแต่ละประเทศ เฉพาะประเทศที่มีลูกค้าไม่ถึง 5 ราย
SELECT Country, COUNT(CustomerID) AS NumberOfCustomers
FROM Customers
GROUP BY Country
HAVING COUNT(CustomerID) < 5;


/*16. แสดงรหัสใบสั่งซื้อและยอดสั่งซื้อรวมในแต่ละใบสั่งซื้อ เฉพาะใบสั่งซื้อที่มียอดสั่งซื้อรวมเกิน $10000
จัดเรียงข้อมูลตามยอดสั่งซื้อรวมจากมากไปหาน้อย */
SELECT OrderID, SUM(UnitPrice * Quantity) AS totalOrderPrice
FROM [Order Details]
GROUP BY OrderID
HAVING SUM(UnitPrice * Quantity) > 10000
ORDER BY totalOrderPrice DESC;
