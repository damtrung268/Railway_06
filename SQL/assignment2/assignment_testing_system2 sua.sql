DROP DATABASE IF EXISTS testing_system;
CREATE DATABASE testing_system;
USE testing_system;


DROP TABLE IF EXISTS department;
CREATE TABLE department(
	department_id 			TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    department_name 			NVARCHAR(50) NOT NULL UNIQUE KEY
);

DROP TABLE IF EXISTS `position` ;
CREATE TABLE `position` (
	position_id				TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    position_name			ENUM('Dev','Test','Scrum Master','PM') NOT NULL UNIQUE KEY
);

DROP TABLE IF EXISTS `account`;
CREATE TABLE `account`(
	account_id				TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    email					VARCHAR(50) NOT NULL UNIQUE KEY,
    user_name				VARCHAR(50) NOT NULL UNIQUE KEY,
    full_name				NVARCHAR(50) NOT NULL,
    department_id 			TINYINT UNSIGNED NOT NULL,
    position_id				TINYINT UNSIGNED NOT NULL,
    create_date				DATETIME DEFAULT NOW(),
    FOREIGN KEY(department_id) 
		REFERENCES department(department_id),
    FOREIGN KEY(position_id)
		REFERENCES `position`(position_id)
);

-- create table 4: group
DROP TABLE IF EXISTS `group`;
CREATE TABLE `group`(
	group_id				TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    group_name				NVARCHAR(50) NOT NULL UNIQUE KEY,
    creator_id				TINYINT UNSIGNED NOT NULL,
    create_date				DATETIME DEFAULT NOW()
);

-- create table 5: group_account
DROP TABLE IF EXISTS group_account;
CREATE TABLE group_account(
	group_id				TINYINT UNSIGNED NOT NULL,
    account_id				TINYINT UNSIGNED NOT NULL,
    join_date				DATETIME DEFAULT NOW(),
    PRIMARY KEY (group_id,account_id)
);

-- create table 6: type_question
DROP TABLE IF EXISTS type_question;
CREATE TABLE type_question (
    type_id 			TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    type_name 			ENUM('essay','multiple-choice') NOT NULL UNIQUE KEY
);

-- create table 7: category_question
DROP TABLE IF EXISTS category_question;
CREATE TABLE category_question(
    category_id				TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    category_name			NVARCHAR(50) NOT NULL UNIQUE KEY
);

-- create table 8: question
DROP TABLE IF EXISTS question;
CREATE TABLE question(
    question_id				TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    content					NVARCHAR(100) NOT NULL,
    category_id				TINYINT UNSIGNED NOT NULL,
    type_id					TINYINT UNSIGNED NOT NULL,
    creator_id				TINYINT UNSIGNED NOT NULL UNIQUE KEY,
    create_date				DATETIME DEFAULT NOW(),
    FOREIGN KEY(category_id) 	
		REFERENCES category_question(category_id),
    FOREIGN KEY(type_id) 		
		REFERENCES type_question(type_id),
    FOREIGN KEY(creator_id) 		
		REFERENCES `account`(account_id)
);

-- create table 9: answer
DROP TABLE IF EXISTS answer;
CREATE TABLE answer(
    answers					TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    content					NVARCHAR(100) NOT NULL,
    question_id				TINYINT UNSIGNED NOT NULL,
    is_correct				BIT DEFAULT 1,
    FOREIGN KEY(question_id) 
		REFERENCES question(question_id)
);

-- create table 10: exam
DROP TABLE IF EXISTS exam;
CREATE TABLE exam(
    exam_id					TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `code`					NVARCHAR(50) NOT NULL,
    title					NVARCHAR(50) NOT NULL,
    category_id				TINYINT UNSIGNED NOT NULL,
    duration				TINYINT UNSIGNED NOT NULL,
    creator_id				TINYINT UNSIGNED NOT NULL,
    create_date				DATETIME DEFAULT NOW(),
    FOREIGN KEY(category_id) 
		REFERENCES category_question(category_id),
    FOREIGN KEY(creator_id) 	
		REFERENCES `account`(account_id)
);

-- create table 11: examQuestion
DROP TABLE IF EXISTS exam_question;
CREATE TABLE exam_question(
    exam_id				TINYINT UNSIGNED NOT NULL,
	question_id			TINYINT UNSIGNED NOT NULL,
    FOREIGN KEY(question_id) 
		REFERENCES question(question_id),
    FOREIGN KEY(exam_id) 
		REFERENCES exam(exam_id),
    PRIMARY KEY (exam_id,question_id)
);


                    
                    
                    
                    
                       
  
                        