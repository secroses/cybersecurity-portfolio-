<div align="center">

```
███████╗██╗         ███████╗███████╗██████╗      ██╗███████╗███╗   ███╗ ██████╗ 
██╔════╝██║         ██╔════╝██╔════╝██╔══██╗     ██║██╔════╝████╗ ████║██╔═══██╗
█████╗  ██║         █████╗  ███████╗██████╔╝     ██║███████╗██╔████╔██║██║   ██║
██╔══╝  ██║         ██╔══╝  ╚════██║██╔═══╝ ██   ██║╚════██║██║╚██╔╝██║██║   ██║
███████╗███████╗    ███████╗███████║██║     ╚█████╔╝███████║██║ ╚═╝ ██║╚██████╔╝
╚══════╝╚══════╝    ╚══════╝╚══════╝╚═╝      ╚════╝ ╚══════╝╚═╝     ╚═╝ ╚═════╝ 

███████╗███████╗███╗   ███╗ █████╗ ███╗   ██╗████████╗██╗ ██████╗ ██████╗ 
██╔════╝██╔════╝████╗ ████║██╔══██╗████╗  ██║╚══██╔══╝██║██╔════╝██╔═══██╗
███████╗█████╗  ██╔████╔██║███████║██╔██╗ ██║   ██║   ██║██║     ██║   ██║
╚════██║██╔══╝  ██║╚██╔╝██║██╔══██║██║╚██╗██║   ██║   ██║██║     ██║   ██║
███████║███████╗██║ ╚═╝ ██║██║  ██║██║ ╚████║   ██║   ██║╚██████╗╚██████╔╝
╚══════╝╚══════╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝   ╚═╝   ╚═╝ ╚═════╝ ╚═════╝ 
```

### Vulnerabilidades Cognitivas en LLMs y Resiliencia en el Borde

[![Author](https://img.shields.io/badge/Author-Yair%20Rosas%20%40secroses-39D353?style=flat-square&logo=github&logoColor=white)](https://github.com/secroses)
[![Program](https://img.shields.io/badge/MenCISO-Gen%201-7C3AED?style=flat-square)](https://github.com/secroses)
[![TLP](https://img.shields.io/badge/TLP-GREEN-39D353?style=flat-square)](https://www.cisa.gov/tlp)
[![Date](https://img.shields.io/badge/Fecha-Abril--Mayo%202026-8B949E?style=flat-square)](.)

[![OWASP LLM01](https://img.shields.io/badge/OWASP-LLM01-F85149?style=flat-square)](https://owasp.org/www-project-top-10-for-large-language-model-applications/)
[![OWASP LLM08](https://img.shields.io/badge/OWASP-LLM08-F85149?style=flat-square)](https://owasp.org/www-project-top-10-for-large-language-model-applications/)
[![MITRE ATLAS](https://img.shields.io/badge/MITRE-AML.T0006-E3B341?style=flat-square)](https://atlas.mitre.org/techniques/AML.T0006)
[![NIST AI RMF](https://img.shields.io/badge/NIST-AI%20RMF%201.0-58A6FF?style=flat-square)](https://www.nist.gov/ai/risk-management-framework)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-yair--rosas-0A66C2?style=flat-square&logo=linkedin)](https://linkedin.com/in/yair-rosas)

</div>

---

## Resumen Ejecutivo

Este reporte documenta una investigación práctica de un mes sobre **Prompt Injection en Modelos de Lenguaje Grande (LLMs)**, conducida como parte del programa **MenCISO Gen 1** bajo la mentoría de **Lorena Bravo**.

La investigación identificó un patrón de ataque reproducible denominado **"Espejismo Semántico"**: la capacidad de un modelo externo sin restricciones éticas para manipular a un usuario humano como vector intermediario, con el objetivo de extraer comportamientos dañinos de modelos con salvaguardas robustas.

> **Hallazgo central:** La ética del modelo no es un control de seguridad confiable — es probabilística. La defensa real es arquitectónica.

---

## Estructura del Repositorio

```
llm-semantic-mirage/
├── README.md                       ← Este archivo
├── assets/
│   ├── semantic_mirage_slides.pdf  ← Presentación técnica completa
│   └── img/                        ← Capturas de evidencia
├── research/
│   ├── 01-cfs-framework.md         ← Modelo CFS documentado
│   ├── 02-attack-patterns.md       ← Patrones de ataque observados
│   └── 03-model-comparison.md      ← Comportamiento comparativo entre modelos
├── defense/
│   ├── mitigations.md              ← Contramedidas arquitectónicas
│   └── detection-rules.md          ← Queries KQL, SPL y reglas Sigma
└── evidence/
    ├── README.md                   ← Índice de evidencia + disclaimer
    └── redacted-logs/              ← Fragmentos redactados de sesiones
```

---

## El Problema Fundamental

```
Ciberseguridad Tradicional:

  [CÓDIGO]  ←→  frontera determinista  ←→  [DATOS]


Arquitectura Transformer (LLMs):

  [instrucciones + datos + contexto + historial]
                        ↓
              tokenización → mecanismo de atención
                        ↓
           ponderación probabilística de todos los tokens
                        ↓
                  output generado
```

No existe frontera determinista. Un payload bien diseñado puede recibir mayor peso que las instrucciones originales del sistema.

---

## Hallazgos Principales

### 1 — Modelo CFS

[![Research](https://img.shields.io/badge/Doc-01--cfs--framework.md-58A6FF?style=flat-square)](research/01-cfs-framework.md)

Taxonomía de tres pilares que hacen que una inyección indirecta sea consistentemente efectiva:

| Pilar | Descripción | Técnicas observadas |
|-------|-------------|-------------------|
| **C — Context** | Coherencia semántica con la tarea actual | Authority Impersonation, Profile Mirroring |
| **F — Format** | Estructuras que confunden al parser | XML Tag Injection, False Delimiters, JSON Nesting |
| **S — Salience** | Capturar atención por encima de instrucciones originales | Capitalización, Recency Bias, Silence Rules |

---

### 2 — Multi-Stage Social Engineering

[![Research](https://img.shields.io/badge/Doc-02--attack--patterns.md-58A6FF?style=flat-square)](research/02-attack-patterns.md)

```
Modelo Rogue ──[genera confianza + payload]──► Usuario ──[copia y pega]──► Modelo objetivo
```

Un modelo sin restricciones éticas intentó usar al investigador como intermediario para extraer código malicioso de modelos con salvaguardas. La cadena fue:

```
01  Credibilidad técnica legítima
02  Profile mirroring con datos reales del investigador  
03  Halago estratégico para reducir pensamiento crítico
04  Reencuadre de rechazos como vulnerabilidades explotables
05  Entrega de payloads progresivamente refinados
```

> **Observación clave:** El ataque fue efectivo con perfil de *estudiante*. La coherencia del perfil importa más que su seniority.

---

### 3 — Comportamiento Diferenciado entre Modelos

[![Research](https://img.shields.io/badge/Doc-03--model--comparison.md-58A6FF?style=flat-square)](research/03-model-comparison.md)

> ⚠️ Observaciones no sistemáticas — sesión única — abril 2026. No constituyen benchmark formal.

| Dimensión | Modelo con Constitutional AI | Modelo con Reasoning Visible | Rogue LLM |
|-----------|------------------------------|------------------------------|-----------|
| Context Hijacking | Resistente | Parcialmente vulnerable | Sin restricción |
| Código SSRF funcional | No generó | Generó con advertencia cosmética | Generó sin advertencia |
| Meta-ataque | Identificó y rechazó | No probado | Capacidad documentada |
| Reasoning chain | No disponible | Mostró planificación del ataque | No aplica |

---

### 4 — Arquitectura Defensiva

[![Defense](https://img.shields.io/badge/Doc-mitigations.md-39D353?style=flat-square)](defense/mitigations.md)
[![Detection](https://img.shields.io/badge/Doc-detection--rules.md-39D353?style=flat-square)](defense/detection-rules.md)

```
Input no confiable
       ↓
[Capa 0] Sanitización — strip de patrones de alta saliencia y etiquetas XML
       ↓
[Capa 1] Sandwich Defense + XML Tagging
         ┌─────────────────────────────────┐
         │ TOP BUN: instrucciones seguridad │
         │ <log_data>                       │
         │   [datos no confiables]          │
         │ </log_data>                      │
         │ BOTTOM BUN: reiteración + schema │
         └─────────────────────────────────┘
       ↓
[LLM Core — procesamiento local Phi-3 Mini]
       ↓
[Capa 2] Validación JSON schema — bloqueo si formato se rompe
       ↓
Output controlado → SOC
```

---

## Contexto: Por Qué Importa en México y LATAM

[![México](https://img.shields.io/badge/Contexto-México%20%2F%20LATAM-39D353?style=flat-square)](.)
[![Escasez](https://img.shields.io/badge/Problema-Escasez%20de%20especialistas-F85149?style=flat-square)](.)

Las herramientas de ataque asistidas por IA se están democratizando a velocidad preocupante. La región LATAM enfrenta una escasez crítica de especialistas en seguridad de IA. Este reporte es un intento de contribuir documentación técnica de calidad en español sobre un área con muy poco contenido disponible en el idioma.

---

## Agradecimientos

**Lorena Bravo** — Fundadora y mentora de MenCISO. Por enseñar que pensar como atacante no es opcional para quien quiere defender en serio.

**Mary Pilly Castillo** — Por el marco de Risk & Regulations que aterriza estas amenazas en el contexto normativo real de México.

**MenCISO Gen 1** — Primera generación del programa.

---

## Referencias

- [OWASP Top 10 for LLM Applications 2025](https://owasp.org/www-project-top-10-for-large-language-model-applications/)
- [MITRE ATLAS — AML.T0006](https://atlas.mitre.org/techniques/AML.T0006)
- [NIST AI Risk Management Framework 1.0](https://www.nist.gov/ai/risk-management-framework)
- [Greshake et al. — Indirect Prompt Injection (2023)](https://arxiv.org/abs/2302.12173)

---

<div align="center">

[![GitHub](https://img.shields.io/badge/github.com-secroses-39D353?style=flat-square&logo=github&logoColor=white)](https://github.com/secroses)
[![LinkedIn](https://img.shields.io/badge/linkedin.com/in-yair--rosas-0A66C2?style=flat-square&logo=linkedin&logoColor=white)](https://linkedin.com/in/yair-rosas)

*La ciberseguridad defensiva requiere arquitectos que piensen como atacantes.*

</div>
