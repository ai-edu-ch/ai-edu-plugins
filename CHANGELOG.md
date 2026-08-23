# Changelog

Marketplace-Version in `.claude-plugin/marketplace.json`, Plugin-Versionen in den jeweiligen `plugin.json`.

## 0.5.0 - 2026-08-23

Drei neue Plugins, ein Update, ein Rückbau.

- **Neu: `ai-edu-mail-agents` 0.1.0** - vier Subagents für Outlook-/Gmail-CSV-Exports (`mail-triage`, `mail-antwort-entwurf`, `mail-wochenrecap`, `mail-vip-radar`), je eine Doku pro Agent und ein synthetischer Beispiel-Datensatz (Persona "Anna Beispiel"). Aus PR #1 (offen seit 08.05.2026), vor dem Merge bereinigt: echte Umlaute statt Transliteration, toter Verweis auf einen nicht existierenden Agent entfernt, Beispiel-Output ohne Autor-Daten, defekte Absender im Beispiel-CSV repariert.
- **Neu: `ai-edu-git-hygiene` 0.1.0** - Hooks `block-shared-commit` (PreToolUse) und `warn-untracked-pile` (Stop), beide aus echten Vorfällen mit parallelen Sessions; optionales macOS-Mitteilungs-Skript.
- **Neu: `ai-edu-mcp-basis` 0.1.0** - `.mcp.json` mit context7, chrome-devtools und playwright (alle ohne Konto und Key), README zu den vier MCP-Anschlusswegen und zur Werkzeugwahl.
- **`ai-edu-starter` 0.3.0 -> 0.4.0** - neuer Subagent `linkedin-research` (read-only via Claude in Chrome, nie Outreach). **Council-Skill entfernt:** der verlinkte MCP-Server `retolutz/llm-council` hat keine Lizenz, seine Modellgeneration ist veraltet, und intern wird er seit Juli 2026 nicht mehr eingesetzt - ein MIT-Marketplace soll nicht auf ungelizenzierten Code verweisen. Die Zweitmeinung übernimmt der in Claude Code eingebaute Advisor. 18 Skills, 2 Subagents.
- Wurzel-README: Plugin-Tabelle, Abschnitt "Empfohlene Fremd-Werkzeuge" (humanizer, claude-seo, impeccable - nur verlinkt, nicht kopiert), Beitragsregel "keine Kopien fremder Skills".
- `marketplace.json`: `category`, `homepage` und `owner.url` je Eintrag.

Nach einem adversarialen Review vor dem Merge zusätzlich korrigiert:

- **Beispiel-Korpus**: die Deklaration "alle Namen frei erfunden" war falsch - der Datensatz nannte real existierende Organisationen, eine davon mit erfundener Honorar-Vereinbarung. Hochschule, IT-Verbund und Zeitung sind jetzt erfunden; die Behörden-Domains bleiben (Lernwert des Behörden-Radars) und sind vollständig deklariert. Zählungen im README korrigiert (VIP-Match 111 statt "ca. 35", 5 Out-of-Office statt 4, Bucket-Summe).
- **Datenschutz-Aussage**: "vollständig lokal, kein Cloud-Roundtrip" und die FAQ-Antwort "Nein" waren irreführend - Mail-Inhalte gehen als Prompt an die Anthropic-API wie jede andere Datei. Beide Stellen sagen das jetzt, mit dem Ausweg "Export ohne Body-Spalte".
- **Hooks**: `warn-untracked-pile` erzeugte bei Dateinamen mit Umlauten ungültiges JSON (jetzt `jq`) und schrieb bei nicht-numerischem Limit einen Shell-Fehler; `block-shared-commit` blockierte dauerhaft nach einem verwaisten Worktree-Eintrag, liess `FOO=bar git commit` durch, erkannte `git -c key="a b" commit` nicht und schlug bei `echo "a; git commit b"` falsch an. 20 Testfälle grün.
- **`linkedin-research`** hat jetzt eine `tools`-Allowlist statt geerbtem Vollzugriff - die Read-only-Zusage ist damit konfigurativ gedeckt, nicht nur im Text behauptet.
- **`ai-edu-mcp-basis`**: Werkzeugnamen aus einem Plugin tragen ein Präfix (`mcp__plugin_ai-edu-mcp-basis_context7__*`), das README nannte die kurzen Namen; "headless" war falsch (beide Browser-Server öffnen ein sichtbares Fenster); Versionen für Pinning ergänzt.
- Tabellen ohne Trennzeile in den Output-Vorlagen, Grammatik- und Umlautfehler, Datumsangaben zwischen CHANGELOG und Plugin-README angeglichen.

## 0.3.0 - 2026-04-23

- `ai-edu-starter` 0.3.0: Council-Skill als "Advanced" ergänzt. Nachtrag 30.04.2026: Marketplace-URL und Skill-Zählung korrigiert.

## 0.2.0 - 2026-04-23

- Initial: Marketplace `ai-edu` mit `ai-edu-starter` 0.2.0 (Repo-Commit 22.04.2026) (18 Skills, Subagent `kundenkorrespondenz`, CLAUDE.md-Template).
