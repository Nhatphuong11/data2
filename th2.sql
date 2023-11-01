DROP DATABASE IF EXISTS student_management;
CREATE DATABASE student_management;
USE student_management;

CREATE TABLE students (
	student_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    student_name VARCHAR(45) NOT NULL,
    student_age INT,
    class_id INT,
    CHECK(student_age > 18)
);

CREATE TABLE classes (
	class_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    class_name VARCHAR(45) NOT NULL
);

CREATE TABLE subjects (
	subject_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    subject_name VARCHAR(45) NOT NULL
);

ALTER TABLE students
ADD CONSTRAINT fk_class FOREIGN KEY (class_id) REFERENCES classes (class_id);

CREATE TABLE student_subject (
	student_id INT,
    subject_id INT
);

ALTER TABLE student_subject
ADD CONSTRAINT pk_student_subject PRIMARY KEY (student_id, subject_id);
ALTER TABLE student_subject
ADD CONSTRAINT fk_student FOREIGN KEY (student_id) REFERENCES students (student_id);
ALTER TABLE student_subject
ADD CONSTRAINT fk_subject FOREIGN KEY (subject_id) REFERENCES subjects (subject_id);
ALTER TABLE student_subject
ADD COLUMN mark INT DEFAULT 0;

SELECT student_id FROM students WHERE class_id = 1;
SELECT mark FROM student_subject WHERE student_id = 1;
SELECT student_id FROM student_subject WHERE subject_id = 1;