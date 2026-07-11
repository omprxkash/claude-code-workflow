# Recipe: video editing pipeline

A talking-head video editing workflow — remove silences, enhance audio, add a
3D swivel teaser — automated with Claude Code + Python scripts.

## What it does

1. **Silence removal** — neural voice activity detection (Silero VAD) cuts dead air
2. **Audio enhancement** — EBU R128 normalization (-16 LUFS), 80Hz highpass
3. **3D swivel teaser** — 5-second fast-forward preview inserted at 3s
4. **Metadata** — Whisper transcription + Claude-generated chapters and summary

Raw recording → upload-ready video in one command.

## Prerequisites

```bash
pip install anthropic faster-whisper python-dotenv torch torchvision
brew install ffmpeg   # macOS; Windows: choco install ffmpeg
```

Environment:
```
ANTHROPIC_API_KEY=sk-ant-...
AUPHONIC_API_KEY=...   # optional — for direct YouTube upload via Auphonic
```

## File structure

```
execution/
├── jump_cut_vad_parallel.py    # silence removal via neural VAD (always use this)
├── insert_3d_transition.py     # 3D swivel teaser
└── simple_video_edit.py        # FFmpeg-only alternative (no torch required)
directives/
├── smart_video_edit.md
├── jump_cut_vad.md
└── pan_3d_transition.md
.tmp/
└── bg.png                      # optional background for the swivel
```

## The one-liner

```bash
python3 execution/jump_cut_vad_parallel.py input.mp4 .tmp/edited.mp4 --enhance-audio && \
python3 execution/insert_3d_transition.py .tmp/edited.mp4 output.mp4 --bg-image .tmp/bg.png
```

## Step by step

### Step 1 — Silence removal

```bash
# Basic
python3 execution/jump_cut_vad_parallel.py input.mp4 output.mp4

# With audio enhancement (recommended)
python3 execution/jump_cut_vad_parallel.py input.mp4 .tmp/edited.mp4 --enhance-audio

# With restart detection (removes "cut cut" mistake takes)
python3 execution/jump_cut_vad_parallel.py input.mp4 .tmp/edited.mp4 \
    --enhance-audio --detect-restarts

# With LUT color grading
python3 execution/jump_cut_vad_parallel.py input.mp4 .tmp/edited.mp4 \
    --enhance-audio --apply-lut .tmp/cinematic.cube
```

Always use `jump_cut_vad_parallel.py` — it's 5–10× faster than the single-pass version.

### Step 2 — Add 3D swivel teaser

```bash
# Default: inserts at 3s, previews content from 1:00 at 60× speed
python3 execution/insert_3d_transition.py .tmp/edited.mp4 output.mp4

# With background image
python3 execution/insert_3d_transition.py .tmp/edited.mp4 output.mp4 \
    --bg-image .tmp/bg.png

# Custom timing
python3 execution/insert_3d_transition.py .tmp/edited.mp4 output.mp4 \
    --insert-at 5 --duration 3 --teaser-start 90
```

What the viewer sees:
```
[0-3s intro] → [3-8s swivel preview at 60× speed] → [8s+ edited content]
Audio: original audio plays continuously throughout
```

## Audio normalization spec

| Parameter | Value | Purpose |
|---|---|---|
| `highpass=f=80` | 80 Hz | Remove low-frequency rumble |
| `I=-16` | -16 LUFS | YouTube loudness standard |
| `TP=-1.5` | -1.5 dBTP | True peak limit |
| `LRA=11` | 11 LU | Loudness range |

## Recording workflow

1. Hit record — a 1–3s silent intro is fine, it gets cut
2. Speak normally with natural pauses
3. Mistake? Pause 3+ seconds and redo — the silence is cut automatically
4. Stop recording

## Troubleshooting

| Problem | Fix |
|---|---|
| Audio too quiet | Don't pass `--no-normalize` — normalization is on by default |
| Cuts feel abrupt | `--silence-duration 5` — only cut longer pauses |
| Too much content cut | `--silence-threshold -40` (less strict threshold) |
| Breathing not cut | `--silence-threshold -30` (more strict) |
| Hardware encoding fails | Script auto-falls back to `libx264` |

## FFmpeg-only alternative (simpler, no PyTorch)

```bash
python3 execution/simple_video_edit.py \
    --video input.mp4 \
    --title "My Video Title" \
    --no-upload
```

Less accurate than neural VAD for detecting speech vs. background noise, but no
heavy ML dependencies. Good for quick edits or environments where PyTorch is
unavailable.
