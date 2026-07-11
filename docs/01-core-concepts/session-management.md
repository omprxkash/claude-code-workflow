# Session management

Every session lives on disk. You don't have to finish a task in one sitting, and you
don't have to lose work when something goes wrong mid-edit.

## Picking up where you left off

```bash
claude --continue     # or: claude -c
```

Instantly resumes your most recent session in the current directory — no picker,
no questions. This is the one to reach for by default.

```bash
claude --resume
```

Opens an interactive picker of past sessions, filtered to the current directory,
showing git branch, message count, and a preview of what you were doing. Use this
when you have several threads going and need to pick the right one.

```bash
claude --resume <session_id>
```

Jump to an exact session by ID — useful for going back to a specific debugging
context from days ago.

## Rewind: undoing without losing the conversation

Claude Code checkpoints automatically. Every prompt you send creates a checkpoint of
the code state *before* that edit — not just at the start of the session.

- **`/rewind`**, or press **Esc twice** with an empty prompt box, opens the rewind
  menu.
- If the prompt box has text in it, double-Esc clears the text instead of opening
  rewind — empty it first.
- You can restore **code only**, **conversation only**, or **both**.
- Checkpoints persist across sessions (including resumed ones) and are cleaned up
  after 30 days by default.

**What rewind does NOT catch:** file changes made by a `Bash` command (a script you
told Claude to run) aren't tracked as checkpoints — only edits made through Claude's
own file-editing tools are. If you need to undo a bash-side-effect, that's a normal
git revert, not `/rewind`.

## Forking instead of rewinding

If you want to try a different approach *without* losing the current path:

```bash
claude --continue --fork-session
```

This branches off a new session from the current one, leaving the original fully
intact. Use this when you want to A/B two approaches rather than commit to rewinding
over one of them.

## `/clear` vs `/rewind` vs `--resume`

These solve different problems — don't conflate them:

| Command | What it does | When to use |
|---|---|---|
| `/clear` | Wipes conversation, keeps you in the same terminal session | Starting a genuinely new task, same project |
| `/rewind` | Rolls back code and/or conversation to an earlier checkpoint | You went down a wrong path and want it undone |
| `claude --resume` | Reopens a *previous, already-ended* session | Coming back after closing the terminal |

If you ran `/clear` earlier in the same process, `/rewind` shows an extra entry at
the top: `/resume <session-id> (previous session)` — lets you get back the
conversation that existed before you cleared it, without losing what came after.

## Next

- [Context management](context-management.md) — why clearing/compacting matters for
  quality, not just plan usage
- [Plans & usage](plans-and-usage.md) — how session length affects your usage budget
