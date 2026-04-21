# 🛡️ Threat Modeling with PASTA – Sneaker Marketplace App

**Analyst:** SECROSES
**Role Focus:** Junior SOC Analyst / Cloud Security

---

## 📌 Overview

This project applies the **PASTA (Process for Attack Simulation and Threat Analysis)** methodology to identify, analyze, and mitigate security risks in a sneaker marketplace mobile application.

The objective is to simulate a **real-world cybersecurity assessment**, aligning with industry practices and frameworks.

---

## 🎯 Business & Security Objectives (Stage I)

* **Data Privacy:** Protect user personal and financial information
* **Secure Transactions:** Prevent fraud and unauthorized payments
* **Service Availability:** Ensure platform uptime and reliability

---

## 🏗️ Technical Scope & Architecture (Stages II & III)

### 🔧 Tech Stack

* API-based architecture
* SQL Database
* Encryption: AES-256
* Hashing: SHA-256 *(recommended: bcrypt)*
* PKI for secure communication

### 🔄 Data Flow Description

1. User submits credentials via Mobile App
2. App communicates with Backend API
3. API processes request and interacts with Database
4. Response is returned to user

---

## 📊 Data Flow Diagram (DFD)

![Data Flow Diagram](./images/DataFlowDiagram.png)

### 🔍 Diagram Explanation

The diagram illustrates the interaction between the user, mobile application, backend API, and database.

* Trust boundaries separate external and internal systems
* Sensitive data flows include credentials and payment information
* Encryption is applied using TLS 1.3 (data in transit)
* AES-256 is used for data at rest
* Authentication points include MFA for user validation

---

## ⚠️ Threat & Vulnerability Analysis (Stages IV & V)

### 1. SQL Injection

**Mapped to:** OWASP Top 10 (A03: Injection)

* **Attack Vector:** Unsanitized user input in login or search fields

* **Impact:**

  * Unauthorized database access
  * Data exfiltration (credentials, payment info)
  * Potential full system compromise

* **Likelihood:** High

* **Risk Level:** Critical

---

### 2. Social Engineering / Phishing

* **Attack Vector:** Fake login interfaces or impersonation

* **Impact:**

  * Credential theft
  * Account takeover

* **Likelihood:** High

* **Risk Level:** High

---

### 3. Unencrypted Sensitive Data

* **Attack Vector:** Data transmitted or stored without encryption

* **Impact:**

  * Exposure of financial data
  * Compliance violations

* **Likelihood:** Medium

* **Risk Level:** High

---

## 🛡️ Mitigation Strategies (Stage VII)

| Threat              | Mitigation                                  |
| ------------------- | ------------------------------------------- |
| SQL Injection       | Prepared Statements / Parameterized Queries |
| Weak Authentication | Multi-Factor Authentication (MFA)           |
| Data Exposure       | AES-256 (at rest) + TLS 1.3 (in transit)    |

### 🔐 Additional Controls

* Input validation and sanitization
* Secure password storage (bcrypt + salt)
* Role-Based Access Control (RBAC)
* Regular penetration testing

---

## 📊 Risk Summary

The most critical risk identified is **SQL Injection**, due to its high likelihood and severe impact.

If exploited, it could result in:

* Full database compromise
* Financial losses
* Reputational damage

---

## 🚀 Conclusion

Applying structured threat modeling using PASTA enables proactive identification of vulnerabilities before exploitation.

Security must be:

* Continuous
* Layered
* Integrated into development processes (DevSecOps mindset)

---

## 🧠 Skills Demonstrated

* Threat Modeling
* Risk Analysis
* Secure Architecture Design
* Alignment with OWASP Top 10
* Cybersecurity Documentation

---

## 🔗 Future Improvements

* Integrate STRIDE for deeper threat classification
* Simulate real attacks (e.g., SQL Injection lab)
* Add logging and monitoring (SIEM perspective)
* Include attack surface visualization

---

## 📌 Notes

This project is intended for educational and portfolio purposes, demonstrating practical application of threat modeling in a real-world scenario.

