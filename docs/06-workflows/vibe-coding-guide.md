# Vibe coding — three rules that prevent the mess

AI-assisted coding is fast. It's also a trap if you don't set it up right. These three rules keep the output consistent and maintainable.

---

## Rule 1 — Monolith first, always

For beginners, a monolith is almost always the right call. It keeps logic, data, and state in one structure instead of scattering them across services with wiring, retries, and observability debt.

**Microservices solve a scaling problem, not a complexity problem.**

| Situation | Architecture |
|---|---|
| Weekend project / demo | Monolith |
| Early-stage startup | Monolith |
| Validating an idea | Monolith |
| Side project | Monolith |
| Drowning in real traffic | Consider splitting |
| Proven product with team bottlenecks | Microservices |

What microservices cost you early: service discovery and wiring, network latency, distributed tracing, separate deploy pipelines per service, retry budgets, and far more cognitive overhead.

**Rule:** Start monolith. Add services only when you have a *specific problem* that microservices actually solve.

---

## Rule 2 — Lock the backbone before you vibe-code

Never ask Claude to "build an app" without first defining four pillars. If you don't define them, the model will guess — differently in different files — leaving you with an inconsistent mess you'll spend more time untangling than building.

### The four pillars

**1. Auth — who's allowed where**
- What method? (JWT, sessions, OAuth, magic links)
- What roles exist? (admin, user, guest)
- What's protected vs public?
- Where do tokens live? (cookie, localStorage, header)

**2. Database — what data shape you're using**
- Which database? (Postgres, SQLite, MongoDB)
- Core entities and their relationships
- Normalised vs denormalised
- Migration strategy

**3. State — what's in-memory vs persisted**
- What lives in the database?
- What lives in server memory?
- What lives in client state?
- What's your state management tool? (Zustand, Redux, Context, none)

**4. File structure — how your app is organised**
- Directory layout
- How features are grouped (by type vs by feature)
- Where shared utilities live
- Import conventions

### Backbone definition template

Copy this and fill it in before every new project:

```markdown
## Project Backbone

### Auth
- Method: [JWT / sessions / OAuth / magic links]
- Roles: [list roles]
- Protected routes: [list them]
- Token storage: [cookie / localStorage / header]

### Database
- Engine: [Postgres / SQLite / MongoDB / etc.]
- Core entities: [User, Post, etc.]
- Key relationships: [User has many Posts, etc.]
- ORM / query layer: [Prisma / Drizzle / raw SQL / mongoose]

### State
- Server state: [what lives in DB]
- Server memory: [what's cached / sessions]
- Client state tool: [Zustand / Redux / Context / none]
- Client state: [what UI state is managed]

### File structure
src/
  features/     # feature modules
  lib/          # shared utilities
  api/          # route handlers / controllers
  types/        # TypeScript types
  components/   # shared UI components
```

### Without vs with backbone

**Without (the vibe-code trap):**
- Claude guesses your auth strategy → inconsistent token handling across files
- Claude guesses your schema → mismatched types between routes and models
- Claude guesses your state approach → some components use Context, some use props, some fetch directly
- You spend hours reconciling instead of building

**With backbone defined first:**
- Every new file follows the same conventions
- Every new feature slots in cleanly
- No surprise rewrites when you scale
- AI assistance is dramatically more consistent

---

## Rule 3 — Rules file, not re-prompting

Every time you re-explain how you want things styled, split, or tested, you're paying a **context tax**. Write a rules file once. Reuse it across every session forever.

### What a rules file is

A `CLAUDE.md` (or `rules.md` / `.cursorrules`) in your project root tells the model your conventions so you never have to repeat yourself. Most AI editors load it automatically.

### Starter rules template

```markdown
# Project Rules

## Naming conventions
- Variables and functions: camelCase
- Components and classes: PascalCase
- Files: kebab-case
- Constants: SCREAMING_SNAKE_CASE
- Database columns: snake_case

## Directory structure
src/
  features/       # one folder per feature, co-located tests
  lib/            # pure utility functions, no side effects
  api/            # route handlers only, thin controllers
  types/          # shared TypeScript interfaces and types
  components/     # truly shared UI components only

## Language and framework constraints
- TypeScript strict mode, no `any` types
- No class components (functional only)
- No default exports (named exports only)
- No barrel files (index.ts re-exports)

## State management
- Server state: database (Postgres via Prisma)
- Client state: Zustand (one store per feature)
- No prop drilling more than 2 levels deep

## Testing
- Framework: Vitest
- Location: co-located with source (*.test.ts)
- Coverage required: functions in /lib only
- No snapshot tests

## Code style
- Linter: ESLint with eslint-config-airbnb-typescript
- Formatter: Prettier (single quotes, no semicolons, 100 char line width)
- No console.log in committed code
- No commented-out code

## API conventions
- REST: noun-based routes (/users, /posts)
- Error format: { error: string, code: string }
- Auth: Bearer token in Authorization header
- Pagination: ?page=1&limit=20

## What NOT to do
- Don't add dependencies without asking first
- Don't refactor files outside the current task scope
- Don't use `any` to fix type errors — fix the type
- Don't write new utilities that already exist in /lib
```

### How to use it

**Option A — Save as CLAUDE.md in project root.** Claude Code loads it automatically every session.

**Option B — Paste at session start.** "Here are my project rules: [paste rules.md]"

**Option C — Prompt prefix.** Keep a snippet saved: "Using the rules in [rules.md], please [task]. Do not deviate from these conventions."

### The compounding benefit

- First prompt you use it: break even
- Every prompt after: free consistent output
- After 10 prompts: you've already saved more time than it took to write

---

## Project startup checklist

Use this at the start of every new project:

- [ ] Decided on monolith (default) or have a specific reason for services
- [ ] Auth method chosen and documented
- [ ] Database and schema sketched out
- [ ] State split defined (server / client / in-memory)
- [ ] File structure decided and written down
- [ ] Rules file created and saved as `CLAUDE.md`
