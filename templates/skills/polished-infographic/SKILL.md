---
name: polished-infographic
description: >
  Use when generating an infographic, chart, or data visual. Produces clean,
  on-brand graphics with the logo placed top-left and the brand palette applied.
  Trigger this whenever a task involves making a visual that contains text or data.
---

# Polished infographic

When asked to create an infographic or data visual, follow this every time so output
stays consistent and on-brand.

## Rules

1. **Brand first.** Pull colors and fonts from the project's brand guidelines (see
   `config/` or the brand assets). Don't invent a palette.
2. **Logo placement.** Put the real logo file in the top-left corner. Use the actual
   asset, not a generated approximation of it.
3. **Prefer precise formats.** For anything with text or exact data, use SVG or a
   chart library rather than raw image generation — generated images garble text and
   can't be edited cleanly. Use image generation only for decorative backgrounds.
4. **Hierarchy.** One clear headline, a single focal statistic or message, supporting
   details secondary. Don't crowd it.
5. **Legibility.** High contrast, generous spacing, readable type sizes.
6. **Consistency.** If making several for one piece, keep layout, type scale, and
   color usage identical across all of them.

## Output

A clean infographic file (SVG preferred) that matches the brand and these rules.
Confirm the logo and palette are correct before finishing.

## Notes

This is an example skill — adapt the rules to your own brand. See
../../../docs/02-customization/skills.md for how skills work.
