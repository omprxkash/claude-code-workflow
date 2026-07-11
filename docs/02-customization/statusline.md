# Status line

The status line is the customizable info bar at the bottom of a Claude Code
session, visible in the [terminal](../00-getting-started/where-to-run.md). You
decide what it shows, and it's the fastest way to build the habit of checking
context usage before it becomes a problem (see
[context management](../01-core-concepts/context-management.md)).

## What it typically shows

- The model currently in use
- A visual progress bar of context usage
- Token count against the context window (e.g. "52K / 1,000K" — 5% of the way up)

**Don't confuse this with your session/weekly usage limit.** The status line's
percentage tracks the *context window* for the current conversation — how full
this one session's working memory is — not your rolling 5-hour or weekly usage
budget from [plans & usage](../01-core-concepts/plans-and-usage.md). Both matter,
but they're two different numbers; the status line only shows the first one.

## Setting it up

Run `/statusline` in the terminal and describe what you want it to show ("model,
context percentage, token count") — Claude configures it for you. You can also
write a custom status line script by hand for more visual control (color-coding,
extra fields like current git branch).

## Next

- [Context management](../01-core-concepts/context-management.md) — the "18 ranked
  hacks" list treats a visible status line as step one for managing tokens
- [Plans & usage](../01-core-concepts/plans-and-usage.md) — the usage-window number
  the status line does *not* show
