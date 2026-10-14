# skill-agant

Agent Skills 仓库，用于存放可被云端 Agent 读取的 SKILL.md 流程文档。

## 目录结构

```
skills/
  example-skill/
    SKILL.md          # 示例 Skill
AGENTS.md             # Agent 人设与规则
```

## 使用方式

1. 在 `skills/` 下新建一个文件夹，放入 `SKILL.md`
2. SKILL.md 必须以 YAML frontmatter 开头（name + description）
3. 云端 Agent 可直接通过 GitHub 读取此仓库使用这些 Skill

## 添加新 Skill

复制 `skills/example-skill/` 目录，改名后修改 SKILL.md 即可。

## 视频风格分析与文案润色（上游导入）

- [analyze-video](skills/analyze-video/SKILL.md)：参考视频风格拆解与可复用模板。
- [copy-editing](skills/copy-editing/SKILL.md)：现有文案的多轮审阅与润色。
- [video](skills/video/SKILL.md)：视频转写、关键帧、OCR 和时间轴读取。

已保留上游脚本、参考资料、评估文件和 MIT 许可证；`novoads-api` 是 `analyze-video` 的配套依赖。来源版本和运行要求见 [UPSTREAM-SKILLS.md](UPSTREAM-SKILLS.md)。导入文件不等于已经安装运行环境或完成视频效果验证。
