---
description: Prüft einen Vertragsentwurf auf KMU-typische Stolperfallen (Haftung, Kündigung, Gerichtsstand, automatische Verlängerung, einseitige Preisanpassungen) und liefert eine Ampel-Bewertung. Ersetzt keine anwaltliche Prüfung. Einsetzen vor Unterschrift von Rahmen- oder Dienstleistungsverträgen.
---

# Vertrags-Check (Light)

Vertragstext zur Prüfung:

$ARGUMENTS

Falls kein Text übergeben wurde: fragen, ob Kunden- oder Lieferantenvertrag, dann Text verlangen.

## Format

```
# Vertrags-Check: [Bezeichnung oder "unbenannter Vertrag"]

**Geprüft am**: [DD.MM.YYYY]
**Art**: [Rahmenvertrag / Dienstleistungsvertrag / SLA / NDA / andere]

## Risiko-Ampel

| Kategorie | Ampel | Begründung |
|-----------|-------|------------|
| Haftungsbegrenzung | 🔴/🟡/🟢 | [Zitat aus Vertrag] |
| Kündigung und Fristen | 🔴/🟡/🟢 | |
| Gerichtsstand und anwendbares Recht | 🔴/🟡/🟢 | |
| Automatische Verlängerung | 🔴/🟡/🟢 | |
| Preisanpassungen (einseitig?) | 🔴/🟡/🟢 | |
| Vertragsstrafen | 🔴/🟡/🟢 | |
| Abtretungsverbot | 🔴/🟡/🟢 | |
| Datenschutz / revDSG | 🔴/🟡/🟢 | |

**Ampel-Bedeutung**: 🟢 unproblematisch, 🟡 verhandelbar, 🔴 Anwaltsprüfung erforderlich.

## Verhandlungsvorschläge (zu 🟡-Punkten)

- [konkret, neutral formuliert, pro Punkt ein Satz]

## Anwalt beiziehen bei

- Alle 🔴-Punkte
- Gesamtvolumen > CHF 100'000
- Exklusivitätsklauseln
- Abweichung vom Schweizer OR als anwendbares Recht
```

## Regeln

- Deutsch (de-CH), echte Umlaute, Hyphen statt Em-Dash.
- CHF mit Apostroph, Datum DD.MM.YYYY.
- **Kein Ersatz für Anwalt.** Disclaimer im Output: "Diese Prüfung ersetzt keine anwaltliche Beratung. Bei Unsicherheit professionelle Prüfung einholen."
- Keine Formulierungs-Vorschläge für juristische Klauseln selbst ausformulieren - nur Verhandlungsrichtungen.
- Zitate aus dem Vertrag immer in Anführungszeichen mit Hinweis auf Artikel/Ziffer.
- Bei Vermutung auf fehlende Standardklauseln (z.B. Gerichtsstand fehlt): als 🟡 markieren mit Hinweis auf Ergänzung.
