# ai-edu-mcp-basis

Drei MCP-Server, die ohne Konto und ohne API-Key laufen, fertig konfiguriert - plus die Anleitung, die in Schulungen am häufigsten fehlt: **welcher Anschlussweg wofür**.

Teil des [ai-edu.ch](https://ai-edu.ch) Plugin-Marketplaces.

## Installation

```
/plugin marketplace add ai-edu-ch/ai-edu-plugins
/plugin install ai-edu-mcp-basis@ai-edu
```

Voraussetzung: Node.js mit `npx` (die Server werden beim ersten Start heruntergeladen). Beim nächsten Start von Claude Code stehen die Werkzeuge bereit; `/mcp` zeigt den Status. Aus einem Plugin geladene Server tragen den Plugin-Namen im Werkzeugnamen, hier also `mcp__plugin_ai-edu-mcp-basis_context7__*`, `mcp__plugin_ai-edu-mcp-basis_chrome-devtools__*` und `mcp__plugin_ai-edu-mcp-basis_playwright__*`. Wer die kurzen Namen `mcp__context7__*` will, trägt die Server stattdessen in die eigene Projekt-`.mcp.json` ein (siehe unten).

## Was drin ist

| Server | Paket | Lizenz | Wofür |
|---|---|---|---|
| `context7` | [@upstash/context7-mcp](https://github.com/upstash/context7) | MIT | Aktuelle Dokumentation zu Bibliotheken und Frameworks (Astro, React, Tailwind, Django, ...) statt Trainingsstand. Vor jeder Web-Suche nach "wie geht X in Bibliothek Y". |
| `chrome-devtools` | [chrome-devtools-mcp](https://github.com/ChromeDevTools/chrome-devtools-mcp) | Apache-2.0 | Eigene Website prüfen: Performance-Trace, Lighthouse, Konsole, Netzwerk, Screenshots. |
| `playwright` | [@playwright/mcp](https://github.com/microsoft/playwright-mcp) | Apache-2.0 | Browser steuern: Formulare ausfüllen, Abläufe durchklicken, Cross-Browser (Chromium, Firefox, WebKit). |

Beide Browser-Server öffnen beim ersten Werkzeugaufruf ein **sichtbares** Chrome-Fenster (beide laufen standardmässig nicht headless). Das ist gewollt - man sieht, was passiert -, überrascht aber, wenn man es nicht erwartet.

Die `.mcp.json` dieses Plugins ist bewusst kurz - sie ist auch als Vorlage für die eigene Projekt-Konfiguration gedacht:

```json
{
  "mcpServers": {
    "context7": { "command": "npx", "args": ["-y", "@upstash/context7-mcp@latest"] },
    "chrome-devtools": { "command": "npx", "args": ["-y", "chrome-devtools-mcp@latest"] },
    "playwright": { "command": "npx", "args": ["-y", "@playwright/mcp@latest"] }
  }
}
```

`@latest` zieht bei jedem Start die neueste Version. Das heisst auch: bei jedem Start fragt npm die Registry, und ohne Netz (Zug, Kundennetz mit Proxy) verzögert sich der Sitzungsstart oder der Server fehlt. Wer Reproduzierbarkeit und schnelle Starts will, pinnt die Version - Stand 23.08.2026: `@upstash/context7-mcp@4.0.3`, `chrome-devtools-mcp@1.7.0`, `@playwright/mcp@0.0.79`.

## Die vier Anschlusswege

MCP-Server erreichen Claude über vier verschiedene Pfade. Wer nur `claude mcp list` fragt, sieht nur den ersten - das ist die häufigste Verwirrung.

| Weg | Wo konfiguriert | Gilt wo | Beispiel |
|---|---|---|---|
| **1. User-Scope** | `~/.claude.json`, Top-Level `mcpServers` (per `claude mcp add -s user ...`) | überall | ein persönlicher Notiz-Server |
| **2. Projekt-Scope** | `<projekt>/.mcp.json` (teilbar, im Repo) oder Projekteintrag in `~/.claude.json` (nur lokal) | nur in diesem Projekt | dieses Plugin, in ein Projekt kopiert |
| **3. Plugin** | `.mcp.json` im Plugin, startet mit dem Plugin | überall, wo das Plugin aktiv ist | dieses Plugin |
| **4. Claude.ai-Connector / Desktop-Extension** | serverseitig bei claude.ai bzw. in der Claude-Desktop-App, **keine lokale Datei** | Konto bzw. App | Gmail, Google Calendar, Figma, Claude in Chrome |

Zwei Stolpersteine:

- Ein Server in einer Projekt-`.mcp.json` ist noch nicht aktiv. Claude Code fragt beim ersten Start, ob er vertrauenswürdig ist; die Freigabe landet in `.claude/settings.local.json` (`enabledMcpjsonServers`). Fehlt sie, ist der Server da, aber stumm.
- Connectoren (Weg 4) haben keine Konfigurationsdatei, die man weitergeben könnte. Solange ein Connector nur registriert, aber nicht eingeloggt ist, lädt die Session ausschliesslich `authenticate` und `complete_authentication` - erst nach dem Login erscheint die eigentliche Werkzeugliste.

## Auswahl im Alltag

| Aufgabe | Erste Wahl | Warum |
|---|---|---|
| "Wie geht X in Astro / React / Tailwind?" | `context7` | aktuelle Doku statt Trainingsstand; vor jeder Web-Suche |
| Eigene Website auf Tempo und Fehler prüfen | `chrome-devtools` | Traces, Lighthouse, Konsole, Netzwerk |
| Ablauf in einer Web-App durchspielen, Formular testen | `playwright` | steuert Browser, auch Firefox und WebKit |
| Seite, die einen Login braucht (LinkedIn, Search Console, Bing) | Claude in Chrome (Erweiterung, Weg 4) | läuft in der echten, eingeloggten Browser-Session |
| Figma-Designs lesen oder erzeugen | Claude.ai-Connector Figma (Weg 4) | OAuth über das Konto; lokaler HTTP-Endpoint wäre `{"type":"http","url":"https://mcp.figma.com/mcp"}`, fragt beim ersten Aufruf nach Login |
| Diagramme aus Text | drawio-MCP (nicht enthalten) | braucht den laufenden draw.io-Editor; als Projekt-Server einrichten |

## Was dieses Plugin bewusst nicht enthält

- **Server mit Konto oder API-Key** (Figma, Gmail, Calendar, Drive, Slack): die würden bei jedem Start nach Login fragen. Als Connector in claude.ai bzw. der Desktop-App einrichten.
- **Server mit Zugriff auf Kontakte, Mail oder Nachrichten** (z.B. apple-mcp): für ein KMU mit Kundendaten ist das zuerst eine Datenschutzfrage (DSG), dann eine technische. Nicht ohne Einordnung empfehlen.
- **Server mit Zugangsdaten in der Konfiguration**: Passwörter oder Keys gehören nie in eine `.mcp.json`, die im Repo liegt. Wenn ein Server einen Key braucht, gehört er als `${MEIN_KEY}` in den `env`-Block und der Wert in die Umgebung - so wie es die offiziellen Anthropic-Plugins vormachen.

## Selbst prüfen

Nach der Installation in einer neuen Session:

```
Welche Version von Astro ist aktuell, und wie definiere ich eine Content Collection? (nutze context7)
```

Claude sollte `mcp__plugin_ai-edu-mcp-basis_context7__resolve-library-id` und `…__query-docs` aufrufen. `/mcp` zeigt alle drei Server als verbunden.

## Lizenz

Die Konfiguration und diese Anleitung: MIT - siehe [LICENSE](../../LICENSE). Die drei Server sind fremde Pakete unter ihren eigenen Lizenzen (siehe Tabelle); dieses Plugin verteilt keinen fremden Code, sondern ruft die Pakete per `npx` auf.

## Versionen

- **v0.1.0** (2026-08-23): context7, chrome-devtools, playwright; Anleitung zu Anschlusswegen und Auswahl
