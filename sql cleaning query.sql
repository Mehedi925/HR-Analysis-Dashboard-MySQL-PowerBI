CREATE DATABASE hr_project;

USE hr_project;

SELECT * FROM hrd;

-- ## emp id column and Datatype change 
ALTER TABLE hrd
CHANGE COLUMN ï»¿id emp_id VARCHAR(20) NULL;

DESCRIBE hrd;

-- ## birthday column formating and datatype change
SELECT birthdate FROM hrd;
-- SET sql_safe_updates = 0;
UPDATE hrd
SET birthdate = CASE
	WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN birthdate LIKE '%-%' THEN date_format(str_to_date(birthdate, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;
ALTER TABLE hrd
MODIFY COLUMN birthdate DATE;

-- ## hire_date column formating and datatype change
UPDATE hrd
SET hire_date = CASE
	WHEN hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN hire_date LIKE '%-%' THEN date_format(str_to_date(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;
ALTER TABLE hrd
MODIFY COLUMN hire_date DATE;

-- ## termdate column formating and datatype change
UPDATE hrd
SET termdate = date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC'))
WHERE termdate IS NOT NULL AND termdate != ' ';

update hrd
set termdate = '0000-00-00'
where termdate = '';

ALTER TABLE hrd
MODIFY COLUMN termdate DATE;

-- ## add a new age column in the table
ALTER TABLE hrd ADD COLUMN age INT;

UPDATE hrd
SET age = timestampdiff(YEAR, birthdate, CURDATE());

-- ## 	see the calculative age column max and min age.
SELECT 
	min(age) AS youngest,
    max(age) AS oldest
FROM hrd;

-- ## 	see the valid values of age column.
SELECT count(*) FROM hrd WHERE age < 18;

-- ## 	see the valid values of termdate column.
SELECT COUNT(*) FROM hrd WHERE termdate > CURDATE();


-- ## 	see the empty like '0000-00-00' values of termdate column.
SELECT COUNT(*)
FROM hrd
WHERE termdate = '0000-00-00';

SELECT location FROM hrd;