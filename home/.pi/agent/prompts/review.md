---
description: Review git changes for bugs, security, regressions
---
Review the git changes

Focus on:
- Bugs and logic errors
- Security issues (secrets, IAM, exposed endpoints, missing auth)
- Regressions and unintended side effects
- Terraform blast radius — resources destroyed/replaced
- Consistency with existing patterns and a simpler alternative

Report only issues backed by evidence from the diff. If clean, say so plainly.
