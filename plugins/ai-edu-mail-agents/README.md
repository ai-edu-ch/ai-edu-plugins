# ai-edu-mail-agents

Vier produktive Subagents für Mail-Bulk-Analyse aus **Outlook- oder Gmail-CSV-Exports**.

Teil des [ai-edu.ch](https://ai-edu.ch) Plugin-Marketplaces.

## Wozu

Wer in einem KMU jeden Morgen 80+ ungelesene Mails sortiert, jeden Freitag den Wochen-Status für die Geschäftsleitung schreibt, oder sicherstellen muss, dass A-Kundinnen und Behörden nie warten, kennt das Problem: Outlook gibt dir kein Werkzeug, das die ganze Inbox versteht, sondern nur einzelne Mails.

Diese vier Agents arbeiten auf einem CSV-Export der Mailbox - vollständig lokal, ohne Live-API, ohne Mail-Versand. Sie geben dir strukturierte Markdown-Outputs, die du in Outlook oder einem Editor weiterverwendest.

| Agent | Zweck | Output-File |
|---|---|---|
| `mail-triage` | Inbox-CSV in 4 Buckets sortieren plus Eskalations-Alarm | `triage-<datum>.md` |
| `mail-antwort-entwurf` | Antwort-Entwürfe im **deinem** Stil (lernt aus `sent.csv`) | `entwurf-NN-<slug>.md` |
| `mail-wochenrecap` | Sent + Inbox kombiniert: Zusagen, offene Punkte, Latenz | `wochenrecap-KW<NN>.md` |
| `mail-vip-radar` | VIP-Liste vs. Inbox: SLA-Verletzungen + Eskalations-Risiko | `vip-radar-<datum>.md` |

## Installation

In Claude Code:

```
/plugin marketplace add ai-edu-ch/ai-edu-plugins
/plugin install ai-edu-mail-agents@ai-edu
```

Anschliessend `/reload-plugins` für sofortige Aktivierung ohne Neustart.

Die Agents werden danach von Claude Code automatisch aufgerufen, wenn der Use-Case zum `description`-Feld passt - oder explizit per *"Nutze den `mail-triage`-Agent auf `inbox.csv`."*.

## Voraussetzungen

- **Outlook** oder **Gmail**, mit Möglichkeit, Mails als CSV zu exportieren.
- Eine **Sent-Folder-CSV** für `mail-antwort-entwurf` und `mail-wochenrecap` (Stilreferenz / Zusagen-Tracking).
- Eine **VIP-Liste als CSV** (`vips.csv`) für `mail-vip-radar` - Spalten: `Adresse_oder_Domain`, `Kategorie`, `SLA_Stunden`, `Notiz`.

Keine Live-Anbindung an Outlook oder Gmail nötig. Keine MCP-Konfiguration zwingend.

## Designprinzipien

- **CSV statt PST** - das binäre Outlook-PST wird nicht direkt verarbeitet. "Speichern als CSV" oder Drittwerkzeug zur Konvertierung.
- **Lokale Dateien, kein Cloud-Roundtrip** - die Agents lesen und schreiben in dem Ordner, in dem du Claude Code startest.
- **Kein Mail-Versand, kein Mail-Löschen** - Output ist immer ein neues Markdown-File. Versand und Action bleiben manuell bei dir, in Outlook oder Gmail.
- **Stil-Lernen aus deinen Sent-Mails** - `mail-antwort-entwurf` liest deinen Sent-Folder und imitiert Anrede, Schluss, Satzlänge, Tonalität. Keine generische ChatGPT-Tonalität.
- **Ehrliche Grenzen** - jeder Agent dokumentiert Stolperfallen (Encoding, Zeitzone, Threading, BCC) und was er **nicht** kann.

## Sprache

- Output in der Sprache des Mail-Korpus (überwiegend deutsch → DE-Output, sonst EN).
- Bei deutschen Mails: de-CH-Konvention (echte Umlaute ü/ö/ä, "ss" statt "ß", Hyphen statt Em-Dash).
- CSV-Encoding-Probleme (Outlook exportiert oft `windows-1252`) werden erkannt und gemeldet.

## Wie die Agents zusammenspielen

Typischer Workflow eines Schweizer KMU am Montagmorgen:

```
1. Outlook → "Speichern als CSV" → inbox.csv (200 Mails seit letzter Woche)
2. mail-vip-radar (auf inbox.csv + vips.csv) → vip-radar-2026-05-08.md
   → Du siehst: Hochrisiko: 1 Behördenmail, SLA-verletzt
3. mail-triage (auf inbox.csv) → triage-2026-05-08.md
   → Aktion-heute: 7 Mails, davon 3 Eskalation
4. mail-antwort-entwurf (für die Top-3) → entwurf-01.md, entwurf-02.md, entwurf-03.md
   → Drei Entwürfe in deinem Stil, du kopierst und versendest manuell
```

Am Freitag:

```
5. Outlook → sent.csv exportieren
6. mail-wochenrecap (auf inbox.csv + sent.csv) → wochenrecap-KW19.md
   → 1-Seiten-Status für die Geschäftsleitung
```

## Doku pro Agent

Detaillierte READMEs mit Beispiel-Prompts, Input-Schemas, Output-Beispielen und Troubleshooting:

- [`docs/mail-triage.md`](docs/mail-triage.md)
- [`docs/mail-antwort-entwurf.md`](docs/mail-antwort-entwurf.md)
- [`docs/mail-wochenrecap.md`](docs/mail-wochenrecap.md)
- [`docs/mail-vip-radar.md`](docs/mail-vip-radar.md)

## Beispiel-Datensatz

In [`examples/`](examples/) liegt ein anonymisierter, fiktiver 2-Wochen-Mail-Korpus (`inbox.csv`, `sent.csv`, `vips.csv`), mit dem du alle vier Agents end-to-end testen kannst, ohne eigene Mails zu exportieren. Persona: Anna Beispiel, KMU-Beraterin Zuerich. 234 Inbox-Mails, 94 Sent-Mails, 25 VIPs, eingebaute Eskalations-Treppe (Lieferant-Reklamation, FINMA-Anfrage, Hausanwalt-Mahnung), erfuellte Threads (Offerte Q3, Workshop) und ca. 25 Spam-Mails.

Anleitung: [`examples/README.md`](examples/README.md).

## Lizenz

MIT - siehe [LICENSE](../../LICENSE) im Repo-Root.

## Schulung und Setup-Begleitung

Wenn du die Agents auf deine Mail-Workflow zuschneiden willst, eigene VIP-Klassen einführen oder MCP-Anbindung an Outlook/Gmail aufsetzen willst:

[Claude Code 1:1 Schulung](https://ai-edu.ch/pakete/claude-code/) - 90 Minuten remote, CHF 990.
