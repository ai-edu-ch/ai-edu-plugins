# `mail-vip-radar` - VIP- und Behörden-Eskalations-Radar

Matched eine Inbox-CSV gegen eine **VIP-Liste** und identifiziert, wer wie lange wartet, wo Eskalations-Risiko entsteht und welche Behörden- oder A-Kunden-Mails Priorität haben. Stellt sicher, dass die wichtigsten Stakeholder nie unbemerkt warten.

## Wann einsetzen

- **A-Kunden-Schutz** - Solo-Beratung mit 5-10 wichtigsten Mandaten, niemand soll unbemerkt warten.
- **Behörden-Radar** - FINMA, EDOEB, AHV, KESB, Schulleitung - Pflicht-Antwort-Domains nicht übersehen.
- **Lieferanten-Radar** - Top-10-Lieferanten, Liefer-Termine, Reklamationen, Mahnstufen.
- **Eskalations-Frühwarnung** - dritte Erinnerung von einem A-Kontakt? Anwalts-Mail im Posteingang?

## Input

### VIP-Liste

Eine der drei Formen:

**1. CSV-Datei `vips.csv`** (empfohlen):

```csv
Adresse_oder_Domain,Kategorie,SLA_Stunden,Notiz
muster@firma-a.ch,A-Kunde,8,Geschäftsleitung
@firma-b.ch,A-Kunde,24,Domain-weit
@finma.ch,Behörde,48,Aufsicht
@edoeb.admin.ch,Behörde,72,Datenschutz
@anwalt-mueller.ch,Recht,24,Hausanwalt
muster@grosskunde.ch,A-Kunde,4,Eskalations-Sponsor
```

Spalten:

- `Adresse_oder_Domain` - entweder konkrete Adresse (`muster@firma.ch`) oder Domain-Match (`@firma.ch`, matched alle `*@firma.ch`).
- `Kategorie` - frei wählbar (z.B. `A-Kunde`, `Behörde`, `Recht`, `Lieferant-Top10`).
- `SLA_Stunden` - innert wie vielen Stunden muss eine Antwort raus? Wenn leer: Default 24h.
- `Notiz` - frei.

**2. Markdown-Liste `vips.md`** mit Rolle und SLA.

**3. Inline im Prompt**:

```
Top-VIPs: kunde-a@firma.ch (8h), finma.ch (48h), @schulleitung-zh.ch (24h).
```

### Inbox-CSV

Pflicht. Format wie bei [`mail-triage`](mail-triage.md).

### Sent-CSV (optional)

Wenn vorhanden, kann der Agent prüfen, ob du auf eine VIP-Mail bereits geantwortet hast. Ohne `sent.csv` zeigt er nur: "Eingegangen, Wartezeit X" - nicht "Antwort offen".

## Beispiel-Prompts

**Standard-VIP-Check:**

```
Prüfe inbox.csv gegen vips.csv mit dem mail-vip-radar-Agent. Wer wartet wie lange?
```

**Behörden-Radar:**

```
Welche Mails von Behörden oder Aufsicht kamen letzten Monat?
mail-vip-radar mit Domain-Filter `.admin.ch, .ch.ch, finma.ch, edoeb.admin.ch`.
```

**Lieferanten-Radar:**

```
mail-vip-radar im Modus Lieferanten-Radar mit lieferanten-top10.csv als VIP-Liste.
Fokus: Liefer-Termine, Mahnstufen, Reklamationen.
```

**Mit Sent-CSV für Antwort-Status:**

```
mail-vip-radar auf inbox.csv + sent.csv + vips.csv für die letzten 14 Tage.
Zeig mir Hochrisiko und Mittelrisiko.
```

## Risiko-Score

Pro Match wird ein Risiko-Level berechnet:

| Risiko | Bedingung |
|---|---|
| **Hoch** | SLA-verletzt **und** Eskalations-Signal (Mahnstufe, Anwaltsdomain, dritte Erinnerung) |
| **Mittel** | SLA-verletzt, ohne Eskalations-Signal |
| **Niedrig** | Pending im SLA - noch innerhalb der erlaubten Zeit |
| **Erledigt** | Antwortet in `sent.csv` vorhanden, innerhalb SLA |

## Output

Eine Markdown-Datei `vip-radar-<datum>.md`. Beispiel-Auszug:

```markdown
# VIP-Radar 2026-05-08

**Quellen:** `inbox.csv` (47 Mails), `sent.csv` (43 Mails), `vips.csv` (12 VIPs)
**Zeitraum:** 24.04.2026 bis 08.05.2026

## TL;DR

- **Hochrisiko:** 1 (FINMA-Anfrage SLA-verletzt mit Anwalt-Anhang)
- **Mittelrisiko:** 2
- **Niedrigrisiko:** 4
- **Erledigt:** 5

## Hochrisiko - Sofort handeln

| # | VIP | Kategorie | Eingegangen | Wartezeit | SLA | Signal | Quelle |
|---|-----|-----------|-------------|-----------|-----|--------|--------|
| 1 | aufsicht@finma.ch | Behörde | 04.05. 09:00 | 95h | 48h | Anwalts-CC | inbox.csv #21 |

## Mittelrisiko - Heute oder morgen

| # | VIP | Kategorie | Eingegangen | Wartezeit | SLA | Quelle |
|---|-----|-----------|-------------|-----------|-----|--------|

## Niedrigrisiko - im SLA

| # | VIP | Eingegangen | SLA-Rest |

## Erledigt

- claudia@grosskunde.ch - geantwortet am 02.05. in 6h.

## Pattern-Beobachtungen

- VIPs ohne Mail im Zeitraum: 4 (sonst regelmässig - prüfen, ob Kontakt schweigt).
- VIPs mit auffallend hoher Frequenz: aufsicht@finma.ch (5 Mails in 14 Tagen).

## Empfehlung

- [ ] FINMA-Antwort heute, vor allem anderen (Hochrisiko, 95h SLA-Verletzung).
- [ ] Mittelrisiko-Block bis morgen Vormittag durcharbeiten.
- [ ] Bei FINMA-Frequenz: prüfen, ob ein Mandat in Schwierigkeiten ist.
```

## VIP-Listen-Konvention

Empfohlene SLA-Werte (Erfahrungswerte, nicht verbindlich):

| Kategorie | SLA |
|---|---|
| Eskalations-Sponsor / CEO | 4h |
| A-Kunde, Geschäftsleitung | 8h |
| A-Kunde, Domain-weit | 24h |
| Hausanwalt | 24h |
| Behörde, Aufsicht | 48h |
| Behörde, Datenschutz/EDOEB | 72h |
| Lieferant-Top10 | 24h |
| B-Kunde / C-Kunde | 48h-72h |

Werktag-Logik: SLA-Werte sind Kalenderzeit, nicht Werktage. Über Wochenende läuft die Uhr - der Agent zeigt das transparent.

## Stolperfallen

- **Domain-Match-Falle**: `@firma.ch` matched auch `newsletter@firma.ch`. Wenn nötig, Newsletter-Subdomains explizit ausschliessen oder Match auf konkrete Personen-Adressen begrenzen.
- **Auto-Replies**: "Out-of-Office"-Antworten in `sent.csv` zählen nicht als echte Antwort.
- **Conversation-Threading**: ohne `Conversation-ID` Match heuristisch, im Output explizit so markiert.
- **VIP-Listen-Stale**: Wenn die VIP-Liste älter als 6 Monate ist, gibt der Agent einen Hinweis "Liste prüfen, ggf. veraltet".
- **Behörden-Sonderfall**: einige Bundesstellen senden über generische Domains (`*.admin.ch`). Bei Bundesstellen lieber breit matchen.

## Was der Agent NICHT tut

- Nie Personen "nach Bauchgefühl" als VIP einstufen - VIP-Status kommt **ausschliesslich** aus deiner Liste.
- Nie Mails an VIPs vorformulieren oder versenden (das macht `mail-antwort-entwurf`).
- Nie SLA-Werte selbst setzen - bei fehlender Spalte transparent Default 24h ausweisen.
- Nie deine VIP-Liste eigenmächtig ergänzen.

## FAQ

**Was, wenn ich keine VIP-Liste habe?**
Du kannst sie iterativ aufbauen. Erste Version: Top-5-Mandate plus Hausanwalt plus relevante Behörden. Im Lauf der Wochen erweitern.

**Funktioniert das auch ohne Sent-CSV?**
Ja, aber dann zeigt der Agent nur "Eingegangen, Wartezeit X" - kein Antwort-Status. Pending vs. Erledigt unterscheidbar nur mit Sent.

**Können mehrere VIP-Listen kombiniert werden?**
Ja, im Prompt mehrere Files referenzieren: *"VIP-Listen: vips-kunden.csv und vips-behoerden.csv"*. Der Agent merged.

**Wie aktualisiere ich SLA-Werte?**
CSV editieren. Der Agent liest die Liste bei jedem Lauf neu.

## Agent-Definition

Die ausführbare Definition liegt in [`../agents/mail-vip-radar.md`](../agents/mail-vip-radar.md).
