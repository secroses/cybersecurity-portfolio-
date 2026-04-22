![AppSec](https://img.shields.io/badge/Domain-Application_Security-8A2BE2?style=for-the-badge&logo=owasp&logoColor=white)
![ThreatModeling](https://img.shields.io/badge/Focus-Threat_Modeling_(PASTA)-FF4500?style=for-the-badge)
![Methodology](https://img.shields.io/badge/Methodology-Risk__Assessment-0052CC?style=for-the-badge)
![Architecture](https://img.shields.io/badge/Tech_Stack-API_&_SQL-336791?style=for-the-badge&logo=database&logoColor=white)

# Threat Modeling & Attack Simulation (PASTA): E-Commerce Architecture

**Tagline:** Proactive risk assessment and secure architecture design for a high-traffic mobile marketplace using the Process for Attack Simulation and Threat Analysis (PASTA) methodology.

---

## 1. Project Metadata

| Attribute | Detail |
| :--- | :--- |
| **Author** | Edgar Yair Rosas Flores (oblivionroot) |
| **Simulated Role** | Cloud Security Engineer / AppSec Analyst |
| **Target System** | Sneaker Marketplace Mobile Application (API-based) |
| **Status** | Completed - Threat Model Finalized |
| **Core Concept** | PASTA Framework, Threat Intelligence, OWASP Top 10 Mitigation |

---

## 2. Executive Summary / Business Value

In the highly targeted retail and e-commerce sector, mobile marketplaces handling PII (Personally Identifiable Information) and PCI (Payment Card Industry) data are prime targets for financial fraud and data exfiltration. Reactive security is insufficient for modern API-driven architectures.

This architectural audit utilizes the **PASTA** methodology to systematically bridge business objectives with technical realities. By decomposing the application's data flow, identifying trust boundaries, and simulating realistic attack vectors, this report provides a comprehensive blueprint for mitigating critical vulnerabilities (such as SQL Injection and credential theft) before they reach production. The result is a resilient, "Secure by Design" infrastructure that protects user privacy, ensures transaction integrity, and maintains platform availability.

---

## 3. Architecture & Flow Analysis

### Logical Data Flow & Trust Boundary Mapping (*Architecture Flow*)

```text
       [ External Threat Landscape ]
                 | (Attack Vectors: Phishing / MITM)
                 v
          +-------------+
          | Mobile App  | <=== [ Trust Boundary 1: Client / MFA / Input Auth ]
          +-------------+
                 | (Encrypted Transit: TLS 1.3 / PKI)
                 v
          +-------------+
          | Backend API | <=== [ Trust Boundary 2: Parametrized Queries / WAF ]
          +-------------+
                 | (Internal Microservices / VPC)
                 v
          +-------------+
          | SQL Database| <=== [ Data at Rest: AES-256 / bcrypt Hashing ]
          +-------------+
```

**Visual Architecture Reference:**
![Data Flow Diagram](./images/DataFlowDiagram.png)
> *Note: The diagram above details the interaction between the client application, middleware API, and database, highlighting critical encryption nodes and authentication checkpoints.*

---

## 4. Methodology / Approach

The assessment followed the risk-centric **PASTA** framework, ensuring that technical mitigations directly support business continuity:

1. **Stages I & II (Business & Tech Scope):** Defined core assets—protecting user PII, securing payment gateways, and mapping the API/SQL technology stack (AES-256, SHA-256/bcrypt, PKI).
2. **Stage III (Application Decomposition):** Charted data flows to identify where sensitive data is processed, transmitted, and stored, establishing clear trust boundaries.
3. **Stages IV & V (Threat & Vulnerability Analysis):** Mapped infrastructure weaknesses against the OWASP Top 10 framework, evaluating the likelihood and potential impact of active exploits.
4. **Stages VI & VII (Attack Modeling & Risk Mitigation):** Developed specific, actionable engineering controls to remediate identified flaws and harden the attack surface.

---

## 5. Technical Execution & Threat Mitigation

Based on the architectural decomposition, the following critical threat vectors were isolated and addressed.

### A. SQL Injection (Mapped to OWASP A03: Injection)
* **Attack Vector:** Unsanitized user inputs within the mobile app's authentication or search modules payloading malicious SQL commands to the backend API.
* **Risk Level:** **Critical** (High Likelihood / Severe Impact). Exploitation leads to unauthorized database dumping, exfiltration of payment data, and potential Remote Code Execution (RCE).
* **Technical Mitigation:** Strict enforcement of **Prepared Statements (Parameterized Queries)** at the API layer. Implementation of rigorous input validation (allow-listing) before data reaches the SQL interpreter.

### B. Credential Harvesting & Account Takeover (ATO)
* **Attack Vector:** Social engineering, phishing, or credential stuffing attacks against the mobile login interface.
* **Risk Level:** **High**. Leads to unauthorized transactions and loss of user trust.
* **Technical Mitigation:** Deployment of **Multi-Factor Authentication (MFA)**. Transitioning password hashing algorithms from SHA-256 to **bcrypt** with unique salts to mitigate rainbow table and brute-force attacks on compromised databases.

### C. Cryptographic Failures (Data Exposure)
* **Attack Vector:** Interception of traffic via Man-in-the-Middle (MITM) attacks or unauthorized access to underlying storage volumes.
* **Risk Level:** **High**. Direct violation of data privacy regulations (GDPR/PCI-DSS).
* **Technical Mitigation:** Mandating **TLS 1.3** coupled with a robust Public Key Infrastructure (PKI) for all data in transit. Enforcing **AES-256** encryption for all sensitive data at rest within the SQL environment.

---

## 6. Results & Impact

* **Quantifiable Risk Reduction:** By identifying SQLi and cryptographic flaws during the modeling phase, the cost and impact of post-deployment patching were effectively eliminated.
* **Secure Data Lifecycle:** Established a hardened data pipeline where PII is protected both at rest and in transit, ensuring regulatory compliance.
* **DevSecOps Integration:** Provided a clear set of security requirements (MFA, Parametrization, bcrypt) that can be integrated directly into the CI/CD pipeline as development tickets.

---

## 7. Best Practices / Next Steps

To mature the application's security posture, the following engineering initiatives are recommended:
1. **STRIDE Integration:** Cross-reference the current model with the STRIDE framework (Spoofing, Tampering, Repudiation, Information Disclosure, Denial of Service, Elevation of Privilege) for deeper component-level threat classification.
2. **Penetration Testing / DAST:** Execute Dynamic Application Security Testing targeting the API endpoints to validate the effectiveness of the parameterized queries.
3. **SIEM Telemetry:** Implement centralized logging and monitoring for the backend API to detect and alert the SOC of anomalous login spikes or SQL error generation in real-time.
4. **RBAC Hardening:** Audit and enforce strict Role-Based Access Control within the database tier to ensure the API service account operates under the Principle of Least Privilege.

---

## 8. What this demonstrates

* **Threat Modeling Mastery:** Ability to apply industry-standard frameworks (PASTA) to deconstruct complex architectures and identify systemic risks.
* **Secure Architecture Design:** Expertise in designing encrypted, resilient data flows mapping trust boundaries and cryptographic controls (AES-256, TLS 1.3, PKI).
* **Risk Analysis & Prioritization:** Capability to translate technical vulnerabilities (OWASP Top 10) into business risk (Likelihood vs. Impact) to prioritize remediation efforts.
* **DevSecOps Mindset:** Shifting security left by defining actionable, technical mitigations (Prepared Statements, bcrypt, MFA) before the deployment phase.

---

## 9. References & Compliance

* **OWASP Top 10:** Application Security Risks 
* **PASTA Framework:** Risk Centric Threat Modeling Methodology
* **PCI-DSS Compliance:** Payment Card Industry Data Security Standard guidelines for e-commerce architecture
