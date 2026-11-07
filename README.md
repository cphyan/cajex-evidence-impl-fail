# cajex-evidence-impl-fail

Fixture repository for cajeX's GitHub check templates (Live Evidence RFC 20, tracks B and E).
It **fails** every check: each file here is wrong on purpose, and this README says how.

cajeX's conformance kit reads it through the *cajeX Evidence (sandbox)* GitHub App, read-only,
and every catalogue template is held to the answer it must give here
(`catalogue/checks/github/*.yaml`, `fixtures:`). Its twin, `cajex-evidence-impl-pass`,
gives the opposite answer.

Nothing here is built, run or secret. Files arrive by pull request from the cajeX repository's
template work, each with the template it proves. Please leave them as they are.

## What is here on purpose

| File | Template | Meant to |
|---|---|---|
| `.github/CODEOWNERS`, with **no** rule requiring code-owner review | `github.code-owners` | fail: owners are named, but nothing requires their review |
| `.github/dependabot.yml` with `updates: []` | `github.dependency-updates` | fail: the file is there, but updates nothing |
| `src/server.js`, **deliberately vulnerable** (command injection), with code scanning on | `github.code-scanning-remediation` | fail once its critical alert is older than the deadline (7 days) |
