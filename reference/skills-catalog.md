# Skills catalog

All 26 skills in the automation system. Each lives in `.claude/skills/<name>/SKILL.md` plus a
`scripts/` folder. Claude auto-activates a skill when the task matches its description.
See [how skills work](../docs/02-customization/skills.md) and the
[skills CLAUDE.md template](../templates/claude-md/skills-system.md) for the full architecture.

## Lead generation & outreach

| Skill | What it does |
|---|---|
| `scrape-leads` | Scrape and verify business leads via Apify, classify with LLM, enrich emails, save to Google Sheets. Works for any industry or location. |
| `gmaps-leads` | Google Maps B2B lead scraping with deep website enrichment and contact extraction. |
| `classify-leads` | LLM-based lead classification for complex distinctions — product SaaS vs agencies, etc. |
| `casualize-names` | Convert formal names to casual versions (first names, company names, city names) for cold email personalization. |

## Cold email & campaigns

| Skill | What it does |
|---|---|
| `instantly-campaigns` | Create cold email campaigns in Instantly with A/B testing. |
| `instantly-autoreply` | Auto-generate intelligent replies to incoming Instantly email threads using knowledge bases. |
| `welcome-email` | Send welcome email sequence to new clients. |

## Gmail

| Skill | What it does |
|---|---|
| `gmail-inbox` | Manage emails across multiple Gmail accounts with unified tooling. |
| `gmail-label` | Auto-label Gmail emails into Action Required, Waiting On, Reference — uses 10 parallel `email-classifier` subagents, ~30s for 100 emails. |

## Client work & proposals

| Skill | What it does |
|---|---|
| `create-proposal` | Generate PandaDoc proposals from client info or sales call transcripts. |
| `onboarding-kickoff` | Full post-kickoff automation — generates leads, creates email campaigns, sets up auto-reply. |

## Website & design

| Skill | What it does |
|---|---|
| `design-website` | Generate a premium mockup website for a prospect (buildinamsterdam.com style); inputs from Google Sheet. |

## YouTube & content

| Skill | What it does |
|---|---|
| `youtube-outliers` | Find viral YouTube videos in your niche; calculates outlier score (views / channel average), fetches transcripts. |
| `cross-niche-outliers` | Find viral videos from adjacent niches to extract content patterns and hooks. |
| `title-variants` | Generate YouTube title variations from outlier analysis. |
| `recreate-thumbnails` | Face-swap YouTube thumbnails using AI. |

## Video editing

| Skill | What it does |
|---|---|
| `video-edit` | Remove silences from talking-head videos with neural VAD and add 3D swivel teaser transitions. |
| `pan-3d-transition` | Create 3D pan/swivel transition effects for videos using Remotion. |

## Skool & community

| Skill | What it does |
|---|---|
| `skool-monitor` | Monitor AND interact with Skool — read posts, create posts, reply to comments, like content, search. Requires explicit user approval for write operations. |
| `skool-rag` | Query Skool community content via RAG pipeline with vector search. |

## Research & reporting

| Skill | What it does |
|---|---|
| `literature-research` | Search academic databases and perform deep research reviews. |
| `generate-report` | Weekly weather reports for Canada using Open-Meteo API (free, no key required). |

## Freelance & Upwork

| Skill | What it does |
|---|---|
| `upwork-apply` | Scrape Upwork jobs via Apify and generate personalized proposals with cover letters. |

## Infrastructure & deployment

| Skill | What it does |
|---|---|
| `modal-deploy` | Deploy execution scripts to Modal cloud (`modal deploy execution/modal_webhook.py`). |
| `add-webhook` | Add new Modal webhooks for event-driven execution. |
| `local-server` | Run the Claude orchestrator locally with Cloudflare tunneling — for testing webhooks locally before deploying. |

## Required environment variables

```
ANTHROPIC_API_KEY   — required for all skills
APIFY_API_TOKEN     — scrape-leads, gmaps-leads, upwork-apply
INSTANTLY_API_KEY   — instantly-campaigns, instantly-autoreply
PANDADOC_API_KEY    — create-proposal
OPENAI_API_KEY      — embeddings in RAG (skool-rag)
PINECONE_API_KEY    — vector search (skool-rag)
```

Keep all of these in `.env` (gitignored). Reference by name only — never inline.
