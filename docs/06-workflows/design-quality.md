# Design quality: impeccable + taste-skill

Two complementary tools that stop Claude Code from producing generic, template-looking UI.
They solve adjacent problems — use both together for the best results.

| Tool | What it fixes |
|---|---|
| [impeccable](https://github.com/pbakaus/impeccable) | Design decisions — typography, color, layout, animation rules |
| [taste-skill](https://github.com/Leonxlnx/taste-skill) | Output style — layout variance, motion intensity, visual density |

---

## impeccable

A skill + hook system that gives Claude Code (and other AI coding tools) shared design
vocabulary and 45 deterministic detector rules. The hook runs automatically on UI file
edits and surfaces violations inside the agent workflow.

### Install

```bash
npx impeccable install
```

Auto-detects your harness (Claude Code, Cursor, Codex, Copilot, etc.) and wires up
hooks. To update:

```bash
npx impeccable update
```

For teams, use a git submodule so everyone shares the same version:
```bash
git submodule add https://github.com/pbakaus/impeccable .impeccable
npx impeccable link --source=.impeccable --providers=claude,cursor
```

### Start a project

```
/impeccable init
```

This writes `PRODUCT.md` and `DESIGN.md` — the audience, brand lane, voice,
anti-references, color palette, type scale, and component inventory. All subsequent
commands read from these files.

### The 23 commands

| Category | Commands |
|---|---|
| Strategy | `shape`, `craft`, `critique`, `audit`, `polish` |
| Refinement | `bolder`, `quieter`, `distill`, `harden` |
| Enhancement | `animate`, `colorize`, `typeset`, `layout`, `delight` |
| Adaptation | `onboard`, `adapt`, `optimize`, `clarify` |

Commands accept an optional focus: `/impeccable audit the header`

### Standalone detector (no AI needed)

```bash
npx impeccable detect src/           # scan a directory
npx impeccable detect index.html     # single file
npx impeccable detect https://...    # live URL
npx impeccable detect --json .       # CI-compatible JSON output
```

### What the 45 rules catch

- **Typography**: overused fonts (Arial, Inter, system-ui defaults)
- **Color**: gray text on colored backgrounds; pure black/gray without tinting
- **Layout**: excessive nesting, cards-within-cards patterns
- **Animation**: bounce/elastic easing (dated)
- **Other**: small touch targets, skipped heading levels, line-length violations, cramped padding

Suppress a specific rule inline: `<!-- impeccable-disable overused-font: reason -->`

### .gitignore block

```gitignore
# impeccable-ignore-start
.impeccable/config.local.json
.impeccable/hook.cache.json
.impeccable/*.png
.impeccable/live/sessions/
.impeccable/live/previews/
.impeccable/live/cache/
# impeccable-ignore-end
```

Commit `design.json` and `critique/*.md` — those are shared artifacts.

---

## taste-skill

A Claude Code skill that adjusts three dials controlling how the agent approaches UI
generation. Install it once; it shapes every frontend task automatically.

### Install

```bash
npx skills add https://github.com/Leonxlnx/taste-skill
```

Or for a specific skill variant:
```bash
npx skills add https://github.com/Leonxlnx/taste-skill --skill "design-taste-frontend"
```

Alternatively, copy any `SKILL.md` directly into `.claude/skills/`.

### The three dials

| Dial | Range | Low end | High end |
|---|---|---|---|
| `DESIGN_VARIANCE` | 1–10 | Centered, clean layouts | Asymmetric, modern layouts |
| `MOTION_INTENSITY` | 1–10 | Hover effects only | Scroll + magnetic interactions |
| `VISUAL_DENSITY` | 1–10 | Spacious, airy | Dense dashboards |

### Variants

- **Minimalist** — clean, high whitespace, restrained motion
- **Brutalist** — raw grid, high contrast, deliberate roughness
- **Soft** — rounded, warm, gentle motion

Image-generation skills for design reference boards (websites, mobile screens, brand
kits) are included — use these to generate reference visuals before implementation.

---

## Using both together

1. Run `npx impeccable install` — wires hooks into Claude Code
2. Run `/impeccable init` — builds PRODUCT.md and DESIGN.md for your project
3. Install taste-skill — sets the output style dials
4. Build normally — impeccable hooks catch anti-patterns on every UI file edit; taste-skill shapes how the agent generates

impeccable is rule-enforcement (it catches what's wrong); taste-skill is style-setting
(it shapes what the agent aims for). Neither replaces the other.

---

## Pairs with

- [`frontend-design` skill](../../skills/frontend-design/) — anti-generic frontend generation skill already in this repo
- [Design workflow](design-workflow.md) — screenshot loop, spec-driven design
- [Vibe coding guide](vibe-coding-guide.md) — lock the visual backbone before building
