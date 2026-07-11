# Skills

All Claude Code skills in one place. Copy a folder into `.claude/skills/<name>/` in your project — or `~/.claude/skills/` to have it everywhere.

---

## General skills

Nine installable skills that work out of the box. Two need a kie.ai API key (noted below).

| Skill | What it does | Cost |
|---|---|---|
| [`skill-builder/`](skill-builder/) | Meta-skill: interviews you and builds/audits other skills | Free |
| [`agent-builder/`](agent-builder/) | Meta-skill: interviews you and builds/audits sub-agent configs | Free |
| [`grill-me/`](grill-me/) | Relentless structured interview — extracts knowledge, saves to context files | Free |
| [`session-handoff/`](session-handoff/) | Pre-`/clear` snapshot — handoff doc so the next session picks up exactly where this one left off | Free |
| [`excalidraw-diagram/`](excalidraw-diagram/) | Generates editable `.excalidraw` files (open at excalidraw.com) | Free |
| [`excalidraw-visuals/`](excalidraw-visuals/) | Hand-drawn-style PNG images via Nano Banana API | ~$0.02–0.09/image |
| [`nano-banana-images/`](nano-banana-images/) | Hyper-realistic photo generation via structured JSON prompting | ~$0.04–0.09/image |
| [`frontend-design/`](frontend-design/) | Distinctive, production-grade frontend code — avoids generic AI aesthetics | Free |
| [`video-to-website/`](video-to-website/) | Turns a video file into a scroll-driven animated website (GSAP + canvas) | Free |

**Two skills need a kie.ai API key** — see each folder's `SKILL.md` or `README.md` for exact setup:
- `excalidraw-visuals/` — `KIE_AI_API_KEY` in `.env`
- `nano-banana-images/` — `KIE_API_KEY` in `.env`

---

## Automation skills

27 business-automation skills built on the WAT framework — lead gen, cold email, Gmail, YouTube, video editing, research, deployment, and more. See [`automation/`](automation/) for the full list and install instructions.

These require API keys specific to each integration (Apify, Instantly, Pinecone, etc.). See [`reference/skills-catalog.md`](../reference/skills-catalog.md) for all required env vars.

---

## Install

```
# Copy a single skill folder into your project
your-project/.claude/skills/<skill-name>/

# Or globally, for use in every project
~/.claude/skills/<skill-name>/
```

Then type `/<skill-name>` in Claude Code to confirm it's loaded.

---

## Full catalog

[`reference/skills-catalog.md`](../reference/skills-catalog.md) — every skill with its description and required env vars.
