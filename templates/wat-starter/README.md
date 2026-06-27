# WAT starter

A copy-paste skeleton for building reliable workflows with Claude Code using the
**WAT framework** (Workflows / Agent / Tools). Full explanation:
[../../docs/06-workflows/wat-framework.md](../../docs/06-workflows/wat-framework.md).

## What's here

```
wat-starter/
├── CLAUDE.md                      # the project brain: tells the agent it runs WAT
├── workflows/
│   └── example-workflow.md        # a model workflow (research briefing)
├── tools/
│   └── example-tool.md            # a model tool (research)
├── config/
│   └── settings.example.yaml      # example settings (no secrets)
└── .env.example                   # credential placeholders
```

## Use it

1. Copy this folder into a new, empty project directory.
2. Copy `.env.example` → `.env` and fill in your keys (never commit `.env`).
3. Copy `config/settings.example.yaml` → `config/settings.yaml` and adjust.
4. Open the folder in Claude Code and say: *"read CLAUDE.md and set up the project
   structure."*
5. Plan your first real workflow in plan mode, then build, run, and steer. See the
   [newsletter recipe](../../docs/06-workflows/recipe-newsletter-automation.md) for a
   complete worked example.

The example workflow and tool are there as patterns — replace them with your own.
