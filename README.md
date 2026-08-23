# ai-edu Plugin-Marketplace

Plugin-Marketplace von [ai-edu.ch](https://ai-edu.ch) für Schweizer KMU, die Claude Code im Alltag produktiv einsetzen.

## Installation

In Claude Code:

```
/plugin marketplace add ai-edu-ch/ai-edu-plugins
```

Danach einzelne Plugins installieren (siehe Liste unten).

## Enthaltene Plugins

### `ai-edu-starter` (v0.3.0)

19 Skills, 1 Subagent und CLAUDE.md-Template für den KMU-Alltag - Offerten, Reklamationen, Finanzen, HR, Content, Planung, Strategie-Second-Opinion.

Installation:

```
/plugin install ai-edu-starter@ai-edu
```

Skills im Überblick:

- **Admin**: meeting-protokoll, prozess-checkliste, wochen-review
- **Kundenkommunikation**: email-triage, reklamations-antwort, zahlungs-erinnerung
- **Offerten und Aufträge**: offerten-entwurf, nachkalkulation, vertrag-check-light
- **Finanzen**: cashflow-notiz, reporting-zusammenfassung
- **Marketing und Content**: blog-skizze, linkedin-post
- **HR und Team**: jobausschreibung, feedback-vorbereitung, bewerbung-einordnen
- **Planung und Sales**: quartalsziele, cold-outreach
- **Strategie (Advanced)**: council (Multi-LLM-Second-Opinion, benötigt MCP-Setup)

Subagent: kundenkorrespondenz (Schweizer B2B-Briefe, E-Mails, Mahnungen).

Details: [plugins/ai-edu-starter/README.md](plugins/ai-edu-starter/README.md)

### `ai-edu-mail-agents` (v0.1.0)

Vier produktive Subagents für Mail-Bulk-Analyse aus Outlook- oder Gmail-CSV-Exports. Schreibt nichts, versendet nichts - liefert strukturierte Markdown-Outputs, die du in Outlook weiterverwendest.

Installation:

```
/plugin install ai-edu-mail-agents@ai-edu
```

Subagents im Überblick:

| Agent | Zweck |
|---|---|
| `mail-triage` | Inbox-CSV in 4 Buckets sortieren plus Eskalations-Alarm |
| `mail-antwort-entwurf` | Antwort-Entwürfe im Stil deiner Sent-Mails |
| `mail-wochenrecap` | Wochenstatus aus Sent + Inbox - Zusagen, offene Punkte, Latenz |
| `mail-vip-radar` | VIP-Liste vs. Inbox - SLA-Verletzungen + Eskalations-Risiko |

Details: [plugins/ai-edu-mail-agents/README.md](plugins/ai-edu-mail-agents/README.md)

## Sprache

Alle Plugins sind auf Deutsch (de-CH) ausgelegt, mit Schweizer Zahl- und Datumskonventionen:

- Echte Umlaute ü/ö/ä, "ss" statt "ß"
- Hyphen statt Em-Dash
- CHF-Tausender mit Apostroph: `CHF 1'500`
- Datumsformat DD.MM.YYYY
- MwSt 8.1% als Standard

## Lizenz

MIT - siehe [LICENSE](LICENSE). Plugins sind frei nutzbar, kommerziell und privat.

## Schulung und Setup-Begleitung

Das Starter-Kit ist der Ausgangspunkt. Wer das Setup auf die eigene Firma zuschneiden, eigene Skills und Subagents bauen oder MCP-Integrationen einrichten will, bucht den Modul-2-Workshop:

https://ai-edu.ch

## Mitwirken

Issues und Pull Requests sind willkommen. Beim Beitragen bitte:

- Sprache Deutsch (de-CH), echte Umlaute ü/ö/ä
- Hyphen statt Em-Dash
- KMU-Fokus, nicht Developer-Fokus
