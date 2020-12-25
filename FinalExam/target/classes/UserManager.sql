/*============================== CREATE DATABASE =======================================*/
/*======================================================================================*/
DROP DATABASE IF EXISTS UserManager;
CREATE DATABASE UserManager;
USE UserManager;
/*============================== CREATE TABLE =======================================*/
/*======================================================================================*/
SELECT * FROM `User`;
-- create table 1: Department  id, FullName, Email, Password
CREATE TABLE `User`(
 UserID  TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 FirstName  NVARCHAR(50) NOT NULL,
 LastName  NVARCHAR(50) NOT NULL,
 Phone  BIGINT,
    Email  VARCHAR(50) UNIQUE KEY NOT NULL,
    `Password` VARCHAR(50) NOT NULL CHECK(length(`Password`) >= 6),
    `Role` VARCHAR(50),
    ExpInYear   TINYINT,
    ProjectName VARCHAR(100),
    ProSkill  VARCHAR(100)
);
/*============================== INSERT DATABASE =======================================*/
/*======================================================================================*/
INSERT INTO `User`  (UserID   , FirstName , LastName,  Email,  `Password`, `Role` ,`ExpInYear` ) 
VALUES                                                                                                                              
 (1, N'Thị Mỵ', N'Nguyễn ', 'mynt2407@gmail.com',  'Mynguyen123', 'Employee', 1 ),
 (2, N'Ngọc Duy', N'Nguyễn ', 'duynn03@gmail.com',  'duyNguyen', 'Manager', 3 ),
                    (3, N'Hùng Mạnh', N'Nguyễn ', 'hungmanh@gmail.com',   'hunGmanh1', 'Employee', 1 ),
                    (4, N'Thị Nhung', N'Tống ', 'nhung@gmail.com',  'nhungtOng', 'Employee', 1 ),
                    (5, N'Thị Kim Anh', N'Trần ', 'kimoanh.tran@gmail.com',  'tran.kim', 'Employee', 1 );