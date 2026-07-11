# Skills

Skills are how you make Claude Code reliably *good* at a specific kind of task. A
skill is essentially a system prompt (plus optional supporting files) that Claude
**loads only when it's relevant** — the same way it decides whether to reach for a
tool.

## The mental model

When you ask for something, Claude scans the skills it has access to and asks, for
each one, *"does this request need this?"* If yes, it pulls that skill's
instructions into play. So a skill is dormant until its moment, then it sharpens
Claude for exactly that job.

The classic example: a **front-end design** skill that makes Claude noticeably
better at building good-looking websites. On any project where you need quality UI,
you tell Claude to invoke it, and the output jumps in quality. The
[skills catalog](../../reference/skills-catalog.md) lists the ones worth knowing.

Skills vs. [slash commands](slash-commands.md): a command is something *you* fire
deliberately by typing `/name`; a skill is something *Claude* invokes when it
recognizes the need (you can also tell it to). Commands are for your routines; skills
are for capabilities you want the agent to reach for on its own.

## Structure of a skill

A skill is a folder with a `SKILL.md` at its root and any supporting files it needs:

```
my-skill/
├── SKILL.md          # the instructions + frontmatter
├── reference.md      # optional: extra detail Claude can pull in when needed
└── scripts/          # optional: helper scripts the skill can run
```

The `SKILL.md` carries frontmatter — crucially a **name** and a **description**. The
description is what Claude reads to decide whether the skill is relevant, so write it
to clearly state *when* to use the skill, not just what it is:

```markdown
---
name: polished-infographic
description: >
  Use when generating an infographic or data visual. Produces clean, on-brand
  graphics with the logo placed top-left and the brand palette applied.
---

# Polished infographic

When asked to create an infographic:
1. Pull colors and fonts from the brand guidelines.
2. Place the logo in the top-left corner.
3. Prefer SVG or chart-based visuals over raw image generation for anything with
   text or precise data.
4. ...
```

Skills live in `.claude/skills/` (project) or `~/.claude/skills/` (personal). This
repo ships a minimal example in [`skills/automation/polished-infographic/`](../../skills/automation/polished-infographic/), and
six real, ready-to-install skills in [`skills/`](../../skills/) — diagram and image
generation, production frontend design, video-to-website, and a skill-builder
meta-skill that interviews you to build new ones.

The frontmatter fields above (`name`, `description`) are the two you'll always set.
There are several more — `disable-model-invocation`, `allowed-tools`,
`argument-hint`, `model`, per-skill `hooks` — for finer control over how and when a
skill can be invoked. Full field-by-field reference:
[`skills/skill-builder/reference.md`](../../skills/skill-builder/reference.md).

## Debugging a skill that isn't working well

| Symptom | Fix |
|---|---|
| Does the steps in the wrong order, or skips some | Edit the step-by-step instructions in `SKILL.md` directly |
| Missing tone, style, or business context | Add a reference file and point to it from `SKILL.md` |
| Same mistake happens repeatedly | Add an explicit rule to `SKILL.md` — don't just fix it once and hope |
| Keeps re-searching for the same info, or struggles with a tool/MCP | Give it a reference doc for that tool instead of relying on it to rediscover the same thing every run |
| Works, but the output quality plateaus below what you want | No shortcut — run it repeatedly and keep refining based on what's actually wrong each time |
| Skill doesn't trigger when you expect it to | Check the `description` in the frontmatter — it's probably not specific enough about *when* to use it |
| Skill triggers too often / on requests it shouldn't handle | Set `disable-model-invocation: true` so it's only reachable by explicit `/skill-name` invocation, not automatic matching |

## Why skills are cheap: progressive loading

Skills are evaluated in three levels of progressive context loading, which is why
you can have dozens installed without paying for them:

1. **Frontmatter only (~100 tokens)** — every conversation, Claude reads just the
   name + description of each skill to know what's available.
2. **Full SKILL.md (1k–2k tokens)** — loaded only when the skill is actually
   invoked.
3. **Supporting files** — `reference.md`, scripts, style guides — loaded only if
   the skill's instructions point Claude at them mid-task.

This is also why you keep raw code and long reference material *out* of SKILL.md
and in supporting files: level 2 stays cheap, and level 3 is pay-per-use.

## Which skills stay valuable

Two kinds of skills age very differently:

- **Capability-uplift skills** ("make Claude better at design/code/writing") tend
  to fade as base models improve — what needed a skill last year the model now
  does natively.
- **Encoded-preference skills** (your exact sequence, your brand rules, your file
  locations, your API quirks) stay durable — no model update can know that your
  drafts go in `/drafts` or that your infographics need the logo top-left.

The reason this distinction matters practically: it's exactly what tells you when to
retire a skill vs. keep investing in it. Run an eval periodically (see below) —
if a capability-uplift skill stops showing measurable uplift after a model update,
archive it. Encoded-preference skills won't hit that wall on their own.

## Evaluating a skill (the `skill-creator` plugin)

Anthropic ships an official `skill-creator` plugin (`/plugins` → search
"skill-creator") that does more than scaffold new skills — it can systematically
evaluate existing ones:

- **Benchmarking** — run the skill with and without being loaded, side by side, and
  compare pass rate, time, and token usage. This is how you get an actual number for
  "does this skill help" instead of a gut feeling.
- **Regression detection** — as base models change, a skill that used to help can
  start hurting (the model now "thinks" differently and the old instructions fight
  it). Periodic evals catch this before you notice quality silently dropping.
- **Spotting when a skill is no longer needed** — the flip side of regression: if an
  eval shows the model now performs *as well without* a capability-uplift skill,
  that's your signal to archive it and stop paying its context cost.
- **Trigger tuning** — if a skill fires too often, too rarely, or gets confused with
  another skill, the plugin can test various phrasings against the skill's
  `description` and rewrite it for more accurate auto-invocation, without you having
  to manually guess at wording.

Worth running whenever you have several skills in one project and start noticing
misfires, or after a significant model upgrade.

When deciding what to build, bias toward encoding *your* preferences and
procedures, not general quality boosts.

## Building your own

The best skills come from noticing a pattern in your own work. The flow I use:

1. Do the task manually a few times with Claude until you know what "good" looks
   like.
2. When you find an output you love, tell Claude *"turn that into a skill."*
3. Refine the `SKILL.md` — especially the description, so it triggers at the right
   times.
4. Reuse it. Now every future request of that kind starts from your best version.

The newsletter build in the [recipe](../06-workflows/recipe-newsletter-automation.md)
is a perfect example: once you know exactly how you like infographics to look,
capture it as a skill so every future infographic is consistent.

## Skills + the WAT framework

Skills pair naturally with the [WAT framework](../06-workflows/wat-framework.md).
WAT gives you reusable *workflows and tools*; skills give the agent reusable
*judgment* for sub-tasks (how to design, how to write, how to format). Together they
make outputs both reliable and high-quality.

## Next

- [Subagents](subagents.md) — turning a capability into a scoped, separate worker.
- [Skills catalog](../../reference/skills-catalog.md)
