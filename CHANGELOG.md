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

## 0.3.0 - 2026-04-22

- `ai-edu-starter` 0.3.0: Council-Skill als "Advanced" ergänzt. Nachtrag 30.04.2026: Marketplace-URL und Skill-Zählung korrigiert.

## 0.2.0 - 2026-04-22

- Initial: Marketplace `ai-edu` mit `ai-edu-starter` 0.2.0 (18 Skills, Subagent `kundenkorrespondenz`, CLAUDE.md-Template).
