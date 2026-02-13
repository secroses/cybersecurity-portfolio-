-- Failed login attempts after 18:00
SELECT *
FROM log_in_attempts
WHERE login_time > '18:00'
AND success = FALSE;

-- Login attempts on specific dates
SELECT *
FROM log_in_attempts
WHERE login_date = '2022-05-09'
OR login_date = '2022-05-08';

-- Login attempts outside Mexico
SELECT *
FROM log_in_attempts
WHERE NOT country LIKE 'MEX%';

-- Marketing employees in East office
SELECT *
FROM employees
WHERE department = 'Marketing'
AND office LIKE 'East%';

-- Employees in Sales or Finance
SELECT *
FROM employees
WHERE department = 'Sales'
OR department = 'Finance';

-- Employees not in IT
SELECT *
FROM employees
WHERE department != 'Information Technology';
