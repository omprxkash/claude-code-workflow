# Persistent memory

`CLAUDE.md` is memory you write by hand and that never changes unless you edit it.
This is the other kind: memory Claude writes *itself*, across sessions, without you
maintaining a file.

## The `#` shortcut

Type `#` followed by anything at the start of a message and Claude saves it to
memory automatically:

```
# Always use British English in client-facing copy
# I run an AI agency based in Manchester
```

This is the fastest way to teach Claude something once and have it stick across
every future session — no file to open, no format to follow.

## Auto-memory

Beyond explicit `#` notes, Claude Code saves patterns it notices on its own —
preferences you state, corrections you make, decisions you confirm. This happens
without configuration; see the
[EA setup prompt](../../templates/system-prompts/executive-assistant-setup.md) for a project that
leans on this heavily (it explicitly tells users "you don't need to configure this
— it works out of the box").

## Where it's stored

| Scope | Location | Shared? |
|---|---|---|
| Personal (all projects) | `~/.claude/CLAUDE.md` and related memory files | Just you |
| Project | `.claude/memory/` or equivalent within the repo | Team, if committed |

### What a real memory folder looks like

Auto-memory isn't one growing file — it's **one fact per file**, each named for what
it holds: `feedback-linkedin-tone.md`, `reference-corporate-structure.md`,
`project-status-launch.md`. A heavily-used setup can accumulate dozens of these (70+
is common after a few months). Each file is small and structured:

```markdown
---
description: Preference correction about LinkedIn post tone
metadata: feedback
---

What: Avoid overly formal/corporate phrasing in LinkedIn posts.
Why: Corrected after a draft came back sounding like a press release.
How to apply: Default to a conversational register; short sentences.
```

One fact per file keeps each memory independently editable and skimmable, and lets
Claude load only the relevant ones instead of re-reading one giant accumulating
document every session.

## Agent memory (a different, narrower thing)

Subagents can get their *own* persistent memory directory, separate from your main
session's memory — see `memory: user | project | local` in
[`skills/agent-builder/reference.md`](../../skills/agent-builder/reference.md) for
the full field reference. Quick version:

| Scope | Directory | Use for |
|---|---|---|
| `user` | `~/.claude/agent-memory/<name>/` | Cross-project knowledge for that agent |
| `project` | `.claude/agent-memory/<name>/` | Project-specific, shareable via git |
| `local` | `.claude/agent-memory-local/<name>/` | Project-specific, gitignored |

When an agent has memory enabled, the first 200 lines of its `MEMORY.md` load
automatically at the start of each run, and Read/Write/Edit are auto-enabled for it
even if not explicitly listed in its `tools` field.

**This is rare, not default.** Most agents don't need memory — only give an agent
memory if it genuinely learns something reusable across runs (a recurring bug
pattern, an API quirk it discovered). Don't add it just because it's available.

## When to use which

- **`#` note** — a fact or preference about *you* that should apply everywhere,
  forever. "I prefer terse responses," "always check X before Y."
- **CLAUDE.md** — project facts that don't change session to session: architecture,
  conventions, commands. Read every message, so keep it lean (see
  [What CLAUDE.md is](../01-core-concepts/claude-md.md)).
- **`.claude/rules/`** — one focused topic per file, referenced by CLAUDE.md rather
  than crammed into it (see [rules](rules.md)).
- **Agent memory** — narrow, agent-specific learnings that only that agent needs,
  not general project knowledge.

## Next

- [CLAUDE.md](../01-core-concepts/claude-md.md) — the hand-written counterpart to auto-memory
- [Rules files](rules.md) — focused, topic-scoped instruction files
