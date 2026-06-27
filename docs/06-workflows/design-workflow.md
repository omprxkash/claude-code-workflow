# Designing with Claude Code

Claude Code has gotten genuinely good at building polished, "award-winning-looking"
websites and UIs — most high-end designs you'd admire are reproducible in well under
an hour. The trick is knowing *how* people drive it. There are three main approaches.

## 1. The screenshot-compare loop

This is the most reliable way to match a specific look. You give Claude a target
design and the ability to screenshot its own output, and you let it close the gap
iteratively:

1. Claude builds a first version — usually an ~80% match.
2. It screenshots that version and compares it directly to the source image.
3. It lists the differences, fixes them, and gets to ~90%.
4. Repeat → ~95% → ~99%. It rarely hits a perfect 100%, but it gets very close.

The practical pattern: take an inspiration site, use it to template the design
*fundamentals* — type scale, colors, button styles, spacing — then swap the
**content** for your own. You keep the craft of the reference and make it your site.
The [Playwright skill](../../reference/skills-catalog.md) is useful here for driving
the browser and capturing screenshots.

## 2. The design-skill approach

Instead of chasing a specific reference, lean on a [skill](../02-customization/skills.md)
that encodes good design judgment — a **front-end design** skill being the obvious
one. You tell Claude to invoke it whenever you're building UI, and the baseline
quality of everything it produces jumps. This is best when you want consistently
good design rather than a pixel match of one particular site.

Pair it with curated design references (e.g. motion/interaction principles — see
[resources](../../reference/resources.md)) to push quality further.

## 3. The spec / CLAUDE.md approach

Bake your design system into the project's
[`CLAUDE.md`](../01-core-concepts/claude-md.md): the palette, fonts, spacing scale,
component conventions, brand rules. Then every build starts already on-brand without
you re-explaining. This is how you get consistency across many pages or a whole
product, and it's the approach that scales best once you've settled your style.

## Which to use

| Goal | Approach |
|---|---|
| Match a specific design closely | **Screenshot-compare loop** |
| Consistently good design, no fixed target | **Design skill** |
| On-brand consistency across many pages | **Spec in CLAUDE.md** |

These combine well: a `CLAUDE.md` design system *plus* a design skill *plus* a
screenshot pass for the one hero section that has to be perfect.

## Brand assets

Whichever approach, feed Claude your real assets and tag them in the prompt with
`@filename` — logo, brand guidelines, color tokens. That's the difference between
"a nice generic site" and "*my* site." The
[newsletter recipe](recipe-newsletter-automation.md) shows this end to end with a
logo and brand guidelines driving every visual.
