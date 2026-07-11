# Your first project

The fastest way to understand Claude Code is to build something with it. This page
walks the loop I use every time I start fresh: open a folder, give it a brain, plan
in plan mode, then let it build.

## Open a folder

Claude Code works inside a folder — that folder *is* your project. In an IDE, use
**Open Folder** and point it at an empty directory. In the terminal, `cd` into it
and run `claude`. There are really only two things in front of you: your **files**
(on the left in a GUI) and the **agent** (where you chat).

## Give it a brain: CLAUDE.md

Before you ask for anything real, create a `CLAUDE.md` in the project. This is the
instructions file Claude reads at the start of every conversation — think of it as
the system prompt for this project. Put the things that don't change: how the
folders are laid out, where files live, what the project is for, which frameworks
you're using, conventions to follow.

You can start with the [generic template CLAUDE.md](../../templates/claude-md/generic.md) and adapt it.
The full reasoning for why this file matters so much is in
[What CLAUDE.md is](../01-core-concepts/claude-md.md) — for now just know that a
good one steers everything that follows.

A common first move: drop in your `CLAUDE.md`, then tell Claude *"read CLAUDE.md and
set up the project structure."* It'll scaffold folders and confirm what it
understands before you build anything.

## Plan before you build

Cycle the mode (Shift-Tab in most surfaces) until you're in **plan mode**. This is
the single most useful habit for beginners. In plan mode Claude doesn't edit
anything — it researches, asks clarifying questions, and proposes a plan you
approve first.

The magic is that you can be *vague on purpose*. Give it a loose description and it
comes back with "to do this well I need to know X, Y, and Z." For example:

> I want to build a workflow that takes a topic, does research, writes it up as
> nicely formatted HTML, and creates a couple of infographics to go with it. Help
> me figure out the tech stack and tell me what I haven't thought of.

It'll ask about the research source, how to deliver the output, brand assets, and
so on — then produce a plan. **Read the plan.** This is where you catch wrong
assumptions cheaply, before any code exists. You can push back ("use this service
instead", "drop the human-review step") and it re-plans.

You can also tag specific files in your prompt with `@filename` so Claude looks at
exactly the right thing (a logo, a brand guideline, a config).

## Let it build

Once the plan looks right, approve it and switch to a build mode (see
[permission modes](../01-core-concepts/permission-modes.md)). Claude creates a
**to-do list**, then works through it, checking items off as it goes. You can watch,
work on something else, and check back.

The first run is the one that needs your attention — you're learning how it behaves
and steering it past rough spots. After that, a well-built workflow tends to run
cleanly every time. When something breaks mid-build, you usually just tell it, in
plain language, "this output is wrong, figure out what happened and fix it," and it
diagnoses, repairs, and often updates its own tools so the same error doesn't
recur.

## The loop, summarized

1. Open a folder.
2. Add a `CLAUDE.md`.
3. Plan in plan mode — let it ask questions, read the plan, correct it.
4. Approve, then let it build through its to-do list.
5. Iterate in natural language.

That's the whole rhythm. Everything else in this handbook makes each step sharper.

## Next

- Understand the brain you just created: [What CLAUDE.md is](../01-core-concepts/claude-md.md)
- Or jump to a real build: [Recipe: newsletter automation](../06-workflows/recipe-newsletter-automation.md)
