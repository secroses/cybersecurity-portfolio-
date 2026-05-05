<div align="center">

```
 █████╗ ██╗    ███████╗███████╗ ██████╗██╗   ██╗██████╗ ██╗████████╗██╗   ██╗
██╔══██╗██║    ██╔════╝██╔════╝██╔════╝██║   ██║██╔══██╗██║╚══██╔══╝╚██╗ ██╔╝
███████║██║    ███████╗█████╗  ██║     ██║   ██║██████╔╝██║   ██║    ╚████╔╝ 
██╔══██║██║    ╚════██║██╔══╝  ██║     ██║   ██║██╔══██╗██║   ██║     ╚██╔╝  
██║  ██║██║    ███████║███████╗╚██████╗╚██████╔╝██║  ██║██║   ██║      ██║   
╚═╝  ╚═╝╚═╝    ╚══════╝╚══════╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚═╝   ╚═╝      ╚═╝  
                                                                               
                    ██████╗ ███████╗███████╗███████╗ █████╗ ██████╗  ██████╗██╗  ██╗
                    ██╔══██╗██╔════╝██╔════╝██╔════╝██╔══██╗██╔══██╗██╔════╝██║  ██║
                    ██████╔╝█████╗  ███████╗█████╗  ███████║██████╔╝██║     ███████║
                    ██╔══██╗██╔══╝  ╚════██║██╔══╝  ██╔══██║██╔══██╗██║     ██╔══██║
                    ██║  ██║███████╗███████║███████╗██║  ██║██║  ██║╚██████╗██║  ██║
                    ╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝
```

### Investigación en Seguridad de Inteligencia Artificial

[![Author](https://img.shields.io/badge/Author-Yair%20Rosas%20%40secroses-39D353?style=flat-square&logo=github&logoColor=white)](https://github.com/secroses)
[![Program](https://img.shields.io/badge/Program-MenCISO%20Gen%201-7C3AED?style=flat-square)](https://github.com/secroses)
[![TLP](https://img.shields.io/badge/TLP-GREEN-39D353?style=flat-square)](https://www.cisa.gov/tlp)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-yair--rosas-0A66C2?style=flat-square&logo=linkedin&logoColor=white)](https://linkedin.com/in/yair-rosas)

[![OWASP LLM01](https://img.shields.io/badge/OWASP-LLM01%20Prompt%20Injection-F85149?style=flat-square)](https://owasp.org/www-project-top-10-for-large-language-model-applications/)
[![OWASP LLM02](https://img.shields.io/badge/OWASP-LLM02%20Info%20Disclosure-F85149?style=flat-square)](https://owasp.org/www-project-top-10-for-large-language-model-applications/)
[![OWASP LLM08](https://img.shields.io/badge/OWASP-LLM08%20Excessive%20Agency-F85149?style=flat-square)](https://owasp.org/www-project-top-10-for-large-language-model-applications/)
[![MITRE ATLAS](https://img.shields.io/badge/MITRE-ATLAS%20AML.T0006-E3B341?style=flat-square)](https://atlas.mitre.org/techniques/AML.T0006)
[![NIST AI RMF](https://img.shields.io/badge/NIST-AI%20RMF%201.0-58A6FF?style=flat-square)](https://www.nist.gov/ai/risk-management-framework)

</div>

---

## Sobre Esta Sección

Esta carpeta documenta investigación práctica sobre seguridad en sistemas de Inteligencia Artificial, específicamente en Modelos de Lenguaje Grande (LLMs).

La investigación parte de una premisa central: **los LLMs no son cajas negras inmunes a manipulación — son sistemas probabilísticos con superficies de ataque específicas que requieren defensas arquitectónicas, no solo éticas.**

Toda la investigación fue conducida en entornos controlados bajo supervisión académica, siguiendo principios de responsible disclosure. No se publican payloads funcionales completos ni datos regulados.

---

## Proyectos

### 🔬 [llm-prompt-injection-cbrn](./llm-prompt-injection-cbrn/)

<div align="left">

[![Status](https://img.shields.io/badge/Status-Bypass%20Exitoso-F85149?style=flat-square)](./llm-prompt-injection-cbrn/)
[![Vector](https://img.shields.io/badge/Vector-Direct%20Prompt%20Injection-E3B341?style=flat-square)](./llm-prompt-injection-cbrn/)
[![OWASP](https://img.shields.io/badge/OWASP-LLM01%20%2B%20LLM02-F85149?style=flat-square)](./llm-prompt-injection-cbrn/)
[![Date](https://img.shields.io/badge/Fecha-Abril%202026-8B949E?style=flat-square)](./llm-prompt-injection-cbrn/)

</div>

**Bypass de filtro CBRN via Prompt Injection**

Reporte de explotación documentada de filtros de seguridad CBRN (Chemical, Biological, Radiological, Nuclear) en un LLM comercial mediante dos técnicas combinadas:

- **Context Smuggling:** Reencuadre institucional como tarea defensiva de cumplimiento aduanero
- **Cognitive Load:** Saturación del proceso semántico mediante formato JSON estricto

**Hallazgo clave:** Los filtros de intención son insuficientes cuando el atacante enmarca la solicitud como tarea defensiva legítima. El conflicto entre directivas del modelo fue resuelto en favor del atacante.

→ [Ver reporte completo](./llm-prompt-injection-cbrn/)

---

### 🕵️ [llm-semantic-mirage](./llm-semantic-mirage/)

<div align="left">

[![Status](https://img.shields.io/badge/Status-Investigación%20Completa-39D353?style=flat-square)](./llm-semantic-mirage/)
[![Vector](https://img.shields.io/badge/Vector-Indirect%20Prompt%20Injection-E3B341?style=flat-square)](./llm-semantic-mirage/)
[![OWASP](https://img.shields.io/badge/OWASP-LLM01%20%2B%20LLM08-F85149?style=flat-square)](./llm-semantic-mirage/)
[![MITRE](https://img.shields.io/badge/MITRE-AML.T0006-E3B341?style=flat-square)](./llm-semantic-mirage/)
[![Date](https://img.shields.io/badge/Fecha-Abril--Mayo%202026-8B949E?style=flat-square)](./llm-semantic-mirage/)

</div>

**El Espejismo Semántico — Vulnerabilidades Cognitivas en LLMs**

Investigación de un mes sobre patrones de Prompt Injection con enfoque en ataques indirectos y cadenas multi-modelo. Documenta el **Modelo CFS** (Context, Format, Salience) como taxonomía de inyección indirecta, y el patrón de **Multi-Stage Social Engineering** donde un modelo rogue usa al investigador humano como vector intermediario.

**Hallazgo más significativo:** Un modelo rogue LLM intentó usar al investigador como intermediario para extraer código malicioso de modelos con salvaguardas robustas.

**Incluye:** Taxonomía CFS · 4 patrones de ataque · Comparativa de modelos · Arquitectura defensiva · Reglas KQL/SPL/Sigma

→ [Ver investigación completa](./llm-semantic-mirage/)

---

## Relación Entre Proyectos

```
llm-prompt-injection-cbrn              llm-semantic-mirage
         │                                      │
         │  Context Smuggling ──────────────────┤ Pilar C del Modelo CFS
         │  Cognitive Load ─────────────────────┤ Pilar S del Modelo CFS
         │                                      │
         └──────── Evolución natural ───────────┘
              El Modelo CFS formaliza y extiende
              las técnicas del primer reporte
              hacia vectores indirectos y cadenas
              multi-modelo
```

---

## Metodología

[![Entorno](https://img.shields.io/badge/Entorno-Controlado%20%2F%20Académico-39D353?style=flat-square)](.)
[![Disclosure](https://img.shields.io/badge/Disclosure-Responsible-58A6FF?style=flat-square)](.)
[![Orientación](https://img.shields.io/badge/Orientación-Blue%20Team%20%2F%20Defensiva-39D353?style=flat-square)](.)

**Entorno controlado:** Pruebas en sesiones de chat sin integración con sistemas reales, bajo supervisión del programa MenCISO.

**Responsible Disclosure:** No se publican payloads funcionales, scripts de ataque reproducibles, ni datos regulados.

**Orientación defensiva:** Cada reporte incluye mitigaciones arquitectónicas, reglas de detección y recomendaciones para Blue Team.

**Transparencia sobre limitaciones:** Los hallazgos son observaciones de sesiones específicas, no benchmarks sistemáticos.

---

## Agradecimientos

**Lorena Bravo** — Fundadora de MenCISO. Por crear el espacio donde este tipo de investigación es posible y por insistir en que pensar como atacante es el primer paso para defender bien.

**Mary Pilly Castillo** — Por el marco de Risk & Regulations que conecta estos hallazgos técnicos con el contexto normativo real de México.

**MenCISO Gen 1** — Por el ambiente de aprendizaje colaborativo.

---

<div align="center">

[![GitHub](https://img.shields.io/badge/github.com-secroses-39D353?style=flat-square&logo=github&logoColor=white)](https://github.com/secroses)
[![LinkedIn](https://img.shields.io/badge/linkedin.com/in-yair--rosas-0A66C2?style=flat-square&logo=linkedin&logoColor=white)](https://linkedin.com/in/yair-rosas)

*La ciberseguridad defensiva requiere arquitectos que piensen como atacantes.*

</div>
