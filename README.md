# Claude Code Workflow

A practical, open-source resource for getting real work done with Claude Code. Built from working projects — not a pitch, not a summary. The docs explain how things work; the skills, templates, and prompts are files you can drop straight into your own setup.

---

## What's in here

```
docs/        the course — start here if you're new, jump around if you're not
skills/      36 installable Claude Code skills — general tools + business automation
templates/   drop-in assets: CLAUDE.md variants, agent definitions, hooks, MCP configs
reference/   fast lookups: command cheatsheet, skills catalog, glossary, troubleshooting
MUST_LISTEN.md  curated videos — the ones actually worth your time
```

---

## Grab something immediately

### Skills — copy a folder into `.claude/skills/`, done

**General skills** (work anywhere, no API keys needed):

| Skill | What it does |
|---|---|
| [`skills/grill-me/`](skills/grill-me/) | Structured interview that extracts knowledge and saves context files |
| [`skills/session-handoff/`](skills/session-handoff/) | Pre-`/clear` snapshot — next session picks up exactly where this left off |
| [`skills/skill-builder/`](skills/skill-builder/) | Builds and audits other skills following official best practices |
| [`skills/agent-builder/`](skills/agent-builder/) | Builds and audits sub-agent definitions |
| [`skills/excalidraw-diagram/`](skills/excalidraw-diagram/) | Generates editable Excalidraw diagrams |
| [`skills/frontend-design/`](skills/frontend-design/) | Distinctive, production-grade frontend code |
| [`skills/video-to-website/`](skills/video-to-website/) | Turns a video into a scroll-driven animated website |

**Automation skills** (lead gen, cold email, Gmail, YouTube, research, and more):
→ [`skills/automation/`](skills/automation/) — 27 skills, grouped by category

**Image generation** (need a `kie.ai` API key — cost per image, see each skill's setup):
[`skills/excalidraw-visuals/`](skills/excalidraw-visuals/) (hand-drawn-style PNGs) and
[`skills/nano-banana-images/`](skills/nano-banana-images/) (hyper-realistic photos).
Full catalog with descriptions and costs: [`skills/README.md`](skills/README.md).

### Templates — copy a file, adapt it, use it

| What you need | Where |
|---|---|
| A generic project CLAUDE.md | [`templates/claude-md/generic.md`](templates/claude-md/generic.md) |
| AIOS / second-brain CLAUDE.md | [`templates/claude-md/aios.md`](templates/claude-md/aios.md) |
| Trigger.dev project CLAUDE.md | [`templates/claude-md/trigger-dev.md`](templates/claude-md/trigger-dev.md) |
| Sub-agent definitions (code reviewer, researcher, QA, etc.) | [`templates/agents/`](templates/agents/) |
| WAT project skeleton | [`templates/wat-starter/`](templates/wat-starter/) |
| Full build prompts (GMaps pipeline, Upwork scraper, etc.) | [`templates/system-prompts/`](templates/system-prompts/) |

---

## If you're new, read these four first

| Step | Page | What you'll get |
|---|---|---|
| 1 | [Why Claude Code](docs/00-getting-started/why-claude-code.md) | What it actually is and why it's different |
| 2 | [Install & setup](docs/00-getting-started/install-and-setup.md) | Plans, install command, login |
| 3 | [Where to run it](docs/00-getting-started/where-to-run.md) | Terminal, desktop app, VS Code, Antigravity, web |
| 4 | [Your first project](docs/00-getting-started/first-project.md) | Plan mode, permission modes, building something real |

Not ready to pay? → [Running Claude Code for free](docs/00-getting-started/free-access.md) — 18 alternative providers via a local proxy.

---

## Full learning path

**Foundations**

- [What CLAUDE.md is](docs/01-core-concepts/claude-md.md)
- [Context management](docs/01-core-concepts/context-management.md) — context window, compaction, the 18 token hacks
- [Permission modes](docs/01-core-concepts/permission-modes.md) — plan / ask / auto-edit / bypass
- [Tokens & cost](docs/01-core-concepts/tokens-and-cost.md)
- [Plans & usage](docs/01-core-concepts/plans-and-usage.md) — Pro vs Max vs Team, model access
- [Session management](docs/01-core-concepts/session-management.md) — `--continue`, `--resume`, `/rewind`

**Make it yours**

- [Slash commands](docs/02-customization/slash-commands.md)
- [Skills](docs/02-customization/skills.md) — how skills work, progressive loading, building your own
- [Hooks](docs/02-customization/hooks.md)
- [Subagents](docs/02-customization/subagents.md)
- [Agent teams](docs/02-customization/agent-teams.md) — enable flag, cost reality, when to use
- [Persistent memory](docs/02-customization/memory.md) — `#` shortcut, auto-memory, scopes
- [Rules files](docs/02-customization/rules.md) — `.claude/rules/`, splitting out of CLAUDE.md
- [Status line](docs/02-customization/statusline.md)
- [Settings reference](docs/02-customization/settings-reference.md)

**Connect the world (MCP)**

- [MCP overview](docs/03-mcp/mcp-overview.md)
- [Setting up servers](docs/03-mcp/setup-servers.md)
- [MCP token cost](docs/03-mcp/token-usage-mcp.md) — what each server actually costs

**Advanced**

- [Git worktrees](docs/04-advanced/worktrees.md) — parallel sessions without file conflicts
- [Parallelization](docs/04-advanced/parallelization.md) — sub-agent fan-out, failure math, cost calibration
- [Multi-agent patterns](docs/04-advanced/multi-agent-patterns.md) — assembly line, consensus, debate, verification
- [agent-browser](docs/04-advanced/agent-browser.md) — browser automation CLI built for AI agents; deterministic element refs
- [Understand Anything](docs/04-advanced/understand-anything.md) — turn any codebase into a knowledge graph before building
- [LLM wiki](docs/04-advanced/llm-wiki.md) — build a second brain: cross-linked Obsidian wiki ingested from transcripts, PDFs, URLs
- [The 5 levels of a second brain](docs/04-advanced/second-brain-levels.md) — from exact-word CLAUDE.md routing to a fully autonomous knowledge graph
- [Plugins & marketplaces](docs/04-advanced/plugins.md)
- [Headless mode & Agent SDK](docs/04-advanced/headless-and-sdk.md)
- [GitHub Actions](docs/04-advanced/github-actions.md)

**Ship it**

- [Deployment](docs/05-deployment/deploy.md) — Modal, Trigger.dev, Vercel, GitHub Actions
- [Routines & scheduling](docs/05-deployment/routines.md) — scheduled tasks vs `/loop`, memory architecture

**Workflows & recipes**

- [The WAT framework](docs/06-workflows/wat-framework.md)
- [Design workflow](docs/06-workflows/design-workflow.md) — screenshot loop, spec-driven design
- [Design quality](docs/06-workflows/design-quality.md) — impeccable + taste-skill; stop generic output at the hook level
- [Vibe coding guide](docs/06-workflows/vibe-coding-guide.md) — monolith first, lock the backbone, rules file
- [Multi-model vibe coding](docs/06-workflows/multi-model-vibe-coding.md)
- [Google Workspace CLI](docs/06-workflows/google-workspace-cli.md) — Docs, Gmail, Drive without MCP overhead
- [Video editing](docs/06-workflows/video-editing.md)
- [Recipes](docs/06-workflows/recipes.md) — social repurposing, multimodal RAG, executive assistant

**Business**

- [Selling AI solutions](docs/07-business/selling-ai-solutions.md)
- [Finding clients](docs/07-business/finding-clients.md) — Trojan Horse partner method, outreach
- [Pricing workflows](docs/07-business/pricing.md) — 10x ROI rule, retainer math
- [Delivering projects](docs/07-business/delivering-projects.md) — licensing, security, handover

---

## Quick reference

- [Command cheatsheet](reference/commands-cheatsheet.md)
- [Skills catalog](reference/skills-catalog.md) — all 36 skills with env vars
- [Agent loop reference](reference/agent-loop.md)
- [Glossary](reference/glossary.md)
- [Troubleshooting](reference/troubleshooting.md)
- [Resources & links](reference/resources.md)
- [Must-watch / must-read](MUST_LISTEN.md)

---

## Secrets

No real API keys anywhere in this repo. Every credential is a placeholder like `<YOUR_TOKEN>`. Keep your own keys in a local `.env` — it's in `.gitignore` already.
