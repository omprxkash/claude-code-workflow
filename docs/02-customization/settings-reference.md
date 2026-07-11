# settings.json reference

`templates/hooks/settings.snippet.json` shows a hook example, but the settings file
itself does a lot more than hooks. This page covers the file, not just one field of it.

## Where it lives

| Location | Scope | Priority |
|---|---|---|
| `.claude/settings.json` | This project, shared via git | Checked in, team-wide |
| `.claude/settings.local.json` | This project, just you | Gitignored — personal overrides |
| `~/.claude/settings.json` | Every project | Personal, global defaults |
| Managed/enterprise policy | Org-wide | Highest priority, admin-controlled |

Project settings override personal global settings; managed policy overrides
everything. Put team conventions in `.claude/settings.json` (commit it) and your
personal tweaks in `.claude/settings.local.json` (don't).

## Permissions

The most commonly edited section — controls what runs without a prompt.

```json
{
  "permissions": {
    "allow": [
      "Bash(git status)",
      "Bash(git diff)",
      "Bash(npm test)",
      "Read"
    ],
    "deny": [
      "Bash(rm -rf *)",
      "WebFetch"
    ]
  }
}
```

Same glob syntax as skill `allowed-tools` (see
[skills](skills.md)): `Bash(git *)` matches any git subcommand, `Bash(npm test)`
matches only that exact command, a bare tool name like `Read` is unrestricted.
`deny` always wins over `allow`.

## Hooks

Lifecycle scripts that run around tool calls, project-wide (not scoped to one
skill or agent — see [hooks](hooks.md) for the concept, this is where they're wired):

```json
{
  "hooks": {
    "PreToolUse": [
      { "matcher": "Bash", "hooks": [{ "type": "command", "command": "./scripts/validate-command.sh" }] }
    ],
    "PostToolUse": [
      { "matcher": "Edit|Write", "hooks": [{ "type": "command", "command": "./scripts/run-linter.sh" }] }
    ]
  }
}
```

Exit code `0` allows the action, `2` blocks it. The hook script receives the tool
call as JSON on stdin.

## Environment variables

```json
{
  "env": {
    "SLASH_COMMAND_TOOL_CHAR_BUDGET": "20000"
  }
}
```

Useful when you have enough skills/commands that their descriptions start getting
excluded from context (see [skills](skills.md) — descriptions share a fixed
character budget, override it here if you're hitting it legitimately rather than
by having too many vague skills).

## Model

```json
{
  "model": "sonnet"
}
```

Pins the default model for this project. Overridable per-agent (see
[subagents](subagents.md)) and per-skill.

## MCP servers

Project-level MCP servers usually live in `.mcp.json`, not `settings.json` — see
[MCP setup](../03-mcp/setup-servers.md). `settings.json` is where you *reference*
an already-configured server by name inside an agent or hook, not where you
originally define one.

## Common edits, in order of how often you'll actually make them

1. Add a command to `permissions.allow` because you're tired of approving it
2. Add a command to `permissions.deny` because you never want it to run silently
3. Add a hook for auto-formatting or linting after edits
4. Pin `model` for a project that should default to something other than your
   global default

## Next

- [Hooks](hooks.md) — the concept this file's `hooks` block configures
- [Permission modes](../01-core-concepts/permission-modes.md) — the interactive-side
  counterpart to the `permissions` block
