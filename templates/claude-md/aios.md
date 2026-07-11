# AIOS CLAUDE.md (template)

> This is the master routing file for an AI Operating System. It tells Claude who you are,
> where everything lives, what it can do, and how to improve itself.
> Keep it under 200 lines. Point to files for detail — don't paste detail here.
> Background: ../docs/01-core-concepts/claude-md.md

---

## Profile

- **Name:** <your name>
- **Role / what you do:** <one sentence — e.g. "founder of a 6-person SaaS, focused on growth and product">
- **Primary goal:** <what you're optimizing for right now — e.g. "close 10 new clients this quarter">
- **My job here:** Help <name> spend less time on operations and more time on <highest-value thing>.

> **Gut check:** If you asked this Claude about your business and got an answer that sounds like a stranger wrote it, this section is too thin.

---

## Context (first C)

Your static knowledge base. Claude reads pointers here — not the full files.

```
context/
  about-me.md          ← background, how you work, communication style
  about-business.md    ← what the business does, customers, revenue, team
  priorities.md        ← current 90-day focus, top 3 goals
  decisions/           ← key decisions made and why (adr-style)
```

When asked about me or the business, read `context/about-me.md` and `context/about-business.md` first. For current priorities, read `context/priorities.md`.

---

## Connections (second C)

Live data sources. These are APIs or CLIs, not static files.

| Source | Type | What it has |
|---|---|---|
| <e.g. Google Calendar> | API via `$GOOGLE_TOKEN` | Schedule, meetings |
| <e.g. Stripe> | API via `$STRIPE_KEY` | Revenue, customers |
| <e.g. Gmail> | CLI / connector | Emails, threads |
| <e.g. ClickUp> | API via `$CLICKUP_TOKEN` | Tasks, team comms |

> Connection rule: prefer CLI → API endpoint → MCP in that order. CLIs use 60-70% fewer tokens than equivalent MCP servers.

---

## Capabilities (third C)

What Claude can do in this workspace. Read this before claiming something can't be done.

- **Skills:** Located in `.claude/skills/`. Run `/skill-name` or describe the task naturally.
- **Agents:** Located in `.claude/agents/`. Claude spawns them as needed.
- **Browser:** Can control Chrome via Playwright for visual verification and web tasks.
- **Files:** Full read/write access to this workspace.
- <add specific capabilities as you build them>

### Active skills

| Skill | What it does | Invoke with |
|---|---|---|
| `grill-me` | Structured interview to extract knowledge | `/grill-me [topic]` |
| `session-handoff` | Pre-`/clear` snapshot | `/session-handoff` |
| <your skill> | <what it does> | `/<name>` |

---

## Cadence (fourth C)

What runs automatically without you present.

| Routine | Schedule | What it does |
|---|---|---|
| <e.g. daily-standup> | 8am weekdays | Pulls calendar + tasks, writes daily plan to `context/today.md` |
| <e.g. weekly-review> | Friday 4pm | Reviews week, updates `context/priorities.md` |

> Cadence rule: only automate what you've already battle-tested manually. Prompts are never permission layers — if it can, it might. Scope your API keys.

---

## How to work here

- Plan before doing. On non-trivial tasks, state your plan and wait for confirmation before acting.
- Use subagents for research and exploration — keep the main context clean.
- When you make a mistake or find a better way: **update this CLAUDE.md**.
- For anything outward-facing (email sends, pushes, API writes): confirm before doing.

---

## Lab notes — what not to repeat

> Self-updating section. When something fails or a better approach is found,
> append a one-line bullet. Keep each under 15 words. No explanations.

- <Claude appends learnings here over time>
