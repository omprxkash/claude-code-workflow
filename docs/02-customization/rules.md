# `.claude/rules/` files

The [EA setup prompt](../../templates/system-prompts/executive-assistant-setup.md) tells Claude to
create files in `.claude/rules/`, and the
[skills doc](skills.md) mentions keeping "communication style rules" there instead
of in `CLAUDE.md` — but neither explains what a rules file actually is. This does.

## What it is

A rules file is a plain markdown file, one per topic, that Claude reads the same
way it reads `CLAUDE.md` — always loaded, every conversation. The only difference
from `CLAUDE.md` itself is organizational: instead of one growing file, you split
concerns into small, focused files.

```
.claude/
  rules/
    communication-style.md
    api-conventions.md
    testing-requirements.md
```

## Why split it out instead of putting it all in CLAUDE.md

`CLAUDE.md` is reloaded on every message — so is everything in `.claude/rules/`.
Splitting doesn't save context by itself. What it buys you:

- **Editability.** Changing your tone preferences shouldn't require scrolling
  through architecture notes to find the right section.
- **Reusability across projects.** Copy `communication-style.md` into a new
  project's `.claude/rules/` without dragging along project-specific architecture
  notes that don't apply.
- **Clarity of intent.** `CLAUDE.md` answers "what is this project and how does it
  work." Rules files answer "how do you want things done" — a different kind of
  fact, worth keeping visually separate.

## What goes in CLAUDE.md vs. a rules file

| Goes in `CLAUDE.md` | Goes in a rules file |
|---|---|
| What the project is, architecture, commands | Writing tone, formatting preferences |
| Where secrets live, gotchas | Domain-specific conventions (e.g., "always cite sources this way") |
| Framework-level facts (e.g., the WAT layout) | Anything you'd describe as "a policy," not "a fact" |

Rule of thumb from the [skills doc](skills.md): if it's a fact about the project,
`CLAUDE.md`. If it's a policy about *how to behave*, a rules file.

## Keep it to one topic per file

Don't create a `rules/misc.md` that accumulates everything. A rules file that tries
to cover three unrelated concerns is just `CLAUDE.md` with extra steps. The
[EA prompt](../../templates/system-prompts/executive-assistant-setup.md) explicitly caps this at
3-4 rule files to start, for the same reason.

## Next

- [What CLAUDE.md is](../01-core-concepts/claude-md.md) — the file rules files
  supplement, not replace
- [Persistent memory](memory.md) — the auto-generated counterpart to hand-written rules
