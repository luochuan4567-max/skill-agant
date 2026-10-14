#!/usr/bin/env python3
"""Validate active skill entrypoints and their local Markdown links."""
from pathlib import Path
import re
import sys
import yaml

ROOT = Path(__file__).resolve().parents[1]
errors = []
seen = set()
skills = sorted((ROOT / "skills").glob("*/SKILL.md"))
if not skills:
    errors.append("No active skills found")
for path in skills:
    content = path.read_text(encoding="utf-8")
    match = re.match(r"\A---\r?\n(.*?)\r?\n---(?:\r?\n|$)", content, re.S)
    if not match:
        errors.append(f"{path.relative_to(ROOT)}: missing YAML frontmatter")
        continue
    try:
        meta = yaml.safe_load(match.group(1))
    except yaml.YAMLError as exc:
        errors.append(f"{path.relative_to(ROOT)}: invalid YAML: {exc}")
        continue
    if not isinstance(meta, dict):
        errors.append(f"{path.relative_to(ROOT)}: frontmatter must be a mapping")
        continue
    name = meta.get("name")
    if not isinstance(name, str) or not re.fullmatch(r"[a-z0-9]+(?:-[a-z0-9]+)*", name) or len(name) >= 64:
        errors.append(f"{path.relative_to(ROOT)}: invalid name")
    elif name != path.parent.name or name in seen:
        errors.append(f"{path.relative_to(ROOT)}: name mismatch or duplicate")
    seen.add(str(name))
    if not isinstance(meta.get("description"), str) or not meta["description"].strip():
        errors.append(f"{path.relative_to(ROOT)}: missing description")
    if len(content.splitlines()) > 500:
        errors.append(f"{path.relative_to(ROOT)}: entrypoint exceeds 500 lines")

# Historical upstream snapshots and imported references are not active entrypoints.
# This checker checks existence, not heading anchors, runtime, routing or media quality.
for path in [*skills, ROOT / "README.md", ROOT / "AGENTS.md"]:
    for target in re.findall(r"\[[^\]]*\]\(([^)]+)\)", path.read_text(encoding="utf-8")):
        if re.match(r"[a-zA-Z][a-zA-Z0-9+.-]*:", target) or target.startswith("#"):
            continue
        local = target.split("#", 1)[0]
        if not (path.parent / local).resolve().exists():
            errors.append(f"{path.relative_to(ROOT)}: missing link {target}")
if errors:
    print("\n".join(errors), file=sys.stderr)
    sys.exit(1)
print(f"PASS: {len(skills)} active skills; metadata, names and entrypoint links valid")
