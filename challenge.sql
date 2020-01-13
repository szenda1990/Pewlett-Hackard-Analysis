--Module 07 Challenge
-- New inner join table
DROP TABLE t_retire CASCADE;
SELECT employees.emp_no,
     employees.first_name,
     employees.last_name,
     titles.title,
	 titles.from_date,
	 titles.to_date,
	 salaries.salary
INTO t_retire
FROM employees
	INNER JOIN titles
		ON (employees.emp_no = titles.emp_no)
	INNER JOIN salaries
		ON (employees.emp_no = salaries.emp_no)
		
SELECT * FROM t_retire

-- Duplicate names
SELECT
	first_name,
	last_name,
	count(*)
FROM t_retire
GROUP BY
	first_name,
	last_name
HAVING count(*) > 1

-- Delete duplicates
SELECT DISTINCT ON (first_name, last_name) * FROM t_retire;
DELETE FROM t_retire WHERE t_retire.emp_no NOT IN
(SELECT emp_no FROM(SELECT DISTINCT ON (first_name, last_name) * 
	FROM t_retire))