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

## Cost reality

Agent teams are expensive. Each agent in the team maintains its own full context window — roughly 7x more tokens than a single session for the same work.

**Real example:** Scanning the OpenClaude repository with 10 scanner agents + 2 debate agents consumed approximately 1.3 million Sonnet 4.5 tokens in ~15 minutes, costing roughly $80 USD.

This isn't a reason to avoid teams — it's a reason to use them deliberately. Run a team when:
- The task genuinely needs roles that react to each other mid-build
- The quality improvement from multi-role work justifies the cost
- You'd otherwise spend more human hours coordinating the work yourself

Don't run a team when sub-agents or sequential sessions would get to the same result.

## Choosing

- Need many hands on *separate* tasks → sub agents (or [worktrees](../04-advanced/worktrees.md) for full session isolation).
- Need roles that *react to each other* while working → agent team.
- Not sure → start with sub agents; they're cheaper and cover most cases.

See [multi-agent-patterns.md](../04-advanced/multi-agent-patterns.md) for the six higher-level orchestration patterns these building blocks enable.
