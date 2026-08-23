#!/usr/bin/env bash
# PreToolUse/Bash: blockiert einen Commit im geteilten Haupt-Arbeitsbaum.
#
# Hintergrund: mehrere Claude-Code-Sessions arbeiten gleichzeitig im selben
# Arbeitsbaum. Wechselt eine davon den Branch, landet der eigene Commit auf fremder
# Arbeit - in der Praxis zweimal passiert, einmal unbemerkt bis in den eröffneten PR.
#
# Blockiert nur, wenn ALLE drei zutreffen:
#   1. Der Befehl startet in seiner ERSTEN ZEILE einen Commit. Nur dort, damit der
#      Text in Heredocs, Skriptrumpf oder Commit-Message keinen Fehlalarm auslöst -
#      genau daran ist die erste Fassung dieses Hooks gescheitert.
#   2. Das Zielverzeichnis ist der HAUPT-Arbeitsbaum. `git -C <pfad>` und ein
#      führendes `cd <pfad> &&` werden aufgelöst, sonst blockiert der Hook genau
#      den Weg, den er empfiehlt.
#   3. Das Repo hat mehr als einen Worktree - nur dann existiert die Gefahr.
#
# Ausnahme: CLAUDE_ALLOW_SHARED_COMMIT=1
#
# Bewusst kein Sicherheitsmechanismus, sondern ein Stolperdraht. Wer will, umgeht ihn.

set -uo pipefail

erlauben() { exit 0; }

payload=$(cat 2>/dev/null) || erlauben
cmd=$(printf '%s' "$payload" | jq -r '.tool_input.command // empty' 2>/dev/null) || erlauben
[ -n "$cmd" ] || erlauben

# Nur die erste Zeile betrachten.
kopf=$(printf '%s' "$cmd" | head -1)

# An einer Befehlsposition: Zeilenanfang oder direkt nach && || ; |
printf '%s' "$kopf" \
  | grep -Eq '(^|[;&|][[:space:]]*)[[:space:]]*git([[:space:]]+-[^[:space:]]+([[:space:]]+[^[:space:]]+)?)*[[:space:]]+commit([[:space:]]|$)' \
  || erlauben

[ "${CLAUDE_ALLOW_SHARED_COMMIT:-}" = "1" ] && erlauben
command -v git >/dev/null 2>&1 || erlauben

# Zielverzeichnis aufloesen: `git -C <pfad>` schlägt ein führendes `cd <pfad>`.
ziel=$(printf '%s' "$kopf" | sed -n 's/.*git[[:space:]][[:space:]]*-C[[:space:]][[:space:]]*\([^[:space:];&|]*\).*/\1/p' | tail -1)
[ -n "$ziel" ] || ziel=$(printf '%s' "$kopf" | sed -n 's/^[[:space:]]*cd[[:space:]][[:space:]]*\([^[:space:];&|]*\).*/\1/p' | head -1)
if [ -n "$ziel" ]; then
  ziel=${ziel%\"}; ziel=${ziel#\"}; ziel=${ziel%\'}; ziel=${ziel#\'}
  case "$ziel" in "~"*) ziel="$HOME${ziel#\~}" ;; esac
  [ -d "$ziel" ] && cd "$ziel" 2>/dev/null
fi

git rev-parse --is-inside-work-tree >/dev/null 2>&1 || erlauben

# --path-format=absolute ist nötig: aus einem Unterverzeichnis liefert
# --git-common-dir sonst einen relativen Pfad (../.git) und der Vergleich schlägt
# fälschlich fehl - dann käme `cd src && ...` durch.
gitdir=$(git rev-parse --path-format=absolute --git-dir 2>/dev/null) || erlauben
commondir=$(git rev-parse --path-format=absolute --git-common-dir 2>/dev/null) || erlauben
[ "$gitdir" = "$commondir" ] || erlauben          # verknuepfter Worktree: durchlassen

anzahl=$(git worktree list 2>/dev/null | wc -l | tr -d ' ')
case "$anzahl" in ''|*[!0-9]*) erlauben ;; esac
[ "$anzahl" -gt 1 ] || erlauben                   # nur ein Worktree: keine Gefahr

wurzel=$(git rev-parse --show-toplevel 2>/dev/null || printf '<repo>')

grund="Commit im geteilten Haupt-Arbeitsbaum blockiert.

Dieses Repo hat $anzahl Worktrees. Eine parallele Session kann HEAD bewegen, bevor
der Commit landet - dann sitzt er auf fremder Arbeit und wandert in den eigenen PR.

Stattdessen einen eigenen Worktree nehmen:
  git fetch origin
  git worktree add -b <mein/branch> <scratch>/wt origin/main
  ln -sfn $wurzel/node_modules <scratch>/wt/node_modules
  git -C <scratch>/wt add ... && git -C <scratch>/wt commit ...
  git worktree remove <scratch>/wt

Der Hook lässt \`git -C <worktree>\` und \`cd <worktree> && ...\` durch.
Bewusst trotzdem hier: CLAUDE_ALLOW_SHARED_COMMIT=1 voranstellen."

jq -n --arg grund "$grund" '{
  hookSpecificOutput: {
    hookEventName: "PreToolUse",
    permissionDecision: "deny",
    permissionDecisionReason: $grund
  }
}'
