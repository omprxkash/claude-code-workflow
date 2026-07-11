---
name: session-handoff
description: Use when someone is about to clear their context, end a session, or wants to preserve what was built so a new session can pick up exactly where this one left off.
---

## What This Skill Does

Generates a handoff document that captures everything in the current session — what was built, decisions made, where files live, and what comes next — so the next session starts with full context instead of from zero.

Run this **before** `/clear` or ending a long session. Paste the output at the start of the next conversation.

This solves context rot: instead of letting a session drag on past its quality peak, you snapshot it, clear, and continue fresh.

---

## Steps

1. **Scan the session.** Look back through the full conversation history for:
   - What the original goal was
   - Everything that was built or changed (files created, files edited, decisions made)
   - Approaches that were tried and rejected (and why)
   - Open questions or unfinished work
   - File paths for everything that was produced

2. **Write the handoff document.** Use the template below.

3. **Print it directly in the conversation** so the user can copy it. Do not save it to a file — the user will paste it into the next session themselves.

4. Tell the user: "Copy the above and paste it at the start of your next session. It will give the new Claude full context. Then you can `/clear` safely."

---

## Output Template

```markdown
# Session Handoff — [one-line description of what this session was about]

## What we were doing
[1-3 sentences. The goal of this session and why it mattered.]

## What was built / changed
[Bullet list of every file created or edited, with the file path and what changed.]
- `path/to/file.md` — created: [what it does]
- `path/to/other.py` — edited: [what changed and why]

## Key decisions made
[Bullet list of important choices, and the reasoning behind each one.]
- Chose X over Y because [reason]
- Decided NOT to do Z because [reason]

## Approaches that didn't work
[Optional. List things that were tried and abandoned, so the next session doesn't repeat them.]
- Tried [approach] — didn't work because [reason]

## Where things stand
[Current state. What's working, what's not, what's partially done.]

## What comes next
[Numbered list of the logical next steps.]
1. [next step]
2. [next step]
3. [next step]

## Files to know about
[File paths that are central to this project. The next session should read these first.]
- `CLAUDE.md` — project-wide rules
- `[other important files]`

## Context to paste at session start
[Optional: a short priming prompt the user can paste at the top of the next session before this handoff doc, to orient the new session quickly.]
> "We're continuing work on [project]. Here's where we left off:"
```

---

## Notes

- Be specific about file paths — "the main file" is useless. "src/agents/lead-qualifier.py" is useful.
- Include decisions that were REJECTED, not just what was chosen. Future sessions need to know what's already been ruled out.
- Keep the "What comes next" section honest. Don't put aspirational items — only what the user actually said they want to do next.
- If video editing or design work was done and HTML files exist, note which version is the latest and where it lives.
- This skill produces output to be pasted, not a saved file. Don't write it to disk.
