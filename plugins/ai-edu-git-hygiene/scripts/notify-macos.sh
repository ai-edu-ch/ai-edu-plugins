#!/bin/bash
# macOS-Mitteilung mit dem Projektnamen. Braucht terminal-notifier (brew install terminal-notifier).
# Nicht in hooks.json verdrahtet - siehe README, Abschnitt "Optional: macOS-Mitteilungen".
input=$(cat)
project=$(basename "$(echo "$input" | jq -r '.cwd')")
case "$TERM_PROGRAM" in
  iTerm.app) app="com.googlecode.iterm2" ;;
  *) app="com.apple.Terminal" ;;
esac
terminal-notifier -title "Claude: $project" -message "$1" -activate "$app"
