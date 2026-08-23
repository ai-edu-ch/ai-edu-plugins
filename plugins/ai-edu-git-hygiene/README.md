# ai-edu-git-hygiene

Zwei Hooks gegen die häufigsten Git-Unfälle, wenn mehrere Claude-Code-Sessions im selben Repo arbeiten. Beide sind aus echten Vorfällen entstanden, nicht aus Vorsicht.

Teil des [ai-edu.ch](https://ai-edu.ch) Plugin-Marketplaces.

## Installation

```
/plugin marketplace add ai-edu-ch/ai-edu-plugins
/plugin install ai-edu-git-hygiene@ai-edu
```

Die Hooks sind nach der Installation sofort aktiv - in jedem Projekt, in dem Claude Code läuft. Wer sie nur in einem Projekt will, installiert das Plugin mit `--scope project`.

Voraussetzung: `jq` (macOS: `brew install jq`). Fehlt es, lassen die Hooks alles durch, statt zu blockieren.

## Hook 1: kein Commit im geteilten Haupt-Arbeitsbaum

`PreToolUse` auf `Bash`, Skript `scripts/block-shared-commit.sh`.

**Das Problem.** Zwei oder drei Claude-Code-Sessions teilen sich einen Arbeitsbaum. Eine wechselt den Branch oder zieht `main` nach. Die andere committet - und ihr Commit sitzt plötzlich auf fremder Arbeit. Das ist in der Praxis zweimal passiert, einmal unbemerkt bis in den eröffneten Pull Request.

**Was der Hook tut.** Er verweigert `git commit`, wenn drei Bedingungen zusammen erfüllt sind:

1. Die **erste Zeile** des Befehls startet einen Commit. Nur die erste Zeile - sonst löst dasselbe Wort in einem Heredoc oder in der Commit-Nachricht einen Fehlalarm aus. Genau daran ist die erste Fassung gescheitert.
2. Das Ziel ist der **Haupt**-Arbeitsbaum. `git -C <pfad>` und ein führendes `cd <pfad> &&` werden aufgelöst - sonst würde der Hook exakt den Weg blockieren, den er empfiehlt.
3. Das Repo hat **mehr als einen Worktree** (`git worktree list`). Mit nur einem Worktree gibt es die Gefahr nicht, und der Hook ist still.

Blockiert er, erklärt die Meldung den Ausweg: eigener Worktree, `git -C <worktree> commit`.

**Abschalten.** `CLAUDE_ALLOW_SHARED_COMMIT=1 git commit ...` lässt den Commit bewusst durch. Der Hook ist ein Stolperdraht, keine Sicherheitsgrenze.

## Hook 2: Warnung bei liegengelassenen Dateien

`Stop`, Skript `scripts/warn-untracked-pile.sh`.

**Das Problem.** Sessions erzeugen Befunde, Notizen, Skripte - und committen sie nie, weil eine Regel vor jedem Push eine Rückfrage verlangt oder weil die Session einfach endet. In einem realen Repo lagen so 94 Markdown-Dateien und 20 Arbeitsordner unversioniert in der Wurzel, ohne dass es jemand bemerkte.

**Was der Hook tut.** Am Ende jeder Antwort zählt er `git status --porcelain`-Einträge mit `??`. Liegen mehr als 12 unversionierte Einträge herum, gibt er einen Hinweis mit fünf Beispielen aus. Er blockiert nichts. Bewusst gitignorierte Ordner (`node_modules`, `dist`) zählen nicht.

**Schwelle ändern.** `CLAUDE_UNTRACKED_LIMIT=30` hebt sie an, `CLAUDE_UNTRACKED_LIMIT=0` schaltet den Hook ab.

## Optional: macOS-Mitteilungen

`scripts/notify-macos.sh` schickt eine macOS-Mitteilung mit dem Projektnamen ("Claude: mein-projekt - Fertig"). Es ist **nicht** in `hooks/hooks.json` verdrahtet, weil es `terminal-notifier` voraussetzt (`brew install terminal-notifier`) und nur auf macOS läuft. Wer es will, ergänzt in der eigenen `~/.claude/settings.json`:

```json
{
  "hooks": {
    "Stop": [
      { "hooks": [ { "type": "command", "command": "~/.claude/plugins/cache/ai-edu/ai-edu-git-hygiene/0.1.0/scripts/notify-macos.sh 'Fertig'" } ] }
    ],
    "Notification": [
      { "hooks": [ { "type": "command", "command": "~/.claude/plugins/cache/ai-edu/ai-edu-git-hygiene/0.1.0/scripts/notify-macos.sh 'Wartet auf Eingabe'" } ] }
    ]
  }
}
```

Einfacher: das Skript nach `~/.claude/notify.sh` kopieren und von dort referenzieren - dann überlebt es Plugin-Updates.

## Hook gegen Regel

Eine Zeile in `CLAUDE.md` ist eine Bitte an das Modell. Ein Hook ist ein Schaltvorgang im Harness - er läuft, bevor das Modell entscheidet. Für alles, was mit "immer wenn X" oder "nie wieder Y" beginnt, ist ein Hook der richtige Ort. Die beiden Skripte hier sind dafür als Vorlage gedacht: kurz, mit Kopfkommentar, der erklärt, warum es sie gibt und woran die erste Fassung gescheitert ist.

## Selbst prüfen

```bash
# in einem Repo mit zwei Worktrees:
echo '{"tool_input":{"command":"git commit -m x"}}' | scripts/block-shared-commit.sh
# -> JSON mit "permissionDecision": "deny"

# in einem Repo mit 13 unversionierten Dateien:
scripts/warn-untracked-pile.sh
# -> JSON mit "systemMessage"
```

## Lizenz

MIT - siehe [LICENSE](../../LICENSE).

## Versionen

- **v0.1.0** (2026-08-23): block-shared-commit, warn-untracked-pile, notify-macos (optional)
