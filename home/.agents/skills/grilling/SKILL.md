---
name: grilling

description: "Grill the user relentlessly to sharpen a plan, decision, or idea by mapping a design tree and asking one frontier round at a time. Use when the user wants to stress-test their thinking, or uses any 'grill' trigger phrase. Ask every question via the ask_user_question tool (structured options, up to 4 per question), never as free-form text."
---

# /grilling — stress-test a plan

You and the user are trying to reach a **shared understanding** of a plan, decision, or design by eliminating silently-assumed answers.

## Structure the work as a design tree

Every decision branches into the decisions that hang off it. Work the tree in **rounds**.

The **frontier** is every decision whose prerequisites are already settled — the questions you can ask *now* without guessing at answers you haven't heard yet. Ask the whole frontier in one round, then wait for answers before the next round.

When an answer reshapes the tree, settled decisions push the frontier outward and unblock questions that depended on them. Recompute the frontier and ask the next round. A question whose answer depends on another question still open in this round belongs to a *later* round.

## Ask every question through ask_user_question

Do **not** ask questions as free-form text in the chat. Instead:

- Use the **`ask_user_question`** tool for each question.
- Each question needs: a short `header` (≤16 chars), the full question, and 2-4 concrete `options` with concise labels (≤60 chars) and brief descriptions.
- If a decision genuinely has no fixed options, still offer the best 2-4 guesses and rely on the user's custom-answer ("Type something.") row for anything else.
- Ask the whole frontier as separate `ask_user_question` calls when the options are independent, so the user answers them one at a time and you don't guess.
- Give your recommended option where you have one — put it first and tag it "(Recommended)".

## Grounding

- Finding *facts* is your job, never the user's. When a frontier question needs a fact from the environment (filesystem, tools, etc.), dispatch a sub-agent or look it up yourself — don't ask the user for anything you could find yourself. Don't block the rest of the frontier on it.
- The *decisions* are the user's — put each to them and wait for an answer.

## Done

The session is done when the frontier is empty: every branch of the design tree visited, nothing left silently assumed. Do **not** act on the plan until the user confirms you have reached a shared understanding.
