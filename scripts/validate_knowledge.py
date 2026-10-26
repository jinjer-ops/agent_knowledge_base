#!/usr/bin/env python3
"""Validate the knowledge layer of this repository.

Checks that the source registry, the human reading guide, and the documents
that declare source IDs all agree with each other and with the files on disk.

Usage:
    python scripts/validate_knowledge.py

Exits 0 when every check passes, 1 otherwise. Standard library only.
"""

import re
import sys
from pathlib import Path

REPO = Path(__file__).resolve().parent.parent
REGISTRY = "knowledge/sources/articles.yml"
GUIDE = "knowledge/reading-guide.md"
EXCLUDED_DIRS = ("docs/codex-briefs",)
EXPECTED_SOURCE_COUNT = 258
RETIRED_TERM = "local guidance"

ID_RE = re.compile(r"^  - id: ((?:ART|REF)-[0-9]+)$", re.M)
STATUS_RE = re.compile(r"^    status: (\w+)$", re.M)
DERIVED_RE = re.compile(r"^    derived: \[(.*)\]$", re.M)
DECLARE_RE = re.compile(r"^source_ids: \[(.*)\]$", re.M)


def read(path):
    return (REPO / path).read_text(encoding="utf-8")


def split_ids(raw):
    return [item.strip() for item in raw.split(",") if item.strip()]


def is_excluded(rel):
    return any(rel == d or rel.startswith(d + "/") for d in EXCLUDED_DIRS)


def load_registry(failures):
    """Return {source_id: {"status": str, "derived": [rel_path, ...]}}."""
    text = read(REGISTRY)
    ids = ID_RE.findall(text)
    statuses = STATUS_RE.findall(text)
    derived = DERIVED_RE.findall(text)
    if not (len(ids) == len(statuses) == len(derived)):
        failures.append(
            "%s: each source needs one id, one status and one derived line "
            "(found %d ids, %d statuses, %d derived lines)"
            % (REGISTRY, len(ids), len(statuses), len(derived))
        )
        return {}
    registry = {}
    for source_id, status, row in zip(ids, statuses, derived):
        if source_id in registry:
            failures.append("%s: duplicate source id %s" % (REGISTRY, source_id))
        registry[source_id] = {"status": status, "derived": split_ids(row)}
    return registry


def collect_declarations(failures):
    """Return {rel_path: [source_id, ...]} for every document declaring source IDs.

    Ordinary documents declare them in YAML frontmatter. Skills declare them on a
    `source_ids: [...]` line inside their `## Provenance` section. Both forms are a
    single line starting at column 0, so one pattern covers them.
    """
    declarations = {}
    for path in sorted(REPO.rglob("*.md")):
        rel = path.relative_to(REPO).as_posix()
        if is_excluded(rel):
            continue
        matches = DECLARE_RE.findall(path.read_text(encoding="utf-8", errors="replace"))
        if not matches:
            continue
        if len(matches) > 1:
            failures.append("%s: %d source_ids declarations, expected 1" % (rel, len(matches)))
        declarations[rel] = split_ids(matches[0])
    return declarations


def main():
    failures = []
    registry = load_registry(failures)

    # 1. The registry holds exactly the expected number of sources.
    if registry and len(registry) != EXPECTED_SOURCE_COUNT:
        failures.append(
            "%s: %d source IDs, expected %d"
            % (REGISTRY, len(registry), EXPECTED_SOURCE_COUNT)
        )

    # 2. Every derived path exists, is not excluded, and is listed once.
    for source_id, entry in sorted(registry.items()):
        seen = set()
        for rel in entry["derived"]:
            if rel in seen:
                failures.append("%s: derived lists %s more than once" % (source_id, rel))
            seen.add(rel)
            if is_excluded(rel):
                failures.append("%s: derived points into an excluded directory: %s" % (source_id, rel))
            elif not (REPO / rel).is_file():
                failures.append("%s: derived path does not exist: %s" % (source_id, rel))

    # 3. Declarations and derived agree in both directions.
    declarations = collect_declarations(failures)
    for rel, ids in sorted(declarations.items()):
        for source_id in ids:
            if source_id not in registry:
                failures.append("%s declares unknown source id %s" % (rel, source_id))
            elif rel not in registry[source_id]["derived"]:
                failures.append("missing from derived: %s should list %s" % (source_id, rel))
    for source_id, entry in sorted(registry.items()):
        for rel in entry["derived"]:
            if rel in declarations and source_id not in declarations[rel]:
                failures.append(
                    "unsupported derived entry: %s lists %s, but that file does not declare %s"
                    % (source_id, rel, source_id)
                )
            elif rel not in declarations and (REPO / rel).is_file():
                failures.append(
                    "unsupported derived entry: %s lists %s, but that file declares no source_ids"
                    % (source_id, rel)
                )

    # 4. The reading guide carries exactly one card per source ID.
    guide_text = read(GUIDE)
    for source_id in sorted(registry):
        found = len(re.findall(r"^### " + re.escape(source_id) + r"\b", guide_text, re.M))
        if found != 1:
            failures.append("%s: %d cards in %s, expected 1" % (source_id, found, GUIDE))
    guide_ids = set(re.findall(r"^### ((?:ART|REF)-[0-9]+)\b", guide_text, re.M))
    for source_id in sorted(guide_ids - set(registry)):
        failures.append("%s: card in %s has no entry in the registry" % (source_id, GUIDE))

    # 5. The retired term is gone from the reading guide.
    if RETIRED_TERM in guide_text:
        count = guide_text.count(RETIRED_TERM)
        failures.append('%s: retired term "%s" appears %d time(s)' % (GUIDE, RETIRED_TERM, count))

    if failures:
        print("FAIL: %d problem(s) found" % len(failures))
        for line in failures:
            print("  - %s" % line)
        return 1

    print("OK: %d sources, %d declaring documents, %d guide cards"
          % (len(registry), len(declarations), len(guide_ids)))
    return 0


if __name__ == "__main__":
    sys.exit(main())
