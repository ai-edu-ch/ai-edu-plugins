---
description: Erstellt aus Kontostand, offenen Debitoren und Kreditoren eine rollende 4-Wochen-Liquiditätsnotiz mit Ampel pro Woche und Top-3-Risiken. Einsetzen Montagmorgen oder vor Lohnlauf für einen schnellen Finanz-Überblick.
---

# Cashflow-Notiz

Aktuelle Finanz-Daten:

$ARGUMENTS

Falls Kontostand, Debitoren-Liste oder Kreditoren-Liste fehlen: anfragen. Nicht schätzen - Cashflow ohne echte Zahlen ist Fiktion.

## Format

```
# Liquiditätsnotiz: [DD.MM.YYYY]

**Startkontostand**: CHF X'XXX.XX
**Planungshorizont**: KW+0 bis KW+4

## Wochenübersicht

| Woche | Einzahlungen (CHF) | Auszahlungen (CHF) | Endbestand (CHF) | Ampel |
|-------|-------------------|--------------------|--------------------|-------|
| KW+0 | ... | ... | ... | 🟢/🟡/🔴 |
| KW+1 | ... | ... | ... | |
| KW+2 | ... | ... | ... | |
| KW+3 | ... | ... | ... | |
| KW+4 | ... | ... | ... | |

**Ampel-Schwellen** (Standardannahme, anpassbar):
- 🟢 > CHF 20'000 Reserve
- 🟡 CHF 5'000 bis 20'000
- 🔴 < CHF 5'000 oder negativ

## Top-3 Risiken

1. [konkretes Risiko mit Datum und Betrag]
2. ...
3. ...

## Empfohlene Massnahmen

- Mahnung an [Kunde] wegen Rechnung [Nr.] über CHF X'XXX.XX
- Zahlungsaufschub bei [Lieferant] anfragen falls 🔴-Woche
- Mit Treuhand/Bank vor KW+N sprechen
- [weitere]

## Fragen an Buchhaltung / Treuhand

- [wo die Zahlen unklar waren]
```

## Regeln

- Deutsch (de-CH), echte Umlaute, Hyphen statt Em-Dash.
- CHF-Beträge mit Apostroph, 2 Dezimalstellen: `CHF 24'500.50`.
- Datum DD.MM.YYYY.
- Ampel-Schwellen mit dem User abstimmbar - im Output die verwendeten Schwellen oberhalb der Tabelle nennen.
- Keine Empfehlungen zu Kreditaufnahme, Factoring oder Finanzprodukten - das ist Bankberatung, nicht Skill-Aufgabe.
- Lohnläufe, MwSt-Zahlungen, AHV-Rechnungen als Kreditoren explizit separat aufführen, falls im Input erwähnt.
- Maximal 1 A4-Seite.
