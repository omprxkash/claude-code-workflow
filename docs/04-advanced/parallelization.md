# Parallelization

Getting many hours of work done in a fraction of the time by running work in parallel — across multiple Claude Code instances and across [subagents](../02-customization/subagents.md).

<!-- source: see MUST_LISTEN.md -->

---

## Two flavors of parallelism

| | Sub-agent fan-out | Multiple full sessions (worktrees) |
|---|---|---|
| Isolation | Each agent has its own context window | Each agent has its own git working tree — no file conflicts possible |
| Coordination | Parent agent orchestrates, gets results back | You coordinate; agents can't talk to each other |
| Best for | Fan-out tasks on the same codebase (classify 1,000 emails, scrape 1,000 leads) | Building different features simultaneously on separate branches |
| Cost | Adds up — each agent runs its own context overhead | Adds up — full sessions |
| Setup | One prompt to the main session | `claude --worktree <name>` per branch, or let Claude create them |

See [worktrees.md](worktrees.md) for the full worktree walkthrough.

---

## The sub-agent fan-out pattern

A parent agent assigns chunks of a batch to N sub-agents, each running in parallel. The key rule: **sub-agents should return only the data you need, not the full input back.**

The 1,000-email example shows exactly what happens when you get this wrong, then right:

**Wrong — sub-agents return full email text:**
The parent spawns 10 agents, each processes 100 emails, and then tries to pass all 1,000 raw email strings back to the parent. The parent hits a "prompt too long" context error because 1,000 email bodies are enormous.

**Right — sub-agents return only labels/metadata:**
Sub-agents classify each email and return only the result: `{ id: "abc123", label: "Action Required" }`. The parent receives 1,000 tiny objects, not 1,000 full email bodies. Same work, 50x less data on the return trip.

**Rule:** design sub-agent outputs to be summaries, decisions, or structured metadata — not re-transmissions of the raw input.

### Worked example — 1,000 emails in ~1 minute

```
Hey I'd like you to turn this Gmail-label flow into a sub agent.
Spawn 10 sub-agents that do all of those simultaneously.
Use sonnet-4.5.
```

10 parallel sub-agents, 100 emails each. Result: 987/989 emails classified in approximately 1 minute.

### The parallel failure problem

Parallel agents compound failure probability. If a single agent has a 95% success rate:

```
1 agent:  95% success
2 agents: 95% × 95% = 90% all succeed
5 agents: 95%^5 = 77% all succeed
10 agents: 95%^10 = 59% all succeed
```

**This is not a reason to avoid parallelism — it's a reason to design for partial failure.** Structure the parent to handle some agents returning errors or empty results rather than treating any failure as a full stop. Use idempotency keys (see [deploy.md](../05-deployment/deploy.md)) so failed agents can be safely retried.

---

## When parallelism makes sense (and when it doesn't)

**Use it for:**
- Batch processing — N items that are independent (classify, scrape, enrich)
- Divergent exploration — three agents each take a different design direction, you pick one
- Big codebase scans — break a large repo into sections, scan in parallel

**Don't use it for:**
- Tasks where agents need to share state mid-run (use [agent teams](../02-customization/agent-teams.md) instead)
- Anything where the overhead (context load per agent) would cost more than the time saved
- Simple sequential tasks dressed up as parallel to seem sophisticated

---

## Cost reality

Each sub-agent pays its own context overhead on startup — system prompt, tools, memory files. For a fresh Claude Code session that's roughly 40-50k tokens before a single message. Multiply by 10 agents and you've pre-spent 400-500k tokens on overhead alone.

This is worth it when the task-per-agent is big relative to that fixed cost. It's not worth it for tiny tasks — one agent processing 5 lines of text probably costs more in overhead than it saves in parallelism.

**Rough calibration:** parallelize when each agent does at least several thousand tokens of real work. Below that, sequential is cheaper.

See [context-management.md](../01-core-concepts/context-management.md) for the full cost breakdown.
