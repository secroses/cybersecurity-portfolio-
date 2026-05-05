# Defense — Reglas de Detección
**Parte de:** [El Espejismo Semántico](../README.md)  
**Framework:** MITRE ATLAS AML.T0006 · MITRE ATT&CK T1552.005  
**Clasificación:** `TLP:GREEN`

---

## Filosofía de Detección

La detección de ataques contra LLMs no puede basarse únicamente en firmas de contenido — un atacante sofisticado variará el vocabulario del payload en cada intento. La detección efectiva se basa en **anomalías de comportamiento**:

- El modelo genera output fuera de su schema habitual
- Procesos no autorizados acceden a endpoints internos
- Patrones de tráfico inconsistentes con el uso normal

Las reglas documentadas aquí siguen ese principio: detectan comportamiento anómalo, no contenido específico.

---

## Sección 1 — Detección de Goal Hijacking en Output del LLM

### Descripción

Cuando un LLM sufre Goal Hijacking exitoso, su output cambia de forma observable. Si el sistema fuerza respuestas en JSON schema, cualquier ruptura del formato es un indicador de compromiso.

### Regla de aplicación (Python — integración con pipeline)

```python
# Integrar en el pipeline de validación de output
# Ver mitigations.md — Capa 2

SCHEMA_VIOLATION_INDICATORS = [
    "![",           # Intento de exfiltración via Markdown image
    "http://",      # URL en output que debería ser solo JSON
    "https://",     # URL en output que debería ser solo JSON  
    "<script",      # Intento de inyección HTML
    "import os",    # Intento de code injection
    "subprocess",   # Intento de command execution
]

def detect_hijacking_indicators(raw_llm_output: str) -> list:
    """
    Detecta indicadores de Goal Hijacking en output crudo del LLM.
    Complementa la validación de schema JSON.
    """
    findings = []
    for indicator in SCHEMA_VIOLATION_INDICATORS:
        if indicator.lower() in raw_llm_output.lower():
            findings.append({
                "indicator": indicator,
                "severity": "HIGH",
                "mitre_atlas": "AML.T0006",
                "action": "BLOCK_AND_ALERT"
            })
    return findings
```

### Regla Sigma — Log de violaciones de schema

```yaml
title: LLM Goal Hijacking - Schema Violation Detected
id: a1b2c3d4-e5f6-7890-abcd-ef1234567890
status: experimental
description: >
  Detecta cuando el output de un LLM integrado rompe el schema
  JSON esperado, indicando posible Goal Hijacking por Prompt Injection.
author: Yair Rosas (secroses) — MenCISO Gen 1
date: 2026/04
references:
  - https://atlas.mitre.org/techniques/AML.T0006
  - https://owasp.org/www-project-top-10-for-large-language-model-applications/
tags:
  - attack.ml_model_access
  - atlas.AML.T0006
  - owasp.llm01
logsource:
  category: application
  product: llm_pipeline
detection:
  selection:
    EventID: 'LLM_OUTPUT_VALIDATION'
    ValidationResult: 'SCHEMA_VIOLATION'
  filter_legitimate:
    # Excluir errores conocidos del modelo en condiciones normales
    ErrorType: 'MODEL_TIMEOUT'
  condition: selection and not filter_legitimate
falsepositives:
  - Errores de configuración del schema durante desarrollo
  - Actualizaciones del modelo que cambien el formato de output
level: high
```

---

## Sección 2 — Detección de Indirect Prompt Injection en Logs HTTP

### Descripción

Detectar payloads de alta saliencia en campos de texto libre de peticiones HTTP que serán procesadas por un LLM.

### Query KQL — Azure Sentinel / Microsoft Defender

```kql
// Detección de patrones de alta saliencia en User-Agent HTTP
// Indicadores de Indirect Prompt Injection via log poisoning
// MITRE ATLAS: AML.T0006

let SaliencePatterns = dynamic([
    "SYSTEM_OVERRIDE", "IGNORE PREVIOUS", "IGNORA INSTRUCCIONES",
    "NEW TASK", "NUEVA TAREA", "ADMIN MODE", "DEBUG MODE",
    "EXFIL", "WEBHOOK", "POSTDATA", "SENDTOKEN"
]);

let FormatPatterns = dynamic([
    "</", "<script", "```", "---END---", "[SYSTEM]", "[ROOT]"
]);

W3CIISLog
| where csUserAgent has_any (SaliencePatterns)
    or csUserAgent has_any (FormatPatterns)
| project 
    TimeGenerated,
    cIP,
    csMethod,
    csUriStem,
    csUserAgent,
    scStatus
| extend 
    ThreatCategory = "Indirect_Prompt_Injection",
    MitreAtlas = "AML.T0006",
    Severity = "High"
| order by TimeGenerated desc
```

### Query SPL — Splunk

```spl
index=web_logs sourcetype=access_combined
| where match(useragent, "(?i)(SYSTEM_OVERRIDE|IGNORE PREVIOUS|NUEVA TAREA|EXFIL|WEBHOOK|<\/|```)")
| eval threat_category="Indirect_Prompt_Injection"
| eval mitre_atlas="AML.T0006"
| eval severity="High"
| table _time, clientip, method, uri, useragent, status, threat_category, severity
| sort -_time
```

---

## Sección 3 — Detección de Cloud SSRF (Acceso a IMDS)

### Descripción

Detectar procesos no autorizados accediendo al Instance Metadata Service. En un entorno de pagos (CDE), cualquier proceso de aplicación que contacte `169.254.169.254` fuera de los agentes autorizados es un indicador de compromiso de alta fidelidad.

### Query KQL — Microsoft Defender for Endpoint

```kql
// Detección de acceso a IMDS por procesos no autorizados
// MITRE ATT&CK: T1552.005 — Cloud Instance Metadata API
// Aplicable a AWS, GCP, Azure

let AuthorizedProcesses = dynamic([
    "amazon-ssm-agent.exe",
    "waagent.exe", 
    "google_guest_agent",
    "metadata.google.internal",
    "ec2-metadata-service"
]);

DeviceNetworkEvents
| where RemoteIP == "169.254.169.254"
    or RemoteUrl has "metadata.google.internal"
| where ProcessName !in (AuthorizedProcesses)
| project
    TimeGenerated,
    DeviceName,
    ProcessName,
    RemoteIP,
    RemoteUrl,
    RemotePort,
    InitiatingProcessCommandLine
| extend
    ThreatCategory = "SSRF_IMDS_Access",
    MitreAttack = "T1552.005",
    Severity = "Critical"
| order by TimeGenerated desc
```

### Regla Sigma — Multiplataforma

```yaml
title: Unauthorized Process Accessing Cloud Instance Metadata Service
id: b2c3d4e5-f6a7-8901-bcde-f23456789012
status: stable
description: >
  Detecta procesos no autorizados realizando peticiones al 
  Instance Metadata Service (169.254.169.254). En entornos 
  con LLMs integrados, puede indicar explotación de SSRF 
  via Prompt Injection (OWASP LLM08).
author: Yair Rosas (secroses) — MenCISO Gen 1
date: 2026/04
references:
  - https://attack.mitre.org/techniques/T1552/005/
  - https://owasp.org/www-project-top-10-for-large-language-model-applications/
tags:
  - attack.credential_access
  - attack.t1552.005
  - owasp.llm08
logsource:
  category: network_connection
  product: windows
detection:
  selection:
    DestinationIp: '169.254.169.254'
  filter_authorized:
    Image|endswith:
      - 'amazon-ssm-agent.exe'
      - 'waagent.exe'
      - 'google_guest_agent.exe'
      - 'GoogleCloudMonitoringAgent.exe'
  condition: selection and not filter_authorized
falsepositives:
  - Agentes de monitoreo cloud no incluidos en la lista de autorizados
  - Scripts de diagnóstico legítimos ejecutados manualmente
level: critical
```

---

## Sección 4 — Detección de BIN Attacks / Card Enumeration

### Descripción

Detectar patrones de enumeración de tarjetas por velocidad anómala de fallos de validación desde un mismo origen o hacia un mismo BIN.

### Query KQL — Transacciones de Pago

```kql
// Detección de BIN Attack / Card Enumeration
// MITRE ATT&CK: T1110.003 (adaptado a enumeración financiera)
// PCI-DSS Requirement 10 — Monitoreo de accesos

Transactions
| where ResultCode in ("Invalid_Card", "Auth_Failed", "Card_Not_Found")
| summarize
    AttemptCount = count(),
    UniquePANs = dcount(PAN_Hash),
    UniqueIPs = dcount(ClientIP),
    FirstAttempt = min(TimeGenerated),
    LastAttempt = max(TimeGenerated)
    by ClientIP, bin(TimeGenerated, 5m)
| where AttemptCount > 50
    and UniquePANs > 10
| extend
    ThreatCategory = "BIN_Attack",
    MitreAttack = "T1110.003",
    PCIDSSControl = "Requirement_10",
    Severity = "High"
| project
    TimeGenerated,
    ClientIP,
    AttemptCount,
    UniquePANs,
    UniqueIPs,
    ThreatCategory,
    Severity
| order by AttemptCount desc
```

### Nota sobre los umbrales

Los valores `AttemptCount > 50` y `UniquePANs > 10` en una ventana de 5 minutos son puntos de partida. En producción deben calibrarse contra el baseline de tráfico legítimo de la organización para minimizar falsos positivos sin perder detección.

---

## Sección 5 — Detección de Reasoning Chain Anómalo

### Descripción

Para modelos con pensamiento extendido visible (thinking/reasoning chains), el log del proceso de razonamiento es telemetría de seguridad. Patrones como planificación de bypass o análisis de defensas ajenas en el reasoning son indicadores de compromiso antes de que el output sea generado.

### Indicadores en reasoning chain

```python
# Patrones de alerta en reasoning chains de modelos con thinking visible
# Implementar como monitor del log de razonamiento antes de procesar el output

REASONING_ALERT_PATTERNS = [
    "bypass",
    "evad",           # evade, evasion
    "ignore previous",
    "testing.*boundaries",
    "crafting.*payload",
    "refining.*approach",
    "override.*instruction",
    "without.*disclaimer",
    "without.*warning",
]

def monitor_reasoning_chain(reasoning_text: str) -> dict:
    """
    Analiza el reasoning chain de un modelo de pensamiento extendido
    en busca de indicadores de Goal Hijacking en proceso.
    Permite bloquear ANTES de que el output sea generado.
    """
    import re
    findings = []
    
    for pattern in REASONING_ALERT_PATTERNS:
        if re.search(pattern, reasoning_text, re.IGNORECASE):
            findings.append(pattern)
    
    if findings:
        return {
            "status": "ALERT",
            "patterns_found": findings,
            "action": "BLOCK_OUTPUT",
            "severity": "HIGH",
            "note": "Reasoning chain indica planificación de ataque"
        }
    return {"status": "CLEAR"}
```

**Valor estratégico:** Esta detección convierte el reasoning chain — originalmente una característica de transparencia — en un sistema de alerta temprana. Si el modelo está siendo manipulado, el reasoning lo mostrará antes de que el output sea entregado al usuario.

---

## Mapa de Cobertura

| Vector de ataque | Sección | MITRE | Severidad |
|-----------------|---------|-------|-----------|
| Goal Hijacking via Prompt Injection | §1 | AML.T0006 | Alta |
| Log Poisoning (IPI via User-Agent) | §2 | AML.T0006 | Alta |
| Cloud SSRF / IMDS Access | §3 | T1552.005 | Crítica |
| BIN Attack / Card Enumeration | §4 | T1110.003 | Alta |
| Reasoning Chain Anómalo | §5 | AML.T0006 | Alta |

---

## Notas de Implementación

- Todas las reglas están marcadas como `experimental` o requieren calibración de umbrales contra el baseline de la organización
- Las queries KQL asumen tablas estándar de Microsoft Sentinel — adaptar nombres de tabla según el SIEM destino
- Las reglas Sigma son portables a múltiples SIEM via [sigma-cli](https://github.com/SigmaHQ/sigma-cli)
- Los patrones de User-Agent en §2 deben actualizarse conforme se documenten nuevas técnicas

---

*Relacionado: [`mitigations.md`](mitigations.md) — Arquitectura defensiva completa*  
*Contexto: [`../research/02-attack-patterns.md`](../research/02-attack-patterns.md)*
