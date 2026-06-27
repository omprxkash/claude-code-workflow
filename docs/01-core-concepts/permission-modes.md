# Permission modes

> **Stub.** Outline below; full write-up to come.

Because Claude Code runs locally and can change real files, it has modes that
control how much it asks before acting. This page will cover each, when to use it,
and how to stay safe.

## To cover

- **Plan mode** — read-only; researches and proposes a plan you approve before any
  edits. The safest place to start a non-trivial task. (See
  [first project](../00-getting-started/first-project.md).)
- **Ask before edits** — prompts you before each file change. Conservative; how many
  developers prefer to work.
- **Edit automatically (auto-accept)** — applies edits without prompting, but stops
  short of the riskier stuff.
- **Bypass permissions ("dangerously skip permissions")** — no prompts at all;
  maximum flow, maximum trust. How to enable it (settings → "allow dangerously skip
  permissions"), and the contexts where it's reasonable vs. reckless.
- Cycling modes (Shift-Tab) and reading the visual indicator around the prompt.
- Interrupting a run mid-execution (pause), then redirecting.
- A decision guide: which mode for which kind of task and risk level.
