# Multi-Model Vibe Coding: Claude Code + Gemini

A practical setup for splitting work across Claude Code (Anthropic) and Gemini (Google) based on what each model does best.

---

## The split

| Task | Model | Why |
|---|---|---|
| UI design, visual landing pages | Gemini 3.1 Pro High (in anti-gravity) | Stronger at design-specific applications, cinematic output |
| Backend logic, code cleanup, architecture | Claude Opus (in Claude Code) | Better reasoning, more reliable code edits |
| Quick one-off tasks | Gemini Flash or Claude Haiku | Fast and cheap |

Models are hot-swappable. No need to commit to one — swap based on the task at hand.

---

## IDE setup (anti-gravity / Cursor-style)

The IDE has three panes:
- **Left** — file explorer (treat it like Finder/Explorer; AI manages most files for you)
- **Center** — code editor (rarely need to touch this directly)
- **Right** — agent chat panel (where you spend most of your time)

The agent chat on the right is just a wrapper around whichever model you pick. Swap models from the model picker at the bottom of the chat panel.

For Claude Code specifically: install it as an extension, then open a separate Claude Code panel. Keep them side by side — Gemini panel for design, Claude Code panel for backend.

---

## Conversation modes

| Mode | Use when |
|---|---|
| **Planning** | Starting a new feature or page — forces the model to think and present a plan before touching files |
| **Fast** | Quick one-off edits (rename a file, change a variable, reformat something) |

Always start with Planning for anything non-trivial. You can reject the plan and redirect before the model writes a single line.

---

## Workspace rules (CLAUDE.md / gemini.md)

Drop a file called `CLAUDE.md` (for Claude) or `gemini.md` (for Gemini) in your project root. It acts as a persistent system prompt for every conversation in that folder.

Example structure for a design-heavy rule:

```markdown
Your role is to act as a world-class senior creative technologist and lead front-end engineer.
You build high-fidelity, cinematic, pixel-perfect landing pages.

Every site you produce should feel like a digital instrument. Eradicate generic AI patterns
(standard hero → 3-column features → CTA). Use a vastly different structural layout based
on the chosen archetype.

When the user asks you to build something, immediately ask:
1. Brand name
2. Core thesis (one sentence)
3. Aesthetic archetype
4. Structural typology
5. Three core pillars
6. Ultimate conversion goal
```

Rules can be global (apply to all projects) or workspace-scoped (only this folder).

---

## Website generation prompt pattern

For landing pages, store a detailed generation prompt in `gemini.md` and then just say `build me a website`. The prompt handles:

- Aesthetic archetypes (e.g., brutalist, cinematic dark, minimal glassmorphism)
- Structural typologies (bento grid, split screen, infinite horizontal, linear narrative)
- Tool preferences (Tailwind, specific icon libraries, animation libraries)
- Q&A flow to gather brand info before generating

The model runs through its Q&A, gets your answers, then builds in one shot.

---

## Voice dictation

Average typing speed: 50–80 WPM. Average speaking speed: 150–200 WPM.

Use your IDE's built-in voice input (or a tool like Whisper Flow) to dictate prompts instead of typing them. The model transcribes and treats it identically to typed input. Significant speedup for longer, more detailed prompts.

---

## Workflows / skills

You can define reusable workflows (sequences of steps) that the agent runs on demand. Example: a code review workflow that:

1. Reads a reference security checklist
2. Goes through each item against your codebase
3. Makes small, incremental changes
4. Asks you to test before anything is pushed

Trigger it by saying: *"Run the code-review workflow."*

Store workflows in your agent's rules/skills folder. Slash-trigger them from the chat input.

---

## MCP servers

MCP servers are pre-built workflow bundles for specific tools — someone else wrote the step-by-step process so you don't have to. Examples:

- **CloudSQL for PostgreSQL** — translates natural language into SQL queries
- **GitHub MCP** — predictable git operations from chat
- **Stripe MCP** — payment-related workflows
- **Neon** — serverless Postgres operations

In practice: useful when you're connecting to a specific service repeatedly. Overhead isn't worth it for one-off tasks.

---

## Debugging and steering

When the model drifts:

1. **Stop immediately** — don't let it keep building in the wrong direction.
2. **Describe what went wrong specifically** — not "this is bad", but "this section uses a three-column layout, I explicitly said no standard layouts."
3. **Restate the constraint** — pull from your rules file if needed.
4. **Use Planning mode** — get a new plan before it writes anything.

For bigger resets: edit your `CLAUDE.md`/`gemini.md` rule directly to close the gap that caused the drift, so it doesn't happen again.

---

## Iteration loop (typical session)

```
1. Set/confirm rules in CLAUDE.md
2. Describe the feature in Planning mode
3. Review the plan — redirect if needed
4. Approve → model builds
5. Test in browser
6. Prompt specific changes in Fast mode
7. Repeat from step 5 until done
8. Run security/code-review workflow
9. Deploy
```

---

## Economics

Rough cost comparison:

| Option | Monthly cost | Hours/day |
|---|---|---|
| Senior developer (US) | $20,000–$30,000 | 8 |
| Claude Max + Gemini Pro | ~$200 | 24 |

The models improve every few weeks. ROI compounds.

Pricing tiers (Claude Code, as of mid-2026):
- **Pro** — $17/month (entry point for Claude Code access)
- **Max** — $100+/month (higher usage limits, more parallel sessions)
