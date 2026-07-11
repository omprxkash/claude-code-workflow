# Four Upgrades That Make Claude Code Actually Make You Money

Claude's default behavior is tuned to make you feel productive. It is not tuned to make you money. These are different things. Four upgrades fix the specific design habits that quietly work against output quality and speed.

---

## The core problem

Your income from Claude Code is capped by two things:
1. Quality of output
2. How fast you produce it

By default, Claude is agreeable (sycophantic), doesn't check its own work, gets dumber as the conversation grows, and can only move as fast as you can review. Each upgrade targets one of those.

---

## Upgrade 1 — Make it challenge you, not agree with you

**The problem:** Claude agrees with you ~88% of the time even when you're wrong. This is documented — researchers call it "sycophancy." It gets worse the longer the conversation goes and the more Claude knows about you (personalization and memory make it more agreeable, not more honest).

**The fix:** Before Claude builds anything, run a council of adversarial personas that stress-tests the idea from different angles.

**The `/roast` skill:**

Spins up five sub-agents with distinct roles:

| Persona | Job |
|---|---|
| Contrarian | Finds fatal flaws only |
| Expansionist | Finds the biggest upside |
| First principles | Pure logic, no outside context |
| Deep researcher | Pulls real market data and competitor pricing from the web |
| Buyer | Role-plays as your customer — says whether they'd actually buy it |

A sixth agent (the Judge) takes all five findings and delivers one verdict: **green light**, **reshape**, or **kill**. It also gives you the single cheapest test you can run in the next 48 hours to validate before writing any code.

**Example output (for a $9/month YouTube-to-LinkedIn-posts tool):**

> Kill the product exactly as described. It's a free, no-login commodity wrapped in a subscription that's structurally built to churn. But keep the engine and aim it at a narrow paying niche — the moat is provable voice matching and direct scheduled posting.

Scores: Contrarian 2/10, Expansionist 8/10, Buyer 2/10. Verdict: reshape.

Compare that to asking Claude directly "do you think this will work?" — you get generic, agreeable advice with no actionable direction.

**The method matters more than the skill.** Even without `/roast`, always have something challenge your idea from multiple perspectives before you build.

---

## Upgrade 2 — Make it verify its own work

**The problem:** Claude handing you something "finished" and that thing actually working are not the same. ~40% of AI-generated code has security vulnerabilities (NYU study, GitHub Copilot). And Claude will confidently tell you something is done when it isn't — silently failing automations, half-sent email batches, broken form handlers.

**The fix:** Bake a verification loop into your build prompts. Two parts:

### Part A — Verify during the build

After building, before reporting done:

```
Do not trust that it looks right. Verify with Playwright CLI:
- Start the local server
- Screenshot each section at desktop and mobile viewports
- Look at the screenshots
- Iterate until: every section is screenshotted, no visible errors, the form looks clean
Only stop when all of that is true.
```

The model runs Playwright, takes screenshots, looks at them, and loops until it passes — not until it decides it probably passes.

**Bake the check into the to-do list itself, not just the prompt.** Claude builds
its plan as a to-do list and works through it item by item. If "verify" is only a
sentence in your original prompt, it can get lost by the time the last item is
checked off. Make verification its own explicit to-do item — "build the form,"
then "screenshot the form and confirm it renders correctly," then "open Chrome
DevTools and confirm no console errors" as separate, checkable steps — so
verification is a tracked part of the plan Claude is visibly working through, not
an afterthought it might skip under time pressure.

### Part B — Stress test after the build

```
Use Playwright CLI with a headed browser. Submit the form multiple times
with different dropdown options, different email formats, edge cases
(spaces before email, malformed inputs, duplicate submissions).
Report what passed and what failed.
```

This surfaces things you wouldn't think to test manually:
- Same email can join twice (no duplicate guard)
- Email validation is structural only, not deliverability — fake emails pass
- Edge cases around spaces, special characters

**What "verification loop" looks like in a prompt:**

```
After you build, run a verification pass. Screenshot every section at
1440px and 375px. If anything looks off, fix it and re-screenshot.
Only declare done when: all sections are screenshotted at both viewports,
no visible errors, the form is clean.
```

The output isn't just asserted — it's evidenced. You get a folder of screenshots, a pass/fail report, and specific non-blocking notes.

---

## Upgrade 3 — Manage context so Claude stays sharp

**The problem:** Context rot. Every one of 18 tested AI models (including Claude) degrades in performance as the conversation grows — even on simple tasks. The drop-off starts well before the context window fills up. More context = dumber Claude.

Claude's context is like a desk. Pile enough paper on it and finding one document takes much longer.

**The fix:** Treat context as a resource, not an afterthought.

### Commands worth knowing

| Command | What it does |
|---|---|
| `/context` | Shows what's in your context window and how many tokens each item uses |
| `/clear` | Wipes everything — fresh start |
| `/compact` | Summarizes and compresses the conversation in-place |

### The `/session-handoff` skill

Better than `/compact`. Before clearing, run session handoff. It writes a structured summary:

- What we're working on
- Decisions that are locked
- What shipped
- Key files (where things live)
- Running state and open questions
- Exactly where to pick back up

Then: copy the output → `/clear` → paste it in. You're in a clean window with full project context. No information lost.

You can also use session handoff to hand off to a different model (Opus → Sonnet for cheaper tasks, or across tools entirely).

### Token budget rule of thumb

Watch your context indicator. Keep it under ~25% of your window (~250k tokens on a 1M window). Past that, start a new session via handoff.

---

## Upgrade 4 — Stop being the bottleneck: sub-agents + `/goal`

**The problem:** You can only point Claude one direction at a time. You are the bottleneck — the reviewer, the decision maker, the next instruction. Anthropic's own testing showed a lead agent coordinating parallel sub-agents outperformed a single agent doing the same work sequentially by over 90%.

**Sub-agents:** Each sub-agent gets its own task and its own clean context window. They run in parallel, independently, and report back. No shared context rot. No serialized waiting.

Use sub-agents for anything that can happen in parallel and doesn't depend on the others finishing first. Examples:
- One agent researching topic A, one researching topic B, one scanning comments
- One building the landing page, one writing copy, one setting up the form backend
- One per deliverable in a go-to-market kit

**The `/goal` command:** Set a finish line — a specific, objective completion condition. Claude works turn after turn until the condition is met. A separate evaluator (a second model with a different persona) checks each turn to see if done = true. Claude doesn't get to declare itself done. The judge is independent.

```
/goal
Build a complete go-to-market kit for [product]. Save in this project.
Use parallel sub-agents, one per deliverable. Each has its own context.
Deliverables: positioning.md, market-research.md, launch-plan.md,
outreach-templates.md, outreach-drafts.md (25 drafts), content-calendar.md

Done when: all six files exist and are non-empty, market research has 6+
competitors, outreach drafts has 25 drafts, no file is thin or generic.

After sub-agents finish, run a verification pass yourself — open each file,
confirm it meets the bar, fix anything thin before declaring done.
```

Eight minutes. Six files. Six parallel sub-agents. All verified before done.

### The full stack in one run

`/goal` with parallel sub-agents combines everything:
- The idea was validated first (upgrade 1 — roast)
- Each sub-agent verifies its own work (upgrade 2 — verification loop)
- Each sub-agent runs in a clean context (upgrade 3 — no context rot)
- Everything runs in parallel (upgrade 4 — not serialized on you)

---

## Summary

| Upgrade | Problem it fixes | Tool/method |
|---|---|---|
| Challenge mode | Claude agrees with everything | `/roast` skill — adversarial council |
| Verification loop | Outputs look done but aren't | Playwright screenshots + form stress testing baked into the build prompt |
| Context management | Long conversations make Claude dumber | `/session-handoff` before `/clear`; stay under 25% context |
| Sub-agents + goal | You're the bottleneck | `/goal` + parallel sub-agents; separate worker from judge |

Your role shifts from builder/producer to decision maker, reviewer, and judge. That's the leverage point.
