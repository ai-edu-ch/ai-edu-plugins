# `mail-wochenrecap` - Wochenstatus aus Sent + Inbox

Extrahiert aus deinen **gesendeten Mails** und der **Inbox** der Woche einen Stakeholder-tauglichen Status: was hast du versprochen, was ist noch offen, wer wartet wie lange. Ideal für den Freitag-Status an die Geschäftsleitung.

## Wann einsetzen

- **Freitag-Status für GL** - du brauchst eine 1-Seiten-Übersicht der Woche.
- **Pendenzen-Check** - welche Zusagen aus den letzten 14 Tagen sind noch offen?
- **Mandats-Sicht** - pro Kunde aufgeschlüsselt, was diese Woche gelaufen ist.
- **Latenz-Selbstbild** - wie schnell antwortest du? Wo bist du langsamer als üblich?

## Input

| Input | Pflicht | Format |
|---|---|---|
| `inbox.csv` | ja | Eingegangene Mails der Woche (Outlook-/Gmail-Export) |
| `sent.csv` | ja | Gesendete Mails desselben Zeitraums |
| Zeitraum | nein, default 7 Tage | z.B. "letzte 7 Tage", "KW 19", "01.05.-07.05.2026" |
| Zielgruppe | nein, default "GL" | "GL" / "mich selbst" / "Mandant <X>" - beeinflusst Tonalität |
| Gruppierung | nein, default "thematisch" | "thematisch" / "domain" / "tag" |

CSV-Spalten siehe [`mail-triage`](mail-triage.md) - gleiches Schema. Zusätzlich nützlich, wenn vorhanden: `Conversation-ID` oder `In-Reply-To` für sauberes Threading.

## Beispiel-Prompts

**Standard-Wochenrecap:**

```
mail-wochenrecap aus inbox.csv und sent.csv für KW 19. Zielgruppe: GL.
```

**Pendenzen-Only über 14 Tage:**

```
Welche Zusagen habe ich in den letzten 14 Tagen versprochen, aber nicht eingehalten?
mail-wochenrecap im Pendenzen-Modus aus inbox.csv und sent.csv.
```

**Mandats-Sicht:**

```
Pro Kunde aufgeschlüsselt: was ist diese Woche gelaufen?
mail-wochenrecap mit Domain-Gruppierung aus inbox.csv und sent.csv.
```

## Was der Agent extrahiert

### Aus deinem Sent-Folder

**Zusagen** in den von dir gesendeten Mails:

- "Ich melde mich am ...", "schicke ich bis ...", "antworte ich Anfang nächster Woche".
- Termin-Zusagen ("Treffen am ...", "Call um ...").
- Liefer-Zusagen ("Offerte folgt", "Vertrag bis Freitag").

### Aus der Inbox

**Open Loops** - Mails an dich, die du noch nicht beantwortet hast (kein passendes Re: in `sent.csv`).

### Aus beiden kombiniert

**Erfüllt vs. Offen vs. Überfällig**:

- **Erfüllt**: Zusage + Erfüllungs-Mail im selben Thread.
- **Offen**: Zusage ohne Erfüllung, Fällig-Datum noch nicht erreicht.
- **Überfällig**: Zusage ohne Erfüllung, Fällig-Datum vorbei.

### Zusätzlich

- **Eskalations-Signale** (Mahnstufen, dritte Erinnerung, CC-Vorgesetzt:e).
- **Latenz-Statistik** - Median + 90. Perzentil deiner Antwortzeit, Top-3 langsamste Threads.

## Output

Eine Markdown-Datei `wochenrecap-KW<NN>.md`. Beispiel-Auszug:

```markdown
# Wochenrecap KW19 (29.04.-05.05.2026)

**Quellen:** `inbox.csv` (61 Mails), `sent.csv` (43 Mails)
**Zielgruppe:** GL

## TL;DR (3 Sätze)

1. Offerte Q3 für Grosskunde A erfolgreich versendet, Rückfrage von Claudia ist beantwortet.
2. Zwei überfällige Zusagen Richtung Lieferant B - Liefer-Termin und Reklamations-Antwort.
3. Latenz im Median 4.2h (Vorwoche 3.1h) - leicht langsamer, vor allem Donnerstag.

## Erfüllte Zusagen (7)

- **30.04.** an `claudia@grosskunde.ch`: "Offerte folgt am Mittwoch" → erfüllt am 02.05. (sent.csv #14).
- ...

## Offene Zusagen (3)

| # | An | Versprochen | Inhalt | Fällig | Status |
|---|----|-------------|--------|--------|--------|
| 1 | mueller@lieferant-b.ch | 28.04. | Reklamations-Antwort | 02.05. | **überfällig** |
| 2 | weber@kunde-c.ch | 04.05. | Termin-Vorschlag | 09.05. | offen |

## Offene Anfragen an dich (4)

| # | Von | Eingegangen | Betreff | Tage offen |
|---|-----|-------------|---------|-----------|

## Eskalations-Alarm

- [ ] mueller@lieferant-b.ch - Mahnstufe 2 - Reklamation überfällig (inbox.csv #34).

## Latenz-Statistik

- Median Antwortzeit: 4.2h (Vorwoche 3.1h, leicht langsamer).
- 90. Perzentil: 18.5h.
- Langsamste Threads:
  1. Lieferant B (Reklamation) - 7 Tage offen
  2. ...

## Empfehlung für nächste Woche

- [ ] Reklamations-Antwort an Lieferant B (überfällig - heute, vor allem anderen).
- [ ] Termin-Vorschlag an Weber (Frist 09.05.).
- [ ] Latenz Donnerstag prüfen - 5 Mails >12h offen.
```

## Stolperfallen

- **Re:/Fwd:-Matching**: ohne `Conversation-ID` ist das Match heuristisch (Subject-basiert). Der Agent markiert das im Output.
- **Zeitzone**: Outlook exportiert oft in lokaler Zeit, Gmail in UTC. Im Zweifel klärt der Agent vor der Latenz-Statistik.
- **Ferien-/Out-of-Office**: nach Rückkehr sind alle "offenen Zusagen" überfällig - der Agent erwähnt das im TL;DR explizit.
- **Phantom-Zusagen**: Floskeln wie "ich schaue es mir gerne an" sind keine harten Zusagen - der Agent bewertet konservativ.
- **Auto-Replies in sent**: Out-of-Office-Antworten und automatische Termin-Bestätigungen werden gefiltert.

## Was der Agent NICHT tut

- Nie Pendenzen erfinden, die nicht in den CSVs stehen.
- Nie Personen direkt bewerten ("Kunde X nervt") - nur Daten.
- Nie Empfehlungen geben, die über "diese Mail beantworten" hinausgehen (kein Strategie-Coaching).
- Nie ohne Sent-CSV laufen - dann liefert er nur einen Inbox-Status, klar so deklariert.

## FAQ

**Kann ich den Wochenrecap automatisch jeden Freitag laufen lassen?**
Mit Claude Code's Scheduling-Feature (`/loop` oder Cron) ja, aber nur wenn dein Mail-Export automatisiert ist. Manueller Export-Schritt aus Outlook bleibt.

**Was, wenn ich Outlook nicht nutze?**
Gmail-Export funktioniert genauso - Spalten-Mapping ist anders, der Agent fragt nach.

**Können mehrere Personen den Recap nutzen?**
Ja, aber jede:r mit eigenem Sent-Export. Der Agent macht keinen Team-Recap aus mehreren Sent-Folders.

**Sind Werturteile vermeidbar?**
Der Agent gibt nur datenbasierte Aussagen. "Kunde X hat 3 Mails ohne Antwort, alle mit `[dringend]`" - statt "Kunde X nervt".

## Agent-Definition

Die ausführbare Definition liegt in [`../agents/mail-wochenrecap.md`](../agents/mail-wochenrecap.md).
