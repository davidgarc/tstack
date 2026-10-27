# tstack

My curated set of everyday agent skills. They work in Claude Code and Codex.
Some use [T3 Code](https://github.com/pingdotgg/t3code) features when they are
available and fall back to native tools when they are not.

Forked from [t3dotgg/tstack](https://github.com/t3dotgg/tstack). Upstream
changes are pulled in selectively.

## Skills

| Skill | Say | What it does |
|---|---|---|
| `full-send` | "full send" | Takes a change to a merged PR with nobody watching: proves it, reviews it, files it, babysits it, merges it. |
| `full-stop` | "full stop" | Same as `full-send`, but stops when the PR is ready for you to merge. |
| `council` | "council" | Gets review from three models from different providers, and loops until they agree. |
| `sol-loop` | "sol loop" | Reviews a change with GPT Sol in a loop until both agents agree. |
| `file-pr` | "file a PR" | Files a short PR that leads with the problem, not an inventory of changes. |
| `takeover` | "take over" | Finishes someone else's PR, branch, or agent thread, and keeps their credit. |
| `babysit-pr` | "babysit" | Watches a PR through CI and review bots, and fixes the real findings. |
| `modernize` | "modernize" | Rebases an old PR and decides if it should still exist. |
| `leaving-pr-comments` | (automatic) | Formats comments that an agent posts on your behalf. |

Some skills call others. Install the ones they need too:

- `full-send` uses `sol-loop`, `file-pr`, and `babysit-pr`.
- `full-stop` uses `full-send`.
- `takeover` uses `modernize`, `file-pr`, `babysit-pr`, and `leaving-pr-comments`.
- `file-pr`, `babysit-pr`, and `modernize` use `leaving-pr-comments`.

## Install

```bash
git clone https://github.com/davidgarc/tstack ~/Projects/tstack
~/Projects/tstack/install.sh
```

`install.sh` symlinks each skill into `~/.agents/skills`, then links those into
`~/.claude/skills` (Claude Code) and `~/.codex/skills` (Codex). A `git pull`
updates every install. Existing skills that are not symlinks are left alone.

## Syncing upstream

```bash
git fetch upstream
git log main..upstream/main   # review before merging
git merge upstream/main
```

## Requirements

- An authenticated [GitHub CLI](https://cli.github.com) (`gh`).
- `python3` for `babysit-pr`'s `pr-wait` script.
- `council` and `sol-loop` need subagents on other providers' models. T3 Code
  does this with `delegate_task`. Otherwise you need a harness that can run
  those models.

## Personal settings

Put personal settings, like which models sit on the council, in `CLAUDE.md` or
`AGENTS.md`, so the skills can change without losing them.

## License

[MIT](LICENSE)
