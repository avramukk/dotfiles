---
name: acli
description: Interact with Atlassian Cloud (Jira & Confluence) via the acli CLI. Use for searching/creating/editing/transitioning/assigning Jira work items (issues/tickets), comments, links, attachments, watchers, projects, sprints, boards, filters, and Confluence pages/spaces/blog posts. Trigger when the user mentions Jira, Confluence, a ticket, work item, issue, sprint, or an Atlassian site.
---

# acli — Atlassian CLI (Jira & Confluence)

Use the [acli](https://developer.atlassian.com/cloud/acli/) CLI to manage Jira and Confluence.

## Prerequisites
- `acli` installed and authenticated (`acli --version`).
- Auth: `acli auth login` (global OAuth) or `acli jira auth login --web`.
- Verify: `acli auth status`.

## Multi-site
- `<org>.atlassian.net` (one entry per Atlassian site you use)

Switch before commands:
```bash
acli auth switch --site <org>.atlassian.net
```

## Jira work items (issues/tickets)
Common pattern for mutating commands: one of `--key <KEY-1>`, `--jql "<jql>"`, or `--filter <id>`.

```bash
# Search
acli jira workitem search --jql "project = <PROJECT> ORDER BY created DESC" --limit 10
acli jira workitem search --filter <filterId>

# View
acli jira workitem view <PROJECT>-47

# Create (note: description, not --body)
acli jira workitem create --project <PROJECT> --type Task --summary "Summary" --description "Details"
acli jira workitem create --project <PROJECT> --type Task --summary "Sum" --description-file desc.md
acli jira workitem create --from-json workitem.json   # full control
# Allowed issue types vary per project; check with create --help / project metadata.

# Edit fields (uses selectors)
acli jira workitem edit --key <PROJECT>-47 --...          # edit requires --key/--jql/--filter group

# Assign (separate subcommand)
acli jira workitem assign --key <PROJECT>-47 --assignee "@me"                 # self
acli jira workitem assign --key <PROJECT>-47 --assignee "user@example.com"
acli jira workitem assign --jql "project = <PROJECT>" --assignee "default"

# Transition (change status)
acli jira workitem transition <PROJECT>-47 --transition "In Progress"
acli jira workitem transition <PROJECT>-47 --to "Done"

# Comments
acli jira workitem comment add <PROJECT>-47 --body "text"        # plain text (auto-ADF)
acli jira workitem comment list <PROJECT>-47
acli jira workitem comment update <commentId> --body "..."    # ADF + visibility supported

# Other
acli jira workitem link ...          # create/list/delete links
acli jira workitem attachment ...    # list/delete attachments
acli jira workitem watcher ...       # list/add/remove watchers
acli jira workitem clone --key <PROJECT>-47
acli jira workitem delete --key <PROJECT>-47
acli jira workitem archive --key <PROJECT>-47
```

## Projects / Sprints / Boards / Filters
```bash
acli jira project list --limit 50
acli jira project view <KEY>
acli jira sprint view <id>            # list work items, create, update, delete
acli jira board search | view         # list sprints/projects, create, delete
acli jira filter list | view          # reusable via workitem search --filter
```

## Confluence
```bash
acli confluence space list
acli confluence page get --page-id <ID>
acli confluence page list --space <SPACE_KEY>
acli confluence blogpost list --space <SPACE_KEY>   # blog posts
```

## ADF format
Jira Cloud uses Atlassian Document Format (ADF), not markdown.
- Simple plain-text `--body`/`--description` works (auto-converted to ADF).
- For rich formatting (headers, tables, code blocks) write an ADF JSON file and use `--description-file` / `--body-file`.

## Tips
- Always confirm the target site (`acli auth status`) before mutating — your sites may have different projects.
- `--assignee "@me"` self-assigns; `"default"` uses the project's default assignee.
- New Jira tickets typically need a project key (e.g. <PROJECT>) and a type valid for that project (Task/Epic/Sub-task; Story may not be allowed).
