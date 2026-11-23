---
name: slide-plan
description: Plan the live slides for a talk from its script. Use when the user has a script and wants to know which slides to show, what goes on each, and when each appears; not for slides meant to be read.
---

# Slide plan

Produce `presentation/slides.md`: a written plan of the **live slides**, one entry per slide. It stops at the plan; building the slides in a tool is left to the user or another tool. Terms follow `presenting-vocabulary`; the layout is in [SLIDES-FORMAT.md](SLIDES-FORMAT.md).

For slides meant to be read without a speaker, use `slidedoc`.

## 1. Gather

Read `presentation/script.md` and `presentation/brief.md`. With no `presentation/script.md`, send the user to `scripting` first, because the plan is derived from the script and never the other way round.

Done when you know the core message, the script's cue ids and the setting (room size, live or online).

## 2. Find the moments

Read the script and mark every moment where a slide would do a job the speaker's voice cannot: raise a question, show something that is hard to say, or land a conclusion. Every other moment has no slide. Slide count follows from this list, never from a slides-per-minute rule.

Done when each marked moment names its cue id and the job it does.

## 3. Assign one role and one idea

Give each slide one role and one idea, so it has exactly one job:

- **Teaser**: hangs a question in the audience's mind before the speaker answers it.
- **Amplifier**: shows a diagram, simple chart, image or number that strengthens what is being said (picture superiority is research-backed).
- **Punchline**: appears at the moment the key conclusion is spoken.

Write the headline as the single word, number or short phrase the audience should remember.

Done when every slide has a role, a headline of at most one idea, and a cue id.

## 4. Visual and reveal

For each slide choose the visual and the order in which things appear.

- No bullet lists. Use one word, one image, or an icon with a short label.
- Show long text in fragments, revealed as the speaker reaches each part, so the audience listens instead of reading ahead.
- Use contrast to make the one important element stand out (Gestalt, research-backed), and leave whitespace around it.
- Use one or two typefaces and three or four colors across all slides, with high contrast between text and background.

Done when every slide has a visual and a reveal order, and no slide has a bullet list.

## 5. Write

Write `presentation/slides.md` in the SLIDES-FORMAT.md layout. State the slide count and why each slide exists. Tell the user that `slidedoc` makes the reading version.

Done when the file exists and the user has confirmed it.
