---
description: Vergleicht Offertwerte (Soll) mit Ist-Aufwand, zeigt Abweichungen pro Position in Stunden und CHF, liefert Marge und Lehren für Folgeofferten. Einsetzen nach Projektabschluss für ehrliche Auswertung.
---

# Nachkalkulation

Offertpositionen plus Ist-Aufwände:

$ARGUMENTS

Falls nur Offerte oder nur Ist-Daten geliefert: fehlenden Teil explizit anfragen. Nichts schätzen.

## Format

```
# Nachkalkulation: [Projektname]

**Kunde**: [Name]
**Projektzeitraum**: [DD.MM.YYYY bis DD.MM.YYYY]

## Soll-Ist-Vergleich

| Position | Soll Std. | Ist Std. | Delta Std. | Soll CHF | Ist CHF | Delta CHF | Delta % |
|----------|-----------|----------|------------|----------|---------|-----------|---------|
| ... | | | | | | | |

**Summen-Zeile**: Gesamtmarge in CHF und % berechnen.

## Hauptabweichungen

Top-3 Positionen mit grösstem CHF-Delta. Pro Position ein Satz Ursachen-Hypothese (aus Input), kein Raten.

## Lehren für Folgeofferten

Genau 3 konkrete Punkte:
1. [was bei nächster Offerte anders formulieren]
2. [welche Annahme explizit machen]
3. [welche Risikoposition einpreisen]

## Offene Fragen

- [wo Ursache unklar ist]
- [was vom Kunden noch gebraucht würde für vollständige Auswertung]
```

## Regeln

- Deutsch (de-CH), echte Umlaute, Hyphen statt Em-Dash.
- CHF-Beträge mit Apostroph-Tausender, 2 Dezimalstellen: `CHF 14'500.00`.
- Deltas negativ als `-CHF 2'000.00`, positiv ohne Vorzeichen. Prozente mit 1 Dezimalstelle.
- Datum DD.MM.YYYY.
- Nichts erfinden: wenn ein Wert im Input fehlt, im Output als `[Wert fehlt]` markieren.
- Lehren müssen konkret sein. "Besser planen" ist keine Lehre. "Montagezeit pauschal mit 20% Puffer offerieren" ist eine.
- Maximal 1 A4-Seite.
