CREATE DATABASE QuanLySinhVien;
USE QuanLySinhVien;
CREATE TABLE Class (
    ClassID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ClassName VARCHAR(60) NOT NULL,
    StartDate DATETIME NOT NULL,
    Status BIT
);
CREATE TABLE Student (
    StudentId INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    StudentName VARCHAR(30) NOT NULL,
    Address VARCHAR(50),
    Phone VARCHAR(20),
    Status BIT,
    ClassId INT NOT NULL,
    FOREIGN KEY (ClassId)
        REFERENCES Class (ClassID)
);
CREATE TABLE Subject (
    SubId INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    SubName VARCHAR(30) NOT NULL,
    Credit TINYINT NOT NULL DEFAULT 1 CHECK (Credit >= 1),
    Status BIT DEFAULT 1
);
CREATE TABLE Mark (
    MarkId INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    SubId INT NOT NULL,
    StudentId INT NOT NULL,
    Mark FLOAT DEFAULT 0 CHECK (Mark BETWEEN 0 AND 100),
    ExamTimes TINYINT DEFAULT 1,
    UNIQUE (SubId , StudentId),
    FOREIGN KEY (SubId)
        REFERENCES Subject (SubId),
    FOREIGN KEY (StudentId)
        REFERENCES Student (StudentId)
);
insert into Class Values(1,'A1','2008-12-20',1);
insert into Class Values(2,'A2','2008-12-22',1);
insert into Class Values(3,'B3',current_date(),0);

insert into Student (StudentName,Address,Phone,Status,ClassId) values('Huy','Ha nam','0989665048',1,1);
insert into Student (StudentName,Address,Phone,Status,ClassId) values('Nam','Hai phong','0989665058',1,1);
insert into Student (StudentName,Address,Phone,Status,ClassId) values('Duy','Ha noi','0837282598',0,2);

insert into Subject values(1,'CF',5,1),(2,'C',6,1),(3,'HDJ',5,1),(4,'RDBMS',10,1);

INSERT INTO Mark (SubId, StudentId, Mark, ExamTimes)
VALUES (1, 1, 8, 1),
       (1, 2, 10, 2),
       (2, 1, 12, 1);
       
SELECT *
FROM student;

    SELECT *
FROM student
WHERE Status = true;

select * from  subject where Credit < 10;

select S.StudentId ,S.StudentName,C.Classname 
From Student S join Class C on S.ClassId = C.ClassID;

select S.StudentId,S.StudentName,C.ClassName
from Student S join Class C on S.ClassId = C.ClassID
where C.ClassName = 'A1';

select S.StudentID,S.StudentName,Sub.SubName,M.mark 
from Student S join mark M on S.StudentId = M.StudentId join subject Sub on M.SubId = Sub.SubId;

SELECT 
    S.StudentID, S.StudentName, Sub.SubName, M.mark
FROM
    Student S
        JOIN
    mark M ON S.StudentId = M.StudentId
        JOIN
    subject Sub ON M.SubId = Sub.SubId
WHERE
    Sub.SubName = 'CF';
