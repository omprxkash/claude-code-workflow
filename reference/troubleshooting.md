# Troubleshooting

Quick answers for the problems that come up most. Not read in order — search for
your symptom.

## Skill not triggering

1. **Check the description.** It's the only thing Claude reads to decide whether to
   invoke a skill — vague descriptions ("helps with images") undertrigger. Rewrite
   as "Use when someone asks to X, Y, or Z" with real trigger phrases. See
   [skills](../docs/02-customization/skills.md).
2. **Verify it's visible at all.** Ask "what skills are available?" If it's not
   listed, check `disable-model-invocation` isn't set to `true` in its frontmatter.
3. **Confirm direct invocation works.** Run `/skill-name` explicitly. If that fails
   too, the problem is the skill file, not the trigger phrasing.
4. **Check the character budget.** If you have many skills installed, descriptions
   compete for a shared budget (~2% of context, 16,000 char fallback). Run
   `/context` to see if yours is being excluded. See
   [settings reference](../docs/02-customization/settings-reference.md) for the
   override env var.

## Context full / responses degrading

That's [context rot](../docs/01-core-concepts/context-management.md). Fixes, in
order of how often you'll need them:
- `/compact` before starting a big new phase
- `/clear` when switching to an unrelated task
- Push broad searches/research to [subagents](../docs/02-customization/subagents.md)
  so the noise stays out of your main session

## MCP server not connecting

1. Check the server is actually listed: it should appear in `.mcp.json`
   (project-level) or via `claude mcp list`.
2. If it needs an API key, confirm it's in `.env` and the MCP config references the
   variable name correctly — never hardcode the key inline.
3. Restart the session. MCP servers are loaded at startup; a config change made
   mid-session won't take effect until you relaunch.
4. See [MCP setup](../docs/03-mcp/setup-servers.md) for server-specific install
   steps (GitHub, Firecrawl, Context7, trigger.dev).

## Permission prompts on every single command

You're in a stricter [permission mode](../docs/01-core-concepts/permission-modes.md)
than you need for the task. Either switch modes (Shift-Tab cycles them) for this
session, or add the specific commands you keep approving to
`permissions.allow` in [`settings.json`](../docs/02-customization/settings-reference.md)
so you stop being asked for the same thing every time.

## Agent/subagent returns nothing useful

If it's a skill with `context: fork`, or an agent spawned from one, and it comes
back empty: it probably received guidelines with no concrete task. Subagents need
an actionable instruction ("do X, then return Y"), not just reference material —
they have no back-and-forth to clarify. See
[subagents](../docs/02-customization/subagents.md).

## Arguments not substituting in a skill or command

Check that `$ARGUMENTS`, `$0`/`$1`, or `$ARGUMENTS[N]` actually appears somewhere in
the file content. If none of those placeholders are present, Claude Code appends
the arguments as plain text at the end instead of substituting them — which usually
isn't what you wanted. See
[skills](../docs/02-customization/skills.md).

## Manually-added agent or skill file isn't picked up

Session restart required — Claude Code discovers `.claude/agents/` and
`.claude/skills/` at launch, not continuously. Restart, or run `/agents` to
force a rescan for agents.

## Headless/CI run hangs or fails silently

No human is present to answer a permission prompt in headless mode — anything not
pre-approved just blocks or fails instead of prompting. Add the exact tools/commands
the run needs to `--allowedTools`, or set `--permission-mode acceptEdits`. See
[headless mode](../docs/04-advanced/headless-and-sdk.md).

## Hitting usage limits constantly

Check whether it's actually a plan-tier issue or a context-management issue first —
long, bloated sessions and heavy parallel subagent fan-out burn budget fast
regardless of tier. See [plans & usage](../docs/01-core-concepts/plans-and-usage.md).

## Next

- [Glossary](glossary.md) — if a term above is unfamiliar
- [Command cheatsheet](commands-cheatsheet.md) — every slash command in one table
