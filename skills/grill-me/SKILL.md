---
name: grill-me
description: Use when someone wants to be interviewed, interrogated, or questioned to extract knowledge about themselves, their business, their project, or their goals. Pulls structured information out of the user's head and saves it to files.
argument-hint: [topic — e.g. "my business", "this project", "my AIOS setup"]
---

## What This Skill Does

Conducts a relentless, structured interview to extract everything Claude needs to know about a topic from the user's head. At the end, it saves the results as usable context files in your project.

Use this to:
- Bootstrap a new AIOS — "Use grill-me to learn everything about my business"
- Start a new project with rich context upfront
- Extract preferences, constraints, or goals before building something
- Replace the "explain yourself again" pattern with a one-time interrogation

Extracts knowledge systematically through structured Q&A, then saves it as usable context files rather than leaving it buried in conversation history.

---

## Steps

### Phase 1 — Setup

1. If `$ARGUMENTS` is provided, the topic is `$ARGUMENTS`. Otherwise, ask: "What do I need to grill you about? (your business, this project, your goals — anything)"
2. Create the folder `brainstorm/` in the project root if it doesn't exist.
3. Tell the user: "I'm going to ask you questions one at a time. Answer however feels natural. I'll keep going until I have enough to actually be useful. Ready?"

### Phase 2 — The Interview

Ask questions **one at a time**. Do NOT ask multiple questions in a single message. Wait for the answer before asking the next one.

Work through these areas in order, skipping areas that don't apply:

**About you / the person:**
- What do you do day-to-day?
- What are you trying to build or achieve in the next 90 days?
- What would a perfect week look like for you?
- What keeps getting in the way?

**About the business / project:**
- Describe what you're building in one sentence. Now describe it to a 10-year-old.
- Who is the customer? What does that person look like?
- What does winning look like — 6 months from now?
- What's the biggest bottleneck right now?
- What have you already tried that didn't work?

**About tools / workflow:**
- What tools do you open every single day?
- Where does the most important data live? (email, CRM, spreadsheet, Notion?)
- What tasks do you do repeatedly that you wish you could skip?
- If you could hand one thing off to an AI today, what would it be?

**About constraints:**
- What can't be automated? What needs a human?
- Are there sensitive things Claude should NOT touch?
- What's your budget/time/technical level?

**Open floor:**
- What did I miss? What do you wish I'd asked?
- What's the most important thing I should know about this that we haven't covered?

Keep asking follow-up questions until you have **95% confidence** you understand the topic well enough to be genuinely useful. Aim for at least 15 questions, but go longer if there's more to extract. Don't rush.

### Phase 3 — Save the results

Once the interview is complete:

1. Synthesize everything into a structured document.
2. Save to `brainstorm/[topic-slug]-[YYYY-MM-DD].md` using today's date.
3. If the topic is "my business" or "my AIOS" and a `context/about-me.md` or `context/about-business.md` file exists, ask: "Should I update those context files with what I've learned?" If yes, merge the new information in.

**Output format:**

```markdown
# Grill Me Session: [topic]
*Date: [date]*

## Summary
[2-3 sentence synthesis of the most important things learned]

## Key Facts
- [fact]
- [fact]
...

## Goals & Priorities
- [goal]
- [goal]

## Constraints & Guardrails
- [constraint]
- [constraint]

## Opportunities / Things to Automate
- [opportunity]
- [opportunity]

## Raw Q&A
[condensed version of key exchanges]
```

---

## Notes

- Never ask multiple questions at once. One at a time, always.
- Push back when answers are vague. "Tell me more" or "What does that look like in practice?" — don't accept non-answers.
- The goal is extraction, not validation. Don't affirm every answer. Just probe.
- Don't stop early because the user seems satisfied. Keep going until YOU have what you need.
- The brainstorm doc is the output, not the conversation. Make it something future sessions can actually use.
