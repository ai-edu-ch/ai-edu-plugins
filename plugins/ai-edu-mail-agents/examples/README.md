# Beispiel-Datensatz `ai-edu-mail-agents`

Anonymisierter, fiktiver 2-Wochen-Mail-Korpus eines Schweizer KMU. Damit kannst du alle vier Agents end-to-end testen, ohne eigene Mails zu exportieren.

## Persona

**Anna Beispiel**, Inhaberin **Beispiel Consulting GmbH** (fiktiv) - KMU-Beratung mit Schwerpunkt Prozess-Optimierung. Sitz Zürich. Rechnet CHF 220 / Stunde. Stilprofil: Du bei etablierten Kontakten, Sie bei Behörden und neuen Anfragen. Sachlich-knapp, kurze Sätze, de-CH.

## Files

| File | Datenzeilen | Zweck |
|---|---|---|
| `vips.csv` | 25 | VIP-Liste mit SLA pro Eintrag |
| `sent.csv` | 94 | Annas gesendete Mails (Stilreferenz, Zusagen-Quelle) |
| `inbox.csv` | 234 | Eingegangene Mails mit Threads, Eskalationen, Spam |

Alle Spalten sind die typischen Outlook-CSV-Felder: `Von, An, CC, Betreff, Datum, Body`. VIP-Schema: `Adresse_oder_Domain, Kategorie, SLA_Stunden, Notiz`.

Zeitraum: 24.04.2026 - 08.05.2026. "Heute" im Datensatz = Freitag 08.05.2026.

## Test-Reihenfolge

```
cd <pfad-zu-diesem-examples-ordner>
claude
```

Dann nacheinander:

### 1. VIP-Radar - Hochrisiko ohne Triage erkennen

```
Nutze den mail-vip-radar-Agent auf inbox.csv und sent.csv mit vips.csv als VIP-Liste. Zeitraum: letzte 14 Tage.
```

Erwartet: 1-2 Hochrisiko (FINMA-Erinnerung kurz vor SLA-Verletzung, Lieferant B-Eskalation an CEO, Hausanwalt-Mahnstufe-2), 2-4 Mittelrisiko, 4-6 Niedrigrisiko, 5+ Erledigt.

### 2. Triage - voller Inbox-Sweep

```
mail-triage auf inbox.csv.
```

Erwartet: ~10 Aktion-heute (davon 2-3 Eskalation), ~25 Antwort-bis-Wochenende, ~80 FYI, ~25 Spam.

### 3. Wochenrecap - GL-Status

```
mail-wochenrecap aus inbox.csv und sent.csv für KW 18 und 19. Zielgruppe: GL.
```

Erwartet: ~10 erfüllte Zusagen, 3-5 offene Zusagen (davon 1-2 überfällig), 10-15 offene Anfragen, Eskalations-Alarm für Lieferant B.

### 4. Antwort-Entwürfe für Top-3

```
Schreib mit mail-antwort-entwurf Antworten für die Top-3 aus triage-2026-05-08.md. Stilreferenz: sent.csv.
```

Erwartet: 3 Markdown-Files mit Du-Anrede an etablierte Kontakte (Brunner, Fischer), Sie-Anrede an Behörden (FINMA, EDOEB), durchgängig "Liebe Grüsse" / "Freundliche Grüsse" je nach Anrede.

## Eingebaute Test-Szenarien

### Hochrisiko (alle 4 Agents sollten reagieren)

- **Reklamation Lieferant B (Müller)** - 3. Erinnerung, überfällige Zusage Annas seit 02.05., am 07.05. Eskalation an Vorgesetzten, am 08.05. CEO-CC und Anwalts-Kanzlei mahnt.
- **FINMA-Anfrage** - Behörde, SLA 48h, Eingang 04.05., am 08.05. Erinnerung mit Frist 18.05.
- **Hausanwalt-Mahnstufe-2** - eigene Honorar-Schuld, Frist 14.05., Eingang 06.05.

### Mittelrisiko / SLA-grenzwertig

- **Coaching-Anfrage Kunde C (Weber)** - mehrere offene Punkte (Vertrag finalisieren, Kickoff vorziehen)
- **EDOEB Datenschutz-Nachfrage** - 72h SLA, knapp im Rahmen
- **CEO Grosskunde** - möchte bei Vertragsunterzeichnung dabei sein, Termin offen

### Erfüllt (sollten als "abgehakt" auftauchen)

- **Offerte Q3 Grosskunde A (Brunner)** - 6-Mail-Thread, Position 4 Reisepauschale geklärt, v3 freigegeben
- **AHV-Beitragsabrechnung 2025** - bestätigt
- **IT-Wartungsfenster 02.05.** - durchgeführt
- **Hotel-Reservation Bern 12.-13.05.** - bestätigt
- **Workshop Mandant D (Fischer) am 06.05.** - durchgeführt, positives Feedback

### Patterns

- **Threading**: 15+ Mail-Threads über Re:- und Fwd:-Subject erkennbar
- **Stilreferenz**: Anrede gemischt Du/Sie je nach Kontakt, durchgängig de-CH (echte Umlaute, "ss" statt "ß")
- **Newsletter / Spam**: ca. 25 Einträge (LinkedIn, Crypto, Phishing, Software-Newsletter, NZZ)
- **VIP-Match**: ca. 35 Inbox-Einträge matchen `vips.csv` (Domain oder Adresse)
- **Werktag-Verteilung**: weniger Mails an Wochenenden, Spam zu allen Zeiten
- **Out-of-Office-Replies**: 4 Stück in inbox (sollte vom Wochenrecap als "keine echte Antwort" erkannt werden)

## Was diese Daten NICHT sind

- Echte Mails einer realen Person.
- Echte Firmen- oder Personennamen (alle frei erfunden).
- Reproduzierbare Outputs - Claude variiert Formulierung leicht zwischen Läufen.
- Echte Behördenkorrespondenz. Die Behörden-Adressen nutzen reale Domains (edoeb.admin.ch, finma.ch, ahv.ch) mit frei erfundenen Lokalteilen; keine dieser Mails wurde je gesendet oder empfangen.

## Eigene Daten verwenden

Wenn du deine eigene Mailbox testen willst:

1. **Outlook**: Datei → Speichern unter → CSV-Format. Sicherstellen, dass die Spalten `Von`, `Betreff`, `Datum` exportiert werden. Bei Sent-Folder dasselbe.
2. **Gmail**: via Google Takeout oder einem CSV-Export-Tool. Spaltennamen können abweichen - die Agents fragen dann nach dem Mapping.
3. **VIP-Liste**: eigene `vips.csv` mit deinen 5-20 wichtigsten Kontakten anlegen. Spalten siehe `vips.csv` hier.

## Feedback und Verbesserungen

Wenn der Datensatz Edge-Cases nicht abdeckt, die du im Schulungsalltag siehst, freue ich mich über ein Issue im Repo: https://github.com/ai-edu-ch/ai-edu-plugins/issues

Vorschläge für künftige Erweiterungen:
- Branchenspezifische Varianten (Praxis: mehr Patientenanfragen, Handwerk: mehr Offerten)
- Englischsprachige Persona als zweite Test-Suite
- Grössere Volumen (1000+ Mails)
