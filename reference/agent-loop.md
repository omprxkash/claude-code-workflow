# The agent loop

Every AI agent — Claude Code, Codex, Gemini — runs the same loop regardless of the harness. Understanding it is what lets you work with agents instead of against them.

---

## The three-step loop

```
Observe → Think → Act → (repeat)
```

**Observe** — The agent reads its full context: previous messages, tool results, files it was told about, system prompts, skills, memory files. Every loop, it re-reads all of this.

**Think** — Based on the context, the agent reasons about what to do next. Most modern platforms expose this as a "thinking" or "reasoning" step you can click into. This interpretability is one of Claude's strongest points — you can see the decision being made and steer or stop it.

**Act** — The agent calls a tool (bash, file read, web search, API call) or outputs a final response. The result of the tool call feeds back into the next Observe step, growing the context slightly each loop.

The loop runs until the **definition of done** is reached — a series of constraints that tell the agent to stop and output a final result. Without a clear definition of done in your prompt, agents will either loop too long or stop too early. Make it explicit.

---

## PTMRO — the five agent components

Beyond the loop, agents have five components you can optimize:

| Letter | Component | What it does | How to optimize |
|---|---|---|---|
| **P** | Planning | Breaks high-level goal into executable steps | Spend human time here — planning errors compound. Use plan mode. Provide your own structure when the task is complex. |
| **T** | Tools | How the agent interacts with the world (bash, APIs, file I/O, browser) | Standardize tools as skills. Prefer CLIs over MCP for token efficiency. Build tools for repeated tasks. |
| **M** | Memory | How the agent retains context across loops and sessions | Use files. `CLAUDE.md` is always-loaded memory. Hot cache files (`hot.md`) for recent context. Skills as procedural memory. |
| **R** | Reflection | Agent evaluates and corrects its own output | Give it a way to check its own work. Playwright for UI verification, test runners for code, /compact for context quality. |
| **O** | Orchestration | Coordinating multiple agents or complex workflows | Sub-agents for parallel work. Assembly-line sessions for sequential phases. Routines for scheduled runs. |

---

## Self-modifying instructions

One of the highest-ROI patterns for any agent setup: have the agent update its own instructions when it makes a mistake or learns something.

**How it works:**
1. Add a "Lab notes" or "Learned rules" section to your `CLAUDE.md` or `agents.md`
2. Include a meta-instruction: *"When you make a mistake or find a better approach, append a one-line bullet to the Lab notes section. Keep each under 15 words."*
3. Each session, the agent starts with more accumulated knowledge
4. Over 5-10 sessions, errors specific to your preferences and project drop significantly

The math: if error rate starts at 30%, and the agent adds 2-3 learnings per session, by session 5 you're operating with dramatically tighter outputs — because the 80% of the search space that didn't work has been ruled out.

**The global/local split:**
- `~/.claude/CLAUDE.md` (global) — your preferences across all projects. High-level reasoning strategies, personal communication style, who you are. Run `/insights` to generate candidates for this.
- `CLAUDE.md` in a project folder (local) — project-specific knowledge, architecture, failure log for this codebase. Run `/init` to auto-generate from an existing project.

---

## Platform comparison

All three major platforms run the same loop with minor differences:

| | Claude Code | Codex (OpenAI) | Gemini (Antigravity) |
|---|---|---|---|
| Reasoning interpretability | Best — reasoning tab is explicit, steer-able in real time | Less visible | Least interpretable |
| Frontend / design | Good (use Hyperframes or the taste skill) | Decent | **Best** — cleanest output, isomorphic glass aesthetic |
| Backend / engineering | Strong | **Best** — strongest at test-driven development, mathematics | Strong |
| Video / multimodal | Limited (custom pipelines needed) | Limited | **Best** — native video endpoint in the API |
| Speed | Slower without fast mode; fast mode burns credits | Fast by default | Fast output mode available |
| Feel | Consistent, partners with you | Fires and goes autonomously | Inconsistent but powerful highs |

**Rule of thumb:** Claude for orchestration and complex reasoning. Gemini for frontend design and video tasks. Codex for backend-heavy or test-driven work. None of these differences are large enough to matter for most tasks — pick one and get good at it.

---

## Tools: the agent's hands

Without tools, an LLM is intelligence in a jar — it can reason but not act. Tools are what break it out:

- **Code execution** (bash, Python) — run scripts, process files, call CLIs
- **File I/O** — read, write, create, organize files in the workspace
- **Web search** — research, real-time data, documentation
- **API calls** — connect to external services (Stripe, ClickUp, Gmail, etc.)
- **Browser control** — Playwright, computer use — navigate UIs, fill forms, screenshot

Tool quality determines agent quality. Standardize tools as skills so the same tool produces the same result every time. Prefer CLI tools over MCP servers — they use 60-70% fewer tokens because nothing loads into context until you run them.

---

## Agent vs chatbot

A chatbot is intelligence in a box — it answers, you copy the answer somewhere else, you execute.

An agent is intelligence with hands — it plans, acts, checks its work, adjusts, and delivers a result. The interface (a chat window) looks the same. What lives inside is different.

The key unlock: the agent's ability to parallelize. One model running one task is fast. Ten models each running a different part of the task simultaneously is a different category of speed.
