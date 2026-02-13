-- ============================================
-- SQL Security Log Investigation
-- ============================================

-- 1. Retrieve all failed login attempts
SELECT *
FROM log_in_attempts
WHERE success = FALSE;


-- 2. Retrieve login attempts outside business hours (before 08:00 or after 18:00)
SELECT *
FROM log_in_attempts
WHERE login_time < '08:00:00'
   OR login_time > '18:00:00';


-- 3. Retrieve login attempts from outside the United States
SELECT *
FROM log_in_attempts
WHERE country != 'United States';


-- 4. Retrieve employees from the IT department
SELECT *
FROM employees
WHERE department = 'IT';


-- 5. Retrieve employees located in the New York office
SELECT *
FROM employees
WHERE office = 'New York';


-- 6. Retrieve employees from Finance or Sales departments
SELECT *
FROM employees
WHERE department = 'Finance'
   OR department = 'Sales';


-- 7. Retrieve employees NOT in the HR department
SELECT *
FROM employees
WHERE department != 'HR';


-- 8. Retrieve employees whose name starts with 'A'
SELECT *
FROM employees
WHERE name LIKE 'A%';
