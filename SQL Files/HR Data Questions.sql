SELECT 
	*
FROM 
	hr;
    
-- 1. What is the gender breakdown of employees in the company?

SELECT 
	gender,
    COUNT(*) AS count
FROM 
	hr
WHERE
	age >= 18 AND termdate = '0000-00-00'
GROUP BY 
	gender;

#(There are more male employees) 

-- 2. What is the race/ethnicity breakdown of employees in the company?

SELECT
	race,
    COUNT(*) AS count
FROM 
	hr
WHERE 
	age >= 18 AND termdate = '0000-00-00'
GROUP BY 
	race
ORDER BY 
	count DESC;

#(White race is the most dominant while Native Hawaiian and American Indian are the least dominant.)

-- 3. What is the age distribution of employees in the company?

SELECT 
	MIN(age) AS youngest,
    MAX(age) AS oldest
FROM 
	hr 
WHERE 
	age >= 18 AND termdate = '0000-00-00';
    
#(The youngest employee is 21 years old and the oldest is 57 years old)
    
SELECT 
	CASE 
		WHEN age >= 18 AND age <= 24 THEN '18-24'
        WHEN age >= 25 AND age <= 34 THEN '25-34'
        WHEN age >= 35 AND age <= 44 THEN '35-44'
        WHEN age >= 45 AND age <= 54 THEN '45-54'
        WHEN age >= 55 AND age <= 64 THEN '55-64'
        ELSE '65+'
	END AS age_group,
	COUNT(*) AS count
FROM 
	hr 
WHERE 
	age >= 18 AND termdate = '0000-00-00'
GROUP BY 
	age_group
ORDER BY 
	age_group;

#(   5 age groups were created (18-24, 25-34, 35-44, 45-54, 55-64). A large number of employees were between 25-34 followed by 35-44 while the smallest group was 55-64)  

-- 4. How many employees work at headquarters versus remote locations?

SELECT 
	location,
    COUNT(*) AS count
FROM 
	hr
WHERE 
	age >= 18 AND termdate = '0000-00-00'
GROUP BY 
	location;

#(A large number of employees work at the headquarters versus remotely.)

-- 5. What is the average length of employment for employees who have been terminated?

SELECT 
	ROUND(AVG(DATEDIFF(termdate, hire_date))/365,0) AS avg_length_employment
FROM
	hr
WHERE 
	termdate <= CURDATE() AND termdate <> '0000-00-00'
		AND age >= 18;

#( The average length of employment for terminated employees is around 8 years.)

-- 6. How does the gender distribution vary across departments and job titles?

SELECT 
	department,
    gender,
    COUNT(*) AS count
FROM 
	hr 
WHERE 
	age >= 18 AND termdate = '0000-00-00'
GROUP BY 
	department, gender
ORDER BY 
	department;


#(The gender distribution across departments is fairly balanced but there are generally more male than female employees.)

-- 7. What is the distribution of job titles across the company?

SELECT 
	jobtitle,
    count(*) AS count
FROM 
	hr 
WHERE 
	age >= 18 AND termdate = '0000-00-00'
GROUP BY
	jobtitle
ORDER BY 
	jobtitle DESC;


#()
-- 8. Which department has the highest turnover rate?

SELECT 
	department,
    total_count,
    terminated_count,
    terminated_count/total_count AS termination_rate
FROM (
	SELECT 
		department,
        COUNT(*) AS total_count,
        SUM(CASE WHEN termdate <> '0000-00-00' AND termdate <= CURDATE() THEN 1 ELSE 0 END) AS terminated_count
	FROM
		hr 
	WHERE 
		age >= 18
	GROUP BY 
		department
        ) AS subquery
ORDER BY
	termination_rate DESC ;

#(The Marketing department has the highest turnover rate followed by Training. The least turn over rate are in the Research and development, Support and Legal departments.)

-- 9. What is the distribution of employees across locations by state?

SELECT 
	location_state,
    COUNT(*) AS count
FROM 
	hr
WHERE 
	age >= 18 AND termdate = '0000-00-00'
GROUP BY 
	location_state
ORDER BY 
	count DESC;


#(A large number of employees come from the state of Ohio.)

-- 10. How has the company's employee count changed over time based on hire and term dates?

SELECT 
	year,
    hires,
    terminations,
    hires - terminations AS net_change,
    ROUND((hires - terminations)/hires * 100,2) AS net_change_percent
FROM (
	SELECT 
		YEAR(hire_date) AS year,
        COUNT(*) AS hires,
        SUM(CASE 
			WHEN termdate <> '0000-00-00' AND termdate <= CURDATE() THEN 1 ELSE 0 END) AS terminations
	FROM 
		hr
	WHERE 
		age >= 18 
	GROUP BY 
		YEAR(hire_date) 
	) AS subquery
ORDER BY 
	year ASC;
	
    


#(The net change in employees has increased over the years.)

-- 11. What is the tenure distribution for each department?

SELECT 
	department,
    ROUND(AVG(DATEDIFF(termdate, hire_date)/365),0) AS avg_tenure
FROM
	hr
WHERE 
	termdate <= CURDATE() AND termdate <> '0000-00-00' 
		AND age >= 18
GROUP BY 
	department;



#(The average tenure for each department is about 8 years with Legal and Auditing having the highest and Services, Sales and Marketing having the lowest.)

-- 12. What is the age distribution of employees in the company based on gender?

SELECT 
	CASE 
		WHEN age >= 18 AND age <= 24 THEN '18-24'
        WHEN age >= 25 AND age <= 34 THEN '25-34'
        WHEN age >= 35 AND age <= 44 THEN '35-44'
        WHEN age >= 45 AND age <= 54 THEN '45-54'
        WHEN age >= 55 AND age <= 64 THEN '55-64'
        ELSE '65+'
	END AS age_group,
    gender,
	COUNT(*) AS count
    
FROM 
	hr 
WHERE 
	age >= 18 AND termdate = '0000-00-00'
GROUP BY 
	age_group, gender
ORDER BY 
	age_group, gender;

#(The gender distribution across departments is fairly balanced but there are generally more male than female employees.)