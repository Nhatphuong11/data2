CREATE DATABASE ss05_bt01;
USE ss05_bt01;
CREATE TABLE Products(
            ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
            productCode VARCHAR(40) NOT NULL ,
            productName VARCHAR(40) NOT NULL ,
            productPrice FLOAT CHECK ( productPrice > 0 ),
            productAmount INT DEFAULT 0,
            productDescription TEXT,
            productStatus BIT DEFAULT 0
);

INSERT INTO Products(productCode, productName, productPrice, productAmount, productDescription, productStatus)
VALUES('a1', 'oto', 400, 20, 'tot', 1);
INSERT INTO Products(productCode, productName, productPrice, productAmount, productDescription, productStatus)
VALUES('a2', 'xe máy', 200, 10, 'đẹp', 0);

CREATE UNIQUE INDEX idx_code_on_pro ON Products(productCode);
CREATE INDEX  id_composite_product_price ON Products(productName,productPrice);
-- do tốc độ truy vấn
EXPLAIN SELECT * FROM  Products where id=1;

# b4 Tạo view
CREATE VIEW vw_profull AS
SELECT productCode, productName, productPrice FROM Products;

# lấy dữ liệu từ view
SELECT * FROM vw_profull;


# sửa đổi view
ALTER VIEW vw_profull AS
    SELECT productCode, productName, productPrice,productDescription  FROM Products;

# xoá view
DROP VIEW vw_profull;


# b5
# Tạo store procedure lấy tất cả thông tin của tất cả các sản phẩm trong bảng product
DELIMITER &&
CREATE PROCEDURE show_product()
BEGIN
    SELECT * FROM products;
end &&
DELIMITER ;
CALL show_product();

#  Tạo store procedure thêm một sản phẩm mới
DELIMITER &&
CREATE PROCEDURE add_product(IN productCode varchar(40), IN productName varchar(40), IN productPrice FLOAT, IN productAmount int, IN productDescription TEXT, IN productStatus BIT)
BEGIN
    INSERT INTO Products(productCode, productName, productPrice, productAmount, productDescription, productStatus)
        VALUES (productCode,productName,productPrice,productAmount,productDescription,productStatus);
end &&
DELIMITER ;
CALL add_product('b1', 'máy bay', 500, 23,'Vip', 1);
CALL show_product();

# • Tạo store procedure sửa thông tin sản phẩm theo id
DELIMITER &&
CREATE PROCEDURE update_product(IN ID INT, IN productCode varchar(40), IN productName varchar(40), IN productPrice FLOAT, IN productAmount int, IN productDescription TEXT, IN productStatus BIT)
BEGIN
    UPDATE Products SET productCode = productCode, productName = productName, productPrice = productPrice, productAmount = productAmount, productDescription = productDescription, productStatus = productStatus
    WHERE ID = ID;
end &&
DELIMITER ;

CALL update_product(1, 'a9','xe tăng', 500, 15, 'hàng dep',0 );
CALL show_product();


# • Tạo store procedure xoá sản phẩm theo id
DELIMITER &&
CREATE PROCEDURE delete_p (IN id INT)
BEGIN
    DELETE FROM Products WHERE ID = id;
end &&
DELIMITER ;
CALL delete_p(3);
CALL show_product();
