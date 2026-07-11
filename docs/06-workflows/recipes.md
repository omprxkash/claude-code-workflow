# More recipes

An index of end-to-end builds using the [WAT framework](wat-framework.md).
The first full worked example is [newsletter automation](recipe-newsletter-automation.md).

## Built recipes

| Recipe | What it builds |
|---|---|
| [Newsletter automation](recipe-newsletter-automation.md) | Full newsletter pipeline — research, write, format, send |
| [Video editing pipeline](recipe-video-pipeline.md) | Talking-head silence removal + 3D swivel teaser, one command |
| [YouTube outlier detection](recipe-youtube-outliers.md) | Find viral videos in adjacent niches, mine hooks + title variants |

## Quick recipes (condensed)

Proven end-to-end, captured in condensed form. <!-- source: see MUST_LISTEN.md -->

### Social media repurposing (one video → every platform)

Turn one YouTube video into platform-native posts and publish them via [Blotato](https://blotato.com) (a posting API that covers up to 9 platforms).

1. Add your Blotato API key and an LLM API key to `.env`.
2. Have Claude create a `repurpose-youtube-video` skill: *"User inputs a YouTube URL and wants it turned into a LinkedIn post, Instagram post, and X post. Ask me clarifying questions one at a time before building."*
3. On invocation the skill: extracts the transcript, rewrites platform-specific copy (casual for X, professional for LinkedIn), generates carousel graphics with an image API, and auto-resizes images to each platform's requirements.
4. Everything lands in a `/drafts` folder for your review — nothing publishes without approval.
5. Say "push the approved drafts" and Claude hits the Blotato API to publish.

The review-folder step is the load-bearing guard rail: generation is automated, publishing is a human decision.

### Multimodal RAG (search across video, images, and text)

Gemini's multimodal embeddings map video, images, and text into the *same* vector space — so one query can return a manual page, a photo, and a playable video clip.

1. Add Pinecone and Gemini API keys to `.env`.
2. Drop mixed media into a `/data` folder — PDFs, images, MP4s (videos max 120 seconds; up to 6 images per embed request).
3. Prompt: *"Ingest everything in /data into Pinecone using Gemini's multimodal embeddings. Then build me a local React chat app to query it."*
4. Query naturally: "How do I clean the filter?" returns the text instructions *plus* the relevant reference image and video from the database.

### Executive assistant (context-file architecture)

The EA pattern is less about tools and more about file structure:

1. Blank folder, run `/init` to generate a CLAUDE.md.
2. Paste an onboarding prompt that makes Claude the interviewer: time zones, business goals, team structure, communication preferences (the [grill-me skill](../../skills/grill-me/SKILL.md) does exactly this).
3. Claude writes the answers into dedicated context files — `context/me.md`, `context/work.md`, `context/team.md`, `context/priorities.md`, `decisions/log.md` — and updates CLAUDE.md to *link* to them with relative paths rather than inlining them.
4. Result: CLAUDE.md stays under ~200 lines, context loads only when relevant, and every session knows who you are.

## Ideas to flesh out

- **Competitor research report** — research a list of competitors, produce a
  formatted report with sources.
- **Bookkeeper / data-entry automation** — pull, categorize, and log transactions.
- **Website build** — using the [design workflow](design-workflow.md) end to end.

Each should follow the same shape as the newsletter recipe: set up with WAT, plan in
plan mode, build, add credentials, run and steer, then optionally
[deploy](../05-deployment/deploy.md).
