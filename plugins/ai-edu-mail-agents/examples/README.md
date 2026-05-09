# Beispiel-Datensatz `ai-edu-mail-agents`

Anonymisierter, fiktiver 2-Wochen-Mail-Korpus eines Schweizer KMU. Damit kannst du alle vier Agents end-to-end testen, ohne eigene Mails zu exportieren.

## Persona

**Anna Beispiel**, Inhaberin **Beispiel Consulting GmbH** (fiktiv) - KMU-Beratung mit Schwerpunkt Prozess-Optimierung. Sitz Zuerich. Rechnet CHF 220 / Stunde. Stilprofil: Du bei etablierten Kontakten, Sie bei Behoerden und neuen Anfragen. Sachlich-knapp, kurze Saetze, de-CH.

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
mail-wochenrecap aus inbox.csv und sent.csv fuer KW 18 und 19. Zielgruppe: GL.
```

Erwartet: ~10 erfuellte Zusagen, 3-5 offene Zusagen (davon 1-2 ueberfaellig), 10-15 offene Anfragen, Eskalations-Alarm fuer Lieferant B.

### 4. Antwort-Entwuerfe fuer Top-3

```
Schreib mit mail-antwort-entwurf Antworten fuer die Top-3 aus triage-2026-05-08.md. Stilreferenz: sent.csv.
```

Erwartet: 3 Markdown-Files mit Du-Anrede an etablierte Kontakte (Brunner, Fischer), Sie-Anrede an Behoerden (FINMA, EDOEB), durchgaengig "Liebe Gruesse" / "Freundliche Gruesse" je nach Anrede.

## Eingebaute Test-Szenarien

### Hochrisiko (alle 4 Agents sollten reagieren)

- **Reklamation Lieferant B (Mueller)** - 3. Erinnerung, ueberfaellige Zusage Annas seit 02.05., am 07.05. Eskalation an Vorgesetzten, am 08.05. CEO-CC und Anwalts-Kanzlei mahnt.
- **FINMA-Anfrage** - Behoerde, SLA 48h, Eingang 04.05., am 08.05. Erinnerung mit Frist 18.05.
- **Hausanwalt-Mahnstufe-2** - eigene Honorar-Schuld, Frist 14.05., Eingang 06.05.

### Mittelrisiko / SLA-grenzwertig

- **Coaching-Anfrage Kunde C (Weber)** - mehrere offene Punkte (Vertrag finalisieren, Kickoff vorziehen)
- **EDOEB Datenschutz-Nachfrage** - 72h SLA, knapp im Rahmen
- **CEO Grosskunde** - moechte bei Vertragsunterzeichnung dabei sein, Termin offen

### Erfuellt (sollten als "abgehakt" auftauchen)

- **Offerte Q3 Grosskunde A (Brunner)** - 6-Mail-Thread, Position 4 Reisepauschale geklaert, v3 freigegeben
- **AHV-Beitragsabrechnung 2025** - bestaetigt
- **IT-Wartungsfenster 02.05.** - durchgefuehrt
- **Hotel-Reservation Bern 12.-13.05.** - bestaetigt
- **Workshop Mandant D (Fischer) am 06.05.** - durchgefuehrt, positives Feedback

### Patterns

- **Threading**: 15+ Mail-Threads ueber Re:- und Fwd:-Subject erkennbar
- **Stilreferenz**: Anrede gemischt Du/Sie je nach Kontakt, durchgaengig de-CH (echte Umlaute, ss statt ss)
- **Newsletter / Spam**: ca. 25 Eintraege (LinkedIn, Crypto, Phishing, Software-Newsletter, NZZ)
- **VIP-Match**: ca. 35 Inbox-Eintraege matchen `vips.csv` (Domain oder Adresse)
- **Werktag-Verteilung**: weniger Mails an Wochenenden, Spam zu allen Zeiten
- **Out-of-Office-Replies**: 4 Stueck in inbox (sollte vom Wochenrecap als "keine echte Antwort" erkannt werden)

## Was diese Daten NICHT sind

- Echte Mails einer realen Person.
- Echte Firmen- oder Personennamen (alle frei erfunden).
- Reproduzierbare Outputs - Claude variiert Formulierung leicht zwischen Laeufen.
- Mit echten Behoerden korrespondierend - Subdomains von admin.ch / finma.ch / ahv.ch sind fiktive Lokalteile.

## Eigene Daten verwenden

Wenn du deine eigene Mailbox testen willst:

1. **Outlook**: Datei → Speichern unter → CSV-Format. Sicherstellen, dass die Spalten `Von`, `Betreff`, `Datum` exportiert werden. Bei Sent-Folder dasselbe.
2. **Gmail**: via Google Takeout oder einem CSV-Export-Tool. Spaltennamen koennen abweichen - die Agents fragen dann nach dem Mapping.
3. **VIP-Liste**: eigene `vips.csv` mit deinen 5-20 wichtigsten Kontakten anlegen. Spalten siehe `vips.csv` hier.

## Feedback und Verbesserungen

Wenn der Datensatz Edge-Cases nicht abdeckt, die du im Schulungsalltag siehst, freue ich mich ueber ein Issue im Repo: https://github.com/ai-edu-ch/ai-edu-plugins/issues

Vorschlaege fuer kuenftige Erweiterungen:
- Branchenspezifische Varianten (Praxis: mehr Patientenanfragen, Handwerk: mehr Offerten)
- Englischsprachige Persona als zweite Test-Suite
- Groessere Volumen (1000+ Mails)
