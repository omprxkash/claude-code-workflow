# Executive Assistant — Setup Prompt

Paste this as your **first message** in a fresh Claude Code session inside an empty folder. Claude runs 3 phases automatically: scaffold the folder structure, interview you section by section, then build out all files based on your answers.

---

```
I want you to set up this project folder as my personal executive assistant / second brain in Claude Code. You're going to do this in 3 phases. Complete each phase fully before moving to the next.


## Phase 1: Create the folder structure


First, initialize a git repo in this folder if one doesn't exist already.

Then create the following template structure. Don't put any content in the files yet -- just create the skeleton with placeholder files where noted.

CLAUDE.md                           # Main brain file (we'll fill this in Phase 3)
CLAUDE.local.md                     # My personal overrides (git-ignored)
.gitignore                          # Ignore .env, CLAUDE.local.md, settings.local.json
.claude/
  settings.json                     # Empty JSON object for now: {}
  rules/                            # We'll add rule files in Phase 3
  skills/                           # Empty -- we'll build skills over time
context/
  me.md                             # About me (filled in Phase 3)
  work.md                           # My business/work details (filled in Phase 3)
  team.md                           # My team (filled in Phase 3)
  current-priorities.md             # What I'm focused on right now (filled in Phase 3)
  goals.md                          # Quarterly goals and milestones (filled in Phase 3)
templates/
  session-summary.md                # Template for session closeout
references/
  sops/                             # Standard operating procedures (empty for now)
  examples/                         # Example outputs and style guides (empty for now)
projects/                           # Active workstreams (empty for now)
decisions/
  log.md                            # Decision log (append-only, empty for now)
archives/                           # Completed/outdated material (empty for now)

For empty directories, create a .gitkeep file inside them so git tracks them.

For templates/session-summary.md, use this starter:
# Session Summary
**Date:**
**Focus:**
## What Got Done
-
## Decisions Made
-
## Open Items / Next Steps
-
## Memory Updates
- Preferences learned:
- Decisions to log:

For decisions/log.md, use this starter:
# Decision Log
Append-only. When a meaningful decision is made, log it here.
Format: [YYYY-MM-DD] DECISION: ... | REASONING: ... | CONTEXT: ...
---

For .gitignore:
.env
CLAUDE.local.md
.claude/settings.local.json
node_modules/

For CLAUDE.local.md:
# Local Overrides
Personal preferences and overrides that don't get shared via git.
Add anything here that's specific to your local setup.


## Phase 2: Ask me onboarding questions


Before filling in the context files, rules, and CLAUDE.md, interview me. Ask these questions one section at a time. Don't dump all questions at once -- go section by section and wait for my answers before moving on.

Section 1: About You
- What's your name?
- What's your role/title?
- What's your timezone?
- In one sentence, what do you do?
- What's your #1 priority -- the thing everything else should support?

Section 2: Your Business / Work
- What's your company or business called?
- What are your products, services, or revenue streams?
- Roughly how much revenue does each generate? (optional)
- What tools do you use day-to-day?
- Do you have any MCP servers already connected to Claude Code?

Section 3: Your Team
- Do you have a team? If yes, how many people?
- Who are the 2-3 key people I should know about? (name, role, when to loop them in)
- Where does your team communicate?
- What's your biggest pain point with managing your team?

Section 4: Priorities, Goals & Projects
- What are the 3-5 things you're most focused on right now?
- Are there any deadlines or time-sensitive items I should know about?
- Do you have quarterly goals or milestones you're tracking?
- What active projects or workstreams are you managing right now?

Section 5: Communication Preferences
- How do you like information presented?
- Any writing pet peeves?
- What tone do you want internally?
- What tone do you want for external/public-facing content?

Section 6: What Do You Want Help With?
- What are the recurring tasks that eat up your time?
- What would you hand off to an assistant first if you could?
- Are there any specific workflows you want to automate or templatize?


## Phase 3: Build out the files


Based on my answers, fill in all the files:

Context files:
- context/me.md -- My profile based on Section 1 answers
- context/work.md -- My business/work details based on Section 2 answers
- context/team.md -- Team structure based on Section 3 answers
- context/current-priorities.md -- Priorities from Section 4, dated today
- context/goals.md -- Quarterly goals from Section 4, dated with current quarter

Projects:
If active projects were mentioned in Section 4, create a folder for each inside projects/ with a README.md (one-line description, status, key dates).

Rule files in .claude/rules/:
- communication-style.md -- from Section 5 answers
- Any other domain-specific rules that emerged

CLAUDE.md (the main brain file):
Keep it UNDER 150 lines. Include: one-line identity, top priority, @context/ imports, tool integrations, skills directory pointer, decision log pointer, memory explanation, maintenance section, projects/templates/references/archives pointers.

DO NOT put communication style rules in CLAUDE.md.
DO NOT repeat context from the context files -- just import with @.
DO NOT include a "Session Start Protocol".


## Final Step


After everything is created:
1. Show me a tree view of every file and folder created
2. One-line summary per file
3. Skills to Build backlog based on Section 6 answers
4. Show this maintenance cheat sheet:

Keeping Your Assistant Sharp:
- Weekly: Nothing required. Auto-memory handles daily learnings.
- Monthly: Glance at context/current-priorities.md. Update if focus has shifted.
- Quarterly: Update context/goals.md with new goals.
- As needed: Log decisions in decisions/log.md. Add reference files. Build new skills.
- Pro tip: Say "Remember that I always prefer X" to save something permanently.

5. Create the first git commit with all the files
6. Ask me if I want to build any skills right now


## Rules for Claude

- Do NOT create any skills yet. Skills directory stays empty.
- Keep CLAUDE.md UNDER 150 lines.
- Use @ imports in CLAUDE.md instead of repeating information.
- One rule file = one topic. Max 3-4 rule files to start.
- Ask onboarding questions ONE SECTION AT A TIME.
- If I say "skip", create the file with a placeholder and move on.
```
