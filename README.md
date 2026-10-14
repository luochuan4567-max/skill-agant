# skill-agant

服务于国漫二创、小说解说、影视分镜与参考图制作的 Agent Skills 仓库。

## 技能入口

| 任务 | 技能 | 使用边界 |
| --- | --- | --- |
| 小说剧情口播、新稿、改稿、审稿 | [novel-commentary](skills/novel-commentary/SKILL.md) | 原著依据、唯一主线、危机推进 |
| 小说/口播影视化分镜 | [cinematic-storyboard](skills/cinematic-storyboard/SKILL.md) | 人物表演、空间连续性、母版与制作难度 |
| 母版局部修图 | [reference-image-edit](skills/reference-image-edit/SKILL.md) | 以当前原图为基准，执行指定变化 |
| 视频内容读取 | [video](skills/video/SKILL.md) | 转写、关键帧、OCR、事实与时间轴 |
| 优秀视频拆解学习 | [analyze-video](skills/analyze-video/SKILL.md) | 可复用结构、重点学习项、证据时间戳 |
| 营销文案润色 | [copy-editing](skills/copy-editing/SKILL.md) | 品牌、销售、广告文案 |
| Novoads API 生成 | [novoads-api](skills/novoads-api/SKILL.md) | 仅在用户明确指定该服务时使用 |
| 技能创建与检查 | [skill-creator](skills/skill-creator/SKILL.md) | 触发、流程、依赖、验收 |
| 文章总结 | [summarize-article](skills/summarize-article/SKILL.md) | 客观提炼，不添加原文没有的信息 |

先读 [AGENTS.md](AGENTS.md)。通用制作默认值见 [production-defaults.md](references/production-defaults.md)，用户当前指令覆盖默认值。

## 目录与使用

- `skills/<name>/SKILL.md`：9 个日常技能入口。
- `templates/`：示例和空白模板，不作为日常技能加载。
- `references/`：共享制作默认值。
- `scripts/validate_skills.py`：检查入口元数据、名称和本地链接。
- 导入技能目录中的 `UPSTREAM.md`：保留的上游原始入口，仅供查阅。
- `licenses/`：上游许可证。

通过 GitHub 读取技能时，明确指定仓库和路径；本地使用时按客户端的技能安装方式配置。
仅把仓库放在 GitHub 不会自动注册、安装或连接外部服务。

新增技能可复制 [空白模板](templates/skill-template/SKILL.md)，填写完成后放入 `skills/`。
检查命令：`python scripts/validate_skills.py`（需要 Python 3 和 PyYAML）。

视频运行环境、上游来源和导入边界见 [UPSTREAM-SKILLS.md](UPSTREAM-SKILLS.md)。
