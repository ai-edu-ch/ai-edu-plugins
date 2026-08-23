# `mail-triage` - Inbox-Triage aus CSV-Export

Sortiert eine Outlook- oder Gmail-Inbox (CSV-Export) in vier Buckets und markiert Eskalationen. Schreibt keine Antworten - dafür ist [`mail-antwort-entwurf`](mail-antwort-entwurf.md) zuständig.

## Wann einsetzen

- **Montagmorgen nach Ferien** - 200+ ungelesene Mails, du brauchst eine Top-10-Aktionsliste in 60 Sekunden.
- **Tagesplan** - jeden Morgen die letzten 24h sortieren, statt Mail für Mail zu lesen.
- **Eskalations-Check** - du befürchtest, dass eine Mahnstufe oder ein Anwaltsbrief untergegangen ist.
- **Volumen-Pattern** - du willst sehen, wer dich am meisten schreibt und welche Themen sich häufen.

## Input

Eine CSV-Datei aus Outlook ("Datei → Speichern unter → CSV") oder Gmail (via Google Takeout oder eines der Export-Tools). Mindest-Spalten:

| Spalte | Pflicht | Hinweis |
|---|---|---|
| `Von` / `From` | ja | Absender-Adresse |
| `Betreff` / `Subject` | ja | Mail-Subject |
| `Datum` / `Received` | ja | Empfangsdatum |
| `An` / `To` | nein | Empfänger (zur CC/BCC-Erkennung) |
| `CC` | nein | Carbon Copy |
| `Body` / `Inhalt` | empfohlen | Erste 200-500 Zeichen reichen meist |

Wenn deine Spalten anders heissen, fragt der Agent dich nach dem Mapping - er rät nicht.

## Beispiel-Prompts

**Standard-Triage:**

```
Nutze den mail-triage-Agent auf inbox.csv.
```

**Mit Fokus auf Eskalations-Risiko:**

```
mail-triage auf inbox.csv mit Fokus auf Eskalations-Signale (Mahnstufe, Anwaltsdomain, dritte Erinnerung).
```

**Tagesplan für heute:**

```
Gib mir mit mail-triage einen Tagesplan für die Mails von heute morgen aus inbox.csv mit Zeitschätzung pro Mail.
```

## Die vier Buckets

1. **Aktion-heute** - Antwort oder Entscheidung in <24 Stunden nötig (Frage offen, Termin heute, Eskalation).
2. **Antwort-bis-Wochenende** - braucht Reaktion, aber nicht heute.
3. **FYI** - rein informativ, kein Handlungsbedarf.
4. **Spam/Newsletter** - automatisierter Versand, Werbung, Newsletter.

## Eskalations-Flag

Zusätzlich zum Bucket markiert der Agent eine Mail als Eskalation, wenn:

- "Mahnung", "letzte Erinnerung", "dringend", "ASAP", "deadline" im Betreff.
- Vorgesetzte:r oder CEO-Domain auf CC.
- Dritte+ Mail im selben Thread innert 5 Tagen.
- Anwalts-Domain (`.law`, `anwalt`, `rechtsanwalt`).

## Output

Eine Markdown-Datei `triage-<datum>.md` im aktuellen Arbeitsordner. Beispiel-Auszug:

```markdown
# Mail-Triage 2026-05-08

**Quelle:** `inbox.csv` (47 Mails)
**Eskalationen:** 2

## Eskalations-Alarm

- [ ] **anwalt-mueller@kanzlei-zh.ch** - Mahnstufe 2 Vertrag #4711 (06.05.2026) - Anwaltsdomain + 2. Mahnung
  Bucket: Aktion-heute, Begründung: Frist läuft 14.05.2026 ab.

## Aktion heute (7)

| # | Absender | Betreff | Empfangen | Begründung |
|---|----------|---------|-----------|-------------|
| 1 | claudia@grosskunde.ch | Re: Offerte Q3 - Rückfrage | 08.05. 07:14 | A-Kundin wartet seit 2 Tagen, Offerte hängt |
...
```

## Stolperfallen

- **CSV-Encoding**: Outlook exportiert oft `windows-1252` oder `utf-8-bom`. Wenn Umlaute zerstört sind: vorher mit `iconv -f windows-1252 -t utf-8 inbox.csv > inbox-utf8.csv` konvertieren.
- **Zeilenumbrüche im Body**: lange Mails sprengen CSV-Zeilen. Wenn Body-Spalte korrupt ist, fällt der Agent auf Header-Felder zurück (Von/Betreff/Datum) und meldet das.
- **Datums-Format**: `dd.MM.yyyy HH:mm` (CH-Outlook) vs. `MM/dd/yyyy` (US-Gmail) vs. ISO. Der Agent fragt im Zweifel nach.
- **BCC**: ist im Empfänger-Export meist nicht sichtbar - der Agent nutzt es nicht als Quelle.
- **Re: und Fwd:**: zählen als Thread-Member, nicht doppelt priorisieren.

## Was der Agent NICHT tut

- Keine Antworten schreiben (das macht `mail-antwort-entwurf`).
- Keine Mails versenden, löschen, archivieren oder verschieben.
- Kein Live-Zugriff auf Outlook/Gmail (kein API-Call).
- Kein PST-Lesen direkt (CSV ist Pflicht).

## FAQ

**Was, wenn meine Inbox 5'000 Mails hat?**
Der Agent verarbeitet in Batches und meldet, wenn das Volumen sehr hoch ist. Faustregel: erst auf die letzten 7 Tage filtern (Outlook hat Filter beim Export), dann triagieren.

**Kann ich eigene Buckets definieren?**
Ja, im Prompt explizit angeben: *"Nutze diese Buckets statt der Defaults: A-Kunde-heute / B-Kunde-heute / C-Kunde-Woche / Lieferant / FYI."*

**Wo landet das Output-File?**
Im aktuellen Arbeitsordner (dort, wo du Claude Code gestartet hast).

**Werden sensible Mails irgendwohin geschickt?**
Kein Mail-Versand, kein Drittanbieter, keine Kopie ausserhalb deines Ordners. Aber: der Agent läuft in Claude Code, also gehen die Zeilen, die er liest, als Teil des Prompts an die Anthropic-API - wie jede Datei, die du Claude zeigst. Wenn Mail-Inhalte dein Haus nicht verlassen dürfen, exportiere nur Absender, Betreff und Datum ohne Body-Spalte; die Triage funktioniert damit gröber, aber sie funktioniert.

## Agent-Definition

Die ausführbare Definition liegt in [`../agents/mail-triage.md`](../agents/mail-triage.md).
