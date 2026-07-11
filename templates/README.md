# templates

Drop-in assets for real projects. Each folder has its own README. Nothing here is synthetic — the CLAUDE.md files, agent definitions, and hooks came from working projects.

| Folder | What's inside |
|---|---|
| [`claude-md/`](claude-md/) | Three CLAUDE.md variants — generic, AIOS, and Trigger.dev; copy one into your project root |
| [`agents/`](agents/) | Six subagent definitions — code-reviewer, research, qa, email-classifier, frontend-developer, cli-ui-designer |
| [`system-prompts/`](system-prompts/) | Real production CLAUDE.md files and build prompts — WAT, website design, EA setup, skills-system, trigger.dev |
| [`wat-starter/`](wat-starter/) | Full WAT project skeleton — CLAUDE.md, `workflows/`, `tools/`, `.env.example` |
| [`commands/`](commands/) | Slash command `.md` files — human, steel-man, godmode, content |
| [`hooks/`](hooks/) | Hook script + `settings.json` snippet showing how to wire it up |
| [`mcp/`](mcp/) | MCP setup snippets for GitHub, Firecrawl, and Context7 (no real keys) |

## How to use these

Pick the folder that matches what you're building. Read its README. Copy the files you need into your project. Adjust names, paths, and instructions to fit your setup. Keep credentials out of everything you commit.
