---
description: Extrahiert aus einem Fliesstext oder Brain-Dump eine chronologische, abhakbare Checkliste für wiederkehrende KMU-Prozesse. Einsetzen wenn ein mündlich erklärter Ablauf zum dokumentierten SOP werden soll (Neukunden-Onboarding, Monatsabschluss, Event-Vorbereitung etc.).
---

# Prozess-Checkliste

Fliesstext oder Stichworte zum Ablauf:

$ARGUMENTS

Falls der Ablauf nicht chronologisch im Input steht: nachfragen, ob wirklich alles da ist oder Lücken bestehen.

## Format

```
# Checkliste: [Prozessname]

**Gilt für**: [Rolle, Team oder "alle"]
**Version**: [1.0 initial]
**Stand**: [DD.MM.YYYY]

## Ziel des Prozesses

1 Satz: Was soll am Ende erreicht sein?

## Vorbereitung

- [ ] [Schritt 1 vor dem Start]
- [ ] [Schritt 2]
- [ ] [Schritt 3]

## Durchführung

### Phase 1: [Name]

- [ ] 1. [Schritt, nummeriert innerhalb Phase]
- [ ] 2. [Schritt]
- [ ] 3. [Schritt]

### Phase 2: [Name]

- [ ] 1. ...
- [ ] 2. ...

### Phase 3: [Name]

- [ ] 1. ...

## Abschluss-Kontrolle

- [ ] [Was muss am Ende geprüft werden]
- [ ] [Welche Dokumentation abgelegt]
- [ ] [Wer wird informiert]

## Häufige Stolperfallen

- [aus dem Input erkannt oder offensichtlich]
- [was oft vergessen wird]

## Verantwortliche und Eskalation

- **Durchführung**: [Rolle]
- **Freigabe / Kontrolle**: [Rolle]
- **Bei Unklarheit**: [Ansprechperson]

## Offene Punkte

- [wo im Input eine Lücke war]
- [wo Entscheid fehlt]
```

## Regeln

- Deutsch (de-CH), echte Umlaute, Hyphen statt Em-Dash.
- Jeder Schritt beginnt mit Verb im Imperativ ("Prüfe", "Lege ab", "Benachrichtige").
- Nicht zu granular: keine Schritte unter 1 Min. Aber auch nicht zu grob: 1 Schritt = 1 klar abschliessbare Handlung.
- Maximal 3 Phasen. Wenn mehr nötig, eher Teil-Checklisten machen.
- CHF mit Apostroph, Datum DD.MM.YYYY falls im Prozess erwähnt.
- Bei Schritten, die rechtliche oder regulatorische Folgen haben (Datenschutz, Buchhaltung, Arbeitsrecht): Hinweis "Bei Unsicherheit Fachperson beiziehen".
- Checkliste sollte auf 1 A4-Seite druckbar sein. Max. 25 Checkboxes gesamt.
