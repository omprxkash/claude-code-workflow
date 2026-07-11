# Multi-agent patterns

Techniques for orchestrating multiple Claude agents working together. These go beyond simple subagents (one agent delegating a task) into patterns where agents actively check each other, debate, and specialize by model.

<!-- source: see MUST_LISTEN.md → Automation & autonomous agents -->

---

## 1. Assembly line (sequential specialization)

The simplest multi-agent pattern. Each agent does one thing well, then passes its output to the next.

```
Research agent → Draft agent → Polish agent
```

Each step: do the work, `/clear`, pass the output forward as context.

**Why it works:** Each agent starts with a clean context window focused only on its job. No context rot from earlier phases. The research agent doesn't know or care about polishing.

**Practical example:**
```
Session 1: "Research everything about [topic]. When done, summarize findings in a structured doc."
[/clear]
Session 2: "Here's research output. Write a first draft."
[/clear]
Session 3: "Here's a draft. Polish it."
```

See [four-upgrades.md](../06-workflows/four-upgrades.md) for the `/goal` skill which automates this pattern.

---

## 2. Parallel fan-out (simultaneous specialization)

Multiple agents run the same type of task simultaneously on different inputs — or the same input in parallel.

**Example — lead enrichment:** Spawn one Claude agent per lead, each with its own browser, simultaneously filling contact forms or enriching data. Ten agents working at once finishes in the same time as one agent doing one item.

**Example — content creation:** Three agents each write a version of the same piece with different angles. You review all three and pick the best.

**How to run it in Claude Code:** Worktrees. `claude --worktree task-1`, `claude --worktree task-2`, each in an isolated git workspace. They can't conflict each other. Comfortable limit: 3-4 simultaneous.

```bash
# Terminal 1
claude --worktree feature-auth

# Terminal 2  
claude --worktree feature-search

# Terminal 3
claude --worktree bug-fix-login
```

See [worktrees.md](worktrees.md) for the full walkthrough.

---

## 3. Stochastic consensus (multi-agent voting)

Run the same task with 3-5 agents using identical prompts. Compare outputs. Where they agree, you have signal. Where they diverge, you have something worth investigating.

**When to use it:**
- High-stakes decisions (architecture choices, security review)
- When you want to surface assumptions — different agents will expose different ones
- When a single agent gave you a confident answer you're unsure about

**How to run it:**
```
Run this exact task three times independently, each in a fresh session, and return all three outputs without combining them.
```

Or use an orchestrating agent that spawns the sub-agents:
```
Spawn 3 sub-agents with this exact prompt. Return all three responses. Do not combine or summarize — show me each one.
```

**Reading the spread:** 
- All three agree → high confidence
- Two agree, one differs → the outlier may be catching something real, or may be noise
- All three differ significantly → you have a genuinely ambiguous problem; the disagreement is information

---

## 4. Debate (agent teams)

Multiple agents debate a topic or approach, each taking a different position. Leads to higher quality answers than asking one agent to consider all perspectives itself.

**The problem with asking one agent:** It's sycophantic. It will present "both sides" but lean toward whatever it thinks you want to hear. Two separate agents with opposing briefs will actually argue.

**How to set it up:**

```
Spawn two sub-agents:
- Agent A: argue that we should [approach 1]. Find every reason this is the right call.
- Agent B: argue that we should [approach 2]. Find every reason this is the right call.

Have them debate. After 3 rounds, summarize where they agree and where they genuinely disagree.
```

**Agent chat rooms** — for ongoing multi-agent collaboration, have each agent read and write to a shared `debate/thread.md` file. Each agent appends its reasoning. Later agents see what earlier ones said and build on it. Works like a Slack thread that agents actually update.

```markdown
# debate/thread.md

## Agent A (architecture review)
[reasoning...]

## Agent B (security review)  
[reasoning...]

## Agent A (response to B's point about auth)
[reasoning...]
```

---

## 5. Sub-agent verification

Agent 1 builds something. Agent 2, in a fresh session, reviews it — with no attachment to the implementation.

**Why fresh context matters:** The builder knows what they intended. The reviewer doesn't. A reviewer with fresh eyes catches the gap between what was intended and what was actually built.

**Standard pattern:**
```
Session 1: [build the thing]
Session 2: "Here is what was built. Review it. You are a fresh set of eyes — you have no context about how or why it was built, only what's in front of you. Point out everything that looks wrong, incomplete, or fragile."
```

**For UI work:** Playwright-based visual verification. Have Claude Code open a browser, navigate to the built UI, take screenshots, and compare to the spec. See [four-upgrades.md](../06-workflows/four-upgrades.md#2-verification-loops).

**Framing that works:**
```
Do not consider this done until you have tested it yourself.
Show me proof it works before reporting it as complete.
```

---

## 6. Multi-model orchestration via MCP

Different models have different strengths. For complex projects, route each task to the model best suited for it.

**Current strengths (mid-2026):**

| Model | Best at | Use for |
|---|---|---|
| Claude (via Claude Code) | Reasoning, orchestration, interpretability | Coordinator; complex logic; anything requiring explanation |
| Gemini (via Antigravity) | Frontend design, multimodal (video), fast output | UI components; anything requiring image/video understanding |
| Codex/GPT (via Codex) | Backend engineering, test-driven development, mathematics | API logic; test suites; numerical reasoning |

**How to wire it:** Register each model as an MCP server so your orchestrating Claude can delegate to them. Each becomes a tool call:

```
tools:
  - call_gemini: "Design the landing page. Here are the brand requirements."
  - call_codex: "Build the API endpoints. Here is the schema."
  - (claude reviews and integrates)
```

The key insight: you're not picking one model anymore. You're building a team where each member does what they're best at. The models are close enough that the difference only matters at the bleeding edge — but when you're building at volume, routing even 10% of tasks to the better model compounds.

---

## Choosing a pattern

| Situation | Pattern |
|---|---|
| Long task with distinct phases | Assembly line |
| Same task on many inputs | Parallel fan-out (worktrees) |
| High-stakes decision, want confidence | Stochastic consensus |
| Architecture or strategy debate | Agent debate / chat room |
| Something built, want independent review | Sub-agent verification |
| Frontend + backend, want best model for each | Multi-model MCP orchestration |

These patterns compose. A typical complex build: assembly line for phases, stochastic consensus for architecture decisions, sub-agent verification before shipping.
