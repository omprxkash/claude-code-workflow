# Glossary

Quick definitions for the terms used across this handbook. Linked to the page that
covers each in depth.

- **Agent** — the Claude Code worker that reads instructions, runs tools, and acts.
  In [WAT](../docs/06-workflows/wat-framework.md), the "A".
- **Agent team** — multiple agents coordinated on a shared goal.
  ([page](../docs/02-customization/agent-teams.md))
- **CLAUDE.md** — the project's instruction file, injected at the start of every
  session; the "project brain."
  ([page](../docs/01-core-concepts/claude-md.md))
- **CLI** — command-line interface; driving a tool by typing text (the terminal).
- **Compaction** — Claude rewriting conversation history at higher density to stay
  inside the context window. ([page](../docs/01-core-concepts/context-management.md))
- **Context window** — the total conversation history the model can see at once,
  shown as a 0–100% gauge. ([page](../docs/01-core-concepts/context-management.md))
- **Context rot** — degraded answers when a session fills with stale/irrelevant
  history. ([page](../docs/01-core-concepts/context-management.md))
- **GUI** — graphical user interface; buttons and panels (desktop app, IDE) vs. a CLI.
- **Hook** — a script the harness runs automatically before/after a tool call.
  ([page](../docs/02-customization/hooks.md))
- **IDE** — integrated development environment; a file explorer + editor + AI panel
  (VS Code, Antigravity). ([page](../docs/00-getting-started/where-to-run.md))
- **MCP** — Model Context Protocol; the standard for connecting the agent to external
  servers/tools. ([page](../docs/03-mcp/mcp-overview.md))
- **Permission mode** — how much Claude asks before acting (plan / ask / auto-edit /
  bypass). ([page](../docs/01-core-concepts/permission-modes.md))
- **Plan mode** — read-only mode where Claude proposes a plan before any edits.
  ([page](../docs/00-getting-started/first-project.md))
- **Plugin** — an installable bundle of commands/skills/agents/config from a
  marketplace. ([page](../docs/04-advanced/plugins.md))
- **Self-healing** — the agent fixing its own errors mid-build; lost once a workflow
  is deployed as static code. ([page](../docs/00-getting-started/why-claude-code.md))
- **Skill** — a capability (a system prompt + files) Claude loads when relevant.
  ([page](../docs/02-customization/skills.md))
- **Slash command** — a `/name` shortcut; built-in or a saved custom prompt.
  ([page](../docs/02-customization/slash-commands.md))
- **Subagent** — a separate Claude worker with its own context, used to delegate and
  protect the main context. ([page](../docs/02-customization/subagents.md))
- **Token** — a chunk of text (roughly "a word") used to measure context and cost.
  ([page](../docs/01-core-concepts/tokens-and-cost.md))
- **Tool** — a single capability a workflow calls (research, send email, etc.). In
  [WAT](../docs/06-workflows/wat-framework.md), the "T".
- **WAT** — Workflows / Agent / Tools; the framework for building reliable workflows.
  ([page](../docs/06-workflows/wat-framework.md))
- **Workflow** — a natural-language, step-by-step process file. In WAT, the "W".
- **Worktree** — a git feature giving each branch its own folder; enables parallel
  sessions. ([page](../docs/04-advanced/worktrees.md))
