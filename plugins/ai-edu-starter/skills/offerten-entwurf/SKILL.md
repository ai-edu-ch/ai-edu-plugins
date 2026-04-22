---
description: Erstellt aus einer Kundenanfrage und eigenen Eckdaten einen strukturierten Offerten-Entwurf mit Positionen, CHF-Preisen, MwSt und Standardklauseln. Einsetzen wenn ein erster Offerten-Entwurf gebraucht wird, nicht als Ersatz für juristische Prüfung.
---

# Offerten-Entwurf

Aus Kundenanfrage und Eckdaten einen Offerten-Entwurf in Markdown:

$ARGUMENTS

Bei fehlenden Angaben (Preise, Leistungsumfang, Gerichtsstand): im Output als `[nachreichen]` markieren. Nicht raten.

## Format

```
# Offerte: [Titel]

**Kunde**: [Firma, Kontaktperson]
**Datum**: [DD.MM.YYYY]
**Offert-Nr.**: [Platzhalter]
**Gültig bis**: [+30 Tage]

## Ausgangslage
2-3 Sätze zum Kontext der Anfrage.

## Leistungspositionen

| Pos | Leistung | Einheit | Menge | Preis (CHF) | Total (CHF) |

**Zwischensumme**: CHF X'XXX.XX
**MwSt 8.1%**: CHF X'XXX.XX
**Total**: CHF X'XXX.XX

## Zahlungsbedingungen
30 Tage netto ohne Abzug, ausser anders vereinbart.

## Gültigkeit und Annahme
Gültig bis [Datum]. Annahme schriftlich an [E-Mail].

## Ausschlüsse und Annahmen
- Was nicht enthalten ist
- Voraussetzungen Kundenmitwirkung
- Weitere Annahmen

Gerichtsstand: [Ort]
```

## Regeln

- Deutsch (de-CH), echte Umlaute ü/ö/ä, "ss" statt "ß", Hyphen statt Em-Dash.
- CHF-Beträge mit Apostroph-Tausender, 2 Dezimalstellen, Punkt als Dezimalzeichen: `CHF 12'500.00`.
- MwSt-Satz Schweiz 8.1% (Standard ab 01.01.2024), ausser anders angegeben (z.B. 2.6% für Beherbergung, 3.8% für Beherbergung bis 2027).
- Datumsformat DD.MM.YYYY.
- Bei juristisch heiklen Punkten (Haftungsbegrenzung, Exklusivität, Abtretungsverbote): auf Anwaltsreview hinweisen, nicht selbst formulieren.
- Maximal 1.5 A4-Seiten.
