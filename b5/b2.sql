CREATE DATABASE ss05_bt02_qlbh;
USE ss05_bt02_qlbh;
CREATE TABLE CUSTOMERS(
                          CUSTOMERS_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                          CUSTOMERS_NAME VARCHAR(40) NOT NULL,
                          CUSTOMERS_AGE  INT(3) NOT NULL
);

CREATE TABLE ORDERS(
                       ORDERS_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                       CUSTOMERS_ID INT,
                       ORDER_DATE   DATE,
                       TOTAL_PRICE  DOUBLE,
                       CONSTRAINT FK_CUSTOMER FOREIGN KEY (CUSTOMERS_ID) REFERENCES CUSTOMERS (CUSTOMERS_ID)
);

CREATE TABLE PRODUCT
(
    PRODUCT_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    NAME VARCHAR(40),
    PRICE DOUBLE
);


CREATE TABLE ORDER_DETAIL(
                             ORDERS_ID   INT,
                             PRODUCT_ID INT,
                             ORDER_QTY  INT,
                             PRIMARY KEY (ORDERS_ID, PRODUCT_ID),
                             CONSTRAINT FK_ORDER FOREIGN KEY (ORDERS_ID) REFERENCES ORDERS (ORDERS_ID),
                             CONSTRAINT FK_PRODUCT FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT (PRODUCT_ID)
);


INSERT INTO CUSTOMERS
    VALUE (1, 'Minh Quan', 10),
    (2, 'Ngoc Oanh', 20),
    (3, 'Hong Ha', 50),
    (4, 'Hung', 30);


INSERT INTO ORDERS
    VALUE (1, 1, STR_TO_DATE('2006-03-21', '%Y-%m-%d'), NULL),
    (2, 2, STR_TO_DATE('2006-03-23', '%Y-%m-%d'), NULL),
    (3, 1, STR_TO_DATE('2006-03-16', '%Y-%m-%d'), NULL);

INSERT INTO PRODUCT
    VALUE (1, 'May Giat', 3),
    (2, 'Tu Lanh', 5),
    (3, 'Dieu Hoa', 7),
    (4, 'Quat', 1),
    (5, 'Bep Dien', 2);

INSERT INTO ORDER_DETAIL
    VALUE (1, 1, 3),
    (1, 3, 7),
    (1, 4, 2),
    (2, 1, 1),
    (3, 1, 8),
    (2, 5, 4),
    (2, 3, 3);


# Hiển thị các thông tin gồm oID, oDate, oPrice của tất cả các hóa đơn trong bảng Order,
# danh sách phải sắp xếp theo thứ tự ngày tháng, hóa đơn mới hơn nằm trên như hình sau:

SELECT o.ORDERS_ID, o.ORDER_DATE, o.TOTAL_PRICE FROM ORDERS o
ORDER BY o.ORDER_DATE DESC ;

# Hiển thị tên và giá của các sản phẩm có giá cao nhất như sau:
SELECT * FROM PRODUCT WHERE PRICE = (SELECT MAX(p.PRICE) FROM PRODUCT p);

# Hiển thị danh sách các khách hàng đã mua hàng, và danh sách sản phẩm được mua bởi các khách đó như sau

SELECT CUSTOMERS_NAME,  GROUP_CONCAT(p.NAME SEPARATOR ', ')
FROM CUSTOMERS c JOIN ORDERS o ON c.CUSTOMERS_ID = o.CUSTOMERS_ID
JOIN ORDER_DETAIL od ON o.ORDERS_ID = od.ORDERS_ID
JOIN PRODUCT p ON od.PRODUCT_ID = p.PRODUCT_ID
GROUP BY c.CUSTOMERS_ID;

# Hiển thị tên những khách hàng không mua bất kỳ một sản phẩm nào như sau:
SELECT
    c.CUSTOMERS_ID,
    c.CUSTOMERS_NAME
FROM CUSTOMERS AS c
         LEFT JOIN ORDERS AS o ON c.CUSTOMERS_ID = o.CUSTOMERS_ID
WHERE o.ORDERS_ID IS NULL;


# hiển thị chi tiết các hoá đơn
SELECT
    o.CUSTOMERS_ID, o.ORDER_DATE, od.ORDER_QTY, p.NAME, p.PRICE
FROM ORDERS o JOIN ORDER_DETAIL od ON o.ORDERS_ID = od.ORDERS_ID
                     JOIN PRODUCT p ON od.PRODUCT_ID = p.PRODUCT_ID;

#  tính tổng tiền theo hoa đơn
SELECT
    o.CUSTOMERS_ID, o.ORDER_DATE, SUM(od.ORDER_QTY* p.PRICE) as tongtien
FROM ORDERS o JOIN ORDER_DETAIL od ON o.ORDERS_ID = od.ORDERS_ID
              JOIN PRODUCT p ON od.PRODUCT_ID = p.PRODUCT_ID
            GROUP BY o.ORDERS_ID;
