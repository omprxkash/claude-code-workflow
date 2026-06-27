# Recipe: Newsletter Automation

A complete walkthrough of building a newsletter automation using the WAT framework
— from one prompt to a finished, on-brand newsletter. This is what it looks like in
practice.

**What we're building:** you tell the agent a topic, it does research, structures the
content in HTML, makes it look pretty, creates a few infographics to go with it, and
sends it via Gmail — all branded to your guidelines.

## 1. Set up the project

Open an empty folder. Drop in a WAT `CLAUDE.md` from
[`templates/wat-starter/`](../../templates/wat-starter/) and tell Claude: *"read
CLAUDE.md and set up the project structure."* It scaffolds `workflows/`, `tools/`,
and `config/` and confirms what it understands.

`/clear` to start fresh before planning.

## 2. Plan in plan mode

Switch to plan mode and give a fairly ambiguous prompt on purpose — Claude will come
back and ask what it needs to know:

> I want to build a workflow which will basically be a newsletter automation. I want
> to be able to tell you that I need a newsletter about a certain topic and you will
> do research. You will structure it in HTML. You will make it look pretty and you
> will also create a few infographics to go with it. Help me figure out what tech
> stack to use here and what else you might suggest that I haven't yet thought of.

Claude will ask:

- **Research:** do you want an external search API? → choose a research provider.
- **Delivery:** a newsletter platform, or just send the HTML? → send via Gmail.
- **Brand assets:** want it on-brand? → yes, you'll provide a logo and guidelines.

It comes back with a plan. **Read the plan.** This is important — if it suggests SVG
infographics but you want AI-generated images, say so now. It also flags things you
probably didn't consider: human review checkpoint, subject line, metadata, brand
consistency. Push back on anything before you accept.

Before accepting, create a `brand_assets/` folder, drag in your logo and brand
guidelines, and tell Claude to use them:

> Make sure the whole newsletter is branded based on my logo and brand guidelines.

Tag the files directly with `@logo.png` and `@brand-guidelines.pdf` so Claude has
exact context.

## 3. Accept and let it build

Turn on bypass permissions and accept. The agent creates a to-do list and works
through it. You can work on something else and check back in. It will produce:

- **Config files** — newsletter style (colors, fonts, background) and recipients.
- **5 tools** — `research`, `generate_infographic`, `assemble_html`,
  `send_via_gmail`, `archive_to_sheets`.
- **The workflow** — a single markdown file walking through the whole process in
  plain language, with which tools to call at each step.

## 4. Add credentials

Claude leaves placeholders in `.env`. Paste in your real API keys — research
provider, image provider, Gmail — and save. Never commit `.env`.

## 5. Run it

Kick it off with one prompt:

> Write me a newsletter about agentic AI.

That's it. The agent finds the newsletter workflow and runs it: research → plan
infographics → write content → human review checkpoint (approve a subject line) →
send.

### What happens when it breaks

The first run is the one that needs your attention. Things will go wrong, and that's
fine — watch how the agent handles them.

- **Unicode encoding error** mid-run → the agent reads it and fixes it itself.
- **Image API endpoint error** → the agent investigates, searches the docs, finds
  the endpoint changed, and *updates the tool* so it won't happen again. That's the
  self-improvement loop working.
- **The first email arrives with broken HTML** → tell it in plain language: *"this
  is horrible, I can't read any of it — figure out what happened and resend."* It
  diagnoses, repairs the tool and workflow, and sends again.

You don't debug this yourself. You just describe what's wrong.

## 6. The result

From one prompt — "write me a newsletter about agentic AI" — you get a finished
email: your logo up top, your fonts and colors throughout, multiple sections with
real researched content, on-brand infographics, key takeaways, a call-to-action, and
clickable source links. All from natural language and two brand files.

Iteration one won't be perfect. Maybe the date is wrong, maybe an infographic uses
a generated version of your logo instead of the actual file. You fix those the same
way — tell it. Every run makes the system better because the agent keeps updating its
`CLAUDE.md`, workflows, and tools as it learns.

## 7. Capture it as a skill

Once you know exactly how you like the infographics — say, your actual logo file in
the top-left and the brand palette applied — turn that into a
[skill](../../docs/02-customization/skills.md). Now every future infographic starts
from your best version, automatically, without you repeating yourself.

## 8. Deploy it

When the workflow runs cleanly every time, push the workflows and tools to a GitHub
repo and schedule them on trigger.dev or Modal. They run every Monday at 6am without
you touching anything. Remember: at that point you're running deterministic code —
not the live agent. That's the goal. See [deployment](../05-deployment/deploy.md).
