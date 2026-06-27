# Subagents

A subagent is a separate Claude worker that runs in its own context window. You delegate a task to it; it does the work, writes output to a file, and returns. The main session only sees the result — not the hundreds of messages the subagent processed to get there.

This is the primary tool for protecting the main [context](../01-core-concepts/context-management.md).

## How it works

Subagents run in isolated context with scoped tools. The parent spawns them, they work autonomously, and they return a concise result. They don't share context with the parent — that's the point.

From the skills architecture:

> Subagents are lightweight agents (Sonnet) with self-contained contexts. They're cheaper, unbiased (no parent context leakage), and keep the parent context clean.
>
> **Subagents are read-only reporters. All code changes happen in the parent agent.**

## Agent file format

Each subagent is a `.md` file in `.claude/agents/` with a YAML frontmatter block:

```yaml
---
name: my-agent
description: What this agent does and when to invoke it. Claude reads this to decide when to use it.
model: sonnet
tools: Read, Grep, Glob
---

Body: instructions the agent sees when spawned.
```

- `name` — how you refer to it
- `model` — `sonnet` for most tasks; `opus` if you need heavier reasoning
- `tools` — restrict to what the agent actually needs
- `description` — written for Claude to read, not humans; determines auto-activation

Drop the file in `.claude/agents/` (project-level) or `~/.claude/agents/` (global).

## The four real agents

These are working definitions. Templates in [`templates/agents/`](../../templates/agents/).

### code-reviewer

```yaml
---
name: code-reviewer
description: Unbiased code review of a snippet with zero prior context. Returns actionable recommendations on correctness, readability, performance, and security.
model: sonnet
tools: Read, Write
---
```

Reviews across five areas: correctness, readability, performance, security, error handling.
Returns a clear verdict: **PASS** / **PASS WITH NOTES** / **NEEDS CHANGES** with issues grouped by severity (high / medium / low).

Used in the Design+Build loop: Write → **Code Review** → QA → Fix → Ship.

### research

```yaml
---
name: research
description: Deep research agent with full web and file access. Use for investigations that require many searches, reading docs, or exploring large codebases without polluting parent context.
model: sonnet
tools: Read, Glob, Grep, WebSearch, WebFetch
---
```

Best for tasks that require many searches or large file reads. The work stays in the subagent's context; only the findings come back.

### qa

```yaml
---
name: qa
description: QA agent that generates tests for a code snippet, runs them, and reports pass/fail results back.
model: sonnet
tools: Read, Write, Bash
---
```

Used after `code-reviewer` in the build loop. Generates and runs tests, reports pass/fail. The parent fixes any failures and re-runs.

### email-classifier

```yaml
---
name: email-classifier
description: Classify a chunk of Gmail emails into Action Required, Waiting On, or Reference categories. Used by gmail-label skill for parallel classification.
model: sonnet
tools: Read, Write
---
```

Output is JSON only:
```json
{"Action Required": ["id1", "id2"], "Waiting On": ["id3"], "Reference": ["id4", "id5"]}
```

The `gmail-label` skill spawns **10 of these in parallel** to classify 100 emails in ~30 seconds.

## The Design+Build loop

```
Write code
   ↓
code-reviewer (subagent) — reports issues, no edits
   ↓
Parent fixes issues
   ↓
qa (subagent) — generates + runs tests, reports pass/fail
   ↓
Parent fixes failures
   ↓
Ship
```

## Parallelization

Because each subagent has its own context, you can run many at once. The `gmail-label` skill does this: spawn 10 `email-classifier` agents, each handling a different batch of emails, then merge results in the parent.

See [parallelization](../04-advanced/parallelization.md) for the pattern.

## Next

- [Agent teams](agent-teams.md)
- [Parallelization](../04-advanced/parallelization.md)
- [Templates: real agent files](../../templates/agents/)
