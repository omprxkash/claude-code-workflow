# Automation skills

Business-automation skills built on the [WAT framework](../../docs/06-workflows/wat-framework.md). Each is a `SKILL.md` Claude Code loads when the task matches — install by copying the folder into `.claude/skills/` in your project, or `~/.claude/skills/` to have it everywhere.

For general-purpose skills (diagrams, design, session tools, meta-skills), see the [parent `skills/` folder](../).

Full catalog with descriptions and required env vars: [skills-catalog.md](../../reference/skills-catalog.md).
Architecture reference: [skills-system.md](../../templates/system-prompts/skills-system.md).

---

## The skills, grouped

| Group | Skills |
|---|---|
| Lead gen & outreach | [`scrape-leads/`](scrape-leads/), [`gmaps-leads/`](gmaps-leads/), [`classify-leads/`](classify-leads/), [`casualize-names/`](casualize-names/) |
| Cold email & campaigns | [`instantly-campaigns/`](instantly-campaigns/), [`instantly-autoreply/`](instantly-autoreply/), [`welcome-email/`](welcome-email/) |
| Gmail | [`gmail-inbox/`](gmail-inbox/), [`gmail-label/`](gmail-label/) |
| Client work | [`create-proposal/`](create-proposal/), [`onboarding-kickoff/`](onboarding-kickoff/) |
| Website & design | [`design-website/`](design-website/) |
| YouTube & content | [`youtube-outliers/`](youtube-outliers/), [`cross-niche-outliers/`](cross-niche-outliers/), [`title-variants/`](title-variants/), [`recreate-thumbnails/`](recreate-thumbnails/) |
| Video editing | [`video-edit/`](video-edit/), [`pan-3d-transition/`](pan-3d-transition/) |
| Skool & community | [`skool-monitor/`](skool-monitor/), [`skool-rag/`](skool-rag/) |
| Research & reporting | [`literature-research/`](literature-research/), [`generate-report/`](generate-report/) |
| Freelance | [`upwork-apply/`](upwork-apply/) |
| Infra & deployment | [`modal-deploy/`](modal-deploy/), [`add-webhook/`](add-webhook/), [`local-server/`](local-server/) |

---

## Note: SKILL.md only, no `scripts/`

Each skill ships a `SKILL.md` plus a `scripts/` folder of Python that does the deterministic work. Only the `SKILL.md` files are included here — they're the reusable, secret-free part. Treat them as blueprints: Claude Code can rebuild the missing scripts from the description (that's the WAT self-annealing loop). API keys are always referenced by name from `.env`, never inlined.

## Build your own

Do a task manually a few times. When you hit output you love, tell Claude "turn that into a skill." Refine the `SKILL.md`, especially its `description` frontmatter — that's what Claude reads to decide when to reach for it.
