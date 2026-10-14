# Imported upstream skills

Imported on 2026-10-14. Upstream files are preserved without rewriting or translating their instructions.

| Primary skill | Source | Pinned upstream commit | Runtime requirements |
| --- | --- | --- | --- |
| analyze-video | https://github.com/novoads/agent-skills/tree/dbec1eadf9b4b1d8a5a03fea5d043ddae9013693/skills/analyze-video | dbec1eadf9b4b1d8a5a03fea5d043ddae9013693 | Bash, FFmpeg/ffprobe; Whisper or supplied dialogue for speech. |
| copy-editing | https://github.com/coreyhaines31/marketingskills/tree/c7d7dfb6b460fc376b4b2204b78a9c9fd5ca6467/skills/copy-editing | c7d7dfb6b460fc376b4b2204b78a9c9fd5ca6467 | No dedicated media runtime; requires source copy and context. |
| video | https://github.com/guimatheus92/mcp-video-analyzer/tree/10bfb4e525a8e61b757a66b2e657775f30472c9b/skills/video | 10bfb4e525a8e61b757a66b2e657775f30472c9b | Connected video-analyzer MCP or Node.js 22.12+ CLI; speech requires a configured transcription backend. |

## Included support

- All files within each of the three primary upstream skill directories, including scripts, references and evaluations.
- The upstream `skills/novoads-api/` directory, including its supporting router skill, templates and API documentation, because `analyze-video` reads its formulas and writes new formulas into that directory. This is a dependency, not a fourth primary recommendation.
- Original MIT licenses under `licenses/`, one for each source repository. The source copyright notices remain intact.

## Scope and dependencies

This is a source import, not a local installation or executed video test. No provider accounts, credentials, media files, Node packages or model weights are included. Upstream prerequisites and any paid API requirements still apply. The optional Novoads rendering workflow requires an account and explicit authorization before spending credits.

Novoads links to the optional sibling `clone-video-ad` workflow are not imported; obtain it from the pinned upstream repository if video generation is requested. Copy-editing's related skills (copywriting, cro, marketing-psychology and ab-testing) are also not imported. These are additional workflows, not the core editing references bundled here. The optional copywriting AI-tells reference is available in its upstream skill directory.

The Novoads entrypoint contains some historical link-label/file-map inconsistencies; it is preserved as upstream text. The actual local dependency paths listed above are present. Marketing templates are not evidence of Chinese fantasy adaptation quality. Apply the user's original-story constraints and supplied Chinese copy when using these workflows.

## Updating

Compare with the pinned commits before updating; preserve local customizations and the original licenses. The import does not auto-update from upstream.

## Local organization (2026-10-14)

The active SKILL.md entrypoints for analyze-video, copy-editing, video and novoads-api are now local adapters. Their original entrypoints are preserved verbatim as UPSTREAM.md beside each adapter; supporting references, evaluations and licenses remain included. Original imported evaluations have not been rerun against these adapters and are not validation evidence for the local workflows.

analyze-video now defaults to reference-video learning rather than a paid advertising formula. copy-editing is scoped to marketing copy; novoads-api requires explicit service intent. The local extraction script uses awk instead of bc, validates inputs and refuses reused generated output paths.

Upstream snapshots are historical reference, not executable local instructions. Missing upstream paths include scripts/setup.sh, scripts/check-novoads-env.sh, shared/references/craft.md and shared model/caption/image-ad workflows, as well as the previously documented sibling skills. Do not treat them as installed. Active local entrypoints do not depend on those missing files. Optional routes must use capabilities actually present in the current session.

example-skill and skill-template have moved to templates/ so they do not compete with active skills. Production defaults live in references/production-defaults.md. Static validation does not establish paid API availability, model quality, or actual platform performance.
