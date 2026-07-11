# Deployment

Taking a workflow you built and battle-tested with Claude Code and making it run on
its own — on a schedule or triggered by an event.

## The key idea

When you deploy, you ship the **code and the tools, not the live agent**. While you
build, the agent is present and self-heals; once deployed on a schedule or webhook,
the workflow behaves like a traditional, deterministic automation. That's the goal —
use the agent to build something reliable, then ship the reliable thing.
(Background: [why Claude Code](../00-getting-started/why-claude-code.md).)

## Platform map

| Platform | Best for | Trigger types |
|---|---|---|
| **Modal** | Python-first serverless endpoints + cron | Webhooks, cron, n8n HTTP nodes |
| **trigger.dev** | Long-running jobs, queues, background tasks | Events, scheduled runs, API calls |
| **Vercel** | Next.js frontends + edge functions | HTTP, cron |
| **GitHub Actions** | CI/CD, repo-triggered automation | Git events, cron |

For automation pipelines built in Claude Code, **Modal is the default choice** —
handles Python dependencies natively, deploys in seconds, gives you an HTTPS endpoint
immediately.

## Deploying to Modal

### One-time setup

```bash
pip install modal
modal token set --token-id <ID> --token-secret <SECRET>
```

Get credentials from [modal.com/settings](https://modal.com/settings) → API Tokens.

### Store secrets (once per secret)

```bash
modal secret create anthropic-api-key ANTHROPIC_API_KEY=sk-ant-...
modal secret create api-auth-token API_AUTH_TOKEN=$(openssl rand -hex 32)
```

Secrets are referenced by name in code — never hardcode keys.

### Template: HTTP endpoint

```python
import modal
from fastapi import Header, HTTPException

app = modal.App("my-app")
image = modal.Image.debian_slim().pip_install("anthropic", "fastapi")

@app.function(
    image=image,
    secrets=[
        modal.Secret.from_name("anthropic-api-key"),
        modal.Secret.from_name("api-auth-token"),
    ],
    timeout=120,
)
@modal.fastapi_endpoint(method="POST")
def run(data: dict, authorization: str = Header(None)) -> dict:
    import os, anthropic

    # Bearer auth — required on every endpoint
    token = os.environ.get("API_AUTH_TOKEN")
    if not authorization or authorization.replace("Bearer ", "") != token:
        raise HTTPException(status_code=403, detail="Invalid token")

    client = anthropic.Anthropic(api_key=os.environ["ANTHROPIC_API_KEY"])
    msg = client.messages.create(
        model="claude-sonnet-4-6",
        max_tokens=1024,
        messages=[{"role": "user", "content": data.get("prompt", "")}],
    )
    return {"response": msg.content[0].text}
```

### Deploy and test

```bash
# Deploy
modal deploy modal_app.py

# Test locally without deploying
modal run modal_app.py::run --data '{"prompt": "hello"}'

# Stream logs
modal logs my-app
```

After `modal deploy` you get a URL like:
```
https://your-username--my-app-run.modal.run
```

### Call the endpoint

```bash
curl -X POST "https://your-username--my-app-run.modal.run" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -d '{"prompt": "summarize this"}'
```

## Wiring into n8n

In n8n's **HTTP Request** node:

| Field | Value |
|---|---|
| Method | POST |
| URL | your Modal endpoint URL |
| Authentication | Header Auth |
| Header Name | `Authorization` |
| Header Value | `Bearer YOUR_TOKEN` |
| Body | JSON |

This lets n8n trigger a Claude Code workflow on demand — useful when you need AI
reasoning inside a larger automation.

## Event-driven orchestration (webhook server)

For systems with multiple workflows, run a single `modal_webhook.py` that routes by
slug so you only deploy once:

```python
@app.function(...)
@modal.fastapi_endpoint(method="POST")
def directive(slug: str, authorization: str = Header(None)) -> dict:
    # auth check ...
    config = load_webhooks()[slug]   # slug → directive file
    result = run_directive(config)
    return {"result": result}
```

`webhooks.json` maps slugs to directive files:
```json
{
  "weekly-leads": "directives/gmaps-scrape.md",
  "auto-reply":   "directives/email-reply.md"
}
```

Add new workflows by editing the JSON — no redeploy needed.

## Modal quick reference

| Command | Purpose |
|---|---|
| `modal deploy modal_app.py` | Deploy to Modal |
| `modal run modal_app.py::fn` | Test locally |
| `modal secret create name KEY=val` | Store a secret |
| `modal secret list` | List secrets |
| `modal app list` | List deployed apps |
| `modal app stop name` | Stop an app |
| `modal logs name` | Stream logs |

## Checklist before going live

- [ ] All secrets stored in Modal, not in code
- [ ] Bearer token auth on every endpoint
- [ ] Tested locally with `modal run` before deploying
- [ ] Timeout set appropriately (Claude calls can take 30–90s)
- [ ] Error handling for external API failures
- [ ] Logs accessible via `modal logs` for debugging

## After you deploy — the loss of self-healing

While building with Claude Code, the agent notices when something breaks and fixes it.
Once deployed, there's no agent — the code runs deterministically. Plan for this:

- Add explicit error handling for every external call
- Log failed records to a sheet or file so you can review and retry
- For flaky APIs (scrapers, Google, Apify), add retry logic with backoff
- Consider a nightly alert (email or Slack) if a run produces zero results
