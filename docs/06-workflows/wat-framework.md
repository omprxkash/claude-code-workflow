# The WAT Framework

WAT stands for **Workflows, Agent, Tools**. It's the structure for building reliable,
reusable automations with Claude Code.

In Claude Code you have an agent and you have files. That's it. The left-hand side
is where you see the files — workflows, tools, all of it. The right-hand side is
where you talk to the agent, plan with it, and it executes. WAT is about how those
pieces are organized.

## The three pieces

**Agent** — the Claude Code agent itself. It reads workflows, runs tools, handles
errors, and improves the system over time.

**Workflows** — markdown files written in completely natural language. You could read
through every line and understand exactly what's going on. They use things like pound
signs and dashes and asterisks to separate headers and stress importance for the
agent — but it's all readable. Workflows are natural-language process instructions.

**Tools** — the individual capabilities a workflow calls. One tool per job: research,
send an email, generate an infographic, write to a sheet.

## Pick the simplest layer before you reach for WAT

Not every automation needs a full agent. Think of it as a pyramid, simplest at the
bottom:

1. **Chatbot / static template** — deterministic, same output every time. Fine when
   the process genuinely never varies.
2. **Rules-based workflow** — if/then routing, no generation. "If contact exists in
   Google Contacts, do nothing; if not, extract and add them." Fully predictable.
3. **Generative step** — AI writes the actual content (an email, a summary) inside
   an otherwise deterministic flow, instead of filling a static template.
4. **Full agent** — open-ended reasoning, decides its own steps.

Each level up buys more flexibility and costs more predictability — the higher the
autonomy, the harder it is to fully trust the output without a
[verification loop](../04-advanced/multi-agent-patterns.md#5-sub-agent-verification).
**Build the simplest layer that actually solves the problem.** An inbox-routing
task that looks like it needs a full agent often turns out to just need rules-based
workflow with one generative step for the email text — much simpler to reason about
and much cheaper to run. Reach for the full WAT/agent structure below once you've
confirmed the task genuinely needs open-ended reasoning, not before.

## The recipe analogy

Think of a workflow as a recipe. Let's use baking a chocolate cake.

The workflow is the recipe. It's going to tell you what to do in a certain order:
preheat the oven to this temperature, boil some water, crack two eggs in a bowl,
measure out a cup of flour. Those steps, in that order — that's the workflow.

The tools are all of the ingredients and appliances. But without the structure of
the workflow — without something saying "use tool 1, then tool 5, then tool 7, then
tool 10" — without the order, the tools are useless. A pile of ingredients doesn't
make a cake.

**Workflows tell the agent how to use the tools.** The ordering is what turns
capabilities into a result.

## Why structure it this way

The payoffs are readability, reliability, and self-improvement.

Workflows and tools are plain natural language — anyone can open them and follow the
logic. Because the process is written down explicitly, the same input takes the same
path every time, which is exactly what makes a workflow safe to deploy as a
deterministic automation later.

And because the agent is building and running these files, it can improve them as it
learns. When it hits an error and finds the fix, it updates the tool so the error
doesn't recur. When it discovers a better approach, it updates the workflow. The
system gets better the more you use it.

## How it lives in a project

WAT is expressed through your `CLAUDE.md` plus a folder layout:

```
project/
├── CLAUDE.md        ← tells the agent: you follow WAT, read workflows, run tools, improve the system
├── workflows/       ← one .md per process (natural language, step by step)
├── tools/           ← one file per capability
├── config/          ← settings (styles, recipients, options)
└── .env             ← secrets (never committed)
```

The `CLAUDE.md` is where you instruct the agent: *you are the agent; read the
relevant workflow; run the tools it names; on error, diagnose, fix the tool, and
record what you learned; keep secrets in `.env`.* A ready-to-copy skeleton is in
[`templates/wat-starter/`](../../templates/wat-starter/).

## The build loop

1. Plan the workflow in plan mode — describe the outcome loosely, let the agent ask
   questions, read the plan, correct it.
2. Accept. The agent generates the workflow file and its tools.
3. Add credentials to `.env`.
4. Run it once and watch closely — first run is where you steer and where the agent
   fixes its own tools.
5. Once you trust the workflows and tools, push them to a repo and schedule them.
   At that point you're deploying the code and tools, not the live agent — which is
   exactly what you want.

See the [newsletter recipe](recipe-newsletter-automation.md) for a complete build.
