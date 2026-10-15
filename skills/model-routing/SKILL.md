---
name: model-routing
description: Selectively delegate a bounded, independently verifiable subtask to a lower-cost model while retaining quality. Use only when token efficiency is a stated concern and delegation is likely to reduce total work.
---

# Model routing

Keep the model selected by the user as the parent for problem framing,
authority, synthesis, and final acceptance. A lower-cost model is a separate,
bounded worker; it is not a replacement for the active parent or an invisible
mid-task model switch.

## Default: do not delegate

Do the work directly unless every condition below is true:

1. The subtask has explicit input locations, a small output schema, and a
   deterministic acceptance check.
2. It is independent of unresolved product, analytical, safety, or authority
   decisions.
3. The parent can verify the result from its cited evidence or a focused test
   without rereading the worker's entire input.
4. The worker can receive only the relevant files, query, or task contract;
   it does not need the full conversation or a large raw-data dump.
5. The expected reduction in parent context or repetitive tool work exceeds
   the extra brief, result, and review turns.

Do not delegate a one-command task, a short direct answer, an iterative task
that needs frequent parent clarification, or a task whose output the parent
would have to redo. Do not create workers merely to compare model quality.

## Choose the least capable sufficient worker

- A utility-tier worker may do read-only enumeration, narrow extraction,
  formatting against an exact template, or deterministic aggregation.
- A working-tier worker may make a tightly specified implementation or test
  change when the parent has already fixed the design and will review the
  diff and tests.
- Keep the user-selected highest tier for success criteria, competing
  hypotheses, data interpretation, architecture, permissions, external
  operations, acceptance, and the final report.

Use a platform's per-worker model setting only when it is available and the
user or applicable runtime policy permits it. Never change the parent session's
model setting to implement this pattern. If a proposed lower tier is not
available, either use the parent directly or stop; do not silently substitute a
different provider or model.

## Worker contract

Give a worker a compact brief containing:

- exact paths, query, or input identifiers it may inspect;
- an output schema and size limit;
- allowed tools and whether it is read-only;
- facts to measure, not conclusions it may decide; and
- the evidence or test the parent will use to accept it.

The parent retains all external actions and writes unless the brief explicitly
authorizes a reversible implementation change. A lower-tier worker must not
expand scope, alter the success contract, choose data sources, or approve its
own result.

## Accept or stop

The parent checks the promised evidence or test before using the result. Reject
the route, rather than repairing it through repeated worker turns, when it
produces ambiguous output, needs missing context, or fails the check. Complete
the task directly at the parent tier in that case.

When routing was used, leave one concise line in the handover or final report:
worker tier, bounded purpose, evidence checked, rework required, and actual
token or billing data if the runtime exposes it. If metering is unavailable,
call the saving unmeasured.

After three comparable routed tasks, compare total tokens (including briefs,
results, and parent review), elapsed time, and rework against direct work. Keep
using a route only if quality is unchanged and total cost or context exposure
is lower. Until that evidence exists, reserve routing for cases where it keeps
large irrelevant output out of the parent context.
