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
