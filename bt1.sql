CREATE DATABASE ncc_of_management;
USE ncc_of_management;

CREATE TABLE nhacc(
nhacc_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
ncc_name VARCHAR(50) NOT NULL,
address VARCHAR(50) NOT NULL,
phone VARCHAR(10) NOT NULL
);

CREATE TABLE don_dat_hang(
so_dh INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
ngay_dh DATETIME,
mnhacc_id INT,
FOREIGN KEY (mnhacc_id) REFERENCES nhacc(nhacc_id)
);
CREATE TABLE vattu(
maVT INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
tenVT VARCHAR(50)
);

CREATE TABLE phieu_xuat(
soPX INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
ngay_xuat DATETIME
);

CREATE TABLE phieu_nhap(
soPN INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
ngay_nhap DATETIME
);

CREATE TABLE vattu_phieunhap(
maVT INT,
soPN INT,
DG_nhap FLOAT,
SL_nhap INT,
PRIMARY KEY (maVT, soPN),
FOREIGN KEY (maVT) REFERENCES vattu (maVT),
FOREIGN KEY (soPN) REFERENCES phieu_nhap (soPN)
);
CREATE TABLE vattu_phieuxuat(
    soPX   INT,
    maVT   INT,
    DG_xuat FLOAT,
    SL_xuat INT,
    PRIMARY KEY (maVT, soPX),
    FOREIGN KEY (maVT) REFERENCES vattu (maVT),
    FOREIGN KEY (soPX) REFERENCES phieu_xuat (soPX)
);
CREATE TABLE vattu_donhang(
    so_dh INT,
     maVT INT,
    PRIMARY KEY (so_dh,  maVT),
    FOREIGN KEY (so_dh) REFERENCES don_dat_hang (so_dh),
    FOREIGN KEY ( maVT) REFERENCES vattu ( maVT)
);
