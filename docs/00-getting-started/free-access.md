# Running Claude Code for free

[free-claude-code](https://github.com/Alishahryar1/free-claude-code) is a local proxy
that intercepts API calls from Claude Code (and Codex), routing them to any of 18
alternative providers — including free tiers, cheaper paid tiers, and local models. The
IDE thinks it's talking to Anthropic; the proxy handles translation silently.

Works in: Claude Code CLI, Claude Code VS Code extension, Discord (voice supported).

---

## How it works

The proxy runs locally and sits between Claude Code and the network. It translates
between Anthropic Messages API format and whatever format the target provider uses. You
configure which model answers which Claude tier (Haiku, Sonnet, Opus) independently.

---

## Setup

**Install (one command):**

macOS / Linux:
```bash
curl -fsSL "https://github.com/Alishahryar1/free-claude-code/blob/main/scripts/install.sh?raw=1" | sh
```

Windows PowerShell:
```powershell
irm "https://github.com/Alishahryar1/free-claude-code/blob/main/scripts/install.ps1?raw=1" | iex
```

**Start the proxy:**
```bash
fcc-server
```

**Configure via the local admin UI** at `http://127.0.0.1:8082/admin` — add an API key
from your chosen provider, set your default model, map each Claude tier to a backend.

**Launch Claude Code through the proxy:**
```bash
fcc-claude   # Claude Code
fcc-codex    # Codex
```

That's it. The proxy handles all API translation internally.

---

## Supported providers

| Type | Providers |
|---|---|
| Free / cheap cloud | OpenRouter, Google AI Studio (Gemini), DeepSeek, Cerebras, Groq, Fireworks AI |
| Cloud | NVIDIA NIM, Mistral (La Plateforme + Codestral), Cloudflare Workers AI, Z.ai, Kimi, Wafer, OpenCode |
| Local | LM Studio, llama.cpp, Ollama |

Voice transcription requires an optional Whisper or NVIDIA NIM backend.

---

## Caveats

- Admin UI is local-only (not exposed to network)
- Free provider tiers have rate limits — watch for throttling on long sessions
- Local models need enough context window for Claude Code's system prompt (~17k tokens baseline); small models will struggle
- Some advanced tool-use features may behave differently across providers

---

## When to use this

Good fit for:
- Experimenting with Claude Code before paying for a plan
- Running lighter tasks (file edits, simple scripts) against free providers
- Pointing specific Claude tiers at cheaper models to control cost

Not a replacement for a paid plan when doing heavy parallel work, long context sessions,
or production automation — the free provider rate limits will become a bottleneck quickly.

→ See [plans & usage](../01-core-concepts/plans-and-usage.md) for what a paid plan actually gets you.
