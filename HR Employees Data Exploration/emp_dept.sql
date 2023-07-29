
--SELECT *
--FROM employees

--SELECT *
--FROM departments

--Employees with base salary greater than or equal to 5000

SELECT  CONCAT(first_name,' ', last_name) AS Full_Name, 
		phone, base_salary
FROM employees
WHERE base_salary >= 5000
ORDER BY 3 DESC, 1

--Employees with base salary less than or equal to 5000

SELECT  CONCAT(first_name,' ', last_name) AS Full_Name, 
		phone, base_salary
FROM employees
WHERE base_salary <= 5000
ORDER BY 3 DESC, 1

--Employees with base salary between 1000 and 2000

SELECT  CONCAT(first_name,' ', last_name) AS Full_Name, 
		phone, base_salary
FROM employees
WHERE base_salary BETWEEN 1000 AND  2000
ORDER BY 3 DESC, 1

--Employees with base salary between 1600, 2700 and 4200

SELECT  CONCAT(first_name,' ', last_name) AS Full_Name, 
		phone, base_salary
FROM employees
WHERE base_salary IN(1600, 2700, 4200)
ORDER BY 3 DESC, 1

--Employees hired before 2005

SELECT  CONCAT(first_name,' ', last_name) AS Full_Name, 
		hire_date, phone, base_salary
FROM employees
WHERE hire_date < '2004-12-31'

--Employees hired between 2008 and 2010

SELECT  CONCAT(first_name,' ', last_name) AS Full_Name, 
		hire_date, phone, base_salary
FROM employees
WHERE hire_date
BETWEEN  '2008-01-01' AND '2010-12-31'

--Employee with last name as 'Oles'

SELECT  *
FROM employees
WHERE last_name like '%oles'

--Employees living in Florida

SELECT  CONCAT(first_name,' ', last_name) AS Full_Name, state
FROM employees
WHERE state = 'FL'

--Employees whose Job Title starts with Data

SELECT  CONCAT(first_name,' ', last_name) AS Full_Name, job_title
FROM employees
WHERE job_title like 'Data%'

--Employees who live in New Jersey and with base salary equal to 1800 or 2200

SELECT  CONCAT(first_name,' ', last_name) AS Full_Name, 
		state , base_salary
FROM employees
WHERE state = 'NJ'
AND (base_salary = 1800 OR base_salary = 2200)

-- Employees hired before 2015 with 1600 as base salary and commission rate less than or equal to 35%

SELECT hire_date, base_salary, commission_pct
FROM employees
WHERE hire_date < '2014-12-31' 
AND base_salary = 1600 
AND commission_pct <= 0.35

--Calculation of Net Salary for all employees

SELECT CONCAT(first_name,' ', last_name) AS Full_Name, base_salary,
			base_salary + (base_salary * commission_pct) as Net_Salary
FROM employees

--Calculation of employees whose commission > 2000

SELECT CONCAT(first_name,' ', last_name) AS Full_Name,
			base_salary * commission_pct as Commission
FROM employees
WHERE base_salary * commission_pct > 2000
order by 2 DESC

--A report of employees for payroll

SELECT CONCAT(first_name,' ', last_name) AS Full_Name,
			CONCAT(email, '@pumpin.com') AS email_address,
			job_title,
			hire_date,
			base_salary + (base_salary * commission_pct) as Net_Salary,
			base_salary
FROM employees
ORDER BY job_title, base_salary, hire_date

--All employees hired by their state and job title

SELECT DISTINCT state, job_title 
FROM employees
ORDER BY state, job_title

--Case statement showing states full names

SELECT  CONCAT(first_name,' ', last_name) AS Full_Name,
		CASE state
			WHEN 'AK' THEN 'Alaska'
			WHEN 'AR' THEN 'Arizona'
			WHEN 'AZ' THEN 'Arizona'
			WHEN 'CA' THEN 'California'
			WHEN 'CO' THEN 'Colorado'
			WHEN 'CT' THEN 'Connecticut'
			WHEN 'DC' THEN 'Washington, D.C.'
			WHEN 'FL' THEN 'Florida'
			WHEN 'GA' THEN 'Georgia'
		ELSE 'Other'
		END AS FullStateName
FROM employees

-- Calculation of Employees net salary including income tax

SELECT CONCAT(first_name,' ', last_name) AS Full_Name,
		base_salary, 
		CONCAT(email, '@pumpin.com') AS email_address,
		(base_salary * commission_pct) AS Commission, 
		CASE
			WHEN base_salary < 1000 THEN 0
			WHEN base_salary BETWEEN 1001 AND 2500 THEN base_salary *0.07
			WHEN base_salary BETWEEN 2501 AND 5000 THEN base_salary *0.09
			WHEN base_salary BETWEEN 5001 AND 7000 THEN base_salary *0.11
		ELSE base_salary * 0.15
		END AS IncomeTax,
		base_salary
		+ (base_salary * commission_pct)
		- CASE
			WHEN base_salary < 1000 THEN 0
			WHEN base_salary BETWEEN 1001 AND 2500 THEN base_salary *0.07
			WHEN base_salary BETWEEN 2501 AND 5000 THEN base_salary *0.09
			WHEN base_salary BETWEEN 5001 AND 7000 THEN base_salary *0.11
		ELSE base_salary * 0.15
		END AS Net_Salary
FROM employees

--Using CTE for the calculation of Employees net salary including income tax

WITH EmployeeNetSalary(Full_Name, base_salary, email_address, Commission, IncomeTax, Net_Salary) AS
		(SELECT CONCAT(first_name,' ', last_name) AS Full_Name,
		base_salary,
		CONCAT(email, '@pumpin.com') AS email_address,
		(base_salary * commission_pct) AS Commission, 
		CASE
			WHEN base_salary < 1000 THEN 0
			WHEN base_salary BETWEEN 1001 AND 2500 THEN base_salary *0.07
			WHEN base_salary BETWEEN 2501 AND 5000 THEN base_salary *0.09
			WHEN base_salary BETWEEN 5001 AND 7000 THEN base_salary *0.11
		ELSE base_salary * 0.15
		END AS IncomeTax,
		base_salary
		+ (base_salary * commission_pct)
		- CASE
			WHEN base_salary < 1000 THEN 0
			WHEN base_salary BETWEEN 1001 AND 2500 THEN base_salary *0.07
			WHEN base_salary BETWEEN 2501 AND 5000 THEN base_salary *0.09
			WHEN base_salary BETWEEN 5001 AND 7000 THEN base_salary *0.11
		ELSE base_salary * 0.15
		END AS Net_Salary
FROM employees)
SELECT * 
FROM EmployeeNetSalary

-- Using Temp Table for the calculation of Employees net salary including income tax

DROP TABLE IF EXISTS #EmployeeNetSalary
CREATE TABLE #EmployeeNetSalary( 
		Full_Name varchar(100),
		Base_salary int,
		Email_address varchar(100),
		Commission int, 
		IncomeTax int,
		Net_Salary int)

INSERT INTO #EmployeeNetSalary		
	SELECT CONCAT(first_name,' ', last_name) AS Full_Name,
		base_salary,
		CONCAT(email, '@pumpin.com') AS email_address,
		(base_salary * commission_pct) AS Commission, 
		CASE
			WHEN base_salary < 1000 THEN 0
			WHEN base_salary BETWEEN 1001 AND 2500 THEN base_salary *0.07
			WHEN base_salary BETWEEN 2501 AND 5000 THEN base_salary *0.09
			WHEN base_salary BETWEEN 5001 AND 7000 THEN base_salary *0.11
		ELSE base_salary * 0.15
		END AS IncomeTax,
		base_salary
		+ (base_salary * commission_pct)
		- CASE
			WHEN base_salary < 1000 THEN 0
			WHEN base_salary BETWEEN 1001 AND 2500 THEN base_salary *0.07
			WHEN base_salary BETWEEN 2501 AND 5000 THEN base_salary *0.09
			WHEN base_salary BETWEEN 5001 AND 7000 THEN base_salary *0.11
		ELSE base_salary * 0.15
		END AS Net_Salary
FROM employees

SELECT *
FROM #EmployeeNetSalary

-- Full report of job titles per state, count of employees, average and minimum base salary, sum amount of net salary, maximum commission rate

SELECT job_title,
		state,
		count(*) AS CountEmp,
		AVG(base_salary) AvgBaseSal,
		MIN(base_salary) MinBaseSal,
		SUM(base_salary + (base_salary * commission_pct)) as TotalNetSal,
		MAX(commission_pct) AS MaxCommPct
FROM employees
GROUP BY state, job_title
ORDER BY 3 DESC, 4 DESC

-- Removing records with no more than one employee per state using Having

SELECT job_title,
		state,
		count(*) AS CountEmp,
		AVG(base_salary) AS AvgBaseSal,
		MIN(base_salary) AS MinBaseSal,
		SUM(base_salary + (base_salary * commission_pct)) as TotalNetSal,
		MAX(commission_pct) AS MaxCommPct
FROM employees
GROUP BY state, job_title
HAVING count(*) > 1 AND MIN(base_salary) > 1200
ORDER BY 3 DESC, 4 DESC

--Using CTE

WITH CountEmpLessThanOne(job_title, state, CountEmp, AvgBaseSal, MinBaseSal, TotalNetSal, MaxCommPct) AS
	(SELECT job_title,
		state,
		count(*) AS CountEmp,
		AVG(base_salary) AS AvgBaseSal,
		MIN(base_salary) AS MinBaseSal,
		SUM(base_salary + (base_salary * commission_pct)) as TotalNetSal,
		MAX(commission_pct) AS MaxCommPct
FROM employees
GROUP BY state, job_title
HAVING count(*) > 1 AND MIN(base_salary) > 1200)
SELECT *
FROM CountEmpLessThanOne

--Employees in California with base salary less than min base salary in Florida using Nested Queries

SELECT CONCAT(first_name,' ', last_name) AS Full_Name,
		base_salary
FROM employees
WHERE state = 'CA'
AND base_salary < (SELECT MIN(base_salary)
					FROM employees
					WHERE state = 'FL'
					)

--Joining employees table with departments table

SELECT CONCAT(first_name,' ', last_name) AS Full_Name, emp.job_title, emp.department_id, dep.name 
FROM employees as emp
INNER JOIN departments as dep
ON emp.department_id = dep.id
--WHERE name = 'Sales'

--Inserting a new record into a table

INSERT INTO	employees VALUES
(394, 'Ademoye', 'Oluwaseun', NULL, 'NY', NULL, NULL, NULL, NULL, 1, 'Technician', 1800, NULL)

-- Updating above record's field values

UPDATE employees
SET address = '2451 Ikotun St, Lagos',
	zip_code = 73097,
	hire_date = GETDATE(),
	phone = '356-788-8618',
	commission_pct = 0.0,
	email = LOWER(CONCAT(SUBSTRING(first_name, 1,1), last_name)) FROM employees
WHERE id = 394

--Creating View

CREATE VIEW emp_admin AS
	SELECT id, CONCAT(first_name, last_name) AS Full_Name, job_title, address, phone, zip_code
	FROM employees

SELECT *
FROM emp_admin




