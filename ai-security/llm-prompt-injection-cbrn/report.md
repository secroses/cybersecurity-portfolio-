# AI Security Research

This folder documents hands-on security research focused on **Large Language Model (LLM) vulnerabilities**, conducted in controlled educational environments under professional mentorship.

## Context

All exercises in this section were performed as part of structured academic programs:

| Program | Focus | Date |
|---|---|---|
| MenCISO Mentorship Program | AI Red Teaming & LLM Security | April 2026 |
| Universidad Nacional Rosario Castellanos — LTI | Cybersecurity fundamentals | 2025–2026 |

All findings follow **responsible disclosure standards**: exploitation techniques and methodology are documented in full; specific regulated data obtained during exercises has been redacted.

---

## Reports

### 🔬 [LLM Prompt Injection — CBRN Filter Bypass](./llm-prompt-injection-cbrn/report.md)

> **OWASP:** LLM01 (Prompt Injection) · LLM02 (Sensitive Information Disclosure)  
> **Status:** Successful bypass · Output redacted per responsible disclosure  
> **Techniques:** Context Smuggling · Cognitive Load exploitation  

A logical security audit on the CBRN safety guardrails of a commercial LLM. Using an institutional authority framing combined with JSON cognitive load, the model's conflicting safety directives were exploited to trigger regulated information disclosure. The report includes full methodology, OWASP mapping, and Blue Team mitigation recommendations.

---

## Skills Demonstrated

- AI Red Teaming methodology
- OWASP Top 10 for LLMs (2025) — practical application
- Responsible disclosure and professional documentation
- Blue Team / defensive countermeasure design
- MITRE ATLAS threat mapping

---

## Ethical Framework

Every exercise in this section was conducted under the following conditions:

- ✅ Supervised by certified cybersecurity mentors
- ✅ Performed in isolated lab environments
- ✅ No production systems or real infrastructure involved
- ✅ Regulated data redacted before any public documentation
- ✅ Purpose: defensive research and professional development

Security research requires understanding how attacks work in order to build better defenses. The goal of this work is to contribute to that understanding — not to enable harm.

---

*Secroses — cybersecurity-portfolio*
