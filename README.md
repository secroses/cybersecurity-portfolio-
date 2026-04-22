# Cybersecurity Portfolio

**SECROSES** · Cybersecurity & IT Student · Mexico City

![Linux](https://img.shields.io/badge/Linux-CLI_%26_Hardening-FCC624?style=flat-square&logo=linux&logoColor=black)
![GCP](https://img.shields.io/badge/Google_Cloud-Security-4285F4?style=flat-square&logo=googlecloud&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-Log_Analysis-4479A1?style=flat-square&logo=mysql&logoColor=white)
![Python](https://img.shields.io/badge/Python-Beginner-3776AB?style=flat-square&logo=python&logoColor=white)
![Status](https://img.shields.io/badge/Open_to-Help_Desk_%2F_SOC_Jr-brightgreen?style=flat-square)

Hands-on security research and lab work built while pursuing a B.S. in Information Technologies (Universidad Nacional Rosario Castellanos) and independent cybersecurity training. Current focus: SOC analysis, threat detection, and AI security.

---

## About Me

- 🎓 2nd semester — Licenciatura en Tecnologías de la Información (UNRC, online)
- 🛡️ Active participant in **MenCISO** mentorship program (ransomware simulation, PCI-DSS, AI Red Teaming)
- 📜 **Google Cloud Cybersecurity Certificate** (Google Cloud, Apr 2026)
- 📜 **Google IT Support Professional Certificate** (Coursera, Dec 2025)
- 📜 **Google Cloud Computing Foundations** + 4 additional GCP badges (Oct 2025)
- 📜 **Cisco Intro to Cybersecurity** (Jul 2025)
- 🎯 Target role: Help Desk / SOC Jr — 6-month timeline

**Core skills:** Linux CLI · File permissions & hardening · Log analysis with SQL · Access control (PoLP) · Cloud networking (GCP) · Threat modeling (PASTA) · C++ with file persistence · Python (beginner)

---

## Repository Structure

```
cybersecurity-portfolio/
├── ai-security/
│   └── llm-prompt-injection-cbrn/     # LLM Red Teaming — CBRN filter bypass
├── cloud-incident-response/
│   └── Cymbal-Retail-Case/            # GCP incident response & PCI DSS remediation
├── linux/
│   └── file-permissions/              # Linux permissions lab
├── sql/
│   └── security-investigation/        # Log analysis with SQL
├── threat-modeling-pasta-sneaker-app/ # PASTA threat model — e-commerce app
├── vulnerability-assessments/
│   └── ecommerce-database-exposure/   # Database vulnerability report
└── LICENSE
```

---

## Projects

### 🔬 AI Security — LLM Prompt Injection (CBRN Filter Bypass)
`ai-security/llm-prompt-injection-cbrn/`

Red Teaming exercise conducted during the **MenCISO AI Security session** (April 2026), focused on evaluating LLM safety guardrails using the **PropensityBench** framework developed by Scale AI.

**Techniques used:** Context Smuggling (institutional authority framing) + Cognitive Load (structured JSON output to degrade semantic safety evaluation).

**Result:** Successful bypass (LLM01 + LLM02). Output redacted per responsible disclosure standards.

**PropensityBench scores for context (March 2026):**

| Model | Propensity Score | Risk Level |
|---|---|---|
| o3-2025-04-16 | 10.5% | 🟢 Leader in safety |
| Claude Sonnet 4 | 12.2% | 🟢 High resilience |
| GPT-4o | 46.1% | 🟡 Medium risk |
| Gemini 2.0 Flash | 77.8% | 🔴 High risk |
| Gemini 2.5 Pro | 79.0% | 🔴 Maximum risk |

📄 [Full report →](./ai-security/llm-prompt-injection-cbrn/report.md)

---

### ☁️ Cloud Incident Response — Cymbal Retail Case (GCP)
`cloud-incident-response/Cymbal-Retail-Case/`

Full incident response lifecycle for a simulated data breach at a global retail organization on Google Cloud Platform. From initial vulnerability assessment through containment, recovery, and PCI DSS 3.2.1 compliance validation.

**Key actions:** VM isolation & restoration from snapshot · Public bucket ACL revocation · IAP-only SSH enforcement · Firewall rule hardening · PCI DSS re-audit confirmation.

**Tools:** Security Command Center · Identity-Aware Proxy · Compute Engine · Cloud Storage IAM · gcloud CLI

📄 [Full write-up →](./cloud-incident-response/Cymbal-Retail-Case/README.md)

---

### 🧩 Threat Modeling — PASTA Framework (Sneaker App)
`threat-modeling-pasta-sneaker-app/`

Structured threat model for an e-commerce sneaker application using the **PASTA** (Process for Attack Simulation and Threat Analysis) methodology. Covers attack surface enumeration, threat actor profiling, and risk-prioritized mitigations.

📄 [Full report →](./threat-modeling-pasta-sneaker-app/README.md)

---

### 🗄️ Vulnerability Assessment — E-commerce Database Exposure
`vulnerability-assessments/ecommerce-database-exposure/`

Structured vulnerability assessment documenting a database exposure risk in an e-commerce environment. Includes risk classification, impact analysis, and remediation recommendations aligned with security best practices.

📄 [Full report →](./vulnerability-assessments/ecommerce-database-exposure/README.md)

---

### 🐧 Linux — File Permissions Lab
`linux/file-permissions/`

Hands-on lab covering Linux file permission management: `chmod`, `chown`, permission bits, and security hardening principles (Principle of Least Privilege). Includes baseline analysis, command execution, and verification screenshots.

📄 [Lab notes →](./linux/file-permissions/README.md)

---

### 🔍 SQL — Security Investigation
`sql/security-investigation/`

Log analysis exercise using SQL to investigate a simulated security incident. Demonstrates filtering, aggregation, and pattern detection techniques applicable to SOC tier-1 workflows.

📄 [Queries & write-up →](./sql/security-investigation/README.md)

---

## Certifications & Badges

| Credential | Issuer | Date |
|---|---|---|
| **Google Cloud Cybersecurity Certificate** | Google Cloud | **Apr 2026** |
| Google IT Support Professional Certificate v3 | Coursera / Google | Dec 2025 |
| Google Cloud Computing Foundations | Google Cloud | Oct 2025 |
| Build a Secure Google Cloud Network | Google Cloud | Oct 2025 |
| Implement Load Balancing on Compute Engine | Google Cloud | Oct 2025 |
| Prepare Data for ML APIs on Google Cloud | Google Cloud | Oct 2025 |
| Set Up an App Dev Environment on Google Cloud | Google Cloud | Oct 2025 |
| Intro to Cybersecurity | Cisco | Jul 2025 |
| Career Management Essentials | IBM SkillsBuild | Mar 2026 |
| Digital Mindset | IBM SkillsBuild | Mar 2026 |
| Working in a Digital World | IBM SkillsBuild | Mar 2026 |

---

## Ethical Commitment

All security research in this portfolio was conducted in controlled educational environments under professional supervision. Responsible disclosure standards are applied to all findings — exploitation techniques and methodology are documented; regulated or sensitive data obtained during exercises is redacted before any public release.

---

*Currently building toward CompTIA Security+ · Open to Help Desk and SOC Jr opportunities in Mexico City*
