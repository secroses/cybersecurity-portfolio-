# SQL Security Log Investigation

## Overview

This project simulates a real-world security investigation using SQL to analyze login activity and employee records.

The objective is to identify suspicious login attempts, detect activity outside business hours, and filter employee information based on specific security-related criteria.

---

## Scenario

The organization detected unusual login attempts and requested an internal investigation.

As a security analyst, the task was to:

- Review login activity records
- Identify failed login attempts
- Detect logins outside business hours
- Filter employees by department and office location

The analysis was performed using structured SQL queries.

---

## Objectives

- Analyze authentication logs
- Identify suspicious login patterns
- Apply conditional filtering (AND, OR, NOT, LIKE)
- Extract relevant employee data for further review

---

## Database Tables Used

### `log_in_attempts`

| Column | Description |
|--------|------------|
| employee_id | Unique employee identifier |
| login_date | Date of login attempt |
| login_time | Time of login attempt |
| country | Country of login |
| success | Login status (TRUE/FALSE) |

### `employees`

| Column | Description |
|--------|------------|
| employee_id | Unique employee identifier |
| name | Employee name |
| department | Department name |
| office | Office location |

---

## Investigation Queries

The full SQL script used in this investigation is available here:

🔗 **[View Full SQL Script](queries.sql)**

---

## Query Breakdown

### 1️⃣ Retrieve all failed login attempts

Identifies unsuccessful authentication attempts that may indicate brute-force attacks or unauthorized access attempts.

---

### 2️⃣ Retrieve login attempts outside business hours

Detects logins before 08:00 or after 18:00, which may indicate suspicious behavior.

---

### 3️⃣ Retrieve logins from outside the country

Identifies login attempts that originated from outside the organization's main operating country.

---

### 4️⃣ Retrieve employees from specific departments

Filters employees working in departments relevant to the investigation.

---

## Skills Demonstrated

- SQL data filtering
- Logical operators (AND, OR, NOT)
- Pattern matching using LIKE
- Security log analysis
- Incident investigation methodology
- Structured technical documentation

---

## Tools Used

- SQL (Structured Query Language)
- Relational Database Environment
- Git & GitHub for version control

---

## Author

Yair  
Cybersecurity Student
