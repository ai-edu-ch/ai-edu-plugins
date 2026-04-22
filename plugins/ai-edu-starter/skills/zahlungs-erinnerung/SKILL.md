---
description: Generiert eine höfliche, aber bestimmte Zahlungserinnerung für B2B-Kunden in drei Stufen (freundlich, 1. Mahnung, 2. Mahnung). Einsetzen bei offenen Rechnungen, die überfällig sind. Keine Betreibungsandrohung ohne explizite Freigabe.
---

# Zahlungs-Erinnerung

Rechnungsdetails plus gewünschte Stufe (freundlich / erste Mahnung / zweite Mahnung):

$ARGUMENTS

Falls Rechnungsnummer, Betrag oder Datum fehlen: anfragen. Bei unklarer Stufe: standardmässig "freundliche Erinnerung" annehmen und explizit im Output vermerken.

## Format

```
**Betreff**: Erinnerung: Rechnung [Nummer] vom [DD.MM.YYYY]

Sehr geehrte/r [Name],

**Block 1 - Bezugnahme** (1-2 Sätze)
Höflicher Bezug auf die offene Rechnung.

**Block 2 - Details**
- Rechnungs-Nr.: [Nummer]
- Rechnungsdatum: [DD.MM.YYYY]
- Betrag: CHF X'XXX.XX
- Ursprüngliches Zahlungsdatum: [DD.MM.YYYY]

**Block 3 - Neue Frist** (1 Satz)
Wir bitten um Begleichung bis [DD.MM.YYYY, +10 Tage für Stufe 1, +7 Tage Stufe 2, +5 Tage Stufe 3].

**Block 4 - Dialog-Angebot** (1 Satz)
Falls eine Unklarheit oder ein Problem besteht: Kontakt anbieten.

Freundliche Grüsse
[Name]
```

## Ton pro Stufe

- **Freundliche Erinnerung**: Überzahlung unterstellen ("möglicherweise übersehen"). Keine Mahngebühren. Kein Druck.
- **Erste Mahnung**: Sachlich, Begleichung deutlich einfordern. Keine Betreibungsandrohung.
- **Zweite Mahnung**: Frist klar, Hinweis auf rechtliche Schritte möglich nur wenn vom User explizit freigegeben.

## Regeln

- Deutsch (de-CH), echte Umlaute, Hyphen statt Em-Dash.
- CHF-Beträge mit Apostroph: `CHF 4'500.00`.
- Datum DD.MM.YYYY.
- Keine eigenmächtige Betreibungsandrohung - das ist eine Eskalation, die der User bewusst entscheiden muss.
- Mahngebühren nur aufführen, wenn der User sie explizit im Input nennt. In der Schweiz sind Verzugszinsen ab Fristablauf ohne gesonderte Vereinbarung 5% p.a. (OR Art. 104).
- Maximal 150 Wörter pro Stufe. Kurz und klar.
