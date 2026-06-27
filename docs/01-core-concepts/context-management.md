# Context management

Context is, right now, the real bottleneck in getting these systems to do more for
you. Understanding it is what separates people who fight the tool from people who
get long, complex tasks done cleanly.

## What context is

Every session has a **context window** — the total amount of conversation history
the model can "see" at once, shown as a percentage from 0 to 100%. Everything
counts toward it: your `CLAUDE.md`, every message you've sent, every file Claude has
read, every tool result. As the conversation grows, the window fills.

A related term you'll see is **tokens**. A token isn't quite a word — it's a chunk
of text, and a short sentence is usually a few more tokens than it is words — but
for everyday reasoning you can treat tokens as roughly "words." (More on cost in
[tokens & cost](tokens-and-cost.md).)

## Compaction: how Claude keeps you in the window

You don't have to manage every token by hand. As the conversation gets long, Claude
**compacts** it — it takes the history and rewrites it at higher information
density, again and again as needed, so that even a wordy session stays inside the
window. Bloated phrasing gets compressed; the essential state is preserved.

This happens automatically, but you can also trigger it yourself with `/compact`
when you want to deliberately tighten things up before a big new task.

## Context rot

The failure mode to watch for is **context rot**: as a session drags on and
accumulates dead ends, abandoned approaches, and stale file dumps, the signal-to-
noise ratio drops and the model's answers get worse. The fix is to keep context
*relevant*, not just small.

Practical defenses:

- **Start fresh when you switch tasks.** `/clear` wipes the conversation and gives
  you a clean canvas. Cheap and underused.
- **Don't read files you don't need.** Reading a giant file pulls all of it into
  context. Point Claude at the specific part when you can.
- **Use `/compact`** before a major new phase in a long session.
- **Push fan-out work to [subagents](../02-customization/subagents.md).** A subagent
  does its search/work in its *own* context and returns only the conclusion — your
  main session stays clean. This is the single biggest lever for big tasks.
- **Keep `CLAUDE.md` lean.** It's reloaded on every message, so every wasted line
  there is a tax on the whole session.

## A simple working rhythm

1. New task → `/clear`.
2. Let `CLAUDE.md` set the heading.
3. For anything that requires reading a lot of files or broad searching, delegate to
   subagents so the noise stays out of your main window.
4. Long session getting heavy → `/compact`.
5. Watch the context percentage; when it climbs, it's a signal to compact, clear, or
   delegate.

## Next

- [Tokens & cost](tokens-and-cost.md)
- [Subagents](../02-customization/subagents.md) — your main tool for protecting context
