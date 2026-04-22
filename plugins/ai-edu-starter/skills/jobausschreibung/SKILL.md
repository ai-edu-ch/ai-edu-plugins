---
description: Erstellt aus Rollenstichworten eine schlanke Schweizer Stellenanzeige ohne Konzern-Floskeln. Einsetzen für Sachbearbeitung, Fachkräfte, Projektleiter und ähnliche KMU-Rollen. Nicht für Executive-Search ohne Anpassung.
---

# Job-Ausschreibung

Rollenstichworte:

$ARGUMENTS

Falls Pensum, Arbeitsort oder Muss-Anforderungen fehlen: fragen. Inserat ohne Pensum und Ort filtert niemanden richtig.

## Format

```
# [Rollenbezeichnung] ([Pensum, z.B. 80-100%])

[Arbeitsort, z.B. "Baden" oder "Hybrid Zürich / Homeoffice"]
[Eintritt: Datum oder "nach Vereinbarung"]

## Wer wir sind

1-2 Sätze zur Firma. Was sie tut, wie gross, besondere Merkmale. Kein Werbetext.

## Deine Aufgaben

- [Aufgabe 1, konkret]
- [Aufgabe 2]
- [Aufgabe 3]
- [Aufgabe 4]
- [Aufgabe 5]
- [Aufgabe 6]

Maximal 6 Bullets. Wenn mehr: zusammenfassen.

## Das bringst du mit

**Muss**:
- [Ausbildung, Erfahrung in Jahren, zwingende Kenntnisse]

**Von Vorteil**:
- [was wünschenswert ist, aber nicht zwingend]

## Das bieten wir

- [konkret, nicht "tolles Team"]
- [Arbeitsform, Weiterbildung, Team-Grösse]
- [Rahmenbedingungen wie 5 Wochen Ferien, 13. Monatslohn wenn Standard]

## Bewerbung

Sende deine Unterlagen an [E-Mail]. Erste Fragen beantwortet [Name, Rolle, Kontakt].

Bewerbungsprozess: [Erstgespräch, Zweitgespräch, Entscheid - z.B. "Erstgespräch innerhalb 2 Wochen, Entscheid innerhalb 4 Wochen"].
```

## Diskriminierungs-Check

Der Skill prüft den Entwurf am Schluss auf typische Fallstricke:
- Altersangaben ("junges, dynamisches Team") - streichen
- Geschlechterspezifische Formulierungen ohne m/w/d-Gleichstellung
- Nationalitäts-Anforderungen ohne rechtlichen Grund
- Diskriminierung aufgrund Religion / Orientierung / Herkunft

Falls gefunden: im Output klar als Flag markieren und Alternativformulierung vorschlagen.

## Regeln

- Deutsch (de-CH), echte Umlaute, Hyphen statt Em-Dash.
- Sachliche Sprache. Keine Floskeln ("spannende Herausforderung", "familiäres Team", "dynamisches Umfeld" ohne Beleg).
- "Du" oder "Sie" durchziehen, nicht mischen. Default "du" für KMU, "Sie" wenn im Input angegeben.
- CHF für Gehaltsband nur erwähnen wenn der User im Input explizit nennt. Schweizer KMU nennen selten Gehalt im Inserat, das ist ok.
- Datum DD.MM.YYYY.
- Maximal 1.5 A4-Seiten.
