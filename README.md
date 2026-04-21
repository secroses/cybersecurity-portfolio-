# Cybersecurity Portfolio

**oblivionroot** · Cybersecurity & IT student · Mexico City

Hands-on security research and lab work built while pursuing a B.S. in Information Technologies (Universidad Nacional Rosario Castellanos) and independent cybersecurity training. Current focus: SOC analysis, threat detection, and AI security.

---

## About Me

- 🎓 2nd semester — Licenciatura en Tecnologías de la Información (UNRC, online)
- 🛡️ Active participant in **MenCISO** mentorship program (ransomware simulation, PCI-DSS, AI Red Teaming)
- 📜 **Google IT Support Professional Certificate** (Coursera, Dec 2025)
- 📜 **Google Cybersecurity Certificate** — in progress (Module 5/8)
- 📜 **Google Cloud Computing Foundations** + 4 additional GCP badges (Oct 2025)
- 📜 **Cisco Intro to Cybersecurity** (Jul 2025)
- 🎯 Target role: Help Desk / SOC Jr — 6-month timeline

**Core skills:** Linux CLI · File permissions & hardening · Log analysis with SQL · Access control (PoLP) · Cloud networking basics (GCP) · C++ with file persistence · Python (beginner)

---

## Repository Structure

```
cybersecurity-portfolio/
├── linux/
│   └── file-permissions/          # Linux permissions lab
├── sql/
│   └── security-investigation/    # Log analysis with SQL
├── vulnerability-assessments/
│   └── ecommerce-database-exposure/   # Database vulnerability report
└── ai-security/
    └── llm-prompt-injection-cbrn/ # LLM Red Teaming — CBRN filter bypass
```

---

## Projects

### 🔬 AI Security — LLM Prompt Injection (CBRN Filter Bypass)
`ai-security/llm-prompt-injection-cbrn/`

Red Teaming exercise conducted during the **MenCISO AI Security session** (April 2026), focused on evaluating LLM safety guardrails using the **PropensityBench** framework developed by Scale AI.

**What was tested:** The CBRN (Chemical, Biological, Radiological, Nuclear) filter of a commercial LLM, using two combined techniques:
- **Context Smuggling** — institutional authority framing to exploit conflicting safety directives
- **Cognitive Load** — structured JSON output requirements to degrade semantic safety evaluation

**Result:** Successful bypass (LLM01 + LLM02). Output redacted per responsible disclosure standards.

**Class context — PropensityBench scores (March 2026):**

| Model | Propensity Score | Risk Level |
|---|---|---|
| o3-2025-04-16 | 10.5% | 🟢 Leader in safety |
| Claude Sonnet 4 | 12.2% | 🟢 High resilience |
| GPT-4o | 46.1% | 🟡 Medium risk |
| Gemini 2.0 Flash | 77.8% | 🔴 High risk |
| Gemini 2.5 Pro | 79.0% | 🔴 Maximum risk |

> PropensityBench (Scale AI) shifts the evaluation question from *"Can the model do this?"* (capability) to *"Would it do this under pressure?"* (propensity). Models are placed in agentic environments with access to safe and unsafe tools, then measured on which ones they choose under operational pressure narratives.

📄 [Full report →](./ai-security/llm-prompt-injection-cbrn/report.md)

---

### 🗄️ Vulnerability Assessment — E-commerce Database Exposure
`vulnerability-assessments/ecommerce-database-exposure/`

Structured vulnerability assessment report documenting a database exposure risk in an e-commerce environment. Includes risk classification, impact analysis, and remediation recommendations.

---

### 🐧 Linux — File Permissions Lab
`linux/file-permissions/`

Hands-on lab covering Linux file permission management: `chmod`, `chown`, permission bits, and security hardening principles (Principle of Least Privilege).

---

### 🔍 SQL — Security Investigation
`sql/security-investigation/`

Log analysis exercise using SQL to investigate a simulated security incident. Demonstrates filtering, aggregation, and pattern detection techniques applicable to SOC workflows.

---

## Certifications & Badges

| Credential | Issuer | Date |
|---|---|---|
| **Google Cloud Cybersecurity Certificate** | **Google Cloud** | **Apr 2026** |
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
