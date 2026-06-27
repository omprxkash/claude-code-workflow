# templates

Copy-paste assets for real projects. Every folder has its own README with usage instructions. Nothing here is synthetic — the CLAUDE.md files, agent definitions, and skills came from working projects.

| Folder / File | What's inside |
|---|---|
| [`CLAUDE.md`](CLAUDE.md) | Generic project brain — fill in the blanks and drop it in any project root |
| [`claude-md/`](claude-md/) | Four real CLAUDE.md variants for different project types |
| [`agents/`](agents/) | Four working subagent definitions ready to drop into `.claude/agents/` |
| [`wat-starter/`](wat-starter/) | Full WAT project skeleton — CLAUDE.md, `workflows/`, `tools/`, `.env.example` |
| [`commands/`](commands/) | Slash command `.md` files — human, steel-man, godmode, content |
| [`skills/`](skills/) | Example skill folder showing the SKILL.md structure |
| [`hooks/`](hooks/) | Hook script + `settings.json` snippet showing how to wire it up |
| [`mcp/`](mcp/) | MCP setup snippets for GitHub, Firecrawl, and Context7 (no real keys) |

## How to use these

Pick the folder that matches what you're building. Read its README. Copy the files you need into your project. Adjust names, paths, and instructions to fit your setup. Keep credentials out of everything you commit.
