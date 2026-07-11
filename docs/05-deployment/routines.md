# Claude Code Routines: Scheduled Agents

Routines let you run Claude Code on a cron schedule — pre-market research, daily summaries, automated reports — without you being present. The agent wakes up, reads its context files, does the job, writes back its findings, and sleeps.

---

## Local vs remote routines

| | Local | Remote |
|---|---|---|
| Where it runs | Your machine | Anthropic's cloud |
| Requires computer on | Yes | No |
| Requires GitHub repo | No | Yes |
| Best for | Testing, dev | Production 24/7 runs |

For anything you want running while your computer is off, use **remote routines**. They clone your GitHub repo in the cloud, run the job, and push changes back to the repo. The next run reads from the updated repo.

---

## Scheduled tasks vs `/loop` — know which one you're using

There are two ways to make Claude run on a schedule, and they behave very differently:

| | Desktop scheduled tasks | `/loop` (terminal / VS Code) |
|---|---|---|
| Where to set up | Desktop app → Schedule tab | Type `/loop` or just say it ("check my ClickUp every 10 minutes") |
| Session model | Fresh stateless agentic session each run | Interval prompt inside your *current* session |
| Survives machine off | Yes — catches up on missed runs looking back up to 7 days | No — dies instantly when the terminal closes |
| Lifespan | Until you delete it | Auto-expires after 3 days |
| Best for | Recurring jobs (daily reports, weekly scrapes) | Short-lived monitoring during active work |

Under the hood, `/loop` and natural-language scheduling ("remind me at 10:40 to...") use Claude's built-in `cron_create` / `cron_list` / `cron_delete` tools. Useful to know when you want to ask Claude what loops are currently active or to cancel one.

Rule of thumb: if the job should outlive today's working session, use a scheduled task (or a remote routine). `/loop` is for babysitting something *while you're there*.

---

## Memory architecture

Every time a routine fires, Claude Code wakes up essentially stateless. It has no memory of what the previous run did — unless you explicitly write that memory to files.

The pattern:
1. **Wake up → read context files** (strategy, logs, recent state)
2. **Do the job** (research, trade, summarize, whatever)
3. **Write back** (update memory files, push to GitHub)

Files are the agent's personality and discipline. The more specific and well-organized your context files, the more consistent the agent's behavior across runs.

---

## Setup walkthrough (trading agent example)

### Step 1 — Scaffold the project

Create a fresh folder and open Claude Code. Start in plan mode and describe what the agent should do. Don't write strategy yet — just brain-dump how you'd do the task manually:

```
I'm setting up a 24/7 trading agent. Here's how I currently trade:
[describe your signals, timing, what you check, what makes you buy/sell]
I want to run this on a cron: pre-market, market open, midday, and close.
The agent should research, trade via the Alpaca API, log its decisions,
and send me a daily summary via ClickUp.
Help me scaffold the project.
```

Let Claude propose the folder structure, memory files, and slash commands. Review the plan before accepting.

### Step 2 — Design the memory files

Typical structure for a persistent agent:

```
project/
  CLAUDE.md              ← overall instructions, always read first
  memory/
    strategy.md          ← trading strategy, signals, rules
    trade-log.md         ← every trade placed with reasoning
    research-log.md      ← market research notes
    weekly-review.md     ← weekly performance summary
    hot.md               ← short cache of most recent context (optional)
  routines/
    pre-market.md        ← prompt for the 6am routine
    market-open.md       ← prompt for the 8:30am routine
    midday.md            ← prompt for the noon routine
    market-close.md      ← prompt for the 3pm routine
    weekly-review.md     ← prompt for Friday afternoon routine
  scripts/               ← helper scripts if needed
```

### Step 3 — Write the routine prompts

Each routine gets its own prompt file. Key things every prompt must include:

1. **Read files first** — list exactly which memory files to read before acting
2. **Do the job** — the task for this specific run
3. **Write back** — which files to update before finishing
4. **API keys from environment variables** — never hardcode them; use `$ALPACA_KEY`, `$PERPLEXITY_KEY`, etc.

Example structure:

```markdown
# Pre-market Routine

## On startup, read these files first:
- memory/strategy.md
- memory/trade-log.md (last 5 entries)
- memory/hot.md

## Your job:
Research pre-market catalysts for our current positions and watchlist.
Use Perplexity API ($PERPLEXITY_API_KEY) for research.
Draft trade ideas for market open. Do not place trades yet.
Only message me if something is urgent.

## On finish, write back:
- Update memory/research-log.md with today's findings
- Update memory/hot.md with current state
```

### Step 4 — Set up API keys in environment variables

Never put API keys in files that go to GitHub. Instead, use environment variables configured in the Claude Desktop app's routine settings.

In Claude Desktop → Routines → [routine] → Cloud Environments:
- Create a named environment (e.g., "trading")
- Add your keys: `ALPACA_KEY`, `ALPACA_SECRET`, `PERPLEXITY_API_KEY`, `CLICKUP_TOKEN`
- Select this environment for all your trading routines

In your prompts, reference them as `$ENV_VAR_NAME` so Claude knows where to find them.

### Step 5 — Push to GitHub

Remote routines need a GitHub repo. Claude Code can set this up for you:

```
Help me push this project to a new GitHub repo called [name].
```

It will authenticate with GitHub, create the repo, and push your files. After that, every time a routine runs, it commits its memory updates back to this repo.

**Required setting for remote routines:**  
In each routine's settings → Permissions → enable **"Allow unrestricted branch pushes"**. Without this, the routine can't push its memory updates back to the repo and the next run starts blind.

### Step 6 — Create the routines

Tell Claude Code to create the scheduled routines from your prompt files:

```
Look inside the routines/ folder. Help me set up all five as remote Claude Code
routines using the trading cloud environment and the [repo name] GitHub repo.
Cron jobs are defined in each prompt file. All should run weekdays only except
the weekly review (Fridays only).
```

Claude will configure the crons, set the prompts, and link the environment.

### Step 7 — Test before going live

For each new routine, run it manually first ("Run now") and watch it execute in real time. Check:
- Can it find the API keys?
- Does it read the right memory files?
- Does it write back correctly and commit to GitHub?

Common issue: API key variable names in the prompt must match exactly what you named them in the cloud environment — spacing and capitalization matter.

---

## What remote routines can and can't touch

A remote routine is fully stateless: each run clones your GitHub repo fresh, runs,
and the clone is destroyed afterward (unless the run itself pushes a commit or
branch — that persists, along with the run's session history in your dashboard).
Consequences:

- **No local file access, no local secrets, no local cookies/session state.**
  Anything the run needs must live in the GitHub repo or be provided as an
  environment variable — an `.env`-based automation that works locally can fail
  remotely for exactly this reason. If a workflow depends on a logged-in browser
  session (cookies from prior runs), it generally won't work as a remote routine —
  it needs a token/header-based auth method instead.
- **API keys go in the routine's cloud environment settings** (name the environment,
  add key-value env vars there), not in a repo `.env` — the repo's `.env` is
  git-ignored, so it never reaches the clone. Reference keys in your prompt as
  environment variables explicitly if the agent doesn't find them on its own
  (e.g. *"my API key is available as an environment variable — use it directly,
  don't look for a `.env` file"*).
- **Network access has levels:** *Trusted* (default) only allows outbound requests
  to Anthropic-vetted domains (version control hosts, major cloud platforms, etc.).
  *Full* allows any outbound request — required if a routine needs to reach a
  service outside that vetted list (e.g. certain third-party APIs), but it also
  means that if Claude reads malicious content mid-run, it could theoretically be
  tricked into exfiltrating data to an external server; *Trusted* blocks that class
  of risk. For a private repo where you control all the inputs, the practical risk
  on *Full* is low, but know which setting you're on. *Custom* lets you allow
  specific domains beyond the vetted list without going all the way to *Full*.
- **Setup scripts** run once when the remote session spins up, before Claude Code
  launches — use one if a run needs packages installed first.
- **Resource limits per run:** 4 vCPUs, 16GB RAM, 30GB disk. Don't point a routine
  at a massive multi-purpose repo (like a full AIOS project) if the automation only
  needs a handful of files from it — consider a dedicated smaller repo per routine
  instead, both for resource reasons and because the full repo's `CLAUDE.md` and
  context load in on every run, which counts against your usage the same as an
  interactive session would.

## Daily run limits (by plan)

| Plan | Routine runs / day |
|---|---|
| Pro | ~5 |
| Max | ~15 |
| Team / Enterprise | ~25 (metered overage available for orgs that enable it) |

Minimum schedule interval is **1 hour** regardless of plan — for anything tighter
than that, use `/loop` or a local scheduled task instead (see the comparison table
above). Check current numbers before relying on them; like other plan limits, these
move.

## Context budget

Treat tokens per run like a budget. Each routine run has a limited context window. What eats tokens:
- CLAUDE.md / system instructions
- Memory files you tell it to read
- API responses (research, market data)

Rules of thumb:
- Don't make the agent read every memory file every run — only what it needs
- Keep strategy.md and trade-log.md trim; archive old entries to a separate file
- The `hot.md` pattern (a short 500-word recent-state cache) saves the agent from reading multiple files just to get current context

---

## Guard rails

Autonomous agents are eager. Define what they should never do:
- Max % of portfolio per position (e.g., 5%)
- Daily loss cap
- Banned instrument types (no options, no crypto)
- Max new positions per week

Put these in `memory/strategy.md` and reference them from each routine prompt. The agent will apply them on every run.

---

## Iteration loop

After the first week, review the conversation history of each run and update:
- `memory/strategy.md` — anything you want it to do differently
- Routine prompts — if the agent is doing unnecessary steps or missing something
- CLAUDE.md — if there are global rules to clarify

The agent gets better as you refine its memory files.
