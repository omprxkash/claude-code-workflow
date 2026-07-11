# Git worktrees

Git worktrees let you check out multiple branches into separate folders at once — the key to running several Claude Code sessions in parallel without them stepping on each other.

<!-- source: see MUST_LISTEN.md -->

---

## The problem worktrees solve

Two Claude Code sessions working in the same directory will overwrite each other's files. Session A writes `services.html`, session B overwrites it with something different, and you've lost work.

Worktrees fix this by physically giving each session its own isolated copy of the repo. They share git history but have completely separate working files. An agent in `leftclick-agency-services/` cannot touch files in `leftclick-agency-about/` — they're different folders on disk.

---

## Creating worktrees

**Manual (you run the commands):**

```bash
# Three agents, three branches, three folders
git worktree add ../project-about feature/about
git worktree add ../project-contact feature/contact
git worktree add ../project-services feature/services

# Then open Claude Code in each folder
claude --worktree feature/about
claude --worktree feature/contact
claude --worktree feature/services
```

**Automatic (let Claude do it):**

Just ask in natural language:

```
Design three new pages for this site: about, contact, and services.
Work on each in a separate git worktree so they don't collide.
```

Claude creates the worktrees via bash, spawns an agent inside each isolated folder, and merges the completed branches back into main when done. You don't touch the git commands.

---

## Keeping agents out of each other's way

When assigning work, be explicit about scope:

```
You're building services.html for this project.
Work in the worktree at [path].
Create the file in here — do not modify index.html.
```

Without that instruction, an agent might try to update shared files (navigation, a CSS file referenced by all pages) — causing conflicts when you merge. Rule: each agent owns its branch's new files; shared files get touched after merge by a single session.

---

## Merging the parallel work back

Once parallel work is done, merge branches in a single clean session:

```bash
git worktree remove ../project-services  # clean up the worktree
git merge feature/services               # bring changes into main
```

Or tell Claude: *"The three feature branches are done. Merge them into main and resolve any conflicts."*

Conflicts will happen if agents touched the same file. Claude handles these well — give it context about which version to prefer.

---

## When to use worktrees

- Building distinct features that will eventually merge (about page, contact page, services page)
- Hotfixes on one branch while development continues on another
- Exploring divergent approaches where you want to compare before committing to one

When the work is on the **same branch** (e.g., classify 1,000 emails, scrape 1,000 leads), use [sub-agent fan-out](parallelization.md) instead — no branch management needed.

---

## Session mobility

Worktrees also solve a different problem: **picking up in-progress work from another machine or surface.** Because a worktree is a normal git branch, you can push it to GitHub and pull it anywhere. The context is gone but the files remain, and a fresh Claude Code session can `/init` from the existing code to reconstruct context.
