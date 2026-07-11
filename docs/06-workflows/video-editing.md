# AI Video Editing with Claude Code

Two methods for creating animated video content — motion graphics, text overlays, subtitles, and branded sequences — without touching a timeline editor manually.

---

## Method 1 — Claude Design (fast, web-based)

Claude Design creates HTML-based animations you can export to MP4 via Claude Code. Good for: product promos, release announcements, short social content.

**Workflow:**

1. Open Claude Design → New → Animation → give it a name
2. Attach your video file (MP4)
3. Paste in your transcript with rough timestamps — Claude Design can't listen to the video, so it needs the text to know what to animate and when
4. Answer the style questions (talking head position, visual energy, motion graphic types, brand/color)
5. Let it generate → review → iterate

**Export to MP4:**  
Claude Design doesn't export MP4 directly. Two options:
- Short clips: go fullscreen and screen record
- Longer: use "Hand off to Claude Code" → copy the command → run it in Claude Code → it renders via ffmpeg and gives you a download

**Limitations:**
- Can't listen to/transcribe the video — you have to provide the transcript
- No direct MP4 export (screen recording or Claude Code handoff)
- Less customizable than Hyperframes

---

## Method 2 — Hyperframes (more powerful, more setup)

[HeyGen's Hyperframes](https://github.com/HeyGen-Official/hyperframes) is an HTML-to-video tool designed for agents. Claude Code writes the animation as HTML, renders it in the browser via ffmpeg, and outputs an MP4. More setup than Claude Design but dramatically more control.

**Tech stack:**
- Claude Code writes the animation logic as HTML/JS
- Hyperframes provides component catalog (Mac notifications, app reveals, terminal animations, 3D UI reveals, phone mockups, etc.)
- Whisper (local or OpenAI API) transcribes the video with word-level timestamps
- ffmpeg renders HTML → MP4

**Setup:**

```
# Give Claude Code the repo URL and ask it to get you set up:
"Analyze this repo and help me set up my own video editing studio: 
https://github.com/HeyGen-Official/hyperframes"

# Claude Code will install dependencies and scaffold the project
```

Once set up, drop in video files and use the `make-a-video` skill (or describe what you want):

```
Use the make-a-video skill on golden-ratio-demo.mp4 that I've dropped into the root.
Help me figure out how to animate it.
```

---

## The iteration loop

Both methods require iteration. Expect 3–5 rounds per video.

**Round 1 — First render**
Claude generates V1. Review it. Don't try to give all feedback at once — focus on the most broken things first.

**Giving feedback:**
Treat it like feedback to a human editor. Be specific about timestamps:

```
Overall the vibe is good. A few fixes:
- At 4-7 seconds: the golden ratio title text is completely blurred out — 
  the blur effect needs to go behind the text, not on top of it
- At 12 seconds: the 60% sign is cut off on the left — scale it down slightly
- At 22 seconds: looks good, no changes
```

Voice dictation helps here — you're looking at the video and talking, not typing.

**Context management during editing:**  
Video editing generates a lot of tokens (all that HTML output). When you hit ~250K tokens, do a session handoff before clearing:

```
Give me a summary of everything you've built and where the files are.
```

Copy → `/clear` → paste → continue. The next session picks up exactly where you left off.

---

## Transcription

Hyperframes needs word-level timestamps to sync text and motion graphics to what you're saying. Two options:

**Local (faster, uses RAM):**
```
# Claude Code can install whisper.cpp for you — just ask
# "Help me transcribe this video file locally with word-level timestamps"
```

**OpenAI API (better if running multiple videos at once):**
Provide your `OPENAI_API_KEY` and Claude Code will use OpenAI's Whisper endpoint instead. Less RAM pressure.

The transcript comes back as JSON with timestamps — Claude Code uses this to know when to animate what.

---

## Component catalog

Hyperframes ships with pre-built components you can reference directly:
- Mac OS notifications
- Reddit postcards  
- App store showcases
- 3D UI reveals
- Terminal animations
- Phone mockups
- Chromatic radial splits
- Audio-reactive elements
- Karaoke-style subtitles

Tell Claude Code which ones to use, or have it browse the catalog and pick appropriate ones.

---

## Build your own "video editing studio"

The key is accumulating skills over time. After each iteration:

```
Build a skill for what you just did — the layout logic, the animation style,
the component choices. Save it so the next video can start from this baseline.
```

Every video you make teaches your Claude Code project what you like. Over time you stop correcting the same things repeatedly.

---

## Cost and speed

- Each full video editing session (setup + 3-4 iterations) uses ~10-15% of a Max plan's 5-hour window
- Rendering is CPU/RAM heavy — only run one video at a time if your machine is straining
- Token cost comes from HTML output (long), not the video file itself

**Practical limit:** A 37-second video with 4 iteration rounds took ~15% of a $200/month Max plan's session budget.

---

## When to use which method

| | Claude Design | Hyperframes |
|---|---|---|
| Setup time | Minutes | 15-30 min |
| Customization | Limited | Full |
| Component catalog | Basic | Extensive |
| Export | Screen record or Claude Code handoff | Direct MP4 via ffmpeg |
| Best for | Quick promos, announcements | Polished branded content, shorts |

Start with Claude Design. Move to Hyperframes when you need more control or want to build a reusable studio.
