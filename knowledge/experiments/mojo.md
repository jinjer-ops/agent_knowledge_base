---
id: EXPERIMENT-MOJO
title: Mojo ML-infrastructure spike
type: experiment
status: proposed
created_at: 2026-09-01
updated_at: 2026-09-01
owners: [knowledge-stewards]
source_ids: [ART-011]
tags: [mojo, ml, performance]
---

# Mojo spike

## Hypothesis

For a profiled ML or data-processing hot path, Mojo may improve performance or hardware portability enough to justify its maintenance cost.

## Scope

Select one current, correct baseline implementation. Preserve its test inputs and outputs. This is not a rewrite of an existing ML project.

## Compare

Correctness, end-to-end latency, throughput, hardware/runtime compatibility, build/CI burden, and maintainer effort.

## Environment note

Current Windows support must be verified at the time of the experiment; do not assume an announcement equals native runtime availability.

## Exit rule

Stop if the target is not a real measured bottleneck, correctness cannot be demonstrated, or the maintenance/portability cost outweighs the measured benefit.
