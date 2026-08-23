# `mail-antwort-entwurf` - Antwort-Entwürfe in deinem Stil

Schreibt Antwort-Entwürfe für eingehende Mails - **im Stil deiner eigenen Sent-Folder-Mails**. Versendet nie, sendet nichts an Outlook oder Gmail zurück. Output ist immer eine Markdown-Datei, die du in Outlook kopierst.

## Wann einsetzen

- **Top-3 aus der Triage** - du hast `mail-triage` durchlaufen, jetzt brauchst du Entwürfe für die Aktion-heute-Mails.
- **Standardanfrage** - Termin-Anfragen, Offert-Rückfragen, FAQ-Antworten - dieselbe Mail in deinem Stil.
- **Verhandlungsmail** - du willst zwei Varianten (kurz/ausführlich, weich/direkt) zum Vergleichen.
- **Reklamations-Antwort** - schwieriger Inhalt, aber im üblichen Tonfall.

## Input

| Input | Pflicht | Format |
|---|---|---|
| **Eingangs-Mail** | ja | `.eml`-Datei, `.txt`/`.md` mit Body, oder Verweis auf Triage-Output (z.B. "Mail #2 aus triage-2026-05-08.md") |
| **Stilreferenz** `sent.csv` | ja | Letzte 30-50 deiner gesendeten Mails - daraus lernt der Agent Anrede, Schluss, Satzlänge, Tonalität |
| Tonalität | nein | `sachlich` / `verhandelnd` / `freundlich-bestimmt` / `entschuldigend` / `absagend-diplomatisch` |
| Bausteine | nein | Konkretes Material (z.B. "freie Termine: Di 10:00, Do 14:00, Fr 9:00") |
| Sperrwörter | nein | Begriffe, die du nie verwendest |

## Stil-Lernen

Vor dem ersten Entwurf liest der Agent die Stilreferenz und extrahiert:

- **Anrede** - "Sehr geehrte:r" / "Liebe:r" / "Hallo" / "Guten Tag"? Du oder Sie?
- **Schluss** - "Freundliche Grüsse" / "Beste Grüsse" / kein Schluss?
- **Signatur** - vorhanden? Aufbau?
- **Satzlänge** - kurz (<15 Worte) oder lang? Liste vs. Fliesstext?
- **Floskel-Inventar** - typische Wendungen ("ich melde mich", "kurze Rückfrage").
- **Sprache** - überwiegend de-CH, de-DE oder Englisch?

Diese Stilanalyse ist Teil des Outputs (Stil-Begründung am Ende des Entwurfs), damit du nachvollziehst, warum der Entwurf so klingt wie er klingt.

## Beispiel-Prompts

**Einzel-Antwort:**

```
mail-antwort-entwurf für mail-23.eml, Stilreferenz sent.csv. Tonalität: sachlich.
```

**Batch-Antworten nach Triage:**

```
Schreib mit mail-antwort-entwurf Antworten für die Top-3 aus triage-2026-05-08.md, Stilreferenz sent.csv.
```

**Mit Bausteinen:**

```
mail-antwort-entwurf für die Termin-Anfrage von claudia@firma.ch.
Sent.csv als Stilreferenz.
Bausteine: meine freien Slots Mo 14:00, Di 10:00, Do 9:00. Bestätigung über meinen Buchungslink <dein-link>.
```

**Verhandlungs-Antwort, zwei Varianten:**

```
Lieferant hat Preiserhöhung 8% angekündigt (siehe lieferant-mail.eml).
mail-antwort-entwurf, Stilreferenz sent.csv, Tonalität verhandelnd-respektvoll, zwei Varianten: kurz und ausführlich.
```

## Output

Eine Datei pro Entwurf: `entwurf-NN-<kurz-slug>.md`. Beispiel-Auszug:

```markdown
# Antwort-Entwurf: Re: Offerte Q3 - Rückfrage

**An:** claudia.brunner@grosskunde-ag.ch
**Betreff:** Re: Offerte Q3 - Rückfrage
**Stil-Quelle:** sent.csv (Anrede: "Liebe Claudia" + Du, Schluss: "Liebe Grüsse, Anna", Sprache: de-CH)
**Tonalität:** sachlich

---

Liebe Claudia

Danke für deine Rückfrage. Du hast Recht: Position 4 in der Offerte ist tatsächlich
ohne Reisekosten ausgewiesen, weil ich das normalerweise pauschal ausweise.

Wenn der Workshop bei euch in Zürich stattfindet, sind Reisekosten bei mir
inbegriffen. Bei Standorten ausserhalb des Grossraums Zürich kommt eine
Pauschale dazu, gestaffelt nach Region.

Soll ich die Offerte mit der Pauschale für Zürich neu rausschicken, oder
brauchst du den Standort-Vorbehalt?

Liebe Grüsse
Anna

---

## Hinweise für den Versand

- [ ] Vor Versand: Reisekosten-Pauschale in Buchhaltungstool prüfen.
- [zu bestätigen: Standort des Workshops mit Claudia geklärt?]

## Stil-Begründung

- Anrede gewählt: "Liebe Claudia" + Du, weil sent.csv durchgängig Du bei diesem Kontakt nutzt.
- Tonalität: sachlich, weil Eingangs-Mail neutral-fragend ist.
- Variante: einzig, weil keine Verhandlungsdimension vorliegt.
```

## Mehrvarianten-Output

Bei verhandelnden Themen oder unklarer Intention liefert der Agent zwei Varianten in einem File. Du wählst aus oder mischst.

## Stolperfallen

- **Du/Sie-Wechsel**: wenn `sent.csv` gemischt ist, orientiert sich der Agent an der Eingangs-Mail. Im Zweifel fragt er nach.
- **Sprach-Mix**: englische Eingangsmail bei deutscher `sent.csv` → Antwort auf Englisch, Stil-Elemente übersetzt.
- **Branchen-Floskeln**: Anwaltsmails verlangen "Mit freundlichen Grüssen", Praxis-Sekretariate oft lockerer. Vor dem ersten Entwurf einen Probe-Satz absegnen lassen.
- **Vertrauliche Themen** (Kündigung, Reklamation, Mahnung): der Entwurf bekommt einen Hinweis "Bitte vor Versand juristisch / HR-mässig prüfen".
- **Keine eigenen Termine**: ohne explizite Slot-Liste schlägt der Agent keine Termine vor.

## Was der Agent NICHT tut

- Nie versenden, kein SMTP / IMAP / Graph-API-Call.
- Nie ohne Stilreferenz arbeiten - dann fragt er nach.
- Nie Personen, Firmen, Zahlen erfinden, die nicht in der Eingangs-Mail oder den Bausteinen stehen.
- Nie rechtsverbindliche Aussagen formulieren (Vertragszusagen, Garantien) - markiert sie als `[zu bestätigen]`.

## FAQ

**Was, wenn ich keine Sent-CSV habe?**
Du kannst dem Agent eine kleine Stil-Probe direkt im Prompt geben (3-5 Beispiel-Mails als Text). Reicht oft für eine Probe-Iteration.

**Funktioniert das auch für englische Mails?**
Ja, aber dann braucht der Agent eine Stilreferenz auf Englisch (englische Mails aus `sent.csv` filtern).

**Kann ich den Entwurf direkt in Outlook posten?**
Nein, du kopierst den Body manuell. Das ist Absicht - du hast die letzte Kontrolle.

**Wie viele Mails sollte `sent.csv` enthalten?**
30-50 reichen. Mehr verbessert Stil-Genauigkeit kaum, kostet aber Tokens.

## Agent-Definition

Die ausführbare Definition liegt in [`../agents/mail-antwort-entwurf.md`](../agents/mail-antwort-entwurf.md).
