# Skills

Skills are reusable workflows. Each skill states its source IDs, trigger, output, verification, and permission boundary. Do not promote a one-off article summary into a skill.

| Skill | Use when | Install target |
| --- | --- | --- |
| [knowledge-curator](knowledge-curator/SKILL.md) | Links or notes must be retained as reusable knowledge. | Codex skill directory or a project-specific skill directory. |
| [repository-publish](repository-publish/SKILL.md) | A repository change could be read by others or pushed to GitHub. | `.claude/skills/` or an equivalent agent skill directory. |

Copy only the selected skill directory; do not copy local settings, history, permission state, or credentials. Agent configuration synchronization remains an implementation candidate rather than an installed feature: see the shared-configuration principle in `../foundation/README.md`, and `ART-006` in the source registry (`../knowledge/sources/articles.yml`) for the reading behind it.
