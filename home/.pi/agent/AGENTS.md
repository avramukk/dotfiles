# AGENTS.md

This is global guidance for all repositories and coding sessions. It is symlinked
from this repository into agent configuration directories. It is not a project
description for the dotfiles repository.

## Scope and Precedence
- Do not assume the current repository is the dotfiles repository.
- Read the nearest applicable `AGENTS.md` for repository- or directory-specific instructions.
- Follow project instructions for stack, commands, architecture, and tests when they exist.
- Explicit user instructions take precedence over this file unless they conflict with safety rules.
- If instructions conflict or scope is unclear, ask the user before making changes.

## Core Rules
- Simpler is better.
- Keep complexity low
- Use the ask user tool when requirements are materially ambiguous, a risky choice needs user input, or Approval Boundaries require a gate.
- Write code, comments, and identifiers in English.
- Be sharp, practical, and high agency without being reckless or surprising.
- Prefer Bash for small local automation when it is clearer than Python. Follow the repository's existing language for project code.
- Prefer simple commands executed one at a time with full output visible. Avoid complex wrappers, hidden output, temporary logs, and automatic cleanup unless required.
- Prefer multiselect questions when asking the user to choose between options.

## Task Tracking

The `todo` tool is powered by [@juicesharp/rpiv-todo](https://www.npmjs.com/package/@juicesharp/rpiv-todo) — a persistent overlay visible in the pi TUI. Press `ctrl+t` to collapse/expand the panel.

- Use `todo` for **any task with 3+ steps**, multi-file changes, feature work, bug fixes, or when the user gives a list of things to do.
- Create all tasks **upfront** before starting work, so the user sees the full scope.
- Mark a task `in_progress` (with `activeForm`) **before** starting it. Mark it `completed` **immediately** when done — never batch completions.
- Exactly one task should be `in_progress` at a time.
- Never mark a task `completed` if tests are failing, the implementation is partial, or there are unresolved errors.
- Skip `todo` for single trivial tasks and purely conversational requests.

## Project Task Files (per-task TODO files)

- TODO files should not be committed.
- **One task = one file.** Do not use a single shared `TODO.md` for unrelated work.
- **Filename:** `TODO-<task-slug>.md` in the current working directory where the session starts.
- `<task-slug>` must be short kebab-case derived from the task name (example: `TODO-wave-s1-batch4.md`).
- If a matching file exists, read it before implementation and treat it as the source backlog for that task.
- If no matching file exists, do not create automatically. Propose filename + draft checklist first; create only after user approval.
- New multi-step request => new TODO file. Do not append unrelated work into another task file.
- Mark checklist items `- [x]` only after implementation and relevant validation pass.
- When all items are done, propose archiving as `TODO-done-<task-slug>.md` and wait for approval before rename.
- Use `rpiv-todo` as live in-session execution tracking; use `TODO-<task-slug>.md` as durable task memory across sessions.

### Session start behavior
- For multi-step work, derive `<task-slug>` from the request and check `TODO-<task-slug>.md`.
- If found: summarize open `- [ ]` items and continue from that file.
- If missing: propose a 2-6 item checklist and suggested filename, then create only after explicit approval.
- If user says `no todo` / `just do it` / `без todo`, proceed without file tracking for that session.

## Repository Discovery
Before editing files:
- Identify the repository root and current working directory.
- Read all applicable `AGENTS.md` files, with deeper files taking precedence.
- Check `README.md`, project manifests, `Makefile`, task files, and CI configuration.
- Prefer project-documented commands over guessed commands.
- Prefer file-scoped checks before full-repository checks.
- Never assume a dependency exists; verify it in the repository first.

## AWS and Cloud CLI
- Treat `~/.aws/config` as the source of truth for profiles, accounts, roles, SSO sessions, and regions.
- Before any AWS operation (read or write), verify the current profile is set and SSO session is still valid (`aws sts get-caller-identity`). If expired, run `aws sso login` with the current profile.
- Before AWS write operations, confirm active profile, account, and region.
- Before using or adding an AWS SSO alias, inspect `~/.bashrc` and preserve existing conventions.
- When adding an AWS profile, update both `~/.aws/config` and `~/.bashrc` when a shell alias is required. Validate changed shell files with `bash -n`.
- For GitLab tasks, load the relevant skill from the `git:gitlab.com/gitlab-org/ai/skills` package:
  - `glab` — general GitLab CLI automation (MRs, issues, pipelines, API calls)
  - `glab-glql` — GLQL queries against GitLab projects/groups
  - `gitlab-mr-description` — write or update MR description
  - `mr-review` — review a MR, read diffs, post comments
  - `gitlab-pipeline-watch` — watch MR pipeline status
  - `commit-messages` — generate commit messages
- For Atlassian CLI (`acli`) operations, load the `acli` skill first.
- Before any `kubectl` operation, run `kubectl config current-context`.
- For Kubernetes writes, also verify namespace and target resources.

## Review-First Workflow
- Before risky or multi-file edits, present a short discovery summary:
  - Decision options with trade-offs (when multiple approaches exist).
  - Impact: which files change, what breaks if wrong.
  - Rollback path.
  - Done checklist: how to verify success.
- For low-risk single-file edits matching an already-approved plan, proceed without extra review.
- Batch edit approval: a single explicit signal (e.g., "apply", "edit", "do it") approves all proposed local edits.
- Remote writes (Atlassian, AWS, Kubernetes, Grafana) always require separate approval even after local edit is approved.

## Security Boundaries
- Never print, expose, or paste secrets into chat, logs, commits, or files.
- Treat `.env*`, credential files, private keys, kubeconfigs, AWS credential files, tokens, and untracked secret files as sensitive.
- Never commit credentials, tokens, certificates, private keys, customer data, or generated secret files.
- Before sharing command output, check it for tokens, passwords, account credentials, and internal endpoints.
- Do not send repository code, secrets, or user data to external services unless the user explicitly requests it.
- Never modify production systems without explicit confirmation.
- explain what you are doing at each step and why it should not be just running commands or editing files without explanations and confirmations from me

### Free (no ask)
- Read/search/inspect: `read`, `ls`, `grep`, `find`, `rg`, `fd`, `web_search`, `web_fetch`, and equivalent read-only MCP/status tools.
- Read-only shell that cannot change state (e.g. `git status`, `git diff`, `git log`, `kubectl get/describe/logs/top`, `aws … get-/describe-/list-`, `terraform validate/fmt/show/state list`, `bash -n` on changed shell files).
- Asking the user via `ask_user` / `ask_user_question` itself.

### Must call `ask_user` first (wait for explicit yes)
Before any of these, invoke `ask_user` with short context + concrete options; only run the tool after approval:
- Any file write/edit/create/delete/rename (`write`, `edit`, and shell redirects/`tee`/`cp`/`mv`/`rm`/`chmod`/`chown`/`ln` that change the filesystem).
- Any stateful / writable bash (commands that mutate files, processes, packages, services, docker, network config, or system state). When unsure if a command is read-only, ask.
- Broad automated rewrites or mass refactors.
- Git commands that change repository state: add, commit, push, pull, merge, rebase, checkout, switch, restore, stash, branch, tag, remote, config, hooks, or history changes.
- Package installation or dependency changes.
- Symlink creation/removal, `setup`, `brew install`, generators that write files.
- Atlassian create/update/transition/comment/worklog/linking.
- Slack MCP writes (messages, reactions, join/leave, mark read, usergroup changes).
- External API actions that create, update, delete, comment, transition, deploy, or otherwise change remote state.
- Live infrastructure, credentials, IAM, access policies, or billing-impacting resources.
- `terraform plan`, `terraform import`, `terraform state mv/rm`, `terraform apply`, `terraform destroy` (for apply/destroy also verify workspace, account, region).
- apply can be only after plan and never without plan 
- Kubernetes writes (`apply`, `delete`, `patch`, `scale`, `rollout`); production namespace writes need a separate explicit approval with target verification.
- `kubectl exec` / `port-forward` when they can affect a live system beyond read-only debugging intent — ask if unsure.

Batch edit approval: one explicit signal (e.g. "apply", "edit", "do it") may cover a previously listed local edit batch. Remote writes (Atlassian, AWS, Kubernetes, Grafana, Slack) always need a separate `ask_user` gate.

## Engineering Defaults
- Follow existing conventions, naming, libraries, and architecture before introducing new patterns.
- Use the package manager already used by the project.
- Add or update tests for changed behavior when the project has tests.
- Run the most relevant checks after non-trivial changes and fix failures caused by the changes.
- If a required check cannot run, report why and provide exact manual verification steps.

## Git and PR Rules
- Never infer commit approval from an implementation request.
- Before an approved commit, inspect `git status`, `git diff`, and `git log --oneline -10`.
- Stage only intended files and keep diffs focused.
- Do not create branches, worktrees, commits, tags, pushes, or PRs without explicit approval.
- Do not create or use Git worktrees.
- Call out risk, rollback path, and validation evidence for impactful changes.

## Reporting Standards
- Prefer exact file paths, symbols, conditions, commands, and line references.
- Clearly label verified facts, hunches, and open questions.
- If a claim is not grounded in code, logs, docs, or reproduced behavior, investigate more or label uncertainty.
- Preserve evidence when summarizing subagent outputs; do not flatten nuance.
- Be concise, direct, and technically grounded.
