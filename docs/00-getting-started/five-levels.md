# Five levels of Claude mastery

A progression map from first-time user to production architect — what each level looks like, what unlocks it, and what its ceiling is.

---

## Level 1 — Enthusiast

**What it looks like:** You open Claude, ask a question, get an answer, close the tab. Maybe you have it help write an email or explain something you read. That's it.

**Quick upgrade most people miss:** Paste screenshots. Claude can read images. Half the people stuck at level 1 are typing out what a screenshot would show in two seconds.

**Why people stay stuck here:** They don't realize Claude can hold context across conversations, organize work into projects, or connect to the tools they already use. They treat it like a search bar that returns paragraphs.

**Output:** ~30 minutes saved per day on small things.

---

## Level 2 — Beginner

**Cheat code to get here:** Create your first project. Pick something you keep coming back to — your business, a side hustle, recurring work. Drop in a few reference docs, write a quick system prompt about who you are and how you want Claude to respond. Every chat inside that project now starts preloaded.

**Six features that define this level:**

1. **Memory + past chat search** — Claude remembers your role, preferences, decisions made weeks ago. Search past chats is a paid feature; combined with a project knowledge base, it ends "starting from zero" permanently.

2. **Connectors** — Slack, Google Drive, Gmail, GitHub, Notion, Calendar, 50+ more. Click the plus button, sign in with OAuth, done. Stop pasting — start asking Claude to summarize threads, pull specs from Drive, or check your calendar.

3. **File creation** — Claude can create real Excel spreadsheets with working formulas, PowerPoint decks, Word docs, and PDFs directly from chat. Not just previews — actual files you can send to a client. Free users have this too.

4. **Artifacts with persistent storage** — The side panel where Claude builds interactive things. At this level: artifacts that remember data between sessions, call Claude's API directly (so the app can think for itself), and publish with a public link. A non-coder can build a working customer feedback tracker in a conversation and share it with their team.

5. **Inline visuals** — When a chart would explain something better than text, Claude just builds one in the conversation. Click it, swap the chart type, add variables, update live. Drop a CSV and ask Claude to visualize it. Ephemeral — they live in the chat, not as files.

6. **Microsoft Office add-ins** — Claude lives inside Excel, PowerPoint, and Word as native add-ins. Excel: reads multi-tab workbooks, explains formulas with cell-level citations, edits assumptions while preserving dependencies. PowerPoint: reads your existing slide master and builds on-brand slides. As of April 2026, all three share context across apps — analyze data in Excel, switch to PowerPoint, Claude builds the deck using that analysis.

*Free vs paid at this level:* Memory, file creation, and inline visuals work for everyone. Past chat search, persistent artifact storage, and Office add-ins require Pro+.

**Output:** 5+ hours saved per week. Claude starts paying for itself.

**Ceiling:** Claude can't actually do things on your machine. You're still copying outputs into other tools and executing changes yourself.

---

## Level 3 — Intermediate

**Cheat code to get here:** Stop trying to make chat do everything. Open Claude Desktop and click the Co-work tab.

**What changes:** Claude can now read and write real files on your machine. Point it at your downloads folder — three months of chaos — and it sorts everything, renames consistently, and writes you a summary while you make coffee.

**Five features that define this level:**

1. **File system access** — Co-work runs in an isolated VM but with real read/write access to whatever folders you grant. It can't touch what you don't give it, but what you do give it, it fully owns.

2. **Skills** — Reusable workflows defined as simple markdown files. Write "weekly client reporting" once, invoke it forever. 100+ skills are already published: 16+ official ones from Anthropic plus a community marketplace. Front-end design, PDF manipulation, Excel work, document creation, marketing, accounting, advertising. Install with one command, customize from there. Skills work across Co-work, chat, and Claude Code — build once, run anywhere.

3. **Scheduled tasks** — Type `/schedule` in any Co-work conversation. Claude saves the task to run on a cadence you pick. Daily stand-ups, weekly competitor briefs, monthly reports. Requires computer awake and desktop app open (for always-on, see Level 5 routines).

4. **Mobile dispatch** — Pair your phone with your desktop using Dispatch. Send tasks from anywhere — commuting, gym, meetings — and Claude works on your desktop while you're away. Pings you when done.

5. **Claude Design** — A separate Anthropic Labs product included with Pro. Describe a prototype, slide deck, or landing page in plain English. Claude builds and designs it. Two things make it different: (1) it can read your entire brand — GitHub repo, codebase, design files, brand guidelines — and build a design system that applies to every project automatically; (2) when done, it packages everything into a handoff bundle for Claude Code, Canva, or just a zip.

**Output:** 10+ hours saved per week. First level where non-coders can sell automation as a service.

**Ceiling:** Co-work is safe and friendly, but less precise than what comes next. When you need real version control, engineering rigor, or systems clients would pay $5,000+ for, you outgrow it.

**Setup that unlocks the next level:** Create a folder structure Claude can rely on — `about-me.md`, `templates/`, `projects/`, `outputs/` — and tell Co-work about them once. That structure is what makes it feel like an actual co-worker instead of an unpredictable assistant.

---

## Level 4 — Advanced (Claude Code)

**What changes:** You're in the terminal (or Code tab in Claude Desktop — same engine). Boris Chernny, who built Claude Code at Anthropic, runs five Claude sessions in parallel at minimum every single day, each in its own isolated workspace, and comes back to multiple completed pull requests.

**Five things that make level 4 click:**

1. **CLAUDE.md** — A markdown file in your project folder that Claude reads at the start of every session. Tech stack, naming conventions, who you are, what the project is. Keep it under 200 lines — it loads on every message so every wasted line is a tax. Push detail into separate files and reference them with `@filename`. Key habit: when Claude makes a mistake, say "update your CLAUDE.md so this never happens again." After a few weeks, it trains itself on how you work.

2. **Plan mode** — Shift-Tab twice to enter plan mode. Claude reads the code, presents a plan, waits for approval, asks questions. Hidden setting: **Opus Plan** — Opus does the planning, Sonnet does the execution. Smart model where it matters, cheap model for grunt work. Cuts cost in half without losing quality.

3. **Sub-agents** — Specialized Claudes for specialized jobs: one for tests, one for security review, one for docs. Each runs in its own context window so the noise of the main session doesn't pollute the sub-agent. Run multiple in parallel. You're effectively building a small engineering team.

4. **Worktrees** — `claude --worktree feature-name` spins up an isolated git workspace on its own branch. Open another terminal, do it again. Two to four Claude instances working simultaneously, files never overwriting each other. Three or four is the comfortable sweet spot.

5. **MCP — but with the right mental model** — MCP lets you plug any external tool into Claude. But Anthropic's own docs say: when a CLI exists for the job, use the CLI instead of MCP. CLIs use 60-70% fewer tokens than equivalent MCP servers because nothing loads into context until you run it. Rule: CLI first → API endpoints → skills → MCP only when nothing else fits.

**Power moves at this level:**

- **`/compact` at 60%, not 95%** — Autocompact triggers at 95% when context is already degraded. Run `/context` to check your percentage and compact proactively. After 3-4 compacts in a row, quality degrades; at that point, do a session summary, `/clear`, paste back, continue.
- **`/context` and `/cost`** — See exactly where your tokens are going. Running `/context` in a fresh session shows you what overhead exists before you've even typed a message (system prompt, tools, MCPs, memory files).
- **Status line** — Run `/statusline` in the terminal to see your model, context percentage, and token count at a glance. This is how you pace yourself.
- **The 5-minute cache rule** — Anthropic's prompt cache has a 5-minute TTL. If you step away longer than 5 minutes, your next message reprocesses everything from scratch. Before stepping away: `/compact` or `/clear`.
- **The verification loop** — Boris says this single habit has 2-3x'd the quality of what he gets back. Give Claude a way to check its own work: Playwright browser, screenshots, running the actual output. Don't accept "done" without proof.
- **Batch prompts into one message** — Three separate messages cost three times what one combined message costs, because the model rereads the entire history each time. If Claude got something slightly wrong, edit your original message and regenerate instead of sending a follow-up correction.
- **Assembly-line sessions** — Don't do everything in one session. Research → `/clear` → draft → `/clear` → polish. Pass output from one specialized session into the next. This is how you avoid context rot on long tasks.
- **`/re`** — Escape twice. Drops a failed attempt from context entirely instead of polluting the session with corrections.
- **`/btw`** — Ask Claude a quick question mid-task without breaking the flow or adding noise to the main session history.
- **`/branch`** — Forks your current conversation at that exact point. Try one approach in the branch, jump back, try a different one. Git for your conversation. Pairs perfectly with worktrees.
- **`/insights`** — Reads your past month of usage and generates a report: what you do repetitively, where you waste tokens, what prompts to turn into skills, what to add to your CLAUDE.md. Run once a month.

**Output:** Freelance and agency work becomes $5,000-$15,000 projects. You're building real systems, real software.

**Ceiling:** Managing all parallel work manually. You become the bottleneck — firing off Claudes, watching them, switching contexts. Everything requires you to be sitting there. That's babysitting, not scaling.

---

## Level 5 — Architect

**What changes:** Your laptop is closed. Work still happens.

Someone opens a pull request on your repo. Claude sees it, spins up in the cloud, reviews the code, posts detailed feedback with suggestions. By the time you check your phone, it's done.

**Three things that make this real:**

1. **Routines** — Saved Claude Code configurations that run on Anthropic's cloud. Your machine stays off. Three trigger types: scheduled (cron), on API call, or on GitHub event. Daily backlog triage at 8am. Weekly dependency audit on Mondays. PR reviews the moment a pull request opens. See [routines.md](../05-deployment/routines.md) for the full setup walkthrough.

2. **Hooks** — Custom logic that fires at lifecycle events. Pre-tool-use hooks that block dangerous commands before they run. Post-edit hooks that auto-format every file Claude touches. Stop hooks that ping you on Slack when a long-running session finishes. These are what make the difference between a cool demo and a production system you trust with real work.

3. **Channels** — Control sessions from outside the terminal: Discord, Telegram, iMessage (on Mac). Or two-way: text Claude from your phone, it works against your real codebase. Pair with **remote control** (`/remote-control` → scan QR → your phone is now the remote, the session keeps running on your machine).

**Other tools at this level:**

- **Headless mode + Agent SDK** — Claude Code with no human session. Pass it a prompt with `claude -p`, get output back, pipe it anywhere: Slack, Datadog, another Claude agent. The Agent SDK (Python and TypeScript) lets you build products on top of Claude Code's engine.
- **Autodream** — A background sub-agent that prunes your memory files between sessions: deletes contradicted facts, merges duplicates, converts relative dates to absolute. Turns on in settings.
- **Task budgets** — Give an agent a token budget for an entire run (thinking + tool calls + output). The model regulates itself and wraps up gracefully as the budget runs out. Currently API-only; the lever for cost control on autonomous agents.
- **Agent teams (experimental)** — Multiple specialized Claudes coordinated by a lead agent. Unlike sub-agents, they can message each other, share a task list, and debate. Uses a lot of tokens — use sparingly, but powerful when you need it.

**The real stall at level 5 isn't technical.** Almost everyone can set up a routine. Most won't, because handing the steering wheel to a system that runs while you're asleep feels reckless. The fix is the same as learning to drive: start in a parking lot, not a highway. Pick a low-stakes routine — a daily stand-up summary that only goes to you, not sent externally. Watch it run for weeks. Once you trust those 10 runs, you'll trust the next 10. Roll out responsibly.

**Trust scales with determinism:** A skill that takes data from one place and puts it somewhere else is trustworthy quickly — it's predictable. An agentic skill with open-ended reasoning earns trust more slowly, but is exponentially more powerful.

---

## Which level are you at?

| Level | What you're saving | Unlock |
|---|---|---|
| 1 Enthusiast | 30 min/day | Learn to paste screenshots |
| 2 Beginner | 5+ hrs/week | Create your first project |
| 3 Intermediate | 10+ hrs/week | Claude Desktop + Co-work + skills |
| 4 Advanced | Build $5K-$15K systems | Claude Code, plan mode, worktrees |
| 5 Architect | Build 24/7 infrastructure | Routines, hooks, channels |

You don't have to master level 4 before touching level 5 concepts. But the trust you build at each level is what makes the next level safe.
