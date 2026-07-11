# Hooks

> **Stub.** Outline below; full write-up to come.

Hooks are custom scripts that fire automatically before or after Claude Code tool
calls. They let the *harness*, not the model, enforce automatic behavior — "every
time X happens, run Y."

## To cover

- What a hook is and why "automatic" behavior belongs in a hook, not in memory or a
  prompt.
- Hook events (pre/post tool use, session lifecycle) and where they're configured
  (`settings.json`).
- Common uses: auto-format on edit, run tests after changes, block edits to
  protected paths, notify on stop, log tool calls.
- A worked example with the script + the `settings.json` snippet (see
  [`templates/hooks/`](../../templates/hooks/)).
- Safety: hooks run real commands automatically — review them like you'd review any
  automation.
