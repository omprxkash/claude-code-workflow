# CLAUDE.md (template)

> Copy this into a new project's root as `CLAUDE.md` and trim it to fit. Keep it
> lean — it's reloaded at the start of every message, so every line costs context.
> Background: ../docs/01-core-concepts/claude-md.md

## Project

- **What this is:** <one or two sentences — the project and its goal>
- **Status:** <e.g. early build / in production>

## Layout

- `src/` — <what lives here>
- `tests/` — <what lives here>
- `config/` — <what lives here>
- <add the folders that matter; skip the obvious ones>

Entry points worth knowing: <e.g. `src/main.py`, `README.md`>

## Conventions

- Language / framework: <e.g. Python 3.12, React + Tailwind>
- Style: <naming, formatting, patterns to follow or match the surrounding code>
- Tests: run with `<command>`. Add/adjust tests for behavior changes.
- Commits: <message style, who to author as, any rules>

## How to work here

- Prefer reusing existing functions/utilities over writing new ones.
- For non-trivial tasks, plan first; confirm assumptions before large changes.
- Ask before doing anything hard to reverse or outward-facing.
- Report results honestly — if something failed or was skipped, say so.

## Secrets

- Keep all keys and tokens in `.env` (gitignored). Never put credentials in code,
  in this file, or in committed files. Reference them by name only.

## Notes / gotchas

- <anything that has tripped up work here before — add lines as you learn them>
