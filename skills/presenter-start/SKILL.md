---
name: presenter-start
description: Find where to start when preparing a speech or presentation. Use when the user is unsure which presenter skill to use, or says only that they have to give a talk.
---

# Presenter start

Name the next skill and why. This skill writes no files and never runs another skill; it only points. Converse in the user's language.

## 1. Read the folder

List `presentation/` in the working directory and note which of `brief.md`, `hook.md`, `story.md`, `outline.md`, `script.md`, `slides.md` and `slidedoc.md` exist. The folder answers most questions on its own.

Done when you can name the state from the table.

## 2. Route

| State | Next skill | Reason to give |
|---|---|---|
| Empty or no folder | Ask the one question below, then route from the answer | Nothing is saved, so the user's answer decides |
| Brief only | `structuring` if the user has material to organize; `storytelling` if they want a hook or a story | The brief fixes the audience and core message, so the next piece can start |
| Hook or story only | `presentation-brief` | The hook and story need an audience and a core message before they can be placed |
| Outline only | `scripting` | The outline already records the core message, goal and duration |
| Brief and outline | `storytelling` if the outline says "hook needed"; otherwise `scripting` | The outline is ready for words, and a missing hook should come first |
| Script | `slide-plan` for slides shown live; `slidedoc` for slides read alone | The words exist, so visuals can follow from them |
| Slide plan | Done; offer `slidedoc` for a reading version, or `scripting` to revise the words | Every stage has output |
| Slidedoc only | `scripting` if the user will also present live; otherwise done | A live talk needs its script before its slides |
| Slide plan and slidedoc | Done; offer `scripting` to revise the words | Every stage has output |

When the state needs a choice between two skills, that choice is the one question.

## 3. The one question

Ask at most one question in the whole run. For an empty folder, ask: "What do you have today: only an idea, rough materials, a draft script, or slides?" Route from the answer:

- An idea, or rough materials: `presentation-brief`.
- A draft script: `scripting`, which improves an existing draft without an outline.
- Slides meant to be read: `slidedoc`.
- Slides already built for a talk: `scripting` first, to write what is said, then `slide-plan`.

Done when the user has the name of one skill.

## 4. Reply

Give the skill name and a one-line reason, and tell the user how to start it. Mention one alternative only when the user's answer allows two.

Done when the reply holds the skill name, a one-line reason and nothing else to do.
