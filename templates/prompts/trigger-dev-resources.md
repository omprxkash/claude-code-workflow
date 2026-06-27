# Trigger.dev — Resources & Setup

References for using trigger.dev with Claude Code.

## Links

| Resource | URL |
|---|---|
| Community guide (Skool) | https://www.skool.com/ai-automation-society/classroom/076a1c6e?md=ffb758ec441645258cf07c1b45920edc |
| Claude Code official docs | https://code.claude.com/docs |
| WAT framework video | https://www.youtube.com/watch?v=mpALXah_PBg |
| Project tracking sheet | https://docs.google.com/spreadsheets/d/1jNE9VgtzA9I4ar1bXSBZk_OmDHd93qcj7WuTjAj5Zgc/edit?gid=1806040212 |

## MCP Setup

Add trigger.dev as an MCP server in your project's `.mcp.json`:

```json
{
  "mcpServers": {
    "trigger": {
      "command": "npx",
      "args": ["trigger.dev@4.4.0", "mcp"]
    }
  }
}
```

Or via CLI:

```bash
claude mcp add-json trigger '{"command": "npx", "args": ["trigger.dev@4.4.0", "mcp"]}' --scope project
```

## Project Folder (`D:\AI\Automation`)

Files in the local Trigger.dev project:

- `CLAUDE.md` — project brain
- `trigger-ref.md` — Trigger.dev API reference notes
- `.mcp.json` — MCP server config (trigger.dev)
- `.env` — credentials (gitignored)

## Local Project Folders (Full Reference)

| Project | Path |
|---|---|
| Skills system (26 skills, 4 subagents) | `D:\Work\Claude\All Of My Claude Skills\` |
| Website design | `D:\Work\Claude\Website Design General\` |
| WAT workflow | `D:\AI\Workflow\` |
| Executive assistant | `D:\AI\EA\` |
| Automation / Trigger.dev | `D:\AI\Automation\` |
