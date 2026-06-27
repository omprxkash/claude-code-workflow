# Slash commands

Slash commands are shortcuts you type with a leading `/`. Some are built into Claude
Code; the powerful part is that **you can write your own** — a custom command is
just a reusable prompt saved as a Markdown file.

## Built-in commands you'll actually use

These are the ones that earn their keep day to day:

- `/clear` — wipe the conversation and start fresh. Your main defense against
  [context rot](../01-core-concepts/context-management.md).
- `/compact` — compress the current conversation to reclaim context.
- `/init` — generate a starter `CLAUDE.md` by having Claude survey the codebase.
- `/login` — authenticate.
- `/statusline` — configure the status line (see [statusline](statusline.md)).
- `/help` or `?` — list shortcuts and commands.

There are more, and they change over time — `/help` is the live list. A fuller table
of the commands and "command-style" prompts referenced in this handbook lives in the
[command cheatsheet](../../reference/commands-cheatsheet.md).

## Custom commands: the real power

A custom slash command is a Markdown file containing a prompt. Save it and typing
`/name` injects that prompt. This is how you capture a move you make often — a
research routine, a writing style, a review pass — so you never retype it.

**Where they live:**

- Project commands: `.claude/commands/` in the repo (shared with the project).
- Personal commands: `~/.claude/commands/` (available everywhere).

**Shape of a command file** (`.claude/commands/steel-man.md`):

```markdown
---
description: Argue against my own idea to stress-test it
---

Take the idea I just described and argue the strongest possible case *against* it.
Steel-man the opposition: surface the best counterarguments, the failure modes, and
the assumptions I'm taking for granted. Then tell me which objections are fatal and
which are survivable.
```

Now `/steel-man` runs that prompt anytime. Many of the "commands" people share —
`/human`, `/ghost`, `/godmode`, `/content`, "Steel Man This", `/EL10`, `/X10` — are
exactly this: a saved prompt that nudges Claude into a particular mode of working.
This repo ships a few ready to copy in
[`templates/commands/`](../../templates/commands/).

## Arguments

Commands can take input. Reference what the user typed after the command with
`$ARGUMENTS` (or positional `$1`, `$2`) inside the file, e.g.:

```markdown
Research $ARGUMENTS and give me a tight briefing with sources.
```

Then `/research agentic pricing models` fills it in.

## When to make one

If you've typed roughly the same instruction three times, make it a command. Good
candidates: a house writing voice, a "make this sound human" pass, a deep-research
routine, a code-review checklist, a "explain like I'm 10" rewrite.

## Next

- [Skills](skills.md) — the next step up: bundled, auto-invoked capabilities.
- [Command cheatsheet](../../reference/commands-cheatsheet.md)
