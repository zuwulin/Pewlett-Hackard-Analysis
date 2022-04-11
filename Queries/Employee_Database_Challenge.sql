
--Create retirement by titles table (for 1952 - 1955)
select e.emp_no,
e.first_name,
e.last_name,
t.title,
t.from_date,
t.to_date
INTO ret_titles
FROM employees as e
INNER JOIN title as t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no;

-- Use Dictinct with Orderby to remove duplicate rows and create a new table with only recent titles of current employees
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
rt.first_name,
rt.last_name,
rt.title
INTO unique_titles
FROM ret_titles as rt
WHERE (rt.to_date = '9999-01-01')
ORDER BY emp_no ASC, to_date DESC;

--Count the retiring employees by title
SELECT COUNT(ut.emp_no), ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY ut.title
ORDER BY COUNT DESC;
