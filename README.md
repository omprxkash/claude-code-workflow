# Claude Code Workflow

A practical handbook for getting real work done with Claude Code. Built from working projects — the docs explain the concepts, the templates are actual files you can drop into your own setup.

Not a summarized overview. Not a pitch. Just the stuff you need to actually use it.

---

## What's in here

```
docs/          the course — start here if you're new, jump around if you're not
templates/     working assets: CLAUDE.md files, agents, skills, MCP configs, WAT starter
reference/     fast lookups: command cheatsheet, 26-skill catalog, glossary, links
MUST_LISTEN.md curated videos and resources — the ones actually worth your time
```

---

## If you're new, read these four first

| Step | Page | What you'll get |
|---|---|---|
| 1 | [Why Claude Code](docs/00-getting-started/why-claude-code.md) | What it actually is and why it's different |
| 2 | [Install & setup](docs/00-getting-started/install-and-setup.md) | Plans, install command, login |
| 3 | [Where to run it](docs/00-getting-started/where-to-run.md) | Terminal, desktop app, VS Code, Antigravity, web — how to pick |
| 4 | [Your first project](docs/00-getting-started/first-project.md) | Plan mode, permission modes, building something real |

---

## Learning path

**Foundations**

- [What CLAUDE.md is](docs/01-core-concepts/claude-md.md) — the project brain, loaded at the top of every session
- [Context management](docs/01-core-concepts/context-management.md) — the context window, compaction, context rot
- [Permission modes](docs/01-core-concepts/permission-modes.md) — plan / ask / auto-edit / bypass
- [Tokens & cost](docs/01-core-concepts/tokens-and-cost.md) — what tokens are, how to manage usage

**Make it yours**

- [Slash commands](docs/02-customization/slash-commands.md) — built-ins and how to write custom ones
- [Skills](docs/02-customization/skills.md) — reusable capability bundles Claude activates on demand
- [Hooks](docs/02-customization/hooks.md) — scripts that run before/after tool calls
- [Subagents](docs/02-customization/subagents.md) — delegate work to isolated workers with scoped tools
- [Agent teams](docs/02-customization/agent-teams.md) — running agents in formation
- [Status line](docs/02-customization/statusline.md) — custom terminal status

**Connect the world (MCP)**

- [MCP overview](docs/03-mcp/mcp-overview.md) — what MCP is and how it works
- [Setting up servers](docs/03-mcp/setup-servers.md) — GitHub, Firecrawl, Context7, trigger.dev
- [MCP token cost](docs/03-mcp/token-usage-mcp.md) — evaluating what each server costs

**Advanced**

- [Git worktrees](docs/04-advanced/worktrees.md) — parallel Claude Code sessions on the same repo
- [Parallelization](docs/04-advanced/parallelization.md) — fan-out tasks across multiple agents
- [Plugins & marketplaces](docs/04-advanced/plugins.md) — finding and installing community skills

**Ship it**

- [Deployment](docs/05-deployment/deploy.md) — Modal, trigger.dev, Vercel, GitHub Actions; self-healing vs deterministic

**Workflows & recipes**

- [The WAT framework](docs/06-workflows/wat-framework.md) — Workflows / Agent / Tools — the architecture that makes automation reusable
- [Designing with Claude Code](docs/06-workflows/design-workflow.md) — screenshot-compare loop, spec-driven design
- [Recipe: newsletter automation](docs/06-workflows/recipe-newsletter-automation.md) — a complete build, end to end
- [More recipe ideas](docs/06-workflows/recipes.md)

---

## Templates

Working files you can copy straight into a project. Each folder has its own README.

| Folder | What's inside |
|---|---|
| [`templates/CLAUDE.md`](templates/CLAUDE.md) | Generic project brain — adapt and drop into any project root |
| [`templates/claude-md/`](templates/claude-md/) | Four real CLAUDE.md variants: skills system, website design, executive assistant, WAT workflow |
| [`templates/agents/`](templates/agents/) | Four real subagent definitions: code-reviewer, research, qa, email-classifier |
| [`templates/wat-starter/`](templates/wat-starter/) | Ready WAT skeleton — CLAUDE.md, `workflows/`, `tools/`, `.env.example` |
| [`templates/commands/`](templates/commands/) | Slash command `.md` files: human, steel-man, godmode, content |
| [`templates/skills/`](templates/skills/) | Example skill folder showing the SKILL.md structure |
| [`templates/hooks/`](templates/hooks/) | Hook script + settings.json snippet |
| [`templates/mcp/`](templates/mcp/) | MCP setup snippets for GitHub, Firecrawl, Context7 |

---

## Quick reference

- [Command cheatsheet](reference/commands-cheatsheet.md) — every slash command in one table
- [Skills catalog](reference/skills-catalog.md) — all 26 skills with descriptions and required env vars
- [Resources & links](reference/resources.md) — every link grouped by topic
- [Glossary](reference/glossary.md) — terms defined plainly
- [Must-watch / must-read](MUST_LISTEN.md) — the resources worth your time

---

## Secrets

No real API keys or tokens anywhere in this repo. Every credential is a placeholder like `<YOUR_TOKEN>`. Keep your own keys in a local `.env` — it's in [`.gitignore`](.gitignore) already.
