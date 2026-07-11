# LLM Wiki: Building a Second Brain with Claude Code + Obsidian

*Based on Andrej Karpathy's LLM knowledge base concept.*

The idea: instead of querying your AI cold every time, give it a persistent, structured, cross-linked knowledge base built from your own sources — transcripts, PDFs, URLs, meeting recordings — so it always has context about you and your work.

---

## How it works

1. You drop raw sources (PDFs, URLs, transcripts) into a `raw/` folder inside an Obsidian vault.
2. Claude Code reads everything in `raw/` and ingests it into a `wiki/` folder — splitting one source into multiple linked wiki pages.
3. Pages reference each other via backlinks. Claude Code can crawl them like a web.
4. An `index.md` acts as a table of contents. A `log.md` tracks every ingest session.

The CLAUDE.md (or Gemini.md) in your vault defines routing rules — how the agent should decide where to look for what.

---

## Setup

1. Download [Obsidian](https://obsidian.md) and create a new vault (anywhere on disk).
2. Open that vault folder in Claude Code.
3. Use [Karpathy's LLM wiki gist](https://gist.github.com/karpathy) as your starting prompt — paste it in and say:

```
You are now my LLM wiki agent. Implement this exact idea file as my complete second brain.
Guide me step by step. Create the CLAUDE.md schema with my full rules. Set up the index,
the log, define folder conventions, and show me the first ingest example.
From now on, every interaction follows the schema.
```

Claude Code will scaffold the folder structure: `raw/`, `wiki/`, `index.md`, `log.md`.

---

## Folder structure

```
vault/
  .obsidian/         ← Obsidian config
  raw/               ← drop your sources here (PDFs, transcripts, etc.)
  wiki/
    concepts/
    entities/
    sources/
    topics/
  index.md           ← table of contents (auto-maintained by Claude Code)
  log.md             ← ingest history
  CLAUDE.md          ← routing rules for the agent
```

---

## Ingesting sources

Claude Code can ingest:
- **PDFs** — drag into `raw/`, then prompt: *"Ingest the PDF I just dropped in raw/"*
- **URLs** — paste the URL and say: *"Read this article and ingest it into the wiki"*
- **Transcripts** — paste text directly or save as `.txt` in `raw/`

From two sources (a system card PDF + a news article URL), Claude Code produced 20 interlinked wiki pages in ~10–12 minutes.

---

## Flat vs structured wikis

Not every wiki needs subfolders. It depends on what you're storing.

| Type | Structure | When to use |
|---|---|---|
| YouTube transcripts | Concepts, entities, sources, topics folders | Large, varied content — benefits from categorization |
| Meeting recordings | Flat (everything in wiki/) | Fast to query, easier for agent to scan |

Keep it flat if you're unsure. You can always reorganize later with a "sweep" prompt.

---

## Why cross-linking matters

The real value isn't individual summaries — it's connections the agent makes across sources.

Example: ingesting a Claude system card + an OpenAI blog post together, the agent noticed that OpenAI benchmarked against an older Claude model (not the current one), and that the two labs use different evaluation harnesses — something easy to miss reading them separately.

---

## CLAUDE.md as a router

Your `CLAUDE.md` defines routing rules so the agent knows:
- Where to look for a given type of information
- How to maintain the index and log
- What categories/folders to create

Since it's all markdown, the wiki isn't locked to Claude Code. You can point any agent (via its own config file) at the same vault.

---

## Multiple wikis in one project

You can have several separate wikis feeding into one main project. For example:
- `youtube-wiki/` — ingested video transcripts
- `meetings-wiki/` — internal and external meeting recordings
- `research-wiki/` — papers, articles, competitor analysis

The main project's CLAUDE.md routes queries to the right wiki.

---

## Adding sources with Obsidian Web Clipper

Instead of manually copying web articles into `raw/`, install the **Obsidian Web Clipper** Chrome extension. When you're on any article you want to capture, click the extension → set the destination folder to `raw/` → click "Add to Obsidian". The article lands in `raw/` formatted and ready to ingest.

Change the default destination once in the extension settings (Location section) so you don't have to set it every time.

---

## Hot cache

For wikis that feed into an ongoing project (like an executive assistant), add a `wiki/hot.md` file. This is a short cache (~500 words) of the most recent context — the last thing that happened, the last decision made, whatever the next session most needs to know without reading everything.

Claude Code auto-updates it at the end of each session. It saves the agent from having to crawl multiple wiki pages just to get current.

Not useful for research wikis (where there's no concept of "most recent state"). Very useful for business/personal second brains.

---

## Linting

After a wiki grows, run periodic health checks:

```
Run a health check over the wiki. Find: inconsistent or duplicate data, missing relationships
that should exist, gaps where a web search could fill in missing context. Suggest new article
candidates. Fix anything you can fix directly.
```

Karpathy calls these "lint" passes. They keep the wiki consistent as it scales. Run one whenever the wiki feels messy or after large batch ingests.

---

## Connecting a wiki to other projects

A wiki is just markdown files. Point any Claude Code project at it by adding a wiki path to that project's CLAUDE.md:

```markdown
## Knowledge base
When you need context about me or my business that you don't already have, read:
- wiki_path: /path/to/my-wiki/
- Start with: wiki/index.md
- Also check: wiki/hot.md (recent context)
- Search: wiki/ for specific topics
- Don't read the wiki unless you actually need it. Skip it for: [list of things you always know]
```

This is how one wiki can feed multiple projects (executive assistant, content planning, research) without duplicating data.

---

## LLM wiki vs. semantic search / RAG

| | LLM wiki (markdown graph) | Semantic search (RAG) |
|---|---|---|
| How it finds things | Reads indexes, follows links | Similarity search over embeddings |
| Infrastructure | Just markdown files | Embedding model + vector database + chunking pipeline |
| Cost | Token cost only | Ongoing compute and storage |
| Maintenance | Periodic lint passes | Re-embed when content changes |
| Relationship depth | Explicit, navigable links | Similarity score only |
| Scale limit | Hundreds of pages — fine | Millions of documents — still fine |

At small-to-medium scale (up to a few hundred pages), the wiki approach is cheaper, more transparent, and gives better relationship reasoning. At enterprise scale (millions of documents), you want a traditional RAG pipeline.

---

## Prompt to generate a visual summary from your wiki

Once the wiki has enough data, you can ask:

```
Build me a visual HTML journey of everything in this wiki — key concepts, how they
connect, major themes. Make it beginner-friendly and clickable, not overwhelming.
```

Claude Code generates a self-contained HTML file you can open in a browser.
