# Headless mode & the Agent SDK

Everything so far assumes you're sitting at the terminal, watching Claude Code work.
Headless mode is the other half: running it **unattended** — in a script, a cron
job, or a CI pipeline — where nobody is there to approve a permission prompt.

This is the missing bridge between "using Claude Code at your desk" and
[deploying automations](../05-deployment/deploy.md) — it's how the thing you built
interactively keeps running without you.

## Print mode (`-p`)

```bash
claude -p "Summarize the open TODOs in this repo"
```

`-p` / `--print` runs the prompt non-interactively: no REPL, no back-and-forth.
Claude reads the prompt, does the work, prints the result to stdout, and exits with
a status code your script can branch on.

Options that matter for unattended runs:

```bash
claude -p "..." --output-format json          # structured output instead of plain text
claude -p "..." --output-format stream-json    # streamed, line-by-line JSON events
claude -p "..." --allowedTools "Read,Grep,Bash(npm test)"  # pre-approve specific tools
claude -p "..." --permission-mode acceptEdits  # don't stop to ask about file edits
```

The whole point of `--allowedTools` / `--permission-mode` in headless mode: there's
no human to answer a permission prompt, so anything not pre-approved just fails the
run instead of hanging. Decide up front exactly what the unattended job is allowed
to touch.

You can also pipe input in and redirect output:

```bash
cat error.log | claude -p "What's causing this crash?" > diagnosis.txt
```

## When to reach for this

- A cron job that runs a report generation prompt every morning
- A pre-commit or CI step that asks Claude to review a diff and fail the build on
  serious issues
- Any place you'd otherwise write a bespoke script calling the Claude API directly,
  but you want Claude Code's tool use (file reads, bash, MCP) instead of a bare
  chat completion

## The Agent SDK

For anything beyond "run one prompt and read stdout" — building your own agent
product, need structured outputs with types, need to intercept tool-approval
decisions programmatically — use the **Claude Agent SDK** (Python and TypeScript
packages) instead of shelling out to the CLI.

The SDK gives you:
- Native message objects instead of parsing CLI text output
- Programmatic tool-approval callbacks (approve/deny logic in code, not a prompt)
- The same tool-use and file-checkpointing model as the CLI, embeddable in your own
  application

Rule of thumb: **`claude -p` for scripts and pipelines**, **the Agent SDK for
building an actual product on top of Claude Code's agent loop**.

## Reference

- Headless mode docs: https://code.claude.com/docs/en/headless
- Agent SDK docs: https://code.claude.com/docs/en/agent-sdk/overview (Python & TypeScript)

## Next

- [GitHub Actions](github-actions.md) — the most common headless use case, fully wired
- [Deployment](../05-deployment/deploy.md) — hosting the tools/workflows a headless run depends on
