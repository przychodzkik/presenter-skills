---
name: slidedoc
description: Write a slidedoc, slides that a reader can follow without a speaker. Use when the user wants text-heavy or send-ahead slides, with or without a talk behind them.
---

# Slidedoc

Produce `presentation/slidedoc.md`: a **slidedoc** (craft heuristic, Duarte) that carries its whole argument without a speaker. It is a separate document, not derived from `presentation/slides.md`, because live slides are sparse on purpose and a slidedoc must be complete. Terms follow `presenting-vocabulary`; the layout is in [SLIDEDOC-FORMAT.md](SLIDEDOC-FORMAT.md). Converse and write file contents in the user's language; keep file names and section headings in English so the other skills can find them.

## 1. Gather

Read `presentation/brief.md` and `presentation/script.md`. With no `presentation/script.md`, start from the brief and the raw materials the user supplies; if there is no brief, ask at most four questions: the core message, the reader and what they already know, the length they will accept, and the action you want them to take.

Done when you can state the core message, the reader, what they should do afterwards, and the material you will use.

## 2. Plan the argument

List the slides as a chain of claims: each slide makes one point, and each point follows from the one before. Order for a reader who may skim: the conclusion and the requested action come early, the evidence follows.

Done when each slide has a claim, the claims form a chain that reaches the core message, and the user agrees with the list.

## 3. Write each slide

Give every slide:

- A **full-sentence title** that states its point, so skimming the titles alone tells the argument.
- A body that supports the title with evidence, a number, an example or a diagram description.
- A takeaway line when the slide is long.

Dense text is fine here. Make it readable with hierarchy: short paragraphs, grouped points, and the most important sentence first.

Write for a reader without a speaker: define every term, and avoid phrases that depend on a speaker, such as "as I said" or "as you saw".

Done when every slide passes these three rules and every claim has its support on the same slide.

## 4. Write

Write `presentation/slidedoc.md` in the SLIDEDOC-FORMAT.md layout. Tell the user that `slide-plan` makes the sparse version for presenting live.

Done when the file exists and the user has confirmed it.
