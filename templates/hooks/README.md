# Hook templates

Hooks are scripts the Claude Code harness runs automatically before or after tool
calls. They enforce automatic behavior that shouldn't depend on the model
remembering to do it. Full explanation:
[../../docs/02-customization/hooks.md](../../docs/02-customization/hooks.md).

## What's here

- [`format-on-edit.sh`](format-on-edit.sh) — example: format a file after Claude
  edits it.
- [`settings.snippet.json`](settings.snippet.json) — how to wire a hook into
  `settings.json`.

## Install

1. Put the script somewhere in your project (e.g. `.claude/hooks/`) and make it
   executable.
2. Merge the relevant part of `settings.snippet.json` into your
   `.claude/settings.json`, adjusting the matcher and command path.

> Hooks run real commands automatically. Review any hook the way you'd review any
> automation before enabling it.
