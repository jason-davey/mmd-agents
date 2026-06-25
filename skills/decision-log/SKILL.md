---
name: decision-log
description: Capture a system-design judgment call as a structured, training-grade decision record the moment it's made. Use when a non-obvious architecture/design/strategy decision happens in a session — a reframe, a fork-axis choice, a primitive named, a build-vs-trust call, an instrument-before-solve move — and you want the *reasoning* preserved (not just the resulting code). Triggers: "log this decision", "decision-log", "/decision-log", "record why we chose", "capture this reframe", or right after a debate where one option won for a reason worth keeping. Also run it retroactively over a dev-log/session to extract the decisions buried in it. SKIP if: the choice was mechanical/obvious (no real alternative), it's a pure feature implementation with no design judgment, or the rationale is already captured verbatim elsewhere. This is Layer 2 (the trace) of Multi-Modal Design — the harvestable raw material the skills (Layer 1) and the eval (Layer 3) don't capture.
---

# /decision-log — capture the design process as it happens

GitHub records the *result* of a design decision (the merged code). It does not record the deliberation — the options you rejected, the smell that made you reframe, what actually happened downstream. That trace lives in nobody's repo, and it's exactly the high-signal, low-volume data the design process needs. This skill captures it at the moment of decision, in a fixed schema that doubles as an eval case and as preference data.

One record = one judgment call. Keep it dense. The value is in the `trigger`, the rejected `candidates`, and the eventually-filled `observed` — those three fields are what GitHub and chat history throw away.

## When to use / when to skip

| Use it when | Skip it when |
|---|---|
| A problem got **reframed** (the work was producing right-feeling output to a wrong-shaped problem) | The choice was mechanical — no credible alternative existed |
| You **forked** and had to pick the axis (consumer-attribute vs. design-indecision) | Pure feature implementation with no design judgment |
| You **named a load-bearing primitive** before downstream systems were built | Rationale is already captured verbatim and structured elsewhere |
| You chose **review apparatus over trusting** an artifact that "looked correct" | The decision is reversible and cheap to redo (not worth the record) |
| You built an **instrument before solving** a visibility problem | You're mid-flow and capturing now would break the work — log it at the next natural seam instead |
| Retroactively mining a dev-log/session for the decisions buried in it | |

## Reasoning principles

1. **Capture the trigger, not just the move.** The single most valuable and least-recorded field. What *symptom* told you a decision was needed? For reframes: what made the work feel right but wrong? This is the taste, partially externalised.
2. **Always log the rejected candidates.** A record with only the winner teaches imitation of the surface. The rejected option — especially the *seductive* one that was plausible and wrong — is what makes the record discriminate. If there was an obvious wrong-but-attractive default, name it explicitly.
3. **Name the axis of choice, not just the choice.** "We forked by container width, not viewport" beats "we used ResizeObserver." The axis is the transferable judgment.
4. **Separate prediction from observation.** Fill `predicted` now. Leave `observed` blank and come back to it (at handoff, or when the decision is stress-tested). The gap between the two is the learning.
5. **One judgment per record.** If a session had three decisions, write three records. Don't bundle.
6. **Dense over complete.** A 6-line record with a sharp trigger beats a 40-line record padded with context. Cut anything the next reader could infer.
7. **Rationale names the load-bearing why.** Not "it was cleaner" — *why* cleaner mattered here, what it bought, what breaks without it.
8. **Tag generality honestly.** `stack-specific` / `domain-specific` / `universal`. Over-claiming generality is the most common failure; most decisions are domain-specific until proven otherwise.
9. **Write it so it converts to an eval case for free.** The fields map 1:1 to MMD-Bench (`eval/cases.jsonl`). A good record is a benchmark case waiting for its `state_before` to be shown cold.
10. **Retroactive is fine, but mark it.** Mining old dev-logs is valuable; just set `captured: retroactive` so you know the trigger was reconstructed, not recorded live.

## Output scaffold

Write to `decisions/NNN-slug.md` in the repo (zero-padded, incrementing), or append to a running `DECISIONS.md`. Use this exact field set so records stay parseable and eval-convertible:

```markdown
## DEC-NNN · <short title>

- **date / session:** <YYYY-MM-DD · session NNN>
- **engagement:** <name>
- **stage:** <1–6>  ·  **task_type:** reframe-detection | fork-axis | apparatus-vs-trust | primitive-naming | instrument-before-solve | other
- **captured:** live | retroactive
- **state_before:** <the situation/brief/constraints exactly as they looked *before* the call — no answer leakage>
- **trigger:** <the smell/symptom that said a decision was needed; for reframes, what made it feel right but wrong>
- **candidates:**
  - A (seductive default): <the plausible, fast, often as-briefed option that's wrong> — why it's tempting / why it fails
  - B (chosen): <the call>
  - C (optional): <other real option considered>
- **chosen + axis:** <B>, decided on the axis of <the transferable dimension, e.g. "attribute of the consumer, not branch of design">
- **rationale:** <the load-bearing why>
- **predicted:** <expected consequence at decision time>
- **observed:** <FILL LATER — held / caused rework / neutral, with one line of evidence>
- **generality:** stack-specific | domain-specific | universal
- **source:** <where to read more — dev-log link, PR, doc>
```

After writing, remind the user (once) that `observed` is intentionally blank and worth filling at the next handoff/stress-test. Offer to append the record to `eval/cases.jsonl` (mapping: `state_before`→`situation`, candidate A→`seductive_default`, chosen→`gold_decision`, rationale→`gold_rationale`, observed→`downstream_consequence`).

## Examples

### Example 1 — a reframe (LiVELY)

```markdown
## DEC-014 · Parent app: dashboard → peer product

- **date / session:** 2026-01-12 · session 014
- **engagement:** LiVELY
- **stage:** 1  ·  **task_type:** reframe-detection
- **captured:** live
- **state_before:** Brief: "add a parent view so parents can monitor their child's progress." Parent conceived as someone who logs in occasionally to read a dashboard. Child app already exists.
- **trigger:** The monitoring designs all felt tidy and correct, but every one of them made the parent a spectator. The product is about the parent–child *relationship*, and a spectator has no relationship — that mismatch was the smell.
- **candidates:**
  - A (seductive default): read-only parent dashboard (child's score, progress bars, notifications). Tempting because it's exactly what was asked and ships fast. Fails: makes the parent passive, engagement decays, relationship becomes surveillance.
  - B (chosen): model the parent app as a peer product — own assessment, own progression (parenting archetype with maturing confidence), own daily reason to engage; relate to child via mutual transparency.
- **chosen + axis:** B, decided on the axis of "is the parent a participant or a spectator?" — design for participation.
- **rationale:** A monitoring surface turns the product into surveillance and kills the thing it exists to build. A peer product creates a second active participant and makes the relationship the product. Reshapes route tree (/parent/* first-class) and data model (parent assessment).
- **predicted:** parent retention holds; pacts/assessment gain meaning; ~30% more scope.
- **observed:** held — produced the parent v2 assessment, 4 archetypes, DQ Alignment Score; became the visible v2 surface.
- **generality:** domain-specific
- **source:** process/discovery.md — "the parent-app, intentionally a separate product"
```

### Example 2 — apparatus over trust (LiVELY)

```markdown
## DEC-067 · Validate schema before API handoff, don't trust the migrations folder

- **date / session:** 2026-04-28 · session 067
- **engagement:** LiVELY
- **stage:** 5  ·  **task_type:** apparatus-vs-trust
- **captured:** live
- **state_before:** About to hand 22 API routes to incoming frontend dev. Months of iterative DB changes via migrations, Studio UI, and raw psql. Migrations folder looks complete and is version-controlled.
- **trigger:** "Looks complete" is exactly the state where AI-built/iterated schemas lie — the live DB drifts ahead of the files and it's invisible until someone writes code against the documented schema. The new dev is about to do precisely that.
- **candidates:**
  - A (seductive default): hand over migrations + API list, trust the version-controlled files. Tempting: they look right and it's zero extra work. Fails: ships plausibly-broken contracts.
  - B (chosen): build a reusable 21-scenario smoke test (BEGIN…EXCEPTION…ROLLBACK) against the *live* schema, results to a regular table (TEMP dies under pgBouncer; RAISE NOTICE swallowed by the CLI). Ship the test as part of the handover.
- **chosen + axis:** B, decided on the axis of "trust the artifact vs. build the apparatus that proves it" — build the apparatus, make it the deliverable.
- **rationale:** AI-generated artifacts fail by looking correct; the review apparatus is what catches the drift between looks-correct and is-correct, and it's reusable by the next person any time they suspect drift.
- **predicted:** catches drift before it reaches the frontend; reduces handoff backfill.
- **observed:** held — caught 4 schema-drift bugs pre-handoff; test + footguns shipped in the David handover doc.
- **generality:** universal
- **source:** process/implementation.md — schema smoke-test
```

---

*Part of Multi-Modal Design. Install: copy this file to your repo's `.claude/skills/decision-log.md`. Companion artifacts: the MMD-Bench eval (`eval/`) consumes these records as cases; Stage 2 (Architect the prompt) is where you codify it.*
