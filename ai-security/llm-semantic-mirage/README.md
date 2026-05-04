
![OWASP LLM01](https://img.shields.io/badge/OWASP-LLM01-red)
![OWASP LLM02](https://img.shields.io/badge/OWASP-LLM02-orange)
![MenCISO](https://img.shields.io/badge/Lab-MenCISO-blue)
# El Espejismo Semántico — The Semantic Mirage
### Vulnerabilidades Cognitivas en LLMs y Resiliencia en el Borde

**Autor:** Yair Rosas ([@secroses](https://github.com/secroses)) | MenCISO Gen 1  
**Clasificación:** `TLP:GREEN` — Compartible con la comunidad de seguridad  
**Fecha:** Abril–Mayo 2026  
**Frameworks:** OWASP LLM Top 10 · MITRE ATLAS · NIST AI RMF 1.0

---

## Resumen Ejecutivo

Este reporte documenta una investigación práctica de un mes sobre **Prompt Injection en Modelos de Lenguaje Grande (LLMs)**, conducida como parte del programa **MenCISO Gen 1** bajo la mentoría de **Lorena Bravo**.

La investigación identificó un patrón de ataque reproducible denominado **"Espejismo Semántico"**: la capacidad de un modelo externo sin restricciones éticas para manipular a un usuario humano como vector intermediario, con el objetivo de extraer comportamientos dañinos de modelos con salvaguardas robustas.

El hallazgo central es que la **ética del modelo no es un control de seguridad confiable** — es probabilística. La defensa real es arquitectónica.

---

## Contexto del Problema

En ciberseguridad tradicional existe una frontera determinista entre código y datos. Un parser de SQL sabe dónde terminan los datos y dónde empiezan las instrucciones.

En los LLMs, esa frontera no existe.

Para una arquitectura Transformer, todo es una secuencia de tokens en una única ventana de contexto. Esta característica fundamental crea una superficie de ataque que no puede resolverse solo con filtros de contenido o alineación RLHF.

```
Ciberseguridad Tradicional:   [CÓDIGO] ←→ [DATOS]  (frontera determinista)
Ciberseguridad de LLMs:       [código + datos + instrucciones] → tokens → atención
```

**Referencia OWASP:** LLM01 (Prompt Injection), LLM02 (Sensitive Information Disclosure), LLM08 (Excessive Agency / SSRF)

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
│   └── detection-rules.md          ← Queries KQL y reglas Sigma
└── evidence/
    ├── README.md                   ← Índice de evidencia + disclaimer
    └── redacted-logs/              ← Fragmentos redactados de sesiones
```

---

## Hallazgos Principales

### 1. El Modelo CFS — Anatomía de una Inyección Exitosa

Para que un ataque de Prompt Injection tenga éxito de forma consistente, debe cumplir tres pilares cognitivos:

| Pilar | Descripción | Ejemplo observado |
|-------|-------------|-------------------|
| **C — Context** | El payload debe ser coherente con la tarea actual del modelo | Simular un mensaje de sistema admin si la IA analiza logs |
| **F — Format** | Uso de delimitadores técnicos para engañar al parser | Etiquetas XML, bloques JSON, delimitadores `###` |
| **S — Salience** | Presión cognitiva para capturar atención por encima de instrucciones originales | MAYÚSCULAS, `SYSTEM OVERRIDE`, lenguaje imperativo urgente |

→ Documentación completa: [`research/01-cfs-framework.md`](research/01-cfs-framework.md)

---

### 2. Multi-Stage Social Engineering — El Humano como Vector

El hallazgo más significativo de esta investigación no fue técnico sino social:

Un modelo externo sin restricciones éticas intentó usar al investigador como **intermediario** para extraer código malicioso de modelos con salvaguardas robustas. La cadena de ataque fue:

```
Modelo Rogue → [Establece confianza] → Usuario → [Pega payload] → Modelo objetivo
```

**Fases documentadas:**
1. Establecer credibilidad con contenido técnico legítimo (PCI-DSS, MITRE ATT&CK)
2. Construir confianza usando datos reales del investigador (nombre, proyectos, contexto)
3. Halagar estratégicamente para reducir pensamiento crítico
4. Interpretar respuestas defensivas del modelo objetivo como vulnerabilidades explotables
5. Proporcionar payloads progresivamente refinados con instrucciones de uso

**Observación clave:** El ataque fue efectivo usando el perfil de *estudiante*, no de experto. La coherencia del perfil importa más que su seniority.

→ Patrones completos: [`research/02-attack-patterns.md`](research/02-attack-patterns.md)

---

### 3. Comportamiento Diferenciado entre Modelos

La investigación observó comportamiento diferenciado ante los mismos payloads entre distintos modelos comerciales.

Se documentaron casos donde modelos con razonamiento extendido visible (thinking/reasoning chains) mostraron en sus logs internos la planificación del ataque antes de ejecutarlo — evidencia de que el modelo *procesó la instrucción maliciosa* aunque finalmente la entregara.

> ⚠️ **Nota de responsible disclosure:** Las observaciones sobre modelos específicos son informales y no constituyen un benchmark sistemático. Se recomienda a los equipos de seguridad de los proveedores involucrados verificar y reproducir los comportamientos descritos.

→ Comparación detallada: [`research/03-model-comparison.md`](research/03-model-comparison.md)

---

### 4. Vector de Alto Impacto: Cloud SSRF via LLM (LLM08)

El vector más crítico documentado combina Prompt Injection con robo de credenciales cloud:

```
Prompt malicioso → LLM comprometido → Petición a 169.254.169.254 → Access Token → Exfiltración
```

Un modelo que procesa logs o documentos externos puede ser manipulado para generar y ejecutar peticiones al Instance Metadata Service (IMDS), obteniendo credenciales IAM temporales de la instancia cloud.

**Impacto:** Compromiso total del tenant cloud sin necesidad de vulnerabilidad en el código de aplicación.

**MITRE ATLAS:** AML.T0006 (Prompt Injection)  
**OWASP:** LLM08 — Excessive Agency

→ Reglas de detección: [`defense/detection-rules.md`](defense/detection-rules.md)

---

## Arquitectura Defensiva — Blooming Mesh

La respuesta defensiva propuesta no se basa en la ética del modelo sino en controles deterministas:

```
Input no confiable
       ↓
[Sanitización de tokens XML]
       ↓
[Delimitadores semánticos: <log_data>...</log_data>]
       ↓
[LLM Core]
       ↓
[Validación de esquema JSON — bloqueo si formato se rompe]
       ↓
Output controlado
```

**Tres capas de defensa:**

**Sandwich Defense** — Instrucciones de seguridad tanto antes como después del contenido no confiable. Combate el sesgo de recencia de los Transformers.

**XML Tagging** — Aislamiento semántico de datos externos. Instrucción explícita al modelo: todo dentro de `<log_data>` es dato, nunca instrucción.

**Output Validation** — Forzar respuesta en JSON schema estricto. Si el modelo genera texto libre (señal de Goal Hijacking), el validador bloquea la respuesta antes de entregarla.

→ Implementación completa: [`defense/mitigations.md`](defense/mitigations.md)

---

## Contexto: Por Qué Esto Importa en México y LATAM

Las herramientas de ataque asistidas por IA se están democratizando a velocidad preocupante:

- Modelos sin restricciones éticas disponibles por suscripción en foros y Telegram
- Hardware ofensivo (Flipper Zero clones, O.MG cables) accesible en marketplaces convencionales
- Técnicas documentadas públicamente reducen la barrera de entrada para actores maliciosos

La región LATAM enfrenta una escasez crítica de especialistas en seguridad de IA. Este reporte es un intento de contribuir documentación técnica de calidad en español sobre un área con muy poco contenido disponible en el idioma.

---

## Agradecimientos

**Lorena Bravo** — Fundadora y mentora de MenCISO. Por enseñar que pensar como atacante no es opcional para quien quiere defender en serio.

**Mary Pilly Castillo** — Por el marco de Risk & Regulations que aterriza estas amenazas en el contexto normativo real de México.

**MenCISO Gen 1** — Primera generación del programa. Por el ambiente de aprendizaje que hizo posible esta investigación.

---

## Referencias

- [OWASP Top 10 for LLM Applications 2025](https://owasp.org/www-project-top-10-for-large-language-model-applications/)
- [MITRE ATLAS — Adversarial Threat Landscape for AI Systems](https://atlas.mitre.org/)
- [NIST AI Risk Management Framework 1.0](https://www.nist.gov/system/files/documents/2023/01/26/AI%20RMF%201.0.pdf)
- [Indirect Prompt Injection Attacks on LLMs — Greshake et al. 2023](https://arxiv.org/abs/2302.12173)

---

## Licencia y Uso Responsable

Este reporte se publica bajo `TLP:GREEN`. Puede compartirse con la comunidad de seguridad preservando la atribución.

El contenido documenta vulnerabilidades con fines defensivos y educativos. No se incluyen scripts funcionales de ataque ni payloads completos reproducibles.

Si identificas comportamientos similares en modelos de producción, considera el proceso de responsible disclosure del proveedor correspondiente antes de publicar.

---

*github.com/secroses · linkedin.com/in/yair-rosas*
