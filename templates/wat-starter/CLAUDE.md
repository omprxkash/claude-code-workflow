# CLAUDE.md — WAT project

> A starter project brain for the WAT framework (Workflows / Agent / Tools).
> Background: ../../docs/06-workflows/wat-framework.md

## Framework: WAT

This project follows the **WAT framework**:

- **You are the Agent.** You read workflows, run the tools they call, handle errors,
  and improve the system over time.
- **Workflows** live in `workflows/` — natural-language, step-by-step processes. Each
  describes how to accomplish a task and which tools to use, in order.
- **Tools** live in `tools/` — one capability per file (e.g. research, send email,
  generate image). Tools are useless without a workflow ordering them.

## How to operate

1. When asked to do a task, find the relevant workflow in `workflows/` and follow it
   step by step.
2. Run the tools the workflow names. If a tool doesn't exist yet, build it in
   `tools/` following the same plain-language style.
3. **On error:** diagnose it, fix the underlying tool (don't just patch around it),
   and note what changed so it won't recur.
4. **Self-improve:** when you find a better approach, update the workflow or tool.
   When you learn something durable about this project, add it to this file.

## Layout

- `workflows/` — process files (`*.md`)
- `tools/` — capability files
- `config/` — settings (styles, recipients, options) — see `config/`
- `.env` — secrets (gitignored). Never hardcode keys; reference them by name.

## Conventions

- Language / runtime: <e.g. Python 3.12>
- Keep workflows and tools readable as plain English.
- Confirm the plan in plan mode before building anything non-trivial.

## Secrets

All credentials go in `.env` (copy `.env.example`). Never commit real keys.
