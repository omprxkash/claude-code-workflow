# Trigger.dev — Real Production CLAUDE.md + Resources

Unlike the other files in this folder, this one isn't a template — it's pulled directly
from a real, currently-used monorepo: [`triggerdotdev/trigger.dev`](https://github.com/triggerdotdev/trigger.dev/blob/main/CLAUDE.md),
`main` branch. Worth reading end to end as an example of what a production `CLAUDE.md`
actually looks like once a team has used it for a while — exact commands with time
estimates, version pins with the failure mode they prevent, explicit "never do X"
rules with reasoning, and a closed vocabulary table it tells contributors not to
deviate from. Links and local setup notes follow below it.

---

## The real CLAUDE.md

````markdown
# CLAUDE.md

This file provides guidance to Claude Code when working with this repository. Subdirectory CLAUDE.md files provide deeper context when you navigate into specific areas.

## Build and Development Commands

This is a pnpm 10.33.2 monorepo using Turborepo. Run commands from root with `pnpm run`.

**Adding dependencies:** Edit `package.json` directly instead of using `pnpm add`, then run `pnpm i` from the repo root. See `.claude/rules/package-installation.md` for the full process.

```bash
pnpm run docker              # Core dev services (Postgres, Redis, Electric, MinIO, ClickHouse, s2-lite)
# pnpm run docker:full       # Same + observability stack (Prometheus, Grafana, OTEL) and chaos tooling
pnpm run db:migrate           # Run database migrations
pnpm run db:seed              # Seed the database (required for reference projects)

# Build packages (required before running)
pnpm run build --filter webapp && pnpm run build --filter trigger.dev && pnpm run build --filter @trigger.dev/sdk

pnpm run dev --filter webapp  # Run webapp (http://localhost:3030)
pnpm run dev --filter trigger.dev --filter "@trigger.dev/*"  # Watch CLI and packages
```

### Verifying Changes

The verification command depends on where the change lives:

- **Apps and internal packages** (`apps/*`, `internal-packages/*`): Use `typecheck`. **Never use `build`** for these — building proves almost nothing about correctness.
- **Public packages** (`packages/*`): Use `build`.

```bash
# Apps and internal packages — use typecheck
pnpm run typecheck --filter webapp                  # ~1-2 minutes
pnpm run typecheck --filter @internal/run-engine

# Public packages — use build
pnpm run build --filter @trigger.dev/sdk
pnpm run build --filter @trigger.dev/core
```

Only run typecheck/build after major changes (new files, significant refactors, schema changes). For small edits, trust the types and let CI catch issues.

## Testing

We use vitest exclusively. **Never mock anything** - use testcontainers instead.

```bash
pnpm run test --filter webapp                          # All tests for a package
cd internal-packages/run-engine
pnpm run test ./src/engine/tests/ttl.test.ts --run     # Single test file
pnpm run build --filter @internal/run-engine           # May need to build deps first
```

Test files go next to source files (e.g., `MyService.ts` -> `MyService.test.ts`).

### Testcontainers for Redis/PostgreSQL

```typescript
import { redisTest, postgresTest, containerTest } from "@internal/testcontainers";

redisTest("should use redis", async ({ redisOptions }) => {
  /* ... */
});
postgresTest("should use postgres", async ({ prisma }) => {
  /* ... */
});
containerTest("should use both", async ({ prisma, redisOptions }) => {
  /* ... */
});
```

## Code Style

### Formatting and linting

Format and lint are enforced by CI (`code-quality` check). Run before committing:

```bash
pnpm run format      # oxfmt — auto-fixes formatting
pnpm run lint:fix    # oxlint — auto-fixes lint violations
pnpm run lint        # oxlint — check only (no fixes)
```

### Imports

**Prefer static imports over dynamic imports.** Only use dynamic `import()` when:
- Circular dependencies cannot be resolved otherwise
- Code splitting is genuinely needed for performance
- The module must be loaded conditionally at runtime

Dynamic imports add unnecessary overhead in hot paths and make code harder to analyze. If you find yourself using `await import()`, ask if a regular `import` statement would work instead.

## Changesets and Server Changes

When modifying any public package (`packages/*` or `integrations/*`), add a changeset:

```bash
pnpm run changeset:add
```

- Default to **patch** for bug fixes and minor changes
- Confirm with maintainers before selecting **minor** (new features)
- **Never** select major without explicit approval

When modifying only server components (`apps/webapp/`, `apps/supervisor/`, etc.) with no package changes, add a `.server-changes/` file instead. See `.server-changes/README.md` for format and documentation.

## Dependency Pinning

Zod is pinned to a single version across the entire monorepo (currently `3.25.76`). When adding zod to a new or existing package, use the **exact same version** as the rest of the repo - never a different version or a range. Mismatched zod versions cause runtime type incompatibilities (e.g., schemas from one package can't be used as body validators in another).

## Architecture Overview

### Request Flow

User API call -> Webapp routes -> Services -> RunEngine -> Redis Queue -> Supervisor -> Container execution -> Results back through RunEngine -> ClickHouse (analytics) + PostgreSQL (state)

### Apps

- **apps/webapp**: Remix 2.17.4 app - main API, dashboard, orchestration. Uses Express server.
- **apps/supervisor**: Manages task execution containers (Docker/Kubernetes).

### Public Packages

- **packages/trigger-sdk** (`@trigger.dev/sdk`): Main SDK for writing tasks
- **packages/cli-v3** (`trigger.dev`): CLI - also bundles code that goes into customer task images
- **packages/core** (`@trigger.dev/core`): Shared types. **Import subpaths only** (never root).
- **packages/build** (`@trigger.dev/build`): Build extensions and types
- **packages/react-hooks**: React hooks for realtime and triggering
- **packages/redis-worker** (`@trigger.dev/redis-worker`): Redis-based background job system

### Internal Packages

- **internal-packages/database**: Prisma 6.14.0 client and schema (PostgreSQL)
- **internal-packages/clickhouse**: ClickHouse client, schema migrations, analytics queries
- **internal-packages/run-engine**: "Run Engine 2.0" - core run lifecycle management
- **internal-packages/redis**: Redis client creation utilities (ioredis)
- **internal-packages/testcontainers**: Test helpers for Redis/PostgreSQL containers
- **internal-packages/schedule-engine**: Durable cron scheduling
- **internal-packages/zodworker**: Graphile-worker wrapper (DEPRECATED - use redis-worker)

### Legacy V1 Engine Code

The `apps/webapp/app/v3/` directory name is misleading - most code there is actively used by V2. Only specific files are V1-only legacy (MarQS queue, triggerTaskV1, cancelTaskRunV1, etc.). See `apps/webapp/CLAUDE.md` for the exact list. When you encounter V1/V2 branching in services, only modify V2 code paths. All new work uses Run Engine 2.0 (`@internal/run-engine`) and redis-worker.

### Documentation

Docs live in `docs/` as a Mintlify site (MDX format). See `docs/CLAUDE.md` for conventions.

### Reference Projects

Reference/example projects for testing SDK and platform features live in a separate repo: [`triggerdotdev/references`](https://github.com/triggerdotdev/references). Clone it alongside this repo and use its `projects/hello-world` to manually test changes before submitting PRs. See that repo's README for setup and linking to a local monorepo build.

## Docker Image Guidelines

When updating Docker image references:

- **Always use multiplatform/index digests**, not architecture-specific digests
- Architecture-specific digests cause CI failures on different build environments
- Use the digest from the main Docker Hub page, not from a specific OS/ARCH variant

## Writing Trigger.dev Tasks

Always import from `@trigger.dev/sdk`. Never use `@trigger.dev/sdk/v3` or deprecated `client.defineJob`.

```typescript
import { task } from "@trigger.dev/sdk";

export const myTask = task({
  id: "my-task",
  run: async (payload: { message: string }) => {
    // Task logic
  },
});
```

### SDK Documentation Rules

The `rules/` directory contains versioned SDK documentation distributed via the SDK installer. Current version: `rules/manifest.json`. Do NOT update `rules/` or `.claude/skills/trigger-dev-tasks/` unless explicitly asked - these are maintained in separate dedicated passes.

## Testing with the hello-world Reference Project

The reference projects live in the separate [`triggerdotdev/references`](https://github.com/triggerdotdev/references) repo - clone it alongside this repo.

First-time setup:

1. `pnpm run db:seed` to seed the database (creates the References org + hello-world project)
2. Build the CLI/packages you want to test: `pnpm run build --filter trigger.dev`
3. In your `references` clone, follow its README to link to your local monorepo build, then authorize: `cd projects/hello-world && pnpm exec trigger login -a http://localhost:3030`

Running (from your `references` clone): `cd projects/hello-world && pnpm exec trigger dev`

## Local Task Testing Workflow

### Step 1: Start Webapp in Background

```bash
# Run from repo root with run_in_background: true
pnpm run dev --filter webapp
curl -s http://localhost:3030/healthcheck  # Verify running
```

### Step 2: Start Trigger Dev in Background

```bash
# in your triggerdotdev/references clone
cd projects/hello-world && pnpm exec trigger dev
# Wait for "Local worker ready [node]"
```

### Step 3: Trigger and Monitor Tasks via MCP

```
mcp__trigger__get_current_worker(projectRef: "proj_rrkpdguyagvsoktglnod", environment: "dev")
mcp__trigger__trigger_task(projectRef: "proj_rrkpdguyagvsoktglnod", environment: "dev", taskId: "hello-world", payload: {"message": "Hello"})
mcp__trigger__list_runs(projectRef: "proj_rrkpdguyagvsoktglnod", environment: "dev", taskIdentifier: "hello-world", limit: 5)
```

Dashboard: http://localhost:3030/orgs/references-9dfd/projects/hello-world-97DT/env/dev/runs
````

*(This repo also mirrors skill-loading and debug-tracing conventions specific to trigger.dev's own tooling below that point in the source file — trimmed here since they reference internal packages not relevant outside that repo. See the [live file](https://github.com/triggerdotdev/trigger.dev/blob/main/CLAUDE.md) for the full version.)*

## Links

| Resource | URL |
|---|---|
| Community guide (Skool) | https://www.skool.com/ai-automation-society/classroom/076a1c6e?md=ffb758ec441645258cf07c1b45920edc |
| Claude Code official docs | https://code.claude.com/docs |

## MCP Setup

Add trigger.dev as an MCP server in your project's `.mcp.json`:

```json
{
  "mcpServers": {
    "trigger": {
      "command": "npx",
      "args": ["trigger.dev@4.4.0", "mcp"]
    }
  }
}
```

Or via CLI:

```bash
claude mcp add-json trigger '{"command": "npx", "args": ["trigger.dev@4.4.0", "mcp"]}' --scope project
```

## Project Folder (`D:\AI\Automation`)

Files in the local Trigger.dev project:

- `CLAUDE.md` — project brain
- `trigger-ref.md` — Trigger.dev API reference notes. The real content now lives in this
  repo too: [`templates/system-prompts/trigger-ref.md`](./trigger-ref.md) — full SDK v4 code examples
  (tasks, cron schedules, schema validation, triggering patterns, idempotency, waits,
  debouncing, retry config, the orchestrator+processor pattern, and the v2 syntax to
  never use).
- `.mcp.json` — MCP server config (trigger.dev)
- `.env` — credentials (gitignored)

## Local Project Folders (Full Reference)

| Project | Path |
|---|---|
| Skills system (26 skills, 4 subagents) | `D:\Work\Claude\All Of My Claude Skills\` |
| Website design | `D:\Work\Claude\Website Design General\` |
| WAT workflow | `D:\AI\Workflow\` |
| Executive assistant | `D:\AI\EA\` |
| Automation / Trigger.dev | `D:\AI\Automation\` |
