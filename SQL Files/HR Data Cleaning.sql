/* Creating A Database */ 

CREATE DATABASE projects;

USE projects;


SELECT 
	*
FROM 
	hr;
    
/* Renaming the id column */ 

ALTER TABLE hr
CHANGE COLUMN ï»¿id emp_id VARCHAR(20) NULL;


/* Description of data type present in every column */ 

DESCRIBE hr;

/* Converting String data type to Date format of birthdate column */ 

SELECT 
	birthdate
FROM
	hr;
    
SET sql_safe_updates = 0;
    
UPDATE hr
SET birthdate = CASE 
	WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate, '%m/%d/%Y'),'%Y-%m-%d')
    WHEN birthdate LIKE '%-%' THEN date_format(str_to_date(birthdate, '%m-%d-%Y'),'%Y-%m-%d')
    ELSE NULL
END;

ALTER TABLE hr
MODIFY COLUMN birthdate DATE;

SELECT 
	birthdate
FROM 
	hr;
    
/* Converting String data type to Date format of hire_date column */ 

SELECT 
	hire_date
FROM
	hr;
    
    
UPDATE hr
SET hire_date = CASE 
	WHEN hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date, '%m/%d/%Y'),'%Y-%m-%d')
    WHEN hire_date LIKE '%-%' THEN date_format(str_to_date(hire_date, '%m-%d-%Y'),'%Y-%m-%d')
    ELSE NULL
END;

ALTER TABLE hr
MODIFY COLUMN hire_date DATE;

SELECT 
	hire_date
FROM 
	hr;
    
/* Converting String data type to Date format of termdate column */ 

SELECT 
	termdate
FROM
	hr;
    
SET sql_mode = '';
    
UPDATE hr
SET termdate = IF(termdate IS NOT NULL AND termdate != '', 
DATE(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC')),'0000-00-00') 
WHERE TRUE;
	

ALTER TABLE hr
MODIFY COLUMN termdate DATE;

SELECT 
	termdate
FROM 
	hr;

/* Creating a Age column */ 

ALTER TABLE hr 
ADD COLUMN age INT;

/* Calculating the Age */ 

UPDATE hr
SET age = TIMESTAMPDIFF(YEAR, birthdate, CURDATE());

SELECT 
	birthdate,
    age
FROM 
	hr;
    
/* Determining the Minimum and Maximum Age ( To determine the Age Brackets ) */ 

SELECT 
	MIN(age) AS youngest,
    MAX(age) AS Oldest
FROM 
	hr;
 
/* We can exclude the below values as they are not relevent for our analysis*/ 
 
SELECT 
	COUNT(*)
FROM 
	hr
WHERE 
	age < 18;