/*============================== CREATE DATABASE =======================================*/
/*======================================================================================*/
DROP DATABASE IF EXISTS TestingSystem;
CREATE DATABASE TestingSystem;
USE TestingSystem;

/*============================== CREATE TABLE=== =======================================*/
/*======================================================================================*/

-- create table 1: Department
DROP TABLE IF EXISTS Department;
CREATE TABLE Department(
	DepartmentID 			TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    DepartmentName 			NVARCHAR(30) NOT NULL UNIQUE KEY
);

-- create table 2: Posittion
DROP TABLE IF EXISTS Position;
CREATE TABLE `Position` (
	PositionID				TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    PositionName			ENUM('Dev','Test','Scrum Master','PM') NOT NULL UNIQUE KEY
);

-- create table 3: Account
DROP TABLE IF EXISTS `Account`;
CREATE TABLE `Account`(
	AccountID				TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Email					VARCHAR(50) NOT NULL UNIQUE KEY,
    Username				NVARCHAR(50) NOT NULL UNIQUE KEY,
    FullName				NVARCHAR(50) NOT NULL,
    DepartmentID 			TINYINT UNSIGNED NOT NULL,
    PositionID				TINYINT UNSIGNED NOT NULL,
    CreateDate				DATETIME DEFAULT NOW(),
    FOREIGN KEY(DepartmentID) REFERENCES Department(DepartmentID),
    FOREIGN KEY(PositionID) REFERENCES `Position`(PositionID)
);

-- create table 4: Group
DROP TABLE IF EXISTS `Group`;
CREATE TABLE `Group`(
	GroupID					TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    GroupName				NVARCHAR(50) NOT NULL UNIQUE KEY,
    CreatorID				TINYINT UNSIGNED NOT NULL,
    CreateDate				DATETIME DEFAULT NOW()
);

-- create table 5: GroupAccount
DROP TABLE IF EXISTS GroupAccount;
CREATE TABLE GroupAccount(
	GroupID					TINYINT UNSIGNED NOT NULL,
    AccountID				TINYINT UNSIGNED NOT NULL,
    JoinDate				DATETIME DEFAULT NOW(),
    PRIMARY KEY (GroupID,AccountID)
);

-- create table 6: TypeQuestion
DROP TABLE IF EXISTS TypeQuestion;
CREATE TABLE TypeQuestion (
    TypeID 			TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    TypeName 		ENUM('Essay','Multiple-Choice') NOT NULL UNIQUE KEY
);

-- create table 7: CategoryQuestion
DROP TABLE IF EXISTS CategoryQuestion;
CREATE TABLE CategoryQuestion(
    CategoryID				TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    CategoryName			NVARCHAR(50) NOT NULL UNIQUE KEY
);

-- create table 8: Question
DROP TABLE IF EXISTS Question;
CREATE TABLE Question(
    QuestionID				TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Content					NVARCHAR(100) NOT NULL,
    CategoryID				TINYINT UNSIGNED NOT NULL,
    TypeID					TINYINT UNSIGNED NOT NULL,
    CreatorID				TINYINT UNSIGNED NOT NULL UNIQUE KEY,
    CreateDate				DATETIME DEFAULT NOW(),
    FOREIGN KEY(CategoryID) 	REFERENCES CategoryQuestion(CategoryID),
    FOREIGN KEY(TypeID) 		REFERENCES TypeQuestion(TypeID),
    FOREIGN KEY(CreatorID) 		REFERENCES `Account`(AccountId)
);

-- create table 9: Answer
DROP TABLE IF EXISTS Answer;
CREATE TABLE Answer(
    Answers					TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Content					NVARCHAR(100) NOT NULL,
    QuestionID				TINYINT UNSIGNED NOT NULL,
    isCorrect				BIT DEFAULT 1,
    FOREIGN KEY(QuestionID) REFERENCES Question(QuestionID)
);

-- create table 10: Exam
DROP TABLE IF EXISTS Exam;
CREATE TABLE Exam(
    ExamID					TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `Code`					CHAR(10) NOT NULL,
    Title					NVARCHAR(50) NOT NULL,
    CategoryID				TINYINT UNSIGNED NOT NULL,
    Duration				TINYINT UNSIGNED NOT NULL,
    CreatorID				TINYINT UNSIGNED NOT NULL,
    CreateDate				DATETIME DEFAULT NOW(),
    FOREIGN KEY(CategoryID) REFERENCES CategoryQuestion(CategoryID),
    FOREIGN KEY(CreatorID) 	REFERENCES `Account`(AccountId)
);

-- create table 11: ExamQuestion
DROP TABLE IF EXISTS ExamQuestion;
CREATE TABLE ExamQuestion(
    ExamID				TINYINT UNSIGNED NOT NULL,
	QuestionID			TINYINT UNSIGNED NOT NULL,
    FOREIGN KEY(QuestionID) REFERENCES Question(QuestionID),
    FOREIGN KEY(ExamID) REFERENCES Exam(ExamID),
    PRIMARY KEY (ExamID,QuestionID)
);

/*============================== INSERT DATABASE =======================================*/
/*======================================================================================*/
-- Add data Department
INSERT INTO Department(DepartmentName) 
VALUES
						(N'Marketing'	),
						(N'Sale'		),
						(N'Bảo vệ'		),
						(N'Nhân sự'		),
						(N'Kỹ thuật'	),
						(N'Tài chính'	),
						(N'Phó giám đốc'),
						(N'Giám đốc'	),
						(N'Thư kí'		),
						(N'Bán hàng'	);
    
-- Add data position
INSERT INTO Position	(PositionName	) 
VALUES 					('Dev'			),
						('Test'			),
						('Scrum Master'	),
						('PM'			); 


-- Add data Account
INSERT INTO `Account`(Email								, Username			, FullName				, DepartmentID	, PositionID, CreateDate)
VALUES 				('haidang29productions@gmail.com'	, 'dangblack'		,'Nguyen Hai Dang'		,   '5'			,   '1'		,'2020-03-05'),
					('account1@gmail.com'				, 'quanganh'		,'Tong Quang Anh'		,   '1'			,   '2'		,'2020-03-05'),
                    ('account2@gmail.com'				, 'vanchien'		,'Nguyen Van Chien'		,   '1'			,   '3'		,'2020-03-07'),
                    ('account3@gmail.com'				, 'cocoduongqua'	,'Duong Do'				,   '2'			,   '4'		,'2020-03-08'),
                    ('account4@gmail.com'				, 'doccocaubai'		,'Nguyen Chien Thang'	,   '2'			,   '4'		,'2020-03-10'),
                    ('dapphatchetngay@gmail.com'		, 'khabanh'			,'Ngo Ba Kha'			,   '3'			,   '3'		,'2020-04-05'),
                    ('songcodaoly@gmail.com'			, 'huanhoahong'		,'Bui Xuan Huan'		,   '4'			,   '2'		,'2020-04-05'),
                    ('sontungmtp@gmail.com'				, 'tungnui'			,'Nguyen Thanh Tung'	,   '3'			,   '1'		,'2020-04-07'),
                    ('duongghuu@gmail.com'				, 'duongghuu'		,'Duong Van Huu'		,   '3'			,   '2'		,'2020-04-07'),
                    ('vtiaccademy@gmail.com'			, 'vtiaccademy'		,'Vi Ti Ai'				,   '6'		,   '1'		,'2020-04-09');

-- Add data Group
INSERT INTO `Group`	(  GroupName			, CreatorID		, CreateDate)
VALUES 				(N'Testing System'		,   5			,'2019-03-05'),
					(N'Developement'		,   1			,'2020-03-07'),
                    (N'VTI Sale 01'			,   2			,'2020-03-09'),
                    (N'VTI Sale 02'			,   3			,'2020-03-10'),
                    (N'VTI Sale 03'			,   4			,'2020-03-28'),
                    (N'VTI Creator'			,   6			,'2020-04-06'),
                    (N'VTI Marketing 01'	,   7			,'2020-04-07'),
                    (N'Management'			,   8			,'2020-04-08'),
                    (N'Chat with love'		,   9			,'2020-04-09'),
                    (N'Vi Ti Ai'			,   10			,'2020-04-10');

-- Add data GroupAccount
INSERT INTO `GroupAccount`	(  GroupID	, AccountID	, JoinDate	 )
VALUES 						(	1		,    1		,'2019-03-05'),
							(	1		,    2		,'2020-03-07'),
							(	3		,    3		,'2020-03-09'),
							(	3		,    4		,'2020-03-10'),
							(	5		,    5		,'2020-03-28'),
							(	1		,    3		,'2020-04-06'),
							(	1		,    7		,'2020-04-07'),
							(	8		,    3		,'2020-04-08'),
							(	1		,    9		,'2020-04-09'),
							(	10		,    10		,'2020-04-10');


-- Add data TypeQuestion
INSERT INTO TypeQuestion	(TypeName			) 
VALUES 						('Essay'			), 
							('Multiple-Choice'	); 


-- Add data CategoryQuestion
INSERT INTO CategoryQuestion		(CategoryName	)
VALUES 								('Java'			),
									('ASP.NET'		),
									('ADO.NET'		),
									('SQL'			),
									('Postman'		),
									('Ruby'			),
									('Python'		),
									('C++'			),
									('C Sharp'		),
									('PHP'			);
													
-- Add data Question
INSERT INTO Question	(Content			, CategoryID, TypeID		, CreatorID	, CreateDate )
VALUES 					(N'Câu hỏi về Java'	,	1		,   '1'			,   '1'		,'2020-04-05'),
						(N'Câu Hỏi về PHP'	,	10		,   '2'			,   '2'		,'2020-04-05'),
						(N'Hỏi về C#'		,	9		,   '2'			,   '3'		,'2020-04-06'),
						(N'Hỏi về Ruby'		,	6		,   '1'			,   '4'		,'2020-04-06'),
						(N'Hỏi về Postman'	,	5		,   '1'			,   '5'		,'2020-04-06'),
						(N'Hỏi về ADO.NET'	,	3		,   '2'			,   '6'		,'2020-04-06'),
						(N'Hỏi về ASP.NET'	,	2		,   '1'			,   '7'		,'2020-04-06'),
						(N'Hỏi về C++'		,	8		,   '1'			,   '8'		,'2020-04-07'),
						(N'Hỏi về SQL'		,	4		,   '2'			,   '9'		,'2020-04-07'),
						(N'Hỏi về Python'	,	7		,   '1'			,   '10'	,'2020-04-07');

-- Add data Answers
INSERT INTO Answer	(  Content		, QuestionID	, isCorrect	)
VALUES 				(N'Trả lời 01'	,   1			,	0		),
					(N'Trả lời 02'	,   1			,	1		),
                    (N'Trả lời 03'	,   1			,	0		),
                    (N'Trả lời 04'	,   1			,	1		),
                    (N'Trả lời 05'	,   2			,	1		),
                    (N'Trả lời 06'	,   3			,	1		),
                    (N'Trả lời 07'	,   4			,	0		),
                    (N'Trả lời 08'	,   8			,	0		),
                    (N'Trả lời 09'	,   9			,	1		),
                    (N'Trả lời 10'	,   10			,	1		);
	
-- Add data Exam
INSERT INTO Exam	(`Code`			, Title					, CategoryID	, Duration	, CreatorID		, CreateDate )
VALUES 				('VTIQ001'		, N'Đề thi C#'			,	1			,	60		,   '5'			,'2019-04-05'),
					('VTIQ002'		, N'Đề thi PHP'			,	10			,	60		,   '1'			,'2019-04-05'),
                    ('VTIQ003'		, N'Đề thi C++'			,	9			,	120		,   '2'			,'2019-04-07'),
                    ('VTIQ004'		, N'Đề thi Java'		,	6			,	60		,   '3'			,'2020-04-08'),
                    ('VTIQ005'		, N'Đề thi Ruby'		,	5			,	120		,   '4'			,'2020-04-10'),
                    ('VTIQ006'		, N'Đề thi Postman'		,	3			,	60		,   '6'			,'2020-04-05'),
                    ('VTIQ007'		, N'Đề thi SQL'			,	2			,	60		,   '7'			,'2020-04-05'),
                    ('VTIQ008'		, N'Đề thi Python'		,	8			,	60		,   '8'			,'2020-04-07'),
                    ('VTIQ009'		, N'Đề thi ADO.NET'		,	4			,	90		,   '9'			,'2020-04-07'),
                    ('VTIQ010'		, N'Đề thi ASP.NET'		,	7			,	90		,   '10'		,'2020-04-08');
                    
                    
-- Add data ExamQuestion
INSERT INTO ExamQuestion(ExamID	, QuestionID	) 
VALUES 					(	1	,		5		),
						(	2	,		10		), 
						(	3	,		4		), 
						(	4	,		3		), 
						(	5	,		7		), 
						(	6	,		10		), 
						(	7	,		2		), 
						(	8	,		10		), 
						(	9	,		9		), 
						(	10	,		8		); 
                        
                        
-- Question 1: Tạo store để người dùng nhập vào tên phòng ban và in ra tất cả các account thuộc phòng ban đó              
DROP PROCEDURE IF EXISTS question1 ;
DELIMITER $$
CREATE PROCEDURE question1(IN name_department NVARCHAR(50))
  BEGIN
     SELECT *
     FROM `Account`
     JOIN  Department USING(DepartmentID)
     WHERE DepartmentName LIKE CONCAT('%', name_department ,'%');
  END $$
DELIMITER ;    
-- Question 2: Tạo store để in ra số lượng account trong mỗi group   
DROP PROCEDURE IF EXISTS question2 ;
DELIMITER $$
CREATE PROCEDURE question2(IN group_id TINYINT UNSIGNED)
  BEGIN
     SELECT * ,COUNT(*)
     FROM `GroupAccount`
     WHERE GroupID = group_id
     GROUP BY GroupID;
  END $$
DELIMITER ;    
-- Question 3: Tạo store để thống kê mỗi type question có bao nhiêu question được tạo trong tháng hiện tại
DROP PROCEDURE IF EXISTS queston3 ;
DELIMITER $$
CREATE PROCEDURE queston3()
BEGIN

	SELECT		COUNT(TypeID)
    FROM		Question
    WHERE		MONTH(CreateDate) = Month(NOW());
	
END $$
DELIMITER ; 
-- Question 4: Tạo store để trả ra id của type question có nhiều câu hỏi nhất
DROP PROCEDURE IF EXISTS question4 ;
DELIMITER $$
CREATE PROCEDURE question4 (OUT Type_question_id INT )
  BEGIN
     SELECT q.TypeID INTO Type_question_id 
     FROM Question q
     JOIN TypeQuestion tq ON tq.TypeID = q.TypeID
     GROUP BY q.TypeID 
     HAVING COUNT(*) = ( SELECT COUNT(*)
						FROM Question q
						JOIN TypeQuestion tq ON tq.TypeID = q.TypeID
						GROUP BY q.TypeID 
						ORDER BY COUNT(*) DESC LIMIT 1)
    LIMIT       1;                    
  END $$
DELIMITER ;
SET @Type_question_id  = 0 ;
SELECT @Type_question_id ;
--  cách 2 
DROP PROCEDURE IF EXISTS question41 ;
DELIMITER $$
CREATE PROCEDURE question41(OUT Type_question_id INT )
  BEGIN
     SELECT TypeID INTO Type_question_id 
     FROM Question
     GROUP BY TypeID 
     HAVING COUNT(*) = ( SELECT COUNT(*)
						FROM Question
						GROUP BY TypeID 
						ORDER BY COUNT(*) DESC LIMIT 1)
    LIMIT       1;                    
  END $$
DELIMITER ;
SET @Type_question_id  = 0 ;
SELECT @Type_question_id;
-- Question 5: Sử dụng store ở question 4 để tìm ra tên của type question
DROP PROCEDURE IF EXISTS Ex5;
DELIMITER $$
CREATE PROCEDURE Ex5()
	BEGIN
          DECLARE   Type_questionID INT;
          SET       Type_questionID = 0;
          call     question41(Type_questionID);           
          select    Type_questionID;                 -- su dung data co gia tri cua ex 4       
		SELECT    TypeName
		FROM      TypeQuestion
		WHERE     TypeID = Type_questionID;
     END $$
DELIMITER ;
    call Ex5();


-- Question 6: Viết 1 store cho phép người dùng nhập vào 1 chuỗi và trả về group có tên chứa chuỗi của người dùng nhập vào hoặc trả về user có username chứa chuỗi của người dùng nhập vào
DROP PROCEDURE IF EXISTS question6 ;
DELIMITER $$
CREATE PROCEDURE question6 (IN group_name NVARCHAR(50), IN user_name VARCHAR(50))
  BEGIN
     SELECT  g.GroupName , a.Username
     FROM `GroupAccount` ga
     JOIN  `Account` a ON a.AccountID = ga.AccountID
     JOIN  `Group` g 	   ON g.GroupID = ga.GroupID
     WHERE g.GroupName LIKE CONCAT('%', group_name ,'%') OR a.Username LIKE CONCAT('%', user_name ,'%') ;
  END $$
DELIMITER ; 

-- qs 6 cách 2 : 
DROP PROCEDURE IF EXISTS Question66;
DELIMITER $$
CREATE PROCEDURE Question66(IN input NVARCHAR(50))
	BEGIN
		SELECT    GroupName , `Group` AS `Type`
		FROM      `Group`
        WHERE     GroupName LIKE concat('%',input,'%')
        UNION
        SELECT    Username ,`Account` AS `Type`
		FROM      `Account`
        WHERE     Username LIKE concat('%',input,'%');
	END $$
DELIMITER ;      
-- Question12 Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong năm nay

CREATE VIEW view12 As
	SELECT EachMonthInYear.MONTH
	FROM
	(
				SELECT 1 AS MONTH
				UNION SELECT 2 AS MONTH
				UNION SELECT 3 AS MONTH
				UNION SELECT 4 AS MONTH
				UNION SELECT 5 AS MONTH
				UNION SELECT 6 AS MONTH
				UNION SELECT 7 AS MONTH
				UNION SELECT 8 AS MONTH
				UNION SELECT 9 AS MONTH
				UNION SELECT 10 AS MONTH
				UNION SELECT 11 AS MONTH
				UNION SELECT 12 AS MONTH
	) AS EachMonthInYear;
  
        
DROP PROCEDURE IF EXISTS question12;
DELIMITER $$
CREATE PROCEDURE question12()
 BEGIN
   SElECT * , COUNT(q.QuestionID)
   FROM view12
   LEFT JOIN Question q ON view12.MONTH = MONTH(q.CreateDate)
   GROUP BY view12.MONTH
   HAVING YEAR(q.CreateDate) = 2020 || COUNT(q.QuestionID) = 0
   ORDER BY view12.MONTH ASC ;
 END $$
 DELIMITER ;
-- Question 7: Viết 1 store cho phép người dùng nhập vào thông tin fullName, email và
-- trong store sẽ tự động gán:username sẽ giống email nhưng bỏ phần @..mail đipositionID: sẽ có default là developerdepartmentID: sẽ được cho vào 1 phòng chờSau đó in ra kết quả tạo thành công

DROP PROCEDURE IF EXISTS as7;
DELIMITER $$
CREATE PROCEDURE as7(IN in_email VARCHAR(50), IN in_fullName NVARCHAR(50))
BEGIN
-- "cuongnm580 gmail.com gmail.com2" cuongnm580,gmail.com,gmail.com2
DECLARE Username1 VARCHAR(50) DEFAULT SUBSTRING_INDEX(in_email,'@',1);
DECLARE PositionID TINYINT DEFAULT 2;
DECLARE DepartmentID TINYINT ;
SET DepartmentID = 7;
INSERT INTO `Account` (Email ,Username, FullName , DepartmentID, PositionID, CreateDate)
VALUE (in_email ,Username1, in_fullName , DepartmentID, PositionID, NOW());
SELECT *
FROM `Account`A
WHERE A.Username = Username1;
END$$
DELIMITER ;
-- Question 8: Viết 1 store cho phép người dùng nhập vào Essay hoặc Multiple-Choice
-- để thống kê câu hỏi essay hoặc multiple-choice nào có content dài nhất
DROP PROCEDURE IF EXISTS question8;
DELIMITER $$
CREATE PROCEDURE question8(IN in_typeName NVARCHAR(50))
BEGIN
	IF (in_typeName = 'Essay') THEN
		SELECT	Content, MAX(LENGTH(Content))
		FROM	Question
		WHERE	TypeID = 1;
	ELSEIF (in_typeName = 'Multiple-Choice') THEN
		SELECT	Content, MAX(LENGTH(Content))
		FROM	Question
		WHERE	TypeID = 2;
	END IF;
END$$
DELIMITER ;
-- Question 9: Viết 1 store cho phép người dùng xóa exam dựa vào ID
DROP PROCEDURE IF EXISTS question9;
DELIMITER $$
CREATE PROCEDURE question9 (IN in_ExamID TINYINT UNSIGNED)
BEGIN
	DELETE 	
    FROM 	Exam 
    WHERE	ExamID = in_ExamID;	
END$$
DELIMITER ;
-- Question 11: Viết store cho phép người dùng xóa phòng ban bằng cách người dùng
-- nhập vào tên phòng ban và các account thuộc phòng ban đó sẽ được
-- chuyển về phòng ban default là phòng ban chờ việc
DROP PROCEDURE IF EXISTS question11;
DELIMITER $$
CREATE PROCEDURE question11(IN	in_DepartmentName NVARCHAR(50))
BEGIN
	UPDATE 	`Account`
    SET		DepartmentID = 11
    WHERE	DepartmentID = (SELECT 	DepartmentID	
							FROM	Department
							WHERE 	DepartmentName = in_DepartmentName);
	DELETE 
    FROM	Department
    WHERE	DepartmentName = in_DepartmentName;
END$$
DELIMITER ;