drop database if exists QuanLyBanHang;
create database QuanLyBanHang;
use QuanLyBanHang;
create table Customer (
cID int primary key auto_increment,
cName varchar(50),
cAge int
);
-- có thể có nhiều hóa đơn cho mỗi khách - mqh n-1
create table `Order` (
oID int primary key auto_increment,
cID int,
oDate date,
oTotalPrice float default null,
foreign key (cID) references Customer(cID)
);

create table OrderDetail (
oID int,
pID int,
odQTY int
);
create table Product (
pID int primary key auto_increment,
pName varchar(50),
pPrice float);
alter table OrderDetail
add constraint fk_order_id foreign key (oID) references `Order`(oID);
alter table OrderDetail
add constraint fk_product_id foreign key (pID) references Product(pID);

alter table OrderDetail
add constraint pk_product_id foreign key (pID) references Product(pID);
-- Thêm dữ liệu vào
insert into Customer(cName, cAge) values
('phuong', 10),
('dong', 20),
('Ha', 50)
;
insert into `Order`(oID, cID, oDate) values
(1, 1, '2006/03/21'),
(2, 2, '2006/03/23'),
(3, 1, '2006/03/16');
insert into Product(pID, pName, pPrice) values
(1, 'May Giat', 3),
(2, 'Tu Lanh', 5),
(3, 'Dieu Hoa', 7),
(4, 'Quat', 1),
(5, 'Bep Dien', 2);
insert into OrderDetail(oID, pID, odQTY) values
(1,1,3),
(1,3,7),
(1,4,2),
(2,1,1),
(3,1,8),
(2,5,4),
(2,3,3);


SELECT c.cID, c.cName, GROUP_CONCAT(p.pName ORDER BY p.pName ASC) AS PurchasedProducts
FROM Customer AS c
LEFT JOIN `Order` AS o ON c.cID = o.cID
LEFT JOIN OrderDetail AS od ON o.oID = od.oID
LEFT JOIN Product AS p ON od.pID = p.pID
GROUP BY c.cID, c.cName;

SELECT c.cID, c.cName
FROM Customer AS c
LEFT JOIN `Order` AS o ON c.cID = o.cID
WHERE o.oID IS NULL;

SELECT o.oID, o.oDate, SUM(od.odQTY * p.pPrice) AS oTotalPrice
FROM `Order` AS o
JOIN OrderDetail AS od ON o.oID = od.oID
JOIN Product AS p ON od.pID = p.pID
GROUP BY o.oID, o.oDate;
# Review code