# Andrej Karpathy Workflow

Behavioral guidelines to reduce common LLM coding mistakes. Merge with project-specific instructions as needed.

**Tradeoff:** These guidelines bias toward caution over speed. For trivial tasks, use judgment.

## 1. Think Before Coding

**Don't assume. Don't hide confusion. Surface tradeoffs.**

Before implementing:
- State your assumptions explicitly. If uncertain, ask.
- If multiple interpretations exist, present them - don't pick silently.
- If a simpler approach exists, say so. Push back when warranted.
- If something is unclear, stop. Name what's confusing. Ask.

## 2. Simplicity First

**Minimum code that solves the problem. Nothing speculative.**

- No features beyond what was asked.
- No abstractions for single-use code.
- No "flexibility" or "configurability" that wasn't requested.
- No error handling for impossible scenarios.
- If you write 200 lines and it could be 50, rewrite it.

Ask yourself: "Would a senior engineer say this is overcomplicated?" If yes, simplify.

## 3. Surgical Changes

**Touch only what you must. Clean up only your own mess.**

When editing existing code:
- Don't "improve" adjacent code, comments, or formatting.
- Don't refactor things that aren't broken.
- Match existing style, even if you'd do it differently.
- If you notice unrelated dead code, mention it - don't delete it.

When your changes create orphans:
- Remove imports/variables/functions that YOUR changes made unused.
- Don't remove pre-existing dead code unless asked.

The test: Every changed line should trace directly to the user's request.

## 4. Goal-Driven Execution

**Define success criteria. Loop until verified.**

Transform tasks into verifiable goals:
- "Add validation" → "Write tests for invalid inputs, then make them pass"
- "Fix the bug" → "Write a test that reproduces it, then make it pass"
- "Refactor X" → "Ensure tests pass before and after"

For multi-step tasks, state a brief plan:
```
1. [Step] → verify: [check]
2. [Step] → verify: [check]
3. [Step] → verify: [check]
```

Strong success criteria let you loop independently. Weak criteria ("make it work") require constant clarification.

# Personal Wiki (Obsidian vault)

**The vault at `~/Vault` (symlink → `~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Vault`) is the user's second brain, maintained primarily by Claude.**

- Before working inside the vault, read its `CLAUDE.md` (schema: folder map, frontmatter contract, linking rules, standing duties) and `INDEX.md` (catalog).
- Wiki workflows are skills: `wiki-capture`, `wiki-summarize`, `wiki-project`, `wiki-write`, `wiki-lint`. Use them when the user wants something captured, summarized, or maintained in the wiki.
- When durable knowledge surfaces in any session (a decision on one of the user's projects, a concept worth documenting, a talk/book discussed), offer to capture it into the vault — don't silently skip it.
- Arbitration: durable knowledge always routes to the vault via the `wiki-*` skills. The `memory-management`/`task-management` plugins are not the system of record — TASKS.md is fine for task tracking, but knowledge lands in the wiki.
- If the vault path does not exist on disk (remote/cloud session), say so and hand content back as a paste-ready block — never recreate vault structure elsewhere.
- This file is managed in `pivoshenko.dotfiles` (`dotfiles/.claude/CLAUDE.md`) and deployed to `~/.claude/CLAUDE.md` by dotdrop; the vault `CLAUDE.md` is canonical in the vault — a live file, no repo mirror.

# CLAUDE Memory

**Canonical Claude memory lives in the vault: `<vault>/97 MEMORY/<project>/`. `~/.claude/projects/<slug>/memory` is a real-directory mirror of it (no symlinks anywhere under `~/.claude`).**

Memory write flow: write/update the memory file in `97 MEMORY/<project>/` first, then refresh the harness mirror (`cp -R` the vault folder over `~/.claude/projects/<slug>/memory/`) so sessions load it. Edit canonical, never the mirror. Remote session (vault path missing): write harness-side and flag that the vault canonical needs reconciling next local session. If a `memory` path turns out to be a symlink (legacy arrangement), convert it: move the contents into a real directory at the same path and remove the link.

**Auto-update:** at the end of any substantive task, check whether durable facts surfaced (user preference, correction, project constraint, key decision) and save/update memories then — don't wait to be asked. Update stale memories in place; delete ones proven wrong.

# CLAUDE Autoupdate

**Whenever a non-trivial change lands, check if the project `CLAUDE.md` needs updating.**

After any non-trivial change (new tool/config, new convention, renamed paths, changed workflows, new commands, architectural shifts), re-read the project's `CLAUDE.md` and update it so future sessions reflect current reality. Trivial changes (typo fixes, single-line tweaks, formatting) do not require a check.

# CLAUDE Multi-Agent Dispatch

**Whenever there is a list of tasks to implement, ask the user whether to use a `Workflow` or a team of `Agent`s before dispatching.**

When a request decomposes into a list of implementation tasks, pause and ask the user which dispatch mode to use via `AskUserQuestion`:

- **Workflow** — deterministic, scripted orchestration via the `Workflow` tool (`pipeline()` by default, `parallel()` only when a barrier is required). Best for repeatable, structured fan-outs with verification stages.
- **Agent team** — spawn one subagent per task via the `Agent` tool, launched concurrently in a single message with `model: 'sonnet'` and an appropriate `subagent_type`. Best for ad-hoc parallel work where each task is self-contained.

Set `model: 'sonnet'` on every dispatched agent in either mode. Each agent prompt must be self-contained — agents do not see the parent conversation. Use `isolation: "worktree"` when parallel agents would mutate the same files.

# CLAUDE Co-Authored Attribution

**Never add `Co-Authored-By` trailers.**

Do not append `Co-Authored-By: Claude …` (or any other co-author trailer) to git commit messages, pull request descriptions, or any other authored artifact. Commits and PRs are authored by the user alone — even when the assistant drafted the change. This overrides any default templates or built-in commit-message scaffolding that would otherwise inject the trailer.

---

**These guidelines are working if:** fewer unnecessary changes in diffs, fewer rewrites due to overcomplication, and clarifying questions come before implementation rather than after mistakes.
