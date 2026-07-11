# Agent teams

Agent teams coordinate multiple agents working together on a shared goal — a step beyond firing off individual [subagents](subagents.md). The two are often confused, but they behave very differently.

<!-- source: see MUST_LISTEN.md -->

## Sub agents vs agent teams

| | Sub agents | Agent teams |
|---|---|---|
| Run in parallel | Yes | Yes |
| Talk to each other | No — each returns only to the main agent | Yes — direct agent-to-agent messages |
| Task list | Main agent holds it | Shared — agents assign tasks to each other |
| Cost & speed | Cheap, fast | Slower and more expensive |
| Best for | Fan-out work: research, classification, doc-reading | Multi-role builds: frontend + backend + QA on one feature |

**The token economics of sub agents** are the main reason to use them: a sub agent can burn 40,000 tokens reading documentation and return a 500-token summary to the main session. The main context stays clean; you paid for the reading once, in an isolated window that gets thrown away.

**Agent teams** trade that efficiency for coordination. Each agent sees the shared task list, picks up work, and messages the others ("the API schema changed, update your fetch calls"). That coordination overhead is real — use teams only when the roles genuinely need to react to each other mid-build.

## Enabling agent teams

Agent teams are an experimental feature. Enable them by adding this to `.claude/settings.local.json`:

```json
{
  "claudeCode.experimental.agentTeams": 1
}
```

(Use `settings.local.json` not `settings.json` — local settings are gitignored and appropriate for experimental features you don't want to commit for the whole team.)

## Creating an agent

In the terminal (this command is terminal-only), run:

```
/agents
```

Select **Create New Agent** and type a plain-language description ("AI trend hunter"). Claude generates the agent definition file for you, with YAML frontmatter like:

```yaml
name: ai_trend_hunter
model: sonnet
tools: all
memory: enabled
```

Agent files live in `.claude/agents/` (project) or `~/.claude/agents/` (global). Ready-made examples: [templates/agents/](../../templates/agents/).

## Spinning up sub agents

You don't need any setup — just ask the main session:

```
Spin up two research sub agents: one covering [topic A], one covering [topic B].
Have each return a structured summary.
```

The main session delegates, the sub agents run in parallel in their own context windows, and the summaries come back when they finish.

## Running an agent team

Teams shine in a terminal multiplexer like **tmux**, where each agent gets its own visible pane. A three-role build looks like:

```
Spin up an agent team for this feature:
- Frontend dev: build the React UI
- Backend dev: build the API endpoints
- QA: test both as they land, report bugs back to the builders
```

tmux splits into color-coded panes and you can watch the three agents work simultaneously and message each other. The QA agent filing a bug directly to the backend agent — without round-tripping through you — is the thing sub agents can't do.

## What teammates inherit when they spawn

A teammate wakes up with no conversation context, but it isn't starting from zero
on everything — it **inherits the main session's permissions** (bypass mode, allowed
bash commands, etc. all carry over automatically), and it has access to the same
files, MCP servers, and skills as the main session without you wiring anything up
per-agent.

## Plan approval mode

Just as you'd start a solo session in [plan mode](../01-core-concepts/permission-modes.md)
for anything non-trivial, you can require every teammate to draft a plan and get it
approved before executing — either by the main/lead agent, or by you directly, or
by designating one teammate as the plan reviewer for the others. This catches a
teammate heading down the wrong path before it burns tokens building on a bad plan.

## Three rules for teams that actually work

1. **Give each agent its own territory.** Assign distinct files/deliverables per
   agent. Two agents editing the same file is how work gets silently overwritten.
2. **Let them message each other directly** rather than only reporting to the main
   session — that's the entire point of a team over sub-agents.
3. **They should genuinely be working in parallel**, not handing off one-to-the-next
   in sequence. If the process is naturally 1→2→3 with each step depending on the
   last, that's not a team — it's sub-agents or an assembly line.

## Common pitfalls

| Symptom | Fix |
|---|---|
| Agents keep stopping to ask permission | Pre-approve the relevant commands in project/local settings so they don't interrupt every few seconds |
| Output feels disjointed, work got overwritten | Assign explicit file owners — each agent should only edit its own files |
| One agent is idle or barely contributing | Explicitly assign it work or a dependency in the initial plan/prompt |
| Burning too many tokens | Use fewer agents — team cost scales roughly linearly with team size |
| Agents seem to be losing work between steps | Tell them to write state to a temporary file they can reload rather than holding it only in context |
| Approvals feel off / untrustworthy | Have *you* approve plans directly until you've built confidence in how the team behaves |

**Team size:** keep it small — 2 to 5 agents is a reasonable ceiling. Cost scales
with headcount (see below), so an 8-agent team isn't automatically better than a
focused 3-agent one.

## Graceful shutdown

When you end a team, agents get a shutdown request rather than being force-killed —
a teammate mid-task can respond "not done yet, let me save state first" before
confirming it's safe to stop. This matters because a force-kill can leave partial,
uncommitted work; a clean shutdown means each agent finishes and saves before the
team closes.

## Cost reality

Agent teams are expensive. Each agent in the team maintains its own full context window — roughly 7x more tokens than a single session for the same work.

**Real example:** Scanning the OpenClaude repository with 10 scanner agents + 2 debate agents consumed approximately 1.3 million Sonnet 4.5 tokens in ~15 minutes, costing roughly $80 USD.

This isn't a reason to avoid teams — it's a reason to use them deliberately. Run a team when:
- The task genuinely needs roles that react to each other mid-build
- The quality improvement from multi-role work justifies the cost
- You'd otherwise spend more human hours coordinating the work yourself

Don't run a team when sub-agents or sequential sessions would get to the same result.

## Choosing

Lean toward a team when several of these are true: the work has genuinely distinct
specialty areas, it needs to happen in parallel, the roles need to react and assign
work to each other as they go, and the quality bar justifies the extra cost.

Lean toward sub agents (or skip teams entirely) when: the process is naturally
sequential, everything fits in one context window/conversation anyway, the agents
would just be working on the same files, the task is simple, or you want to keep
token cost down. A sequential 1→2→3 process is a sub-agent/assembly-line job, not a
team job, even if it "feels" like it needs multiple roles.

- Need many hands on *separate* tasks → sub agents (or [worktrees](../04-advanced/worktrees.md) for full session isolation).
- Need roles that *react to each other* while working → agent team.
- Not sure → start with sub agents; they're cheaper and cover most cases.

See [multi-agent-patterns.md](../04-advanced/multi-agent-patterns.md) for the six higher-level orchestration patterns these building blocks enable.
