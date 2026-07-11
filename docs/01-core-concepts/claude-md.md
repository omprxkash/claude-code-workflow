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

## The four things CLAUDE.md actually is

Most people use CLAUDE.md as a note-to-Claude. It's actually four distinct things:

1. **Knowledge compression** — Instead of Claude reading every file in your workspace on every query, CLAUDE.md gives it a bird's-eye summary: what's where, what this project is, why things are structured the way they are. A 45x compression ratio is typical (a 1,100-token component file becomes a 22-token reference in CLAUDE.md).

2. **Preferences and conventions** — Things not natively baked in yet: naming style, how you want commits worded, whether you want it to open the dev server or just give you the link, what frameworks to use by default.

3. **Capability declaration** — Claude doesn't always know what it can do in your workspace. If you have 20 skills, APIs, and browser access wired up but your CLAUDE.md doesn't mention them, Claude will often say "I can't do that" or offer to build something from scratch that already exists. Itemize what's available.

4. **Failure log** — The most underused. A running list of what's been tried and failed, preferences that have been corrected, approaches to avoid. Each session, Claude starts with accumulated knowledge instead of from zero.

## Bootstrapping with `/init`

If you already have an existing project and no CLAUDE.md, run `/init`. Claude reads every file in your workspace and generates a compressed CLAUDE.md that summarizes the architecture, key dependencies, entry points, and conventions. Start there, then add your preferences and failure log.

## `/insights` — global pattern mining

After a few weeks of use, run `/insights`. It launches sub-agents across your full conversation history to find patterns: what you ask about repeatedly, where Claude consistently makes mistakes, which prompts you should turn into skills. Use the output to update your global `~/.claude/CLAUDE.md`.

## The self-modifying loop

The highest-ROI CLAUDE.md pattern is making it self-updating:

Add a "Lab notes" section at the bottom with a meta-instruction: *"When you make a mistake or find a better approach, append a one-line bullet here. Keep each under 15 words. No explanations."*

Then every time Claude makes a mistake and you correct it, add: *"Update your CLAUDE.md so this never happens again."*

**Over time:** Session 1 has zero rules, many errors. Session 5 has 10-15 rules, dramatically fewer errors. The first time a loop takes X time. The fifth time it takes 0.7x. The error rate specific to your project and preferences compounds downward.

The catch: review the lab notes occasionally. A model that updates its own instructions can also write bad ones. Human review before the notes get too long.

## The global / local architecture

```
~/.claude/CLAUDE.md          ← global: your preferences across all projects
                                High-level reasoning, who you are, global rules
                                Generate with /insights after 2-3 weeks

<project>/CLAUDE.md          ← local: this project only
                                Architecture, layout, failure log for this codebase
                                Generate with /init on existing projects
```

Global rules should be high-signal, universal truths: "always look up API documentation before starting." Local rules are project-specific: "the main component is src/App.jsx, keep it under 200 lines."

Don't put local knowledge in global and vice versa. A rule about your Stripe integration doesn't belong in the file that loads for every project.

## Put hard constraints at the top

Attention isn't uniform across a long prompt — content at the beginning and end
gets weighted more than the middle (see
[context management](context-management.md#context-rot) on "lost in the middle").
Put anything you genuinely never want violated — "never delete X," "never push
directly to main" — in the first few lines of `CLAUDE.md`, not buried after
general project description. The order you write things in isn't neutral.

## Real examples

See [`templates/system-prompts/`](../../templates/system-prompts/) for real, working examples:

- `skills-system.md` — for the 26-skill automation architecture
- `website-design-advanced.md` — for screenshot-compare website recreation
- `executive-assistant-setup.md` — for the personal EA setup
- `wat-claude-md.md` — for WAT framework projects
- `trigger-dev-resources.md` — a real production CLAUDE.md pulled directly from trigger.dev's own repo, not a template

A good first action in any project: drop in a `CLAUDE.md` and say *"read CLAUDE.md and set up the project structure."*
