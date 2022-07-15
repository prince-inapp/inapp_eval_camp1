-- Question 2
create database company
use company
go


-- CustomerDetails(manufr_id, manufr_name)
CREATE TABLE CustomerDetails(
	customerId int identity primary key,
	customerName varchar(30)
	);
go

-- OrderDetails(orderId, orderDate, orderPrice,orderQty)
CREATE TABLE OrderDetails (
	orderId int primary key,
	orderDate date,
	orderPrice int,
	orderQty int
	);
go

alter table OrderDetails
add custId int;
alter table OrderDetails add foreign key (custId)
references CustomerDetails(customerId)

-- ManufrDetails
CREATE TABLE ManufrDetails (
	manufrId int primary key,
	manufrName varchar(30));
go
-- ProductDetails(productId,orderId, manufatureDate, productName, manufr_id)
CREATE TABLE ProductDetails (
	productId int primary key,
	orderId int,
	manufrDate date,
	productName varchar(30),
	manufrId int
	constraint fk_manufrId
		foreign key (manufrId)
		references manufrDetails(manufrId)
		)
go

-- inserting into manufrdetails
insert into ManufrDetails values
	(1, 'Samsung'),
	(2, 'Sony'),
	(3, 'Mi'),
	(4, 'Boat')
go

-- insert into customerDetails
insert into CustomerDetails values
	('Jayesh'),
	('Abhilash'),
	('Lily'),
	('Aswathy')
select * from CustomerDetails


select * from OrderDetails
-- insert into OrderDetails
insert into OrderDetails( orderId, orderDate, orderPrice, orderQty, custId)
values
	(1, '2020-12-22', 270, 2, 1),
 ( 2 , '2019-08-10' , 280 , 4 , 2 ),
 ( 3 , '2019-07-13' , 600 , 5 , 3 ),
 ( 4 , '2020-07-15' , 520 , 1 , 1 ),
 ( 5 , '2020-12-22' , 1200 , 4 , 4 ),
 ( 6 , '2019-10-02' , 720 , 3 , 1 ),
 ( 7 , '2020-11-03' , 3000 , 2 , 3 ),
 ( 8 , '2020-12-22' , 1100 , 4 , 4 ),
 ( 9 , '2019-12-29' , 5500 , 2 , 1 )
go
select * from OrderDetails

insert into ProductDetails (productId,orderId, manufrDate,productName, manufrId)
values
(145 , 2 ,'2019-12-23','MobilePhone',1),
 (147 ,6 ,'2019-08-15','MobilePhone',3) ,
 (435 ,5 ,'2018-11-04','MobilePhone',1),
 (783 ,1 ,'2017-11-03','LED TV',2),
 (784 ,4 ,'2019-11-28','LED TV',2),
 (123 ,2 ,'2019-10-03','Laptop',2),
 (267 ,5 ,'2019-11-03','Headphone',4) ,
 (333 ,9 ,'2017-12-12','Laptop',1),
 (344 ,3 ,'2018-11-03','Laptop',1),
 (233 ,3 ,'2019-11-30','PowerBank',2) ,
 (567 ,6 ,'2019-09-03','PowerBank',2)

-- 1. total number of orders in each year
select count(orderId) as count, year(orderDate) as 'year' from OrderDetails
group by YEAR(orderDate);

-- 2. total orders each year by jayeesh
select count(orderId) as count, year(orderDate) as 'year' from OrderDetails
group by YEAR(orderDate)
having OrderDetails.custId in (select CustomerDetails.customerId from CustomerDetails 
where customerName = 'Jayesh')

-- 3. producst which are orderd in the same year of its manufaturing year
select  ProductDetails.productName,YEAR(OrderDetails.orderDate) as 'year of order',
year(ProductDetails.manufrDate) as 'year of manu' from ProductDetails
inner join OrderDetails on YEAR(OrderDetails.orderDate) = YEAR(ProductDetails.manufrDate)

-- 4. 
SELECT * 
FROM OrderDetails
INNER JOIN ProductDetails ON OrderDetails.OrderId = ProductDetails.OrderId
WHERE YEAR(OrderDetails.OrderDate) = YEAR(ProductDetails.manufrDate) 
	AND ProductDetails.manufrId = (SELECT manufrId FROM ManufrDetails WHERE manufrName = 'Samsung')

--5. Total number of products ordered every year.
SELECT YEAR(OrderDate) 'Year', SUM(orderQty) 'No. of products ordered'
FROM OrderDetails
GROUP BY YEAR(orderDate)


--All Manufacturers whose products were sold more than 1500 Rs every year
SELECT ManufrDetails.manufrName, YEAR(OrderDetails.OrderDate) 'Year', COUNT(OrderDetails.OrderId) 'No. of Orders', SUM(OrderDetails.OrderPrice) 'Price' 
FROM ManufrDetails
JOIN ProductDetails ON ProductDetails.manufrId = ManufrDetails.manufrId
JOIN OrderDetails ON OrderDetails.OrderId = ProductDetails.OrderId
GROUP BY ManufrDetails.manufrName, YEAR(OrderDetails.OrderDate)
HAVING SUM(OrderDetails.OrderPrice) > 1500