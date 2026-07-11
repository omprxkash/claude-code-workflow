# Tokens & cost

What a token actually is, what it costs at the raw API level, and why that matters
even if you never touch a per-token bill.

## What a token is

A token is a chunk of text — not quite a word. Roughly three-quarters of a word on
average: short words and punctuation often count as their own token, so token count
always runs a bit higher than word count. You don't need to count precisely; you
need the pricing intuition, which comes from *where* tokens go.

## Where tokens go, and why output costs more

Every message has two sides:

- **Input tokens** — everything read *into* the model: your prompt, `CLAUDE.md`,
  files Claude reads, tool results, prior conversation history.
- **Output tokens** — everything the model *generates*: its responses, the code it
  writes, every command it runs.

Output is priced higher than input across every model, because generating text is
the expensive half of the round trip. A task that reads a lot (large files, broad
search) but writes little is input-heavy and cheap per token; a task that writes a
lot (long files, big responses) is output-heavy and costs more per token even
though it may involve fewer total tokens.

## Raw API pricing (illustrative — check current pricing before relying on it)

| Model | Input ($ / million tokens) | Output ($ / million tokens) | Positioning |
|---|---|---|---|
| Haiku | ~$1 | ~$5 | Fast, cheap — lookups, formatting, subagent grunt work |
| Sonnet | ~$3 | ~$15 | Balanced — the default for most work |
| Opus | ~$5 | ~$25 | Most capable, most expensive — hard reasoning only |
| Fable | highest of the four | highest of the four | Priciest, roughly double Opus |

These numbers move as Anthropic ships new models — the ratios (Haiku cheapest,
output always ~5x input) are the durable takeaway, not the exact dollar figures.

**A worked example:** a multi-step task that researched data, ran scripts, and
built out a spreadsheet with real content burned roughly 25,000 output tokens on
Opus — about $0.63 at Opus output pricing, on top of whatever the input side cost
for all the file reads and tool results along the way. Output-heavy build tasks
(generating documents, writing lots of code) are where the output-token price
premium actually shows up in the bill.

## Subscription vs. API billing

If you're on a Claude subscription (Pro/Max), you are **not** billed per token —
you're billed against rolling usage windows instead. See
[plans & usage](plans-and-usage.md) for the tier breakdown and what eats that budget
fastest. The short version: a $200/mo plan maxed out every window is worth
something like an order of magnitude more in raw API inference than the
subscription costs — the subscription is a heavy discount versus paying per token
through the API. Only reach for direct API billing when you need programmatic
access outside the Claude Code/Desktop harness (e.g. calling the model from your
own deployed service — see [deployment](../05-deployment/deploy.md)).

## Effort levels vs. model choice

Beyond picking a model, each model has an **effort** setting (low / medium / high /
extra-high / max) that trades speed for reasoning depth at the same price tier,
plus a separate **fast mode** toggle that trades cost for latency. In practice,
switching *models* (Haiku → Sonnet → Opus) is the lever that matters most for both
quality and cost — effort tuning is a second-order knob worth learning once the
model-choice fundamentals are second nature, not before.

There's also a one-word trigger, **`ultrathink`**, that allocates a large extended-thinking
budget (tens of thousands of tokens) before Claude responds — reach for it on hard
architecture calls, gnarly debugging, or big refactors, or when a couple of normal
prompts haven't gotten you the right output. It costs meaningfully more tokens than
a normal response, so it's a tool for genuinely hard problems, not a default.

## Keeping usage efficient

The tactical playbook — `/clear`, `/compact`, delegating to
[subagents](../02-customization/subagents.md), reading only what's needed, trimming
`CLAUDE.md`, disconnecting unused MCP servers — lives in
[context management](context-management.md#token-management--18-ranked-hacks). That
page is the "how to not waste tokens" companion to this page's "what tokens
actually cost."
