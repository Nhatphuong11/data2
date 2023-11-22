CREATE DATABASE quanlybanhang;
USE quanlybanhang;
CREATE TABLE Categories
(
    Categories_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Categories_name VARCHAR(40)
);

CREATE TABLE PRODUCT
(
    PRODUCT_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    PRODUCT_NAME VARCHAR(40),
    PRICE DOUBLE,
    Categories_id INT,
    FOREIGN KEY (Categories_id) REFERENCES Categories(Categories_id)
);

-- tao view lấy ra danh sách danh mục số lượng sản phẩm theo danh mục
DROP VIEW vw_count_pro_qty;
CREATE VIEW vw_count_pro_qty
AS
SELECT Categories.Categories_name, count(PRODUCT.PRODUCT_ID) as qty_pro
FROM Categories
    JOIN PRODUCT ON Categories.Categories_id = PRODUCT.Categories_id
group by Categories.Categories_name;
    -- goi view
SELECT * FROM vw_count_pro_qty;



-- Thủ tục không tham số
DELIMITER //
CREATE PROCEDURE yourProcedureName()
BEGIN
    SELECT *FROM PRODUCT;
END //
DELIMITER ;

-- Thủ tục tham số đầu vào
DELIMITER &&
CREATE PROCEDURE pro_insert_categoryies(IN name varchar(40))
BEGIN
    INSERT INTO Categories(Categories_name) VALUES (name);
END &&
DELIMITER ;

-- gọi Thủ tục tham số đầu vào
CALL pro_insert_categoryies('ÁO');
CALL pro_insert_categoryies('dep lao');
SELECT * FROM Categories;



#  1 Bài tạo thủ thục trả về danh sách sản phẩm
#  2 Tạo thủ tục thêm mới sản phẩm
#  3 Tạo thủ tục cập nhật sản phẩm
#  4 Tạo thủ tục xóa sản phẩm
#  5 Tạo thủ tục phân trang  (truyền vào số limit, số trang hiện tại).

# 1. gọi danh sách sp
DELIMITER &&
CREATE PROCEDURE show_product()
BEGIN
    SELECT * FROM PRODUCT;
END &&
DELIMITER ;

# 2.thêm mới
DELIMITER &&
CREATE PROCEDURE add_pro(IN name varchar(40), price DOUBLE, CateId INT)
BEGIN
    INSERT INTO PRODUCT(PRODUCT_NAME, PRICE, Categories_id) VALUES (name,PRICE,CateId);
end &&
DELIMITER ;
-- gọi pro
CALL add_pro('ao dai', 20, 1);
CALL add_pro('dep nam', 50, 2);
CALL add_pro('ao phong', 50, 2);
CALL show_product();

# 3.update

DELIMITER &&
CREATE PROCEDURE update_pro(IN id INT, IN name varchar(40), IN price DOUBLE, IN CateId INT)
BEGIN
    UPDATE PRODUCT SET PRODUCT_NAME = name,  PRICE = price, Categories_id = CateId WHERE PRODUCT_ID = id;
end &&
DELIMITER ;
CALL update_pro(1,'áo ngắn', 10, 2);
CALL show_product();

# 4. xoá
DELIMITER &&
CREATE PROCEDURE delete_pro(IN id INT)
BEGIN
    DELETE FROM PRODUCT WHERE PRODUCT_ID = id;
end &&
DELIMITER ;
CALL delete_pro(1);
CALL show_product();

# 5.phân trang
DELIMITER &&
CREATE PROCEDURE parigition(IN no_page int, IN pro_limit int)
BEGIN
    DECLARE start INT;
    set start = (no_page-1) * pro_limit;
    SELECT * FROM PRODUCT LIMIT start, pro_limit;
end &&
DELIMITER ;
CALL parigition(1,2)
