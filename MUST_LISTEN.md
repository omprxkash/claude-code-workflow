# Must-Watch / Must-Read

Curated resources for learning Claude Code properly. These are the ones worth your time.

## Video courses

| Video | What it covers |
|---|---|
| [Claude Code full masterclass](https://www.youtube.com/watch?v=QoQBzR1NIqI) | Install, CLAUDE.md, IDEs, context management, skills, subagents, agent teams, worktrees, deployment |
| [WAT framework + newsletter build](https://www.youtube.com/watch?v=mpALXah_PBg) | Workflows/Agent/Tools framework, live automation build, 5 ways to run Claude Code |
| [Claude Code workflow deep dive](https://www.youtube.com/watch?v=KrKhfm2Xuho) | Advanced workflows |
| [Agentic systems overview](https://www.youtube.com/watch?v=mZzhfPle9QU) | How agents differ from traditional automation |

## Full beginner courses (English, free)

| Video | Length | Views | What it covers |
|---|---|---|---|
| [FULL Claude Tutorial For Beginners 2026](https://www.youtube.com/watch?v=Xg55nTrbYYY) | 1h52m | 210K | Sign-up → skills → Claude Code → Netlify deploy → GitHub env vars → remote environments — the most complete free course |
| [Full Claude Skills Tutorial 2026](https://www.youtube.com/watch?v=YkpEX_jlb04) | 47min | 84K | Builds two skills live: daily brief (Gmail + Calendar + Slack) and research-to-slides engine using the DBS framework |
| [My Claude Code Workflow for 2026](https://www.youtube.com/watch?v=sy65ARFI9Bg) | 20min | 26K | Video-based specs, orchestrator role, model choice, parallel vibe coding, voice dictation, subagents for context |

## Skills & plugins

| Video | What it covers |
|---|---|
| [Claude Plugins & Skills — All Updates Combined](https://www.youtube.com/watch?v=6EFOT6hjvAU) | Every skill/plugin update in one place; Ansh Mehra |
| [Claude Skills Tutorial for Beginners](https://www.youtube.com/watch?v=2prubd1IZ7U) | Building and activating skills from scratch |
| [Career in AI Agents Roadmap](https://www.youtube.com/watch?v=kQT2JJtOEAw) | How skills and agents fit a production career path |

## Build & deploy live sessions

People doing the work on screen — no setup fluff, straight to shipping.

| Video | Stack | What happens |
|---|---|---|
| [Claude Code + Vercel in 15 min](https://www.youtube.com/watch?v=oA7ttvBWSXg) | Vercel | Zero to live URL — nothing skipped |
| [Full-Stack App to Vercel](https://www.youtube.com/watch?v=sKBuSaaoN1Y) | Neon + Vercel | Tennis court booking app: DB, auth, deploy |
| [Claude Code + Supabase + Vercel](https://www.youtube.com/watch?v=GXx2QB23rxU) | Supabase + Vercel | Auth, database, deploy, custom domain — full stack |
| [Cursor + GitHub + Supabase + Vercel setup](https://www.youtube.com/watch?v=9HGukkCD4-Y) | Cursor + Supabase | Every connection wired from scratch in under an hour |
| [Vibe coding full website live](https://www.youtube.com/watch?v=jOop4g8_ZZM) | Supabase MCP + Vercel | Off-the-cuff, zero to shipped in one session |
| [Deploy to Netlify](https://www.youtube.com/watch?v=HIAuZlMDlkc) | Netlify | CI pipeline wired, full deploy guide |
| [Live Netlify from GitHub repo](https://www.youtube.com/watch?v=CVDa0poM4Ac) | Netlify + GitHub | New repo → Claude Code → sponsor landing page live |
| [VPS deployment on Hostinger](https://www.youtube.com/watch?v=GUgxx6fMiR8) | VPS | Traditional hosting, custom domain, full walkthrough |

## Automation & autonomous agents

| Video | What it builds |
|---|---|
| [Stop Building n8n Agents — Claude Code Does It](https://www.youtube.com/watch?v=3-R6EF7fdc4) | Telegram → Email + Calendar + Research multi-agent via MCP; shows Claude Code 95% vs standard Claude 40% success rate |
| [Fully Autonomous Blog Writing](https://www.youtube.com/watch?v=gg8GPwOexY8) | Firecrawl + Claude Code scheduled routine — researches daily, commits MDX post to GitHub without opening an editor |
| [Overnight Build Loop](https://www.youtube.com/watch?v=BlTpG51x94w) | GStack + Superpowers + RalphLoop — orchestrator triggers background Claude sessions to code, test, and vote on design decisions; runs while you sleep |
| [Deploy Agents to Cloud](https://www.youtube.com/shorts/CgKHi2ejYjo) | Moving agents off local machine to Modal, Railway, Render for 24/7 runs |
| [Modal orchestration layer](https://www.youtube.com/watch?v=4AnnN47QtKY) | Building a continuous sub-agent orchestration layer on Modal |

## Gamification — awards, badges, certificates

| Video | What it builds |
|---|---|
| [Course Platform with Digital Badges & Certificates](https://www.youtube.com/watch?v=kRv5aQhyZvs) | Builds a full course platform; integrates Certifier.io MCP to auto-issue badges at 50% completion and verifiable certs on finish |

## Boris Cherny's guide (Anthropic)

Boris built Claude Code. These two resources cover his actual workflow:

- **nibzard.com/claude-code** — Summary of "Mastering Claude Code in 30 minutes"
- **howborisusesclaudecode.com** — Full workflow: parallel sessions, hooks (JSON examples), MCP config, subagent definitions, verification loop, voice input, mobile access

Key things in Boris's guide not covered elsewhere:
- Hooks system — `PostToolUse`, `SessionStart`, `PreToolUse`, `PermissionRequest`, `Stop`, `PostCompact`
- `.mcp.json` format for project-level MCP config
- Custom agent frontmatter (`name`, `model`, `isolation`, `tools`)
- `/batch`, `/voice`, `/remote-control`, `/sandbox` slash commands
- Parallel sessions via tmux + worktrees

## Channels worth subscribing to

| Channel | Focus |
|---|---|
| Ansh Mehra / The Cutting Edge School | Skills, plugins, AI agent workflows — very practical |
| Ray Amjad | Agentic engineering, real workflows, no hype |
| Simon Scrapes | n8n + Claude Code, builds agentic business systems live |

## Curated lists

- **Awesome Claude Code** — https://awesomeclaude.ai/awesome-claude-code
- **Skills directory** — https://www.skills.sh/
- **Awesome Claude Skills (GitHub)** — https://github.com/ComposioHQ/awesome-claude-skills — 1000+ production-ready skills

## Official free courses (Anthropic)

- **Claude 101** — anthropic.skilljar.com/claude-101
- **Claude Code in Action** — anthropic.skilljar.com/claude-code-in-action — architecture, multi-tool use, context management, MCP, GitHub automation

## Setup references

- **GitHub MCP server install guide** — https://github.com/github/github-mcp-server/blob/main/docs/installation-guides/install-claude.md
- **Design motion principles** (for UI work) — https://github.com/kylezantos/design-motion-principles
- **NVIDIA model catalog** — https://build.nvidia.com/explore/discover

## Communities

- AI Automation Society (Skool) — https://www.skool.com/ai-automation-society/classroom
- The AI Automation Circle (Skool) — https://www.skool.com/the-ai-automation-circle/about
