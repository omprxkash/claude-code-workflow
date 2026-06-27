# Skill templates

A skill is a folder with a `SKILL.md` (plus optional supporting files) that Claude
loads when its description matches the task. Full explanation:
[../../docs/02-customization/skills.md](../../docs/02-customization/skills.md).

## Install

Copy a skill folder into `.claude/skills/` in a project, or `~/.claude/skills/` to
have it everywhere.

## In this folder

- [`polished-infographic/`](polished-infographic/) — an example skill showing the SKILL.md structure. The `description` frontmatter field is the key: it's what Claude reads to decide when to reach for the skill, so write it as a trigger condition.

For a full working example with 26 real skills (lead scraping, cold email, Gmail, YouTube, video editing, deployment, and more), see [`templates/claude-md/skills-system.md`](../claude-md/skills-system.md) and the [skills catalog](../../reference/skills-catalog.md).

## Build your own

The best skills come from your own work: do a task manually a few times, and when you
hit output you love, tell Claude "turn that into a skill." Then refine the
`SKILL.md`, especially its description.
