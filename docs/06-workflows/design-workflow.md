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

## 4. The voice-dump approach

For a build with no pre-existing reference design, talk instead of typing. Use a
dictation tool and just describe the site out loud — what sections it needs, what
it should say, the vibe you're going for. People talk at roughly 200 words/minute
versus 50-70 typed, so a few minutes of talking produces far more usable detail
than the equivalent typing time, and the model is good at extracting structure and
intent from a rough, unstructured transcript. This won't one-shot a finished site
the way a reference design does — expect more back-and-forth after the first pass —
but it gets you from a blank folder to a real first draft much faster than typing
out the same brief.

## Which to use

| Goal | Approach |
|---|---|
| Match a specific design closely | **Screenshot-compare loop** |
| Consistently good design, no fixed target | **Design skill** |
| On-brand consistency across many pages | **Spec in CLAUDE.md** |
| No reference design, just a mental picture | **Voice dump**, then iterate |

These combine well: a `CLAUDE.md` design system *plus* a design skill *plus* a
screenshot pass for the one hero section that has to be perfect.

## Brand assets

Whichever approach, feed Claude your real assets and tag them in the prompt with
`@filename` — logo, brand guidelines, color tokens. That's the difference between
"a nice generic site" and "*my* site." The
[newsletter recipe](recipe-newsletter-automation.md) shows this end to end with a
logo and brand guidelines driving every visual.

## Getting a reference site's CSS

When you want Claude to clone a specific site's aesthetic:

1. Open the site → F12 → **Console** → Ctrl+Shift+P → search "screenshot" → "Capture full size screenshot". Saves the whole page, not just the viewport.
2. **Resize it before feeding it in.** A full-page screenshot is often 15-20MB+ — that eats tokens and can hit upload limits. Run it through a free image resizer (50-75% scale) until it's under ~4-5MB. Slightly blurrier is fine; Claude doesn't need pixel-perfect source, it needs the layout and color info.
3. In the Elements tab, select the root element and copy the computed styles — this gives Claude the color tokens, font stack, spacing scale, and layout rules.
4. Give Claude both the (resized) screenshot and the CSS dump: *"Clone this design — here's the screenshot and here are the styles."* It reproduces the look without stealing layout or content.

## Component inspiration (21st.dev)

For individual UI components — animated backgrounds, buttons, hover effects, shaders — use [21st.dev](https://21st.dev). Find a component you like, copy its prompt/code snippet, and tell Claude to work it into a specific section:

```
Work in this background animation behind the hero text.
Because this is animated, skip the screenshot comparison loop
and just implement the code — I'll review it directly.
```

For animated elements, turn off the screenshot loop explicitly. Claude will loop trying to screenshot something it can't capture well, and over-engineer the component trying to fix a perceived visual mismatch.

## Setting up Puppeteer for the screenshot loop

Claude can do the screenshot loop natively if Puppeteer is installed in your project. Just tell it:

```
Set up Puppeteer so you can take screenshots of the local server for visual review.
```

It installs everything, configures it, and from then on references it whenever it needs eyes on the output. Screenshots go into a `temporary-screenshots/` folder by default. Clean this folder between sessions — or tell Claude to delete it at the start of a new build so old screenshots don't confuse the comparison.

## Deploy to Vercel via GitHub

The standard pipeline once the local site looks right:

1. Push to GitHub (`claude, push these changes to github repo [name]`)
2. Connect the repo to Vercel (vercel.com → add project → import repo → deploy)
3. Vercel auto-deploys on every push to main

Tell Claude explicitly: *"Don't push to GitHub until I tell you to."* That way you can iterate on localhost without auto-deploying every draft. When you're happy: *"This looks good — push to GitHub."* Vercel picks it up in seconds.

Netlify is a free alternative to Vercel — free tier, global CDN, unlimited deploy previews, deploy directly from Claude Code:

```
Make this site live on Netlify.
```

Claude handles the deployment. No manual setup needed.

---

## Animated 3D assets with Kling

When you want a video background, scroll animation, or 3D exploding view on a site — instead of sourcing stock footage, generate it.

**Tool:** [Higgsfield.ai](https://higgsfield.ai) runs Kling 3.0. ~$0.36/video (7.5 credits × $30/600 credits on the pro plan). Generate 2-3 versions, use the best one.

**Prompt patterns that work well:**

```
High-quality 3D render style video of [subject].
White background. Super high-quality. Should read like
something you'd see on a website or landing page.
5 seconds, 16:9, 1080p.
```

For an exploding view / product reveal:
```
Animation of [product] exploding outward in all directions,
both horizontally and vertically. No text. White background.
None of it should go outside the video frame.
```

For a rotating asset (globe, sphere, product):
```
[Subject] rotating perfectly on its axis. Center of mass
does not move. 5 seconds, seamless loop.
```

**After generating:** Download the MP4, drop it in your project folder, then:

```
Take [filename].mp4 and make it the background of the hero header.
Center it. Apply an inward masking gradient so the video doesn't
collide with the page background.
```

---

## Scroll animation (frame-by-frame video scrub)

For the effect where a video plays frame-by-frame as the user scrolls:

```
Take [filename].mp4 in downloads/ and create a scroll animation
immediately below the hero. As the user scrolls, move through
the video frame by frame. Write 2-3 sections of copy that appear
as we scroll through the animation.
```

Claude will:
1. Extract the video as optimized JPEG frames
2. Tie each frame to a scroll position (much faster than loading the full video)
3. Add preloading so frames appear instantly

If it's laggy: *"Make it load significantly faster."* Claude will switch to frame preloading automatically.

If the gradient looks wrong: *"The gradient at the top and bottom isn't strong enough — there's a color difference between sections. Increase the gradient strength."*

---

## The taste skill

For consistently high-end looking sites in one shot, install the community taste skill before prompting Claude to build anything:

```
Use this skill to design a high-end website about [topic]:
https://github.com/[taste-skill-repo]
```

Claude fetches the skill, internalizes the design principles (spacing, typography, luxury aesthetic conventions), and applies them before writing a single line of HTML. The output quality jump from a plain prompt is significant — the kind of site that would have cost $5,000-10,000 two years ago can be built in one shot for ~$3 in tokens.
