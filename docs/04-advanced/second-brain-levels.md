# The 5 levels of a second brain

*Not to be confused with [Five levels of Claude mastery](../00-getting-started/five-levels.md) — that's a ladder for how you use Claude Code overall. This is specifically about how capable your personal knowledge base is at finding and connecting what you've fed it.*

Before reaching for the full [LLM wiki](llm-wiki.md) setup, it's worth knowing there's a ladder — and that higher isn't automatically better. Each level answers a harder retrieval question than the last. **Find the lowest level that actually removes your pain point, not the highest one you could build.** If nothing is currently getting lost or hard to find, there's no reason to climb.

## The five questions

| Level | The question it answers |
|---|---|
| 1 | Can you find the file by an exact word or name? |
| 2 | Can you pull everything on a certain topic together? |
| 3 | Can you find it by meaning, even with different words than you wrote? |
| 4 | Can you trace a relationship chain — topic X connects back to topic A through B and C? |
| 5 | Does the whole thing run itself, with no manual upkeep? |

## Level 1 — CLAUDE.md as router

Just a `CLAUDE.md` plus a folder structure. No wiki, no linking, no special tooling.

```
vault/
  CLAUDE.md          ← routing rules: "for X, look in folder Y"
  context/
    about-me.md
    decisions.md     ← running log, append-only, dated
  projects/
    <project>.md
```

The `CLAUDE.md` isn't just role/preferences here — it's explicit routing: *"If you need information about our Q1 priorities, look in `projects/q1-priorities.md`."* Without that routing, Claude won't guess to search your whole folder tree — it'll just ask you where to look, which is the level-1 failure mode.

**Start here.** This is genuinely enough for most personal setups. The problem it eventually hits: it grows messy past a certain size, and it's exact-match — a query worded differently than your notes won't find them.

## Level 2 — topic aggregation

Same flat structure, but organized so a single topic's scattered notes can be pulled together in one pass (by date, by project, by category folders) rather than living as one-off files Claude has to already know about individually.

## Level 3 — semantic search

You search for meaning, not exact wording — the query and the note don't have to share vocabulary. This is where embeddings/RAG-style retrieval usually enters, if you go that route instead of the wiki approach below.

## Level 4 — relationship-chain tracing (the LLM wiki)

Full cross-linked knowledge graph: ask about topic X, and the system can trace the chain back through B and C to topic A, the way [llm-wiki.md](llm-wiki.md) describes. This is where hub nodes, backlinks, and an `index.md` start to matter — you're no longer just retrieving notes, you're navigating relationships between them.

**Working backwards:** design the structure around how you'll ask questions later, not how the source material happens to arrive. Reverse-engineer from the query you'll eventually make. (The analogy: you wouldn't design a square basketball — start with what has to fit through the hoop.)

## Level 5 — autonomous

The second brain maintains itself: periodic lint passes catch inconsistencies, missing relationships get filled automatically, new-article candidates get suggested without you asking. This is the ceiling, not a default target — running an autonomous wiki-maintenance system is more overhead than most personal setups need, and it's reasonable to deliberately stay at level 4.

## Does the wiki (level 4) replace RAG?

No — they're suited to different scales. See the comparison table in [llm-wiki.md](llm-wiki.md#llm-wiki-vs-semantic-search--rag): a markdown wiki is cheaper and gives better relationship reasoning up to a few hundred pages; past that, into the millions-of-documents range, a traditional RAG pipeline scales where a graph of markdown files doesn't.

## What actually belongs in it: context vs. connections

Not everything you *could* feed a second brain *should* go in. Two different kinds
of data:

- **Context** — evergreen, locked-in information: decisions made, project status,
  how the business works. Stuff that's still going to be useful a year from now.
  This is worth ingesting directly.
- **Connections** — real-time, high-churn data: Slack threads, individual emails,
  raw customer conversations. This goes stale fast and just becomes noise if you
  ingest it wholesale — you'd be back every month deleting old entries.

The fix isn't to ingest connections — it's to give the second brain a **path** to
them. Point it at where the live data lives (a project management tool, an inbox)
so it can go pull the real-time answer on demand, without permanently absorbing
everything that ever passed through those systems. A well-routed second brain
handles a vague question by cascading: check its own evergreen files first, then
the wiki, then reach out to the live connection only if it still can't find the
answer.

## Picking your level

1. Do you currently lose things or have to re-explain context to Claude? If no — stay at level 1, you don't have the pain this solves.
2. Is the problem "I can't find it by the words I originally used"? → Level 3.
3. Is the problem "I can find individual notes but I'm missing how they connect"? → Level 4, the [LLM wiki](llm-wiki.md).
4. Only reach for level 5 once you've run level 4 long enough to know exactly what upkeep you want automated.
