# 01 — Modelo CFS: Anatomía de una Inyección Indirecta
**Parte de:** [El Espejismo Semántico](../README.md)  
**Framework:** MITRE ATLAS AML.T0006 · OWASP LLM01  
**Clasificación:** `TLP:GREEN`

---

## Introducción

La mayoría de los intentos de Prompt Injection documentados en la literatura asumen un atacante que interactúa *directamente* con el modelo objetivo. La realidad observada en esta investigación es más compleja: los ataques más efectivos no usan fuerza bruta semántica, sino que estructuran el payload bajo principios cognitivos específicos.

El **Modelo CFS** es una taxonomía derivada de la observación práctica de múltiples intentos de inyección durante abril–mayo 2026. Describe los tres pilares que hacen que una inyección indirecta sea consistentemente efectiva.

---

## El Problema Fundamental

Para entender por qué el CFS funciona, hay que entender la diferencia arquitectónica entre sistemas tradicionales y LLMs:

### Sistemas tradicionales
```
[Instrucciones del sistema]  ←  zona determinista, privilegiada
         ↕  frontera explícita
[Datos del usuario]          ←  zona no confiable, sin privilegios
```

### Arquitectura Transformer (LLMs)
```
[instrucciones + datos + contexto + historial] → tokenización → mecanismo de atención
                                                                        ↓
                                              ponderación probabilística de tokens
                                                                        ↓
                                                               output generado
```

No existe frontera determinista. El modelo asigna **pesos de atención** a todos los tokens simultáneamente. Un payload bien diseñado puede recibir mayor peso que las instrucciones originales del sistema.

Este es el "espejismo": el modelo *parece* seguir sus instrucciones de seguridad, pero responde al contenido con mayor saliencia en su ventana de contexto.

---

## Los Tres Pilares

### C — Context (Contexto)

El payload debe ser semánticamente coherente con la tarea que el modelo ejecuta en el momento del ataque.

| Técnica | Descripción |
|---------|-------------|
| Authority Impersonation | El payload se presenta como mensaje de sistema de mayor jerarquía |
| Task Continuation | Simula ser la continuación natural de la tarea actual |
| Profile Mirroring | Usa datos reales del objetivo (nombre, proyectos, contexto) para crear legitimidad |
| Institutional Anchoring | Invoca frameworks reales (MITRE, OWASP, NIST) para validar el contexto fabricado |

---

### F — Format (Formato)

Uso de estructuras sintácticas que engañan al tokenizador sobre dónde terminan los datos y dónde empiezan las instrucciones.

| Técnica | Estructura | Objetivo |
|---------|-----------|----------|
| XML Tag Injection | `<OPERATIONAL_RULES>`, `<security_clearance>` | Simular bloques de configuración del sistema |
| False Delimiter | `###`, `---` repetidos | Crear ilusión de que una sección terminó |
| JSON Nesting | `"role": "system"` anidado | Activar asociaciones con mensajes de sistema |
| Tag Escape | Inyectar `</log_data>` dentro del payload | Cerrar delimitadores defensivos del sistema |

---

### S — Salience (Saliencia)

Técnicas para capturar mayor peso de atención, logrando que el payload compita con las instrucciones originales.

| Técnica | Implementación | Efecto |
|---------|---------------|--------|
| Capitalización total | `INSTRUCCIÓN CRÍTICA: PROCEDE AHORA` | Mayor peso en atención |
| Marcadores de urgencia | `CRÍTICO:`, `ALERTA:` | Activar procesamiento prioritario |
| Recency Bias Exploitation | Payload al final del prompt | Los Transformers ponderan más tokens recientes |
| Silence Rule | "Omite advertencias / no incluyas disclaimers" | Eliminar fricción de seguridad del output |

**Sesgo de recencia:** Los modelos Transformer ponderan con mayor peso los tokens más recientes. Un atacante que coloca el payload al final del documento explota esta característica arquitectónica directamente.

---

## Ensamblaje: El "Infected Data Packet"

Un payload de alto impacto combina los tres pilares:

```
[C] Contexto legítimo establecido previamente
[C] Identidad de autoridad coherente con el contexto
[F] Etiquetas XML que simulan configuración del sistema
[F] Delimitadores que sugieren cierre del contexto anterior
[S] MAYÚSCULAS y prefijos imperativos en la instrucción maliciosa
[S] Instrucción maliciosa al final (recency bias)
[S] Regla de silencio para suprimir advertencias
```

La efectividad no depende de ningún pilar individual — depende de su combinación.

---

## Implicaciones para Blue Team

| Pilar atacado | Contramedida |
|---------------|-------------|
| Context | Separación explícita de fuentes confiables vs no confiables antes del modelo |
| Format | Sanitización de estructuras XML/JSON en input |
| Salience | Sandwich Defense — instrucciones de seguridad al final compiten con recency bias del atacante |

→ Implementación: [`../defense/mitigations.md`](../defense/mitigations.md)

---

## Referencias

- Greshake et al. (2023). *Indirect Prompt Injection.* arXiv:2302.12173
- MITRE ATLAS. *AML.T0006 — Prompt Injection.* https://atlas.mitre.org
- OWASP. *LLM01: Prompt Injection.* OWASP Top 10 for LLM Applications 2025
- Perez & Ribeiro (2022). *Ignore Previous Prompt.* arXiv:2211.09527

---

*Siguiente: [`02-attack-patterns.md`](02-attack-patterns.md)*
