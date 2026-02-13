# SQL Security Log Investigation

## 1. Description

This lab simulates a basic security investigation using SQL.  
Authentication logs and employee records were analyzed to identify suspicious login activity and apply structured data filtering techniques.

The project reflects tasks commonly performed by a Tier 1 SOC Analyst during log review and incident investigation.

---

## 2. Objective

The objective of this investigation was to:

- Identify failed login attempts after business hours
- Analyze login activity on specific dates
- Detect login attempts originating outside Mexico
- Filter employee records by department and office location

---

## 3. Queries Performed

The investigation included:

- Filtering login attempts by time and success status
- Filtering records using specific dates
- Pattern matching using `LIKE` and wildcard `%`
- Combining conditions using `AND` and `OR`
- Excluding data using `NOT` and `!=`

The complete SQL script is available in the `queries.sql` file.

---

## 4. Technical Explanation

- `AND` was used to combine multiple filtering conditions.
- `OR` allowed retrieving records matching different criteria.
- `NOT` excluded specific values from results.
- `LIKE` enabled pattern matching for structured values such as country codes.
- `%` acted as a wildcard to represent any number of characters.
- Date and time filtering allowed targeted log analysis.

---

## 5. Security Relevance

This lab demonstrates how SQL can support:

- Log review processes
- Detection of suspicious login behavior
- Investigation of unauthorized access attempts
- Structured data analysis for incident response

Understanding how to query authentication logs is a foundational skill in cybersecurity operations.

---

## 6. Skills Demonstrated

- SQL query construction
- Logical operators (`AND`, `OR`, `NOT`)
- Pattern matching with `LIKE`
- Log analysis fundamentals
- Security-focused data filtering
- Analytical thinking
