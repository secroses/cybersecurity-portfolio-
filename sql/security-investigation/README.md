![SQL](https://img.shields.io/badge/Language-SQL-003B57?style=for-the-badge&logo=postgresql&logoColor=white)
![Security](https://img.shields.io/badge/Domain-Cybersecurity-000000?style=for-the-badge&logo=security&logoColor=white)
![Audit](https://img.shields.io/badge/Focus-Log_Analysis_&_Threat_Hunting-FF4500?style=for-the-badge)
![Database](https://img.shields.io/badge/Tech_Stack-RDBMS-336791?style=for-the-badge&logo=database&logoColor=white)

# Security Log Audit: Identity & Access Threat Hunting via SQL

**Tagline:** Proactive threat hunting and anomaly detection across corporate authentication logs leveraging advanced SQL querying to mitigate unauthorized access and brute-force vectors.

---

## 1. Project Metadata

| Attribute | Detail |
| :--- | :--- |
| **Author** | Edgar Yair Rosas Flores (oblivionroot) |
| **Simulated Role** | Security Analyst / Threat Hunter |
| **Tech Stack / Target System** | SQL, Relational Database Environment |
| **Status** | Completed - Audit Finalized |
| **Core Concept** | IAM Auditing, Log Analysis, Insider Threat Detection |

---

## 2. Executive Summary / Business Value

Following automated alerts regarding unusual authentication patterns, an internal security investigation was initiated to audit organizational access logs. Unmonitored authentication endpoints expose the infrastructure to credential stuffing, brute-force attacks, and compromised insider accounts. 

This project implements a structured SQL-driven audit to systematically filter, correlate, and isolate anomalous login events—such as off-hours access, geographic anomalies, and repeated authentication failures. The resulting intelligence provides actionable data for the Security Operations Center (SOC) to enforce access control policies, trigger password resets, and mitigate active threats before lateral movement can occur.

---

## 3. Architecture & Flow Analysis

### Threat Hunting Logic Flow (*Data Pipeline*)

```text
[ Authentication Endpoints ]
            | (Generates Raw Logs)
            v
+-----------------------------+
|    RDBMS / Log Database     |
| - log_in_attempts table     |
| - employees table           |
+-----------------------------+
            |
            | (SQL Query Execution via queries.sql)
            v
+=============================+=============================+
| 1. Auth Failure Analysis    | 2. Temporal/Spatial Audit   |
| (Brute-force detection)     | (Impossible travel/off-hours|
+=============================+=============================+
            |                               |
            +---------------+---------------+
                            | (Cross-reference with IAM Data)
                            v
+-----------------------------+
|    Compromised Identity     | ---> [ ACTION: Account Lockout ]
|       Isolation             | ---> [ ACTION: Alert SOC       ]
+-----------------------------+
```

---

## 4. Methodology / Approach

The investigation was executed in three critical phases:
1. **Reconnaissance & Data Structuring:** Initial assessment of the database schema (`log_in_attempts` and `employees`) to map available data points (timestamps, geo-location, success flags).
2. **Execution (Log Parsing):** Deployment of conditional SQL statements (housed in `queries.sql`) utilizing logical operators (`AND`, `OR`, `NOT`, `LIKE`) to surface deviations from baseline authentication behavior.
3. **Identity Correlation:** Cross-referencing isolated anomalous events with the employee directory to assess the risk level based on the compromised account's department and privileges.

---

## 5. Technical Execution

> 🔗 **Execution Script:** The complete set of SQL commands and raw query logic used for this investigation is fully documented in the **[`queries.sql`](./queries.sql)** file within this repository. 

Below is a breakdown of the core technical logic applied during the audit:

### A. Authentication Failure Auditing
**Objective:** Identify unsuccessful authentication attempts that indicate potential brute-force attacks or credential stuffing.
**Technical Logic:** Filtering by the boolean state of the authentication transaction to isolate unauthorized access attempts.
```sql
SELECT employee_id, login_date, login_time, country 
FROM log_in_attempts 
WHERE success = FALSE;
```

### B. Temporal Anomaly Detection
**Objective:** Detect logins occurring outside established organizational business hours (08:00 - 18:00).
**Technical Logic:** Mitigating the risk of compromised insider credentials being utilized by malicious actors during off-hours to avoid detection and execute unauthorized operations.
```sql
SELECT employee_id, login_time, success 
FROM log_in_attempts 
WHERE login_time < '08:00:00' OR login_time > '18:00:00';
```

### C. Geographic Anomaly Isolation
**Objective:** Surface login attempts originating from foreign IP infrastructure.
**Technical Logic:** Identifying impossible travel scenarios or external threat actors attempting to bypass perimeter defenses by negating the baseline operational country.
```sql
SELECT employee_id, country, login_date 
FROM log_in_attempts 
WHERE NOT country = 'US'; -- Or applicable baseline region
```

### D. Privilege & Department Correlation
**Objective:** Filter compromised or targeted identities by departmental risk (e.g., IT, Finance).
**Technical Logic:** Utilizing pattern matching and grouping to map the attack surface and prioritize incident response based on user privilege levels.
```sql
SELECT employee_id, name, department 
FROM employees 
WHERE department LIKE 'IT%' OR department = 'Finance';
```

---

## 6. Results & Impact

* **Reduced Threat Surface:** Successfully identified compromised accounts and off-hour access vectors, allowing for immediate credential revocation.
* **Proactive Intelligence:** Transformed raw, unstructured authentication logs into actionable security intelligence using scalable querying.
* **Optimized Incident Response:** The creation of the `queries.sql` script allows the SOC team to automate future log parsing, drastically reducing Mean Time to Detect (MTTD) for brute-force campaigns.

---

## 7. Best Practices / Next Steps

To harden the infrastructure and automate future threat hunting, the following implementations are recommended:
* **SIEM Integration:** Migrate the logic from `queries.sql` into a Security Information and Event Management (SIEM) tool (e.g., Splunk, Sentinel) for real-time alerting.
* **Enforce Conditional Access:** Implement Geo-blocking at the firewall/IdP level to automatically drop authentication requests from unapproved countries.
* **MFA Enforcement:** Ensure Multi-Factor Authentication is strictly required, particularly for accounts attempting off-hours or remote access.
* **Log Retention Policies:** Ensure the RDBMS logging table has a strict data lifecycle policy to maintain compliance while optimizing query performance.

---

## 8. What this demonstrates

* **Advanced SQL for Security:** Mastery of SQL filtering, boolean logic, and pattern matching applied directly to cybersecurity use cases.
* **Log Analysis & Threat Hunting:** Capability to parse large datasets to identify Indicators of Compromise (IoCs) and anomalous behavioral patterns.
* **Identity & Access Management (IAM):** Understanding of authentication vectors, insider threat indicators, and access control auditing.
* **Security Reporting:** Ability to translate raw database outputs into actionable business intelligence and security remediation steps.
