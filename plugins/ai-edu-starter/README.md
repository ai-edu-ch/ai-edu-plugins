# ai-edu-starter

18 Skills, 1 Subagent und CLAUDE.md-Template für Schweizer KMU, die Claude Code produktiv einsetzen wollen.

Teil des [ai-edu.ch](https://ai-edu.ch) Plugin-Marketplaces.

## Installation

In Claude Code:

```
/plugin marketplace add retolutz/ai-edu-plugins
/plugin install ai-edu-starter@ai-edu
```

Anschliessend `/reload-plugins` für sofortige Aktivierung ohne Neustart.

## Enthaltene Skills

### Admin und Meetings

| Skill | Zweck |
|-------|-------|
| `/ai-edu-starter:meeting-protokoll` | Rohe Notizen zu strukturiertem Protokoll |
| `/ai-edu-starter:prozess-checkliste` | Fliesstext zu abhakbarer Schritt-Checkliste |
| `/ai-edu-starter:wochen-review` | Wochen-Notizen zu strukturiertem Review |

### Kundenkommunikation

| Skill | Zweck |
|-------|-------|
| `/ai-edu-starter:email-triage` | Inbox-E-Mail kategorisieren und Entwurf liefern |
| `/ai-edu-starter:reklamations-antwort` | Beschwerde zu deeskalierender Antwort + "was NICHT schreiben" |
| `/ai-edu-starter:zahlungs-erinnerung` | Höfliche bis bestimmte Zahlungserinnerung (3 Stufen) |

### Offerten und Aufträge

| Skill | Zweck |
|-------|-------|
| `/ai-edu-starter:offerten-entwurf` | Anfrage zu Offerten-Entwurf mit CHF, MwSt, Gültigkeit |
| `/ai-edu-starter:nachkalkulation` | Soll-Ist-Vergleich mit Marge und Lehren |
| `/ai-edu-starter:vertrag-check-light` | Vertrags-Risiko-Ampel, ersetzt keine Anwältin |

### Finanzen

| Skill | Zweck |
|-------|-------|
| `/ai-edu-starter:cashflow-notiz` | 4-Wochen-Liquidität mit Ampel und Risiken |
| `/ai-edu-starter:reporting-zusammenfassung` | Langer Report zu One-Pager für VR |

### Marketing und Content

| Skill | Zweck |
|-------|-------|
| `/ai-edu-starter:blog-skizze` | Thema zu H2/H3-Outline mit Argumenten |
| `/ai-edu-starter:linkedin-post` | Rohe Idee zu B2B-Post in CH-Tonalität (120-180 Wörter) |

### HR und Team

| Skill | Zweck |
|-------|-------|
| `/ai-edu-starter:jobausschreibung` | Rollenstichworte zu Schweizer Stellenanzeige |
| `/ai-edu-starter:feedback-vorbereitung` | Beobachtungen zu SBI-Gespräch-Leitfaden |
| `/ai-edu-starter:bewerbung-einordnen` | CV gegen Profil: Fit-Ampel + 5 Interview-Fragen |

### Planung und Sales

| Skill | Zweck |
|-------|-------|
| `/ai-edu-starter:quartalsziele` | Vorhaben zu max. 3 SMART-Zielen mit Streichliste |
| `/ai-edu-starter:cold-outreach` | Erst-Kontakt-Mail + 2 Follow-ups für Tag 7 und 21 |

## Enthaltener Subagent

- **`kundenkorrespondenz`** - spezialisiert auf Schweizer B2B-Kundenkorrespondenz. Kennt Sie-Form, formelle vs. halbformelle Register, CH-Konventionen.

## CLAUDE.md-Template

Die Datei `CLAUDE.md.template` ist ein ausfüllbares Memory-Template für Schweizer KMU. Kopiere es nach `~/.claude/CLAUDE.md` und passe es an deine Firma an.

## Sprache und Konventionen

Alle Skills und der Subagent sind auf **Deutsch (de-CH)** ausgelegt:

- Echte Umlaute ü/ö/ä, "ss" statt "ß"
- Hyphen statt Em-Dash
- CHF-Tausender mit Apostroph: `CHF 1'500`
- Datumsformat DD.MM.YYYY
- MwSt 8.1% (Schweizer Standard ab 01.01.2024)

## Schnelleinstieg für neue Nutzer

Erste drei Skills zum Testen:
1. `/ai-edu-starter:email-triage` mit einer Kunden-E-Mail
2. `/ai-edu-starter:offerten-entwurf` mit einer Anfrage
3. `/ai-edu-starter:wochen-review` am Freitagnachmittag

Danach den Subagent `kundenkorrespondenz` aktivieren, wenn ein Kundenbrief ansteht.

## Support und Anpassung

Das Starter-Kit läuft "as is" unter MIT-Lizenz. Für individuelles Setup-Coaching - eigene CLAUDE.md, zusätzliche Skills, MCP-Integration, DSG-Rahmenwerk - gibt es den Modul-2-Workshop von ai-edu.ch:

https://ai-edu.ch

## Lizenz

MIT - siehe [LICENSE](../../LICENSE).

## Versionen

- **v0.2.0** (2026-04-23): +15 neue Skills (Offerten, Finanzen, HR, Marketing, Planung)
- **v0.1.0** (2026-04-23): Initial: 3 Skills + 1 Subagent + CLAUDE.md-Template
