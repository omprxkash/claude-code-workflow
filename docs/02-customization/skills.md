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
