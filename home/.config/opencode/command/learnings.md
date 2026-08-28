---
description: Learn how this session should have started to avoid its mistakes, and write a startup playbook to AGENTS.md
---

Analyze this whole session and work backwards: if we had known at the very start what we know now, how should we have begun? Identify the mistakes, detours, repeated attempts, confusing turns, and time sinks we hit, and turn them into a **startup playbook** — concrete guidance for how to open a session like this so it runs faster and cleaner next time.

Think about the first steps specifically:

- What setup/context should have been gathered before touching anything?
- What assumptions turned out wrong, and what should have been verified first?
- Which commands, configs, or files should we have looked at / set up before writing code?
- What dead-ends and retries could have been skipped?
- What guardrails or checklists would have caught our mistakes earlier?
- What would have made the whole task simpler?

Then record the findings as instructions a future session can act on.

AGENTS.md files can exist at any directory level, not just the project root. At session start OpenCode loads AGENTS.md from the working directory and its parent directories (up to filesystem root), not per file read. A deep AGENTS.md (e.g. `packages/foo/AGENTS.md`) is only loaded when a session starts inside that directory or one of its subdirectories — it is NOT auto-loaded when a session merely touches files there. So prefer:

- Project-wide lessons → root AGENTS.md (always loaded)
- Package/module-specific → packages/foo/AGENTS.md (only if you work with the session cd'd there)
- Task-type-specific startup checklists → root AGENTS.md (so they always apply)

When unsure, put the learning in the root AGENTS.md so it reliably applies.

What counts as a learning (non-obvious discoveries only):

- How a session of this kind should begin (setup, context, verification steps)
- Mistakes and detours that cost time and how to avoid them from the start
- Assumptions that were wrong and what to check first
- Hidden relationships between files or modules
- Non-obvious configuration, env vars, or flags
- Debugging breakthroughs when error messages were misleading
- API/tool quirks and workarounds
- Build/test commands not in README
- Architectural decisions and constraints
- Files that must change together

What NOT to include:

- Obvious facts from documentation
- Standard language/framework behavior
- Things already in an AGENTS.md
- Verbose explanations
- Session-specific details (keep the reusable lesson, drop the one-off specifics)

Process:

1. Review the whole session and list the mistakes, wrong turns, and repeated attempts
2. For each, determine the "right way to start" that would have avoided it
3. Determine scope - what directory does each lesson apply to?
4. Read existing AGENTS.md files at relevant levels
5. Propose updating AGENTS.md at the appropriate level and use the `question` tool for proposals
6. Keep entries to 1-3 lines per insight, phrased as actionable startup guidance ("Before starting, check X", "Verify Y first")

After updating, summarize which AGENTS.md files were created/updated, how many learnings per file, and how this session should have started.

$ARGUMENTS
