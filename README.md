# ai-edu Plugin-Marketplace

Plugin-Marketplace von [ai-edu.ch](https://ai-edu.ch) für Schweizer KMU, die Claude Code im Alltag produktiv einsetzen. Vier Plugins: Skills für den KMU-Alltag, Subagents für die Mailbox, Hooks für sauberes Git, MCP-Server ohne Konto.

## Installation

In Claude Code:

```
/plugin marketplace add ai-edu-ch/ai-edu-plugins
```

Danach einzelne Plugins installieren (siehe Liste unten). Aktualisieren mit `/plugin marketplace update ai-edu`.

## Enthaltene Plugins

| Plugin | Was | Installation |
|---|---|---|
| `ai-edu-starter` (v0.4.0) | 18 Skills, 2 Subagents, CLAUDE.md-Template | `/plugin install ai-edu-starter@ai-edu` |
| `ai-edu-mail-agents` (v0.1.0) | 4 Subagents für Outlook-/Gmail-CSV-Exports | `/plugin install ai-edu-mail-agents@ai-edu` |
| `ai-edu-git-hygiene` (v0.1.0) | 2 Hooks gegen Git-Unfälle mit parallelen Sessions | `/plugin install ai-edu-git-hygiene@ai-edu` |
| `ai-edu-mcp-basis` (v0.1.0) | 3 MCP-Server ohne Konto, plus Anleitung | `/plugin install ai-edu-mcp-basis@ai-edu` |

### `ai-edu-starter` (v0.4.0)

18 Skills, 2 Subagents und CLAUDE.md-Template für den KMU-Alltag - Offerten, Reklamationen, Finanzen, HR, Content, Planung.

Skills im Überblick:

- **Admin**: meeting-protokoll, prozess-checkliste, wochen-review
- **Kundenkommunikation**: email-triage, reklamations-antwort, zahlungs-erinnerung
- **Offerten und Aufträge**: offerten-entwurf, nachkalkulation, vertrag-check-light
- **Finanzen**: cashflow-notiz, reporting-zusammenfassung
- **Marketing und Content**: blog-skizze, linkedin-post
- **HR und Team**: jobausschreibung, feedback-vorbereitung, bewerbung-einordnen
- **Planung und Sales**: quartalsziele, cold-outreach

Subagents: `kundenkorrespondenz` (Schweizer B2B-Briefe, E-Mails, Mahnungen) und `linkedin-research` (Mitbewerber, Leads, Jobmarkt - strikt read-only in der eigenen Chrome-Session, braucht die Erweiterung [Claude in Chrome](https://claude.com/chrome)).

Details: [plugins/ai-edu-starter/README.md](plugins/ai-edu-starter/README.md)

### `ai-edu-mail-agents` (v0.1.0)

Vier Subagents für Mail-Bulk-Analyse aus Outlook- oder Gmail-CSV-Exports. Sie arbeiten nur auf den exportierten Dateien und haben keinen Zugang zur Mailbox - Ergebnis sind strukturierte Markdown-Outputs, die du in Outlook weiterverwendest. Mit synthetischem Beispiel-Datensatz (Persona "Anna Beispiel") zum Ausprobieren.

| Agent | Zweck |
|---|---|
| `mail-triage` | Inbox-CSV in 4 Buckets sortieren plus Eskalations-Alarm |
| `mail-antwort-entwurf` | Antwort-Entwürfe im Stil deiner Sent-Mails |
| `mail-wochenrecap` | Wochenstatus aus Sent + Inbox - Zusagen, offene Punkte, Latenz |
| `mail-vip-radar` | VIP-Liste vs. Inbox - SLA-Verletzungen + Eskalations-Risiko |

Details: [plugins/ai-edu-mail-agents/README.md](plugins/ai-edu-mail-agents/README.md)

### `ai-edu-git-hygiene` (v0.1.0)

Zwei Hooks aus echten Vorfällen: `block-shared-commit` verweigert `git commit` im geteilten Haupt-Arbeitsbaum, sobald das Repo mehr als einen Worktree hat (parallele Sessions); `warn-untracked-pile` meldet am Ende einer Antwort, wenn mehr als zwölf unversionierte Dateien liegengeblieben sind. Beide abschaltbar per Umgebungsvariable. Dazu ein optionales macOS-Mitteilungs-Skript.

Details: [plugins/ai-edu-git-hygiene/README.md](plugins/ai-edu-git-hygiene/README.md)

### `ai-edu-mcp-basis` (v0.1.0)

`context7` (aktuelle Bibliotheks-Doku), `chrome-devtools` (Website prüfen, Performance) und `playwright` (Browser steuern) - drei MCP-Server, die ohne Konto und ohne API-Key laufen, als Plugin fertig konfiguriert. Das README erklärt die vier Anschlusswege für MCP-Server (User-Scope, Projekt, Plugin, Connector) und welcher Server wofür die erste Wahl ist.

Details: [plugins/ai-edu-mcp-basis/README.md](plugins/ai-edu-mcp-basis/README.md)

## Empfohlene Fremd-Werkzeuge (nicht hier gehostet)

Diese Skills und Plugins nutzen wir selbst, sie gehören aber anderen und werden dort gepflegt - darum hier nur der Installationsweg, keine Kopie:

| Werkzeug | Wofür | Lizenz | Installation |
|---|---|---|---|
| [blader/humanizer](https://github.com/blader/humanizer) | KI-Schreibmuster aus Texten entfernen | MIT | `npx skills add blader/humanizer --global` |
| [AgriciDaniel/claude-seo](https://github.com/AgriciDaniel/claude-seo) | SEO-Audit, Schema, GEO für die eigene Website | MIT | `/plugin marketplace add AgriciDaniel/claude-seo` und `/plugin install claude-seo@agricidaniel-claude-seo` |
| [impeccable](https://github.com/pbakaus/impeccable) | Frontend-Design kritisieren und verbessern | Apache-2.0 | `npx impeccable` |

## Sprache

Alle Plugins sind auf Deutsch (de-CH) ausgelegt, mit Schweizer Zahl- und Datumskonventionen:

- Echte Umlaute ü/ö/ä, "ss" statt "ß"
- Hyphen statt Em-Dash
- CHF-Tausender mit Apostroph: `CHF 1'500`
- Datumsformat DD.MM.YYYY
- MwSt 8.1% als Standard

## Lizenz

MIT - siehe [LICENSE](LICENSE). Plugins sind frei nutzbar, kommerziell und privat. Versionen und Änderungen: [CHANGELOG.md](CHANGELOG.md).

## Schulung und Setup-Begleitung

Die Plugins sind der Ausgangspunkt. Wer das Setup auf die eigene Firma zuschneiden, eigene Skills und Subagents bauen oder MCP-Integrationen einrichten will:

https://ai-edu.ch

## Mitwirken

Issues und Pull Requests sind willkommen. Beim Beitragen bitte:

- Sprache Deutsch (de-CH), echte Umlaute ü/ö/ä
- Hyphen statt Em-Dash
- KMU-Fokus, nicht Developer-Fokus
- Keine Kopien fremder Skills - verlinken statt übernehmen
- `claude plugin validate .` muss grün sein
