# Recipe: YouTube outlier detection

Find high-performing videos — in your niche and adjacent niches — to mine for hooks,
patterns, and content ideas. Outputs to a Google Sheet with pre-generated title
variants adapted to your channel.

## What "outlier" means

**Outlier score = video views ÷ channel average views**

A score of 1.5 means 50% more views than that channel usually gets. A score of 5.0
is viral. The script also applies a recency boost:

| Age | Multiplier |
|---|---|
| < 1 day | 2.0× |
| < 3 days | 1.5× |
| < 7 days | 1.2× |

**Cross-niche score** penalizes technical content and rewards money hooks, time hooks,
and curiosity gaps — this filters for patterns that transfer to *your* channel.

## Two scripts

| Script | Source | When to use |
|---|---|---|
| `scrape_cross_niche_tubelab.py` | TubeLab 4M+ video DB | Default — weekly runs |
| `scrape_cross_niche_outliers.py` | yt-dlp scraping | Backup when TubeLab credits run out |

TubeLab uses pre-calculated scores, no rate limiting, 5 credits per query.
yt-dlp is free but hits rate limits ~80% of the time.

## Quick start

```bash
# TubeLab (recommended) — 1 query = 5 credits, ~100 outliers from last 30 days
python3 execution/scrape_cross_niche_tubelab.py

# Custom search term
python3 execution/scrape_cross_niche_tubelab.py --terms "business strategy"

# Skip transcripts — 10× faster, no summaries
python3 execution/scrape_cross_niche_tubelab.py --skip_transcripts

# Multiple queries
python3 execution/scrape_cross_niche_tubelab.py \
    --queries 3 --terms "entrepreneur" "business" "productivity"
```

## Output sheet (19 columns)

| Column | What it is |
|---|---|
| Cross-Niche Score | Transferability — sort by this first |
| Outlier Score | Views vs. channel average (recency boosted) |
| Title Variants 1–3 | Claude-generated titles adapted to your niche |
| Summary | Hook analysis + content structure (3–4 sentences) |
| Raw Transcript | Full transcript for studying exact hooks and script structure |
| Thumbnail | Embedded image formula |
| Publish Date, Source | Metadata |

## Scoring modifiers (cross-niche score)

| Signal | Effect |
|---|---|
| Technical terms (API, Python, SDK, code) | −20% per term |
| Money hooks ($, revenue, income, profit) | +30% |
| Time hooks (faster, save time, efficient) | +20% |
| Curiosity gaps (?, secret, "nobody talks about") | +20% |
| Listicle format (numbers in title) | +10% |

## Channels monitored

The script watches a configurable list of high-signal business/creator channels by
default — pick large channels adjacent to your niche so there's always fresh material
to score.

To add or remove channels, update `BUSINESS_CHANNELS` in the script with YouTube
channel IDs.

## Keyword tiers

| Tier | Focus | Example keywords |
|---|---|---|
| Adjacent business/tech | Audience overlap with AI/automation | "AI for business", "no-code automation" |
| Broad business | Universal proven patterns | "scale your startup", "solopreneur success" |
| Money/revenue | High engagement triggers | "passive income systems", "10x income" |
| Creator/brand | Meta-content that works | "YouTube strategy", "personal brand" |

## Workflow

1. Run weekly → ~100 outliers sorted by publish date
2. Filter by Cross-Niche Score (top 15 are most transferable)
3. Study the Summary column for hook patterns
4. Pick one with a strong thumbnail
5. Feed the thumbnail URL to the `recreate-thumbnails` skill
6. Use the 3 generated title variants as your starting point

## Frequency

| Script | Frequency | Why |
|---|---|---|
| `cross-niche-outliers` | Weekly | Broad content planning |
| `youtube-outliers` (your niche) | Daily | Competitive monitoring |

Run both; they serve different purposes.

## Required env vars

```
TUBELAB_API_KEY      — TubeLab API (5 credits/query)
ANTHROPIC_API_KEY    — summaries and title variant generation
APIFY_API_TOKEN      — optional fallback for transcript fetching
```

Plus Google Sheets OAuth: `credentials.json` + `token.json`.

## Cost

| Item | Cost per run |
|---|---|
| TubeLab (1 query) | 5 credits |
| Claude summaries + title variants | ~$0.15–0.25 per outlier |
| Transcripts | Free (YouTube API) or Apify fallback |

Recommended frequency: weekly.
