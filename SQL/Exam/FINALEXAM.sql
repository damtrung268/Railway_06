
DROP DATABASE IF EXISTS ThucTap;
CREATE DATABASE ThucTap;
USE ThucTap;

DROP TABLE IF EXISTS country;
CREATE TABLE country (
	country_id			TINYINT UNSIGNED PRIMARY KEY ,
    country_name		NVARCHAR(50) NOT NULL	
   );
DROP TABLE IF EXISTS location;
CREATE TABLE location (
	location_id			TINYINT UNSIGNED  AUTO_INCREMENT PRIMARY KEY ,
    street_address 		NVARCHAR(50) NOT NULL ,		
    postal_code			VARCHAR(50),
	country_id			TINYINT UNSIGNED,
    FOREIGN KEY(country_id) REFERENCES country(country_id )
    
);
DROP TABLE IF EXISTS employee;
CREATE TABLE employee (
	employee_id			TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY ,
    full_name 			NVARCHAR(50) NOT NULL ,		
    email				NVARCHAR(50) NOT NULL UNIQUE KEY , 
	location_id			TINYINT UNSIGNED,
	FOREIGN KEY(location_id) REFERENCES location(location_id )
    );
INSERT INTO country ( country_id			,  country_name)
VALUES 				('29'					, 'ha noi'	),
					('35'					, 'ninh binh'),
                    ('34'					, 'hai duong'),
                    ('15'					, 'hai phong'),	
                    ('90'					, 'ha nam');  
INSERT INTO    location 	( 	street_address	, postal_code,	country_id)
VALUES 						('dong da'			,  	'1b'	 ,   '29'),
							('le duc tho'		,	'2b'	 ,   '35'),
							('my dinh'			,	'3b'	 ,   '34'),	
							('cau giay'			,	'4b'	 ,   '90');       
INSERT INTO employee		 ( full_name 			,  email  			 					, location_id)
VALUES 						('Nguyen Hai Dang'		,'haidang29productions@gmail.com'	    , '2'),
							('Tong Quang Anh'		,'account1@gmail.com'					, '1'),
							('Nguyen Van Chien'		,'account2@gmail.com'					, '4'),
							('Duong Do'				,'account3@gmail.com'					, '2');
-- 2. Viết lệnh để a) Lấy tất cả các nhân viên thuộc Hà Nội    
SELECT * 
FROM  employee
JOIN  location USING(location_id)
WHERE location.country_id = (SELECT country_id
					FROM    country
					WHERE   country_name = 'ha noi' );     
-- 2b) Lấy ra tên quốc gia của employee có email là "nn03@gmail.com"  
SELECT  country_name
FROM  country
JOIN  location USING(country_id)
WHERE location.location_id =(SELECT  location_id 
							FROM    employee  
							WHERE   email = "nn03@gmail.com"  );    
-- 2c) Thống kê mỗi country, mỗi location có bao nhiêu employee đang làm việc.					
SELECT location_id,COUNT(*)	AS sothuctap					
FROM location  
JOIN employee	USING(location_id)
GROUP BY location_id	;

SELECT country_name,COUNT(*) AS so_nhanvien
FROM  location
JOIN  country 	USING(country_id)
JOIN  employee 	USING(location_id)
GROUP BY country_name;

-- 3. Tạo trigger cho table Employee chỉ cho phép insert mỗi quốc gia có tối đa 10 employee		
DROP TRIGGER IF EXISTS qs3; 
DELIMITER $$
CREATE TRIGGER   qs3                    
BEFORE INSERT ON employee
FOR EACH ROW
BEGIN
    DECLARE soluongemployee TINYINT;
	SELECT COUNT(*) INTO soluongemployee
    FROM employee 
    WHERE location_id = NEW.location_id
    GROUP BY location_id ;
	IF  soluongemployee > 10 THEN
     SIGNAL SQLSTATE '10000'
     SET MESSAGE_TEXT = 'lỗi moi quoc gia co toi da 10 employee' ;
   END IF ;
END $$
DELIMITER ;	
INSERT INTO employee		 ( full_name 			,  email  			 				, location_id)
VALUES 						('Nguyen Hai Dang1'		,'haidang29productions1@gmail.com'	, '2'),
							('Tong Quang Anh1'		,'account11@gmail.com'				, '2'),
							('Nguyen Van Chien1'	,'account21@gmail.com'				, '2'),
							('Duong Do11'			,'account311@gmail.com'				, '2'),
							('Tong Quang Anh11'		,'account111@gmail.com'				, '2'),
							('Nguyen Van Chien11'	,'account211@gmail.com'				, '2'),
							('Duong Do111'			,'account31111@gmail.com'			, '2'),
							('Tong Quang1 Anh11'	,'account1111@gmail.com'			, '2'),
							('Nguyen Van 1Chien11'	,'account2111@gmail.com'			, '2'),
							('Duong Do111'			,'account31111@gmail.com'			, '2');

-- 4. Hãy cấu hình table sao cho khi xóa 1 location nào đó thì tất cả employee ở
-- location đó sẽ có location_id = null	
DROP TRIGGER IF EXISTS qs4;
DELIMITER $$
CREATE TRIGGER qs4
BEFORE DELETE ON location
FOR EACH ROW
BEGIN
	DECLARE v_location_id TINYINT;
    
    SELECT location_id INTO v_location_id
    FROM location
    WHERE location_id = OLD.location_id;
	DELETE FROM location  WHERE location_id = v_location_id;
	UPDATE employee SET location_id = NULL WHERE location_id = v_location_id;
END$$
DELIMITER ;				
                              	
                    
                    
                    
