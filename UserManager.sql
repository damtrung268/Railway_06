/*============================== CREATE DATABASE =======================================*/
/*======================================================================================*/
DROP DATABASE IF EXISTS UserManager;
CREATE DATABASE UserManager;
USE UserManager;
/*============================== CREATE TABLE =======================================*/
/*======================================================================================*/

DROP TABLE IF EXISTS Project;
CREATE TABLE Project(
	ProjectId TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY ,
    TeamSize TINYINT UNSIGNED,
    IdManager TINYINT NOT NULL,
    IdEmployees TINYINT NOT NULL 
    
);
DROP TABLE IF EXISTS `User`;
CREATE TABLE `User`	(
	UserID  TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	FullName  NVARCHAR(50) NOT NULL,
	Email  NVARCHAR(50) NOT NULL UNIQUE KEY,
	`Password` VARCHAR(50) NOT NULL,
    `role`  ENUM("Manager","Employee"),
    ExpInYear TINYINT UNSIGNED,
    ProSkill VARCHAR(100),
    ProjectId TINYINT UNSIGNED ,
 FOREIGN KEY(ProjectId) REFERENCES Project(ProjectId)
);

  
/*============================== INSERT DATABASE =======================================*/
/*======================================================================================*/
INSERT INTO `User`  (UserID   , FullName  		, Email				,  `Password`	,  `role`		,	ExpInYear	,  ProSkill  ) 
VALUES                                                                                             
					(1, N'Nguyễn Thị Mỵ'	, 'mynt2407@gmail.com'	, 'mynt2407'	, 	"Manager"	,	'3'			, 	'dev'		),
					(2, N'Nguyễn Ngọc Duy'	,'duynn03@gmail.com'	, 'duynn03'		, 	"Manager"	,	'4'			,	'test'		),
                    (3, N'Nguyễn Hùng Mạnh'	, 'hungmanh@gmail.com'	, 'hungmanh'	,   "Employee"	,	'2'			,	'java'		),
                    (4, N'Nguyễn Thị Nhung'	, 'nhung@gmail.com'		, 'nhung'		,  	"Employee"	,	'1'			,	'test'		),
                    (5, N'Nguyễn Thị Kim Anh','kimoanh.tran@gmail.com', 'kimoanh'	, 	"Employee"	,	'1'			,	'dev'		);
	INSERT INTO Project  (ProjectId , TeamSize  	, IdManager		,  IdEmployees	 )                                              	
	VALUES 			(1   		, '2'  				, '1'				,  '2'	 )  ,
                    (2   		, '2'  				, '2'				,  '3'	 )  ,
					(3		   , '1'  				, '3'				,  '5'	 )  ,
					(4   		, '2'  				, '2'				,  '3'	 )  ,
					(5		   , '1'  				, '3'				,  '5'	 )  ;

                    
SELECT * FROM `User`
WHERE `role` = "Manager";
             