---
description: Extract non-obvious learnings from session to AGENTS.md files to build codebase understanding
---

Analyze this session and extract non-obvious learnings to add to AGENTS.md files.

AGENTS.md files can exist at any directory level, not just the project root. At session start pi loads AGENTS.md from the working directory and its parent directories (up to filesystem root), not per file read. A deep AGENTS.md (e.g. `packages/foo/AGENTS.md`) is only loaded when a session starts inside that directory or one of its subdirectories — it is NOT auto-loaded when a session merely touches files there. So prefer:

- Project-wide learnings → root AGENTS.md (always loaded)
- Package/module-specific → packages/foo/AGENTS.md (only if you work with the session cd'd there)
- Feature-specific → src/auth/AGENTS.md (same caveat)

When unsure, put the learning in the root AGENTS.md so it reliably applies.

What counts as a learning (non-obvious discoveries only):

- Hidden relationships between files or modules
- Execution paths that differ from how code appears
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
- Session-specific details

Process:

1. Review session for discoveries, errors that took multiple attempts, unexpected connections
2. Determine scope - what directory does each learning apply to?
3. Read existing AGENTS.md files at relevant levels
4. Propose to use update AGENTS.md at the appropriate level and use ask_user
   toll for proposals
5. Keep entries to 1-3 lines per insight

After updating, summarize which AGENTS.md files were created/updated and how many learnings per file.

$ARGUMENTS
