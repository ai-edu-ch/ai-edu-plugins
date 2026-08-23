#!/bin/bash
# Stop-Hook: meldet, wenn eine Session unversionierte Dateien liegen lässt.
#
# Hintergrund: Verlangt eine Arbeitsregel vor jedem Push eine Rückfrage, committen
# Sessions oft gar nicht - in einem realen Repo lagen so 94 Markdown-Dateien und
# 20 Arbeitsordner untracked in der Wurzel, ohne dass es jemand bemerkte. Dieser
# Hook macht sichtbar, wenn eine Session Dateien liegen lässt.
#
# Blockiert nichts, gibt nur einen Hinweis aus. Schwelle per CLAUDE_UNTRACKED_LIMIT
# setzbar, ganz abschalten mit CLAUDE_UNTRACKED_LIMIT=0.

limit="${CLAUDE_UNTRACKED_LIMIT:-12}"
# Nicht-numerische Werte still ignorieren, statt bei jeder Antwort einen Shell-Fehler
# nach stderr zu schreiben.
case "$limit" in ''|*[!0-9]*) limit=12 ;; esac
[ "$limit" = "0" ] && exit 0

command -v jq >/dev/null 2>&1 || exit 0
git rev-parse --is-inside-work-tree >/dev/null 2>&1 || exit 0

# -z plus core.quotePath=false: Pfade kommen roh und NUL-getrennt, also auch mit
# Umlauten und Leerzeichen. Sonst liefert git "Pr\303\244sentation.md" mit
# Anführungszeichen und das erzeugte JSON wird ungültig.
# --porcelain respektiert .gitignore; bewusst ignorierte Ordner tauchen nicht auf.
eintraege=$(git -c core.quotePath=false status --porcelain --untracked-files=normal -z 2>/dev/null \
            | tr '\0' '\n' | grep '^?? ' | sed 's/^?? //')
[ -n "$eintraege" ] || exit 0

n=$(printf '%s\n' "$eintraege" | wc -l | tr -d ' ')
[ "$n" -le "$limit" ] && exit 0

beispiele=$(printf '%s\n' "$eintraege" | head -5 | tr '\n' ' ')
projekt=$(basename "$(git rev-parse --show-toplevel 2>/dev/null || echo Repo)")

jq -n --arg n "$n" --arg limit "$limit" --arg projekt "$projekt" --arg beispiele "$beispiele" '{
  systemMessage: ($n + " unversionierte Einträge in " + $projekt + " (Schwelle " + $limit + "). Beispiele: " + $beispiele + "\nWas behalten werden soll, gehört committet - was nicht, in die .gitignore mit einer Begründung daneben.")
}'
exit 0
