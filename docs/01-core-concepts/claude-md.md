# What CLAUDE.md is

`CLAUDE.md` is the brain of your workspace. Every conversation with Claude Code has a pattern — user, then model, then user, then model. What's hidden is that there's another prompt injected at the very top of that conversation string before you even send the first message. That prompt is the contents of your `CLAUDE.md`.

So it's the first thing the model reads and internalizes. Drop a `CLAUDE.md` into any project folder and it loads automatically at the start of every session — you don't repeat yourself, it just works.

## What to put in it

The things that don't change between sessions:

- What the project is and its end goal
- How the folders are laid out — where to find different files
- Any frameworks you're using (the WAT framework, naming conventions, etc.)
- Where secrets live (`.env`, never inline)
- Any gotchas or constraints the model should know up front

Keep it lean. It's reloaded on every message, so every wasted line costs context across the whole session.

## What not to put in it

Don't repeat information from other files — use `@filename` imports instead. Don't put communication style rules in here — those go in `.claude/rules/`. Don't make it a novel; if it's getting long, you're putting too much in it. **Target under 150 lines.**

## CLAUDE.md levels

Claude Code reads from multiple levels in order:

- `~/.claude/CLAUDE.md` — personal preferences, always loaded
- `CLAUDE.md` in the repo root — project-level instructions, shared with the team
- `CLAUDE.local.md` in the repo root — your local overrides, gitignored

## Real examples

See [`templates/claude-md/`](../../templates/claude-md/) for four working variants:

- `skills-system.md` — for the 26-skill automation architecture
- `website-design.md` — for screenshot-compare website recreation
- `executive-assistant.md` — for the personal EA setup
- `wat-workflow.md` — for WAT framework projects

A good first action in any project: drop in a `CLAUDE.md` and say *"read CLAUDE.md and set up the project structure."*
