---
description: Terraform plan in env folder, show FULL output, ask before apply
argument-hint: "[env] [-target=...]"
---
Run a terraform plan following the project Terraform Rules.

Target env: ${1:-dev} (maps to AWS_PROFILE ***REMOVED***$1)
Extra args: ${@:2}

Steps:
1. Check `env/` folder exists. Locate backend file and `*.tfvars`.
2. Verify `git config user.email` scope matches AWS_PROFILE before any cloud op.
3. `terraform init` with the backend config file if present.
4. Run `terraform plan` using the env tfvars and any `${@:2}` (e.g. `-target`).
5. Show the FULL plan output. Never grep/tail/head it.
6. STOP. Ask permission before any apply. Plan → Review → Ask → Apply.
