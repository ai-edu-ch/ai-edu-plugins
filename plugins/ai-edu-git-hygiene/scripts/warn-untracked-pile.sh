#!/bin/bash
# Stop-Hook: meldet, wenn eine Session unversionierte Dateien liegen laesst.
#
# Hintergrund: Verlangt eine Arbeitsregel vor jedem Push eine Rückfrage, committen
# Sessions oft gar nicht - in einem realen Repo lagen so 94 Markdown-Dateien und
# 20 Arbeitsordner untracked in der Wurzel, ohne dass es jemand bemerkte. Dieser
# Hook macht sichtbar, wenn eine Session Dateien liegen lässt.
#
# Blockiert nichts, gibt nur einen Hinweis aus. Schwelle per CLAUDE_UNTRACKED_LIMIT setzbar,
# ganz abschalten mit CLAUDE_UNTRACKED_LIMIT=0.

limit="${CLAUDE_UNTRACKED_LIMIT:-12}"
[ "$limit" = "0" ] && exit 0

git rev-parse --is-inside-work-tree >/dev/null 2>&1 || exit 0

# --porcelain respektiert .gitignore; bewusst ignorierte Ordner tauchen also nicht auf.
n=$(git status --porcelain --untracked-files=normal 2>/dev/null | grep -c '^??')
[ "$n" -le "$limit" ] && exit 0

beispiele=$(git status --porcelain --untracked-files=normal 2>/dev/null \
            | grep '^??' | sed 's/^?? //' | head -5 | tr '\n' ' ')

cat <<EOF
{"systemMessage": "$n unversionierte Einträge in $(basename "$(git rev-parse --show-toplevel)") (Schwelle $limit). Beispiele: $beispiele\\nWas behalten werden soll, gehört committet - was nicht, in die .gitignore mit einer Begründung daneben."}
EOF
exit 0
