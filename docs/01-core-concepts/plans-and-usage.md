# Plans & usage — what you actually get

`install-and-setup.md` tells you which plan to start with. This page goes one level
deeper: what each tier actually unlocks, so you're not guessing when you start
hitting limits or wondering if you need Opus.

## The tiers

| Plan | Roughly | What it's for |
|---|---|---|
| **Pro** | ~$20/mo (cheaper billed annually) | The default starting point. Includes Claude Code. |
| **Max 5x** | ~$100/mo | 5x Pro's per-session usage. For daily heavy use. |
| **Max 20x** | ~$200/mo | 20x Pro's per-session usage, priority access to new models/features first. |
| **Team / Enterprise** | Seat-based | Org-wide billing, admin controls, shared usage pool. |

Exact prices and multipliers change — Anthropic doubled the 5-hour rate limits for
every tier in mid-2026 without changing prices. Treat the table above as "which
tier am I roughly looking at," and check
[support.claude.com](https://support.claude.com/en/articles/11145838-use-claude-code-with-your-pro-or-max-plan)
for the current numbers before you buy.

## What "usage" actually means

Claude Code doesn't meter per-message. It meters against a **rolling usage window**
(5 hours), reset on a schedule. Within that window you get a budget of model time —
burn through it fast (long agentic sessions, big files, lots of subagents) and
you'll hit a wait before the window resets.

What eats budget fastest:
- Long sessions where context keeps growing unchecked (see
  [context management](context-management.md) — compacting/clearing isn't just
  about quality, it also reduces how much you're re-processing per message)
- Spawning many subagents in parallel (each one consumes its own share)
- Large file reads and broad codebase searches

If you're on Pro and hit the wall daily, that's the signal to upgrade — not a sign
you're doing something wrong.

## Model access

Historically Opus was Max-only, reserved for the hardest reasoning/architecture
work while Pro got Sonnet. That line has moved before and will likely move again as
new models ship — Pro has gained Opus access at points in 2026. Don't hardcode an
assumption about which tier gets which model; check `/model` in a session to see
what's actually available to you right now, and the support article above for the
current official breakdown.

**Model choice inside a plan still matters for cost**, independent of your tier:
- `haiku` — fastest, cheapest. Good for subagents doing read-only lookups.
- `sonnet` — the default for most work. Best balance.
- `opus` — heaviest reasoning, slowest, burns the most budget. Reach for it on hard
  architecture/refactor decisions, not routine edits.

Set this per-agent in `.claude/agents/*.md` (see [subagents](../02-customization/subagents.md))
so cheap tasks don't burn expensive-model budget.

## Team / Enterprise

Seat-based, admin-managed, with org-wide policy controls (which MCP servers are
allowed, shared settings, centralized billing). If you're deploying Claude Code
across a team rather than using it solo, this is the tier to look at — not Max
per-seat.

## Practical guidance

1. **Start on Pro.** You don't know your usage pattern yet — don't overpay before
   you do.
2. **Upgrade when the wait timer becomes a daily annoyance**, not preemptively.
3. **If you're burning budget on parallel subagents constantly**, that's a sign to
   look at [parallelization](../04-advanced/parallelization.md) patterns and make
   sure you're not over-fanning-out for simple tasks.
4. **Check current numbers before deciding** — this page will drift, the support
   article won't.

## Running Claude Code cheaper (or free)

Claude Code the agent harness is separate from the Claude model it calls. You can swap in a different model — local or open-source — and use the full Claude Code tooling at dramatically reduced cost (or free).

### Option 1 — Local models via Ollama

[Ollama](https://ollama.com) lets you download and run open-source models on your own machine. The model runs locally; nothing leaves your computer.

```bash
# Pull a model (check ollama.com/models for available options)
ollama pull qwen3.5:9b

# Increase context window (default is often too small for Claude Code's system prompt)
# Ask Claude Code: "I'm pulling a model from Ollama, help me increase the context window"

# Launch Claude Code with the local model
ollama run claude   # follow prompts to pick the model
```

**Trade-offs:**
- Completely free and fully private
- Slower — model runs on your CPU/GPU, not Anthropic's servers
- Quality depends on your hardware and model size; 9B parameter models are noticeably weaker than Opus
- Some open-source models don't follow Claude Code's tool-calling JSON protocol — test before relying on them

**When to use it:**
- Reading/summarizing files before passing context to a smarter model
- Grepping and searching codebases
- Repetitive scaffolding tasks
- When Claude is down or you've hit your session limit

### Option 2 — Open Router (free cloud models)

[Open Router](https://openrouter.ai) routes requests to various models, including many that are free (with rate limits). You can point Claude Code at Open Router instead of Anthropic's API.

Add to your project's `.claude/settings.local.json`:

```json
{
  "env": {
    "ANTHROPIC_BASE_URL": "https://openrouter.ai/api/v1",
    "ANTHROPIC_AUTH_TOKEN": "sk-or-YOUR_OPEN_ROUTER_KEY",
    "ANTHROPIC_API_KEY": "",
    "ANTHROPIC_MODEL": "qwen/qwen3-235b-a22b:free",
    "ANTHROPIC_SMALL_FAST_MODEL": "qwen/qwen3-235b-a22b:free",
    "CLAUDE_CODE_MAX_OUTPUT_TOKENS": "16000"
  }
}
```

**Important:** Set all model variables to your chosen free model — not just the main one. If you only set `ANTHROPIC_MODEL`, Claude Code falls back to Haiku (paid) for tool calls and file searches, and you'll get charged without realizing it.

Free models on Open Router have rate limits: 50 requests/day without a balance, 1,000 requests/day with any balance loaded. A $5-$10 deposit unlocks the higher tier — the free models don't consume the balance.

**Trade-offs:**
- Much faster than local models
- Still free for models labeled `:free`
- Less privacy than local (requests go to Open Router's cloud)
- Web search may not work natively — some models don't have it, so you'll need Perplexity or similar

### Cost comparison

| Option | Cost | Speed | Quality ceiling |
|---|---|---|---|
| Claude Pro ($20/mo) | Fixed monthly | Fast | Sonnet |
| Claude Max ($100-200/mo) | Fixed monthly | Fast | Opus |
| Open Router free models | ~$0 | Fast | Varies (Qwen3, Gemma4 competitive) |
| Ollama local (9B model) | $0 | Slow | Limited by hardware |
| Open Router cheap models (~$0.14/M tokens) | Pay-per-use | Fast | 50-100x cheaper than Opus |

The open-source quality gap is closing fast. For non-critical tasks (research, summarizing, scaffolding, search), free models are more than sufficient.

## Next

- [Session management](session-management.md) — `--continue`, `--resume`, and not
  losing work between sessions
- [Tokens & cost](tokens-and-cost.md) — the token-level view of the same problem
