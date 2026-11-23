#!/usr/bin/env bash
# Structure and provenance checks for the plugin (ticket 01).
set -u
cd "$(dirname "$0")/.."

fail=0
check() { # description, command...
  local desc="$1"; shift
  if "$@" >/dev/null 2>&1; then echo "ok   - $desc"; else echo "FAIL - $desc"; fail=1; fi
}

SKILL=skills/presenting-vocabulary/SKILL.md
PUBLISHED=(README.md LICENSE CONTEXT.md .claude-plugin skills docs tests/check-plugin.sh)

check "plugin manifest is valid JSON"      python3 -c 'import json;json.load(open(".claude-plugin/plugin.json"))'
check "marketplace manifest is valid JSON" python3 -c 'import json;json.load(open(".claude-plugin/marketplace.json"))'
check "marketplace lists the plugin"       grep -q '"presenter-skills"' .claude-plugin/marketplace.json
check "MIT license present"                grep -q "MIT License" LICENSE
check "skill has name in frontmatter"      grep -q '^name: presenting-vocabulary$' "$SKILL"
check "skill has description"              grep -q '^description: .\{20,\}' "$SKILL"
check "README has Sources section"         grep -q '^## Sources' README.md
check "README has provenance note"         grep -qi 'own training and practice' README.md
check "README has install instructions"    grep -qi '## Install' README.md

# Every glossary term in CONTEXT.md appears in the skill.
terms=$(grep -o '^\*\*[^*]*\*\*' CONTEXT.md | tr -d '*')
while IFS= read -r term; do
  [ -z "$term" ] && continue
  check "skill defines: $term" grep -qF "$term" "$SKILL"
done <<< "$terms"

# Sources and myths.
check "skill explains both evidence tags" \
  bash -c "grep -q 'research-backed' '$SKILL' && grep -q 'craft heuristic' '$SKILL'"
check "every framework row is tagged" \
  bash -c "! grep '^| ' skills/presenting-vocabulary/FRAMEWORKS.md | tail -n +3 | grep -vE 'research-backed|craft heuristic'"
check "Mehrabian myth is called out" grep -qi 'mehrabian' "$SKILL"

# Provenance: banned terms come from a local-only list, so this file stays publishable.
if [ -f tests/banned-terms.txt ]; then
  check "no course names or labels in published files" \
    bash -c "! grep -rFi -f tests/banned-terms.txt ${PUBLISHED[*]}"
else
  echo "skip - provenance scan (tests/banned-terms.txt not present)"
fi

# Every top-level directory that is not part of the plugin must be git-ignored.
for d in */; do
  d=${d%/}
  case "$d" in skills|tests|docs) continue;; esac
  check "non-plugin directory is git-ignored: $d" grep -qF "$d" .gitignore
done
check "pre-split SKILL.md is git-ignored" grep -qx '/SKILL.md' .gitignore

# Ticket 02: presentation-brief.
BRIEF=skills/presentation-brief/SKILL.md
FORMAT=skills/presentation-brief/BRIEF-FORMAT.md
check "brief skill has name in frontmatter" grep -q '^name: presentation-brief$' "$BRIEF"
check "brief skill has description"         grep -q '^description: .\{20,\}' "$BRIEF"
for h in Occasion Audience Before-state After-state Goal Material "Opening and closing ideas" "Core message" "Style notes"; do
  check "brief format has section: $h" grep -q "^## $h" "$FORMAT"
done
check "brief format records what the audience knows about the speaker" grep -qi 'knows about the speaker' "$FORMAT"
check "brief skill asks before drafting"    grep -q 'Do not draft' "$BRIEF"
check "brief skill requires confirmed core message" grep -qi 'confirm' "$BRIEF"
check "brief skill skips questions already answered" grep -qi 'already answered' "$BRIEF"
check "brief skill points to its format file" grep -q 'BRIEF-FORMAT.md' "$BRIEF"
check "style notes are free text, no voice-profile schema" \
  bash -c "! grep -rqi 'voice profile' skills"
check "README marks presentation-brief available" \
  grep -q '`presentation-brief` .*available' README.md

# Ticket 03: storytelling.
STORY=skills/storytelling/SKILL.md
check "storytelling skill has name in frontmatter" grep -q '^name: storytelling$' "$STORY"
for w in hook story anecdote opening; do
  check "storytelling description triggers on: $w" \
    bash -c "grep '^description:' '$STORY' | grep -qi '$w'"
done
for m in 'information gap' 'anomaly' 'expectation break'; do
  check "storytelling names hook mechanism: $m" grep -qi "$m" "$STORY"
done
for e in hero desire obstacle change lesson; do
  check "storytelling story element: $e" grep -qi "$e" "$STORY"
done
check "storytelling covers the Sinatra test"        grep -q 'Sinatra test' "$STORY"
check "storytelling asks for real material first"   grep -qi 'real material' "$STORY"
check "storytelling works without a brief"          grep -qi 'no .presentation/brief.md' "$STORY"
check "storytelling writes hook.md and story.md"    bash -c "grep -q 'hook.md' '$STORY' && grep -q 'story.md' '$STORY'"
check "storytelling has no humor content"           bash -c "! grep -qiE 'humou?r|joke' '$STORY'"
check "README marks storytelling available" grep -q '`storytelling` .*available' README.md

# Ticket 04: structuring.
STRUCT=skills/structuring/SKILL.md
OUTLINE=skills/structuring/OUTLINE-FORMAT.md
check "structuring skill has name in frontmatter" grep -q '^name: structuring$' "$STRUCT"
for w in outline structure; do
  check "structuring description triggers on: $w" \
    bash -c "grep '^description:' '$STRUCT' | grep -qi '$w'"
done
for p in 'problem' 'anecdote' 'case' 'data' 'thesis' 'SCQA'; do
  check "structuring body pattern: $p" grep -qi "$p" "$STRUCT"
done
check "structuring ties blocks to the core message"  grep -qi 'core message' "$STRUCT"
check "structuring lists cuts with reasons"          grep -qi 'cut' "$STRUCT"
check "structuring requires exactly one call to action" grep -qi 'exactly one call to action' "$STRUCT"
check "structuring makes timings add up"             grep -qi 'add up' "$STRUCT"
check "structuring works without a brief"            grep -qi 'no .presentation/brief.md' "$STRUCT"
check "structuring reads teach or persuade goal"     grep -qi 'persuade' "$STRUCT"
check "structuring has no sales-funnel or pricing content" \
  bash -c "! grep -qiE 'funnel|pricing' '$STRUCT'"
check "structuring points to its format file"        grep -q 'OUTLINE-FORMAT.md' "$STRUCT"
for h in Opener Body Close Cuts; do
  check "outline format has section: $h" grep -q "^## $h" "$OUTLINE"
done
check "README marks structuring available" grep -q '`structuring` .*available' README.md

# Ticket 05: scripting.
SCRIPTING=skills/scripting/SKILL.md
SCRIPTFMT=skills/scripting/SCRIPT-FORMAT.md
check "scripting skill has name in frontmatter" grep -q '^name: scripting$' "$SCRIPTING"
for w in script draft; do
  check "scripting description triggers on: $w" \
    bash -c "grep '^description:' '$SCRIPTING' | grep -qi '$w'"
done
check "scripting is written for the ear"          grep -qi 'aloud' "$SCRIPTING"
check "scripting uses the ladder of abstraction"  grep -qi 'ladder of abstraction' "$SCRIPTING"
check "scripting requires concrete examples or analogies" \
  bash -c "grep -qi 'concrete' '$SCRIPTING' && grep -qi 'analogy' '$SCRIPTING'"
check "scripting makes causes explicit"           grep -qi 'cause' "$SCRIPTING"
check "scripting reads style notes"               grep -qi 'style notes' "$SCRIPTING"
check "scripting never copies another speaker's phrases" grep -qi "another speaker's" "$SCRIPTING"
check "scripting uses hook and story as given"    grep -qi 'as given' "$SCRIPTING"
check "scripting offers 2-3 drafts of key passages" grep -q '2–3 drafts' "$SCRIPTING"
check "scripting accepts an existing draft"       grep -qi 'existing draft' "$SCRIPTING"
check "scripting works without an outline"        grep -qi 'no .presentation/outline.md' "$SCRIPTING"
check "scripting matches script length to duration" grep -qi 'words per minute' "$SCRIPTING"
check "scripting points to its format file"       grep -q 'SCRIPT-FORMAT.md' "$SCRIPTING"
for h in 'Cue ids' 'Markers'; do
  check "script format has section: $h" grep -q "^## $h" "$SCRIPTFMT"
done
check "README marks scripting available" grep -q '`scripting` .*available' README.md

# Ticket 06: slide-plan.
PLAN=skills/slide-plan/SKILL.md
PLANFMT=skills/slide-plan/SLIDES-FORMAT.md
check "slide-plan skill has name in frontmatter" grep -q '^name: slide-plan$' "$PLAN"
for w in slide script; do
  check "slide-plan description triggers on: $w" \
    bash -c "grep '^description:' '$PLAN' | grep -qi '$w'"
done
for r in teaser amplifier punchline; do
  check "slide-plan role: $r" grep -qi "$r" "$PLAN"
done
check "slide-plan gives each slide one role and one idea" grep -qi 'one role and one idea' "$PLAN"
check "slide-plan anchors slides to cue ids"       grep -qi 'cue id' "$PLAN"
check "slide-plan forbids bullet lists"            grep -qi 'bullet' "$PLAN"
check "slide-plan reveals long text in fragments"  grep -qi 'fragments' "$PLAN"
for g in contrast whitespace typefaces colors; do
  check "slide-plan visual guidance: $g" grep -qi "$g" "$PLAN"
done
check "slide-plan covers live slides only and points to slidedoc" \
  bash -c "grep -qi 'live slides' '$PLAN' && grep -q 'slidedoc' '$PLAN'"
check "slide-plan justifies slide count from the script" grep -qi 'slide count' "$PLAN"
check "slide-plan sends users without a script to scripting" grep -qi 'no .presentation/script.md' "$PLAN"
check "slide-plan points to its format file"       grep -q 'SLIDES-FORMAT.md' "$PLAN"
for h in Role Headline Visual Reveal Cue; do
  check "slides format has field: $h" grep -qi "$h" "$PLANFMT"
done
check "README marks slide-plan available" grep -q '`slide-plan` .*available' README.md

exit $fail
