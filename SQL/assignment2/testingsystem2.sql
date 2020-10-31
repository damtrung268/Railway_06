DROP DATABASE IF EXISTS Testing_System; 
CREATE DATABASE Testing_System;
USE 			Testing_System;

DROP TABLE IF EXISTS Department;
CREATE TABLE Department (
	DepartmentID 		TINYINT UNSIGNED PRIMARY KEY ,
    DepartmentName		NVARCHAR(50) UNIQUE KEY NOT NULL
);
DROP TABLE IF EXISTS Position;
CREATE TABLE Position 	(
	PositionID			TINYINT UNSIGNED PRIMARY KEY,
    PositionName		ENUM('Dev', 'Test', 'Scrum Master',' PM') NOT NULL
);
DROP TABLE IF EXISTS `Account`;
CREATE TABLE `Account`   (
	AccountID			TINYINT UNSIGNED PRIMARY KEY ,
    Email				NVARCHAR(50) NOT NULL UNIQUE KEY,
    Username			NVARCHAR(50) NOT NULL,
    FullName			NVARCHAR(50) NOT NULL,
    DepartmentID		TINYINT UNSIGNED NOT NULL UNIQUE KEY ,
    PositionID    		TINYINT UNSIGNED NOT NULL ,
    CreateDate 			DATE,
    FOREIGN KEY(DepartmentID) REFERENCES Department(DepartmentID),
    FOREIGN KEY(PositionID) REFERENCES `Position`(PositionID)
);
DROP TABLE IF EXISTS `Group`	;
CREATE TABLE `Group`	 (
	GroupID				TINYINT UNSIGNED PRIMARY KEY ,
    GroupName			NVARCHAR(50) NOT NULL UNIQUE KEY,
    CreatorID			TINYINT UNSIGNED NOT NULL ,
    CreateDate			DATE 
);
DROP TABLE IF EXISTS GroupAccount;
 CREATE TABLE GroupAccount (
	GroupID				TINYINT UNSIGNED PRIMARY KEY,
    AccountID			NVARCHAR(50) NOT NULL UNIQUE KEY ,
    JoinDate			DATE ,
    FOREIGN KEY (AccountID) REFERENCES `Account`(AccountID)	
);
DROP TABLE IF EXISTS TypeQuestion;
CREATE TABLE  TypeQuestion (
	TypeID				TINYINT UNSIGNED PRIMARY KEY,
    TypeName			ENUM('Essay', 'Multiple-Choice')
);
DROP TABLE IF EXISTS CategoryQuestion;
CREATE TABLE CategoryQuestion (
	CategoryID			TINYINT UNSIGNED PRIMARY KEY ,
    CategoryName		NVARCHAR(50) NOT NULL 
);
DROP TABLE IF EXISTS Question  ;
CREATE TABLE  Question    (
	QuestionID			TINYINT UNSIGNED PRIMARY KEY ,
    Content				NVARCHAR(50) NOT NULL ,
    CategoryID			TINYINT UNSIGNED NOT NULL UNIQUE KEY ,
    TypeID				TINYINT UNSIGNED NOT NULL UNIQUE KEY,
    CreatorID			TINYINT UNSIGNED NOT NULL UNIQUE KEY ,
    CreateDate			DATE 
);
DROP TABLE IF EXISTS Answer;
 CREATE TABLE Answer (
	AnswerID			TINYINT UNSIGNED PRIMARY KEY ,
    Content				NVARCHAR(50) ,
    QuestionID			TINYINT UNSIGNED NOT NUll,
    isCorrect			ENUM('true','full') ,
	FOREIGN KEY(QuestionID) REFERENCES Question(QuestionID)
);
DROP TABLE IF EXISTS Exam ;
 CREATE TABLE Exam (
	ExamID				TINYINT UNSIGNED PRIMARY KEY ,
    `Code`				TINYINT UNSIGNED NOT NULL UNIQUE KEY,
    Title				NVARCHAR(50) NOT NULL,
    CategoryID			TINYINT UNSIGNED NOT NULL ,
    Duration			DATE,
    CreatorID			TINYINT UNSIGNED NOT NULL ,
    CreateDate			DATE,
    FOREIGN KEY(CategoryID) REFERENCES Question(CategoryID),
    FOREIGN KEY(CreatorID) REFERENCES Question(CreatorID)
);
DROP TABLE IF EXISTS 	ExamQuestion;
CREATE TABLE ExamQuestion (
	ExamID				TINYINT UNSIGNED PRIMARY KEY,
    QuestionID			TINYINT UNSIGNED NOT NULL 
);
