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

## Token management — 18 ranked hacks

One developer tracked a 100+ message chat and found **98.5% of all tokens were spent rereading old history**. Every message, Claude re-reads the entire conversation from the beginning — so cost compounds, not just adds. Message 1 might cost 500 tokens. Message 30 costs 15,000+ because it re-reads everything before it.

This isn't just a cost problem. Bloated context produces worse output — the "lost in the middle" phenomenon means the model pays most attention to the beginning and end of the window; everything in the middle gets relatively ignored.

### Tier 1 — easy wins, do these first

1. **Start fresh between tasks.** `/clear` when switching to a new topic. Carrying context from task A into task B is one of the most expensive habits you can have.

2. **Disconnect MCP servers you're not using.** One connected MCP server can add 18,000+ tokens of tool definitions to *every single message*. Run `/mcp` at the start of a session and disconnect what you don't need. CLI alternatives to MCPs use 60-70% fewer tokens.

3. **Batch prompts into one message.** Three separate messages cost 3x what one combined message costs. If Claude got something slightly wrong, edit your original message and regenerate — editing replaces the bad exchange entirely, while a follow-up stacks permanently onto history.

4. **Use plan mode before any real task.** The biggest token waste is Claude going down the wrong path for 20 messages before you catch it. Add to your CLAUDE.md: *"Do not make any changes until you have 95% confidence in what to build. Ask follow-up questions until you reach that confidence level."*

5. **Run `/context` and `/cost`.** See exactly where your tokens are going: conversation history, MCP overhead, loaded files. Most people have no idea where tokens are bleeding. A fresh session with no chats will already show 40-50K tokens from system prompts, tools, and memory files — know your baseline.

   **Baseline breakdown (approximate):**
   | Category | Tokens |
   |---|---|
   | System tools (file read/write, bash, etc.) | ~17,000 |
   | Connected MCP servers | 0–20,000+ each |
   | Memory files | depends on your setup |
   | CLAUDE.md | depends on length |

   Auto-compact fires automatically when the remaining context window drops below ~33,000 tokens. At that point quality is already degraded — don't wait for it. Run `/compact` manually at 60%.

   **MCP overhead is real and measurable.** The ClickUp MCP server consumes nearly 20,000 tokens on its own — whether you use it or not in a given session. If you only need one API call from a service, a direct `fetch()` in a skill costs a fraction of what the full MCP server costs.

6. **Set up a status line.** Run `/statusline` in the terminal — shows your model, a context progress bar, and token count at a glance. Visibility is the first step to managing it.

7. **Keep your usage dashboard open.** Check every 20-40 minutes. You can automate a Slack or text alert for when you approach the limit.

8. **Be surgical with pasting.** Before dropping a file or doc: does Claude need the whole thing? If the bug is in one function, paste just that function. Specific beats full.

9. **Watch Claude work.** Don't fire a prompt and switch tabs. If it's going down the wrong path or stuck in a loop re-reading the same files, stop it. 80% of the tokens in a bad loop produce zero value.

### The MCP → Skill migration pattern

MCP servers are convenient but expensive. A server for a large API (ClickUp, Notion, Gmail, Slack) can load 15,000–20,000+ tokens of tool descriptions into *every single message*. If you only ever use 2-3 of those 50 endpoints, you're paying for 47 you don't need.

**The fix:** once you've tested which API calls you actually use, convert the MCP routine into a skill that calls those endpoints directly via `fetch()`.

Before (MCP):
```
Install Gmail MCP → 15,000 tokens per message, regardless of use
```

After (Skill):
```
skills/gmail-label/SKILL.md
  → calls /labels and /messages endpoints directly
  → loads only when invoked
  → processes 100 emails in 36 seconds
```

**How to do the migration:**
1. Use the MCP to find the right API endpoints and get auth working.
2. Once it works, tell Claude: *"Convert this MCP routine into a standalone skill that uses direct API calls instead of the MCP server."*
3. Disable the MCP server. Your skill does the same job in fewer tokens and often faster.

This is also why the rule exists: *"For any task you do repeatedly, an MCP is for prototyping, a skill is for production."*

### Tier 2 — one step deeper

10. **Keep CLAUDE.md lean.** It loads on *every single message* — not just session start. If it's 1,000 lines, every "hi" re-reads 1,000 lines. Keep it under 200 lines. Treat it as an index that points to where things live, not a place to dump everything you know.

11. **Use surgical file references.** Don't say "here's my whole repo." Say "check the `verifyUser` function inside `auth.js`." Use `@filename` to point at specific files instead of letting Claude explore freely.

12. **Compact at 60%, not 95%.** Autocompact triggers at ~95% when your context is already degraded. Run `/context` to check percentage, and at ~60% run `/compact` with instructions on what to preserve. After 3-4 compacts in a row, quality degrades — at that point, take a summary, `/clear`, paste back, continue fresh.

13. **Know your cache TTL — it's not the same everywhere.** Cached tokens cost roughly 10% of a fresh input token, so a high cache-hit rate is a real saver, not a rounding error. The window (TTL — time to live) before a cache snapshot expires differs by context: **1 hour** on a Claude subscription (Claude Code in the terminal/IDE, using your Pro/Max plan), **5 minutes by default on direct API billing** (extendable to 1 hour at extra cost), and **5 minutes for sub-agents regardless of plan.** If you step away longer than your TTL, the next message re-processes everything from scratch at full cost — before stepping away, `/compact` or `/clear`.

   **What breaks the cache mid-session, even inside the TTL window:** switching models. If you use "Opus Plan" (Opus for planning, Sonnet for execution — see tip 15 below), each toggle between plan and execution *is* a model switch, and starts a fresh cache — worth it for the model-cost savings, but know that it also means zero cache hits on the next request. Editing `CLAUDE.md` mid-session, by contrast, is safe — the edit doesn't apply until the session restarts, so it doesn't touch the current cache.

   **Three cache layers, roughly in order of stability:** system-level (base instructions, tool definitions — effectively never changes), project-level (`CLAUDE.md`, memory, rules — changes between sessions, not within one), and conversation-level (each turn's messages — grows every turn, cached incrementally). The system and project layers are what make a long, focused session cheap; the conversation layer is what a `/clear` resets.

14. **Command output bloat.** When Claude runs shell commands, the full output enters your context window. A command that returns 200 commits or a full JSON response loads all of that as tokens. In project settings, deny permissions for commands that produce large output if Claude doesn't need them.

### Tier 3 — advanced optimization

15. **Pick the right model for each task.** Sonnet for default coding work. Haiku for sub-agents doing research, formatting, or simple lookups. Opus only for hard architecture decisions where Sonnet wasn't enough — aim for <20% Opus usage. Set model per sub-agent in `.claude/agents/` so cheap tasks don't burn expensive-model budget.

16. **Sub-agent token math.** Agent workflows use roughly 7-10x more tokens than a single session because each sub-agent wakes up with its own full context load. Worth it when you need parallelism or isolation — but delegate to Haiku sub-agents to get cheap parallel work, not Opus.

17. **Schedule heavy sessions for off-peak hours.** Peak usage (roughly 8am-2pm Eastern on weekdays) drains your 5-hour window faster due to demand-based throttling. Large refactors, multi-agent sessions, and big projects should run in afternoons, evenings, or weekends.

18. **CLAUDE.md as constitution.** Store stable decisions and architecture rules here, not conversations. Every architectural call stored in CLAUDE.md is a paragraph you never have to type again. Add a self-learning rule: "When something fails repeatedly, add a one-line bullet here — under 15 words, no explanation, only add things that save time in future sessions."

---

**The core mental model:** most token problems aren't a limits problem — they're a context hygiene problem. You don't need a bigger plan; you need to stop re-sending your entire conversation history 30 times when you could send it 5.

## Next

- [Tokens & cost](tokens-and-cost.md)
- [Subagents](../02-customization/subagents.md) — your main tool for protecting context
