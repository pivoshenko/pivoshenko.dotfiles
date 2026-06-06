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
