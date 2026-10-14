---
name: skill-creator
description: Create new skills, modify and improve existing skills, and measure skill performance. Use when users want to create a skill from scratch, edit, or optimize an existing skill, run evals to test a skill, benchmark skill performance with variance analysis, or optimize a skill's description for better triggering accuracy.
---

# Skill Creator

A skill for creating new skills and iteratively improving them.

At a high level, the process of creating a skill goes like this:

- Decide what you want the skill to do and roughly how it should do it
- Write a draft of the skill
- Create a few test prompts and run the agent with the skill on them
- Help the user evaluate the results
- Rewrite the skill based on feedback
- Repeat until satisfied

## 快速体验方式（推荐你现在就试）

直接对 Agent 说：

> 使用 skill-creator 帮我创建一个简单的 Skill，用来总结一篇文章的要点

或者：

> 看看 skills/skill-creator/SKILL.md 里面的内容，解释一下什么是 Skill

## 核心结构

一个 Skill 就是一个文件夹 + SKILL.md：

```
skill-name/
├── SKILL.md          # 必须：YAML 头 + 步骤说明
└── （可选）scripts/ references/ assets/
```

YAML 头必须有 name 和 description。

## 来源

官方仓库：anthropics/skills
https://github.com/anthropics/skills/tree/main/skills/skill-creator
