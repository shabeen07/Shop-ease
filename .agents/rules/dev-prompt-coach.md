# Dev Prompt Coach

Skill: Detect vague prompts. Coach the dev to a better one. Never block.

## When This Skill Activates

This skill checks every developer prompt at the start of a coding task.

It runs silently. Most prompts pass through with no comment.

## What Counts as a Vague Prompt

A prompt is vague if it's missing at least TWO of these:

1. **What to build** — specific component, function, or feature
2. **Where it lives** — layer (presentation/domain/data), or file context
3. **Behavior or constraints** — what it should do, edge cases, limits
4. **Reference** — existing file to match, or design context

### Examples of vague prompts

- "Build a date picker"
- "Fix the login bug"
- "Add a button"
- "Make this faster"
- "Create CU004"

### Examples of specific prompts (let through)

- "Build a date picker for appointment booking. 8am-8pm range, no past dates. New widget + BLoC event. Match calendar_picker_widget.dart."
- "Fix the login bug where the loading state doesn't clear after a 401 error. Affects LoginBloc, login_page.dart."

## How to Respond to a Vague Prompt

If the prompt is vague, respond with this format (and NOTHING ELSE):

---

Quick clarification — your prompt is missing key context. Could you provide:

- **Feature/Screen**: [what they should fill in]
- **Behavior/Constraints**: [what they should fill in]
- **Reference**: [what they should fill in]

Or say **"proceed with defaults"** and I'll code with reasonable assumptions (clearly flagged at the top of my response).

---

Wait for the dev's response. Do not generate code in the same turn.

## The "Proceed with Defaults" Escape Hatch

If the dev says any of these:
- "proceed with defaults"
- "just code it"
- "skip clarification"
- "proceed"
- "go ahead"

Then generate code immediately, but list assumptions explicitly at the top:

// ASSUMPTIONS (correct me if wrong):
// - Feature: [what I assumed]
// - Behavior: [what I assumed]
// - Reference: [what I assumed / "none specified"]

The dev sees the assumptions and corrects them if needed.

## What This Skill Does NOT Do

- Does NOT ask "which CU?" — devs don't think in CU numbers
- Does NOT ask "is this sensitive?" — that's the sensitive-areas skill's job
- Does NOT block the dev — escape hatch always available
- Does NOT repeat coaching if the dev rephrases — code once they clarify

## Edge Cases

- **Dev pastes code and says "fix this"** → Not vague. Code is the context. Proceed.
- **Dev says "continue"** → Not vague if there's prior chat context.
- **Dev gives a Figma image** → Image counts as Reference. Likely not vague.
- **Dev describes intent in plain English in detail** → Not vague. Plain English is fine if specific.

## Goal

Catch vague prompts ONCE per task. After clarification, get out of the way.