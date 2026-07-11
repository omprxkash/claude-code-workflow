# Resources & links

Everything worth bookmarking, grouped. No credentials here — keep keys in `.env`.

## Official

- **Claude Code docs** — code.claude.com/docs — the source of truth for install
  commands, features, and anything that changes often.
- **Claude Code best practices** —
  https://www.anthropic.com/engineering/claude-code-best-practices — Anthropic's own
  guidance on CLAUDE.md, context management, and custom commands.
- **Anthropic Cookbook** — https://github.com/anthropics/anthropic-cookbook — runnable
  example prompts for RAG, agents, tool use, classification.
- **Anthropic prompt library** — https://docs.anthropic.com/en/prompt-library —
  official categorized example prompts.

## Curated lists & directories

- **Awesome Claude Code** — https://awesomeclaude.ai/awesome-claude-code — a curated
  list of commands, skills, plugins, and workflows.
- **awesome-claude-md** — https://josix.github.io/awesome-claude-md/ — 100+ real
  CLAUDE.md files pulled from public repos, browsable with analysis of what makes
  each one good.
- **claude-md-templates** — https://github.com/abhishekray07/claude-md-templates —
  CLAUDE.md templates by project type.
- **The Prompt Shelf** — https://thepromptshelf.dev/ — another browsable catalog of
  CLAUDE.md / AGENTS.md rules files.
- **skills.sh** — https://www.skills.sh/ — directory of skills.
- **public-apis** — https://github.com/public-apis/public-apis — categorized list of
  free, no-auth or simple-key APIs; useful starting point when building a new skill or
  WAT tool and looking for a data source (weather, music, finance, geo, etc.).

## Real production CLAUDE.md files (not templates — actual shipping repos)

Worth reading end to end for what a battle-tested CLAUDE.md looks like once a team
has used it for a while: exact commands with time estimates, version pins with the
failure mode they prevent, explicit "never do X" rules with reasoning.

- **trigger.dev** — https://github.com/triggerdotdev/trigger.dev/blob/main/CLAUDE.md
- **Prisma** — https://github.com/prisma/prisma/blob/main/CLAUDE.md
- **Next.js (Vercel)** — https://github.com/vercel/next.js/blob/canary/CLAUDE.md
- **PostHog** — https://github.com/PostHog/posthog/blob/master/CLAUDE.md

To find more like these: GitHub code search for `filename:CLAUDE.md org:<company>` on
[github.com/search](https://github.com/search?q=filename%3ACLAUDE.md&type=code)
surfaces real, currently-used files inside serious engineering orgs — a better filter
than browsing curated template lists, since a file at the root of a company's main repo
had to survive actual engineers using it daily.

## Learning resources

Background knowledge that makes you significantly better at building agentic systems —
not Claude Code-specific, but directly applicable.

- **Hands-On Large Language Models** — https://github.com/HandsOnLLM/Hands-On-Large-Language-Models —
  official notebook companion for the O'Reilly book (~300 custom illustrations). 12 chapters:
  (1) Intro to Language Models, (2) Tokens & Embeddings, (3) Inside Transformer LLMs,
  (4) Text Classification, (5) Clustering & Topic Modeling, (6) Prompt Engineering,
  (7) Advanced Text Generation, (8) Semantic Search & RAG, (9) Multimodal LLMs,
  (10) Creating Embedding Models, (11) Fine-tuning for Classification, (12) Fine-tuning
  Generation Models. Runs on free Google Colab T4.

- **RAG Techniques** — https://github.com/NirDiamant/RAG_Techniques — 42+ notebooks
  across 7 categories. The practical reference when your RAG skill needs to go beyond
  naive chunking:
  - *Foundational*: Basic RAG, CSV RAG, Reliable RAG, Chunk Size Optimization, Proposition Chunking
  - *Query enhancement*: Query Transformations, HyDE, HyPE
  - *Context enrichment*: Contextual Chunk Headers, RSE, Context Window Enhancement, Semantic Chunking, Contextual Compression, Document Augmentation
  - *Advanced retrieval*: Fusion Retrieval, Reranking, Multi-faceted Filtering, Hierarchical Indices, Dartboard, Multimodal RAG
  - *Iterative*: Feedback Loops, Adaptive Retrieval
  - *Evaluation*: DeepEval, GroUSE, End-to-End RAG Eval, Open-RAG-Eval
  - *Advanced architectures*: Graph RAG, Microsoft GraphRAG, RAPTOR, Agentic RAG, Self-RAG, Corrective RAG (CRAG), MemoRAG, Explainable Retrieval, Controllable Agent

- **AI Agents for Beginners** — https://github.com/microsoft/ai-agents-for-beginners —
  Microsoft's 12-lesson course. Lessons: (1) Intro & use cases, (2) Agentic frameworks,
  (3) Design patterns, (4) Tool use, (5) Agentic RAG, (6) Trustworthy agents,
  (7) Planning pattern, (8) Multi-agent pattern, (9) Metacognition pattern,
  (10) Agents in production, (11) MCP / A2A / NLWeb protocols, (12) Context engineering.
  Python throughout; uses Azure AI Foundry Agent Service.

- **awesome-llm-apps** — https://github.com/Shubhamsaboo/awesome-llm-apps — 100+
  runnable AI agent and RAG apps. Categories: starter agents, advanced agents,
  always-on background agents, multi-agent teams (13 projects), voice AI agents,
  generative UI agents, RAG systems (20 projects), reusable agent skills library
  (19 modules), memory & persistence. Provider-agnostic — most work with Claude via
  config change. Apache 2.0.

## Guides & references

- **GitHub MCP server — install for Claude** —
  https://github.com/github/github-mcp-server/blob/main/docs/installation-guides/install-claude.md
  — official setup guide; see also [MCP setup](../docs/03-mcp/setup-servers.md).
- **Design motion principles** —
  https://github.com/kylezantos/design-motion-principles — reference for
  motion/interaction design; pairs with the
  [design workflow](../docs/06-workflows/design-workflow.md).
- **Firecrawl MCP** — https://mcp.firecrawl.dev — hosted scraping/crawling MCP
  server (key goes in the URL — keep it secret).
- **n8n-mcp** — https://github.com/czlonkowski/n8n-mcp — MCP server for Claude Code
  (or Cursor/Windsurf) to build n8n workflows directly.
- **n8n-skills** — https://github.com/czlonkowski/n8n-skills — companion Claude Code
  skillset for building n8n workflows.

## Communities

- **AI Automation Society (Skool)** —
  https://www.skool.com/ai-automation-society/classroom
- **The AI Automation Circle (Skool)** —
  https://www.skool.com/the-ai-automation-circle/about

## Tools & platforms

- **free-claude-code** — https://github.com/Alishahryar1/free-claude-code — local proxy
  that routes Claude Code API calls to 18 alternative providers (OpenRouter, Gemini,
  DeepSeek, Groq, Ollama, llama.cpp, and more); voice supported. Good for experimenting
  before paying for a plan. → [Setup guide](../docs/00-getting-started/free-access.md)
- **agent-browser** — https://github.com/vercel-labs/agent-browser — browser automation
  CLI for AI agents; deterministic element refs (`@e1`, `@e2`) make it reliable for
  LLM-driven workflows without Playwright boilerplate. Install as a skill:
  `npx skills add vercel-labs/agent-browser`. → [Full guide](../docs/04-advanced/agent-browser.md)
- **impeccable** — https://github.com/pbakaus/impeccable — 23 design commands + 45
  detector rules wired as hooks into Claude Code; catches overused fonts, bad color
  contrast, cramped padding, dated animation easing automatically on every UI file edit.
  `npx impeccable install`. → [Design quality guide](../docs/06-workflows/design-quality.md)
- **taste-skill** — https://github.com/Leonxlnx/taste-skill — Claude Code skill with
  three adjustable dials (design variance, motion intensity, visual density); stops the
  agent defaulting to generic centered layouts. `npx skills add Leonxlnx/taste-skill`.
  → [Design quality guide](../docs/06-workflows/design-quality.md)
- **Understand-Anything** — https://github.com/Egonex-AI/Understand-Anything — Claude
  Code plugin that builds an interactive knowledge graph of any codebase; `/understand`,
  `/understand-chat`, `/understand-diff`, `/understand-onboard` and more. Best used
  before writing a CLAUDE.md for an unfamiliar large repo.
  → [Full guide](../docs/04-advanced/understand-anything.md)
- **NVIDIA build / model catalog** — https://build.nvidia.com/explore/discover
- **Deployment platforms** — Modal, trigger.dev, Vercel (see
  [deployment](../docs/05-deployment/deploy.md)).
- **Google Workspace CLI** — https://github.com/googleworkspace/cli — one CLI for
  Drive, Gmail, Calendar, Sheets, Docs, Chat, and Admin; built from Google's
  Discovery Service and ships with its own AI agent skills.

## Agent examples & inspiration

Real agentic systems worth studying before building your own — patterns, failure modes,
and architecture decisions that don't show up in tutorials.

- **autoresearch** — https://github.com/karpathy/autoresearch — Karpathy's autonomous
  ML research agent: runs ~100 experiments overnight on a single GPU, modifying
  `train.py`, running 5-minute training runs, measuring val_bpb, and deciding whether
  to keep or discard each change. Architecture: three files only — `prepare.py`
  (immutable constants + data prep), `train.py` (the one file the agent modifies),
  `program.md` (human-authored objectives given to the agent as context). Key design
  decision: fixed 5-minute time budget per experiment regardless of hardware, making
  results platform-independent. Study this before designing any autonomous experiment
  or evaluation loop with Claude Code.

## Fun / extras

- **Pixel Agents** — https://github.com/pixel-agents-hq/pixel-agents — visualizes live
  Claude Code sessions as pixel-art characters working in a virtual office. Also on the
  [VS Code Marketplace](https://marketplace.visualstudio.com/) — search "Pixel Agents".
