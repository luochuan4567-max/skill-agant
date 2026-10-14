---
name: novoads-api
description: 仅在用户明确要求使用 Novoads 服务或其 REST API 生成图片、视频、广告素材时使用。处理该服务的参考素材上传、实时报价、生成、轮询和验收；普通图像编辑、国漫分镜、视频分析或仅提到模型名不触发。
---

# Novoads 专用入口

这是可选的外部服务流程。用户没有明确指定 Novoads 时，使用当前任务对应的技能和已授权工具。
先读 [制作默认值](../../references/production-defaults.md)，再按所选模型读取 [API 参考](reference.md) 和对应提示词资料。

## 环境和边界
- 本仓库不提供 setup.sh 或 check-novoads-env.sh，也不假定共享技能已安装。
- 检查运行环境中是否配置 NOVOADS_API_KEY；只报告有无，不打印值。缺少配置时说明如何在安全的环境变量或本地 .env 中设置；不得提交凭据。
- 上游入口保存在 [UPSTREAM.md](UPSTREAM.md)，仅作参考。API 字段、模型支持和报价必须从当前官方接口核实；遇到文档矛盾时不猜参数。
- 不读取不存在的 image-to-motion、clone-video-ad 或 shared/ 路径。相关任务改用现有能力；无可用能力时明确说明。
- 本仓库不默认将用户素材上传给该服务。执行上传须在已授权的服务任务范围内。

## 执行
1. 取得本次素材、目标、画幅、时长、声音和模型选择。保持当前母版及中文制作要求。
2. 查看服务当前模型能力；选择本地已有的对应参考资料，不把某模型的时长/分辨率限制推广到其他模型。
3. 按参考中的上传流程取得 assetId。参考槽位与素材逐一对应，不混用起始帧与参考图模式。
4. 调用当前估价接口，展示实际报价、素材/台词和生成范围；授权须覆盖实际费用与台词。既有明确授权覆盖本次具体请求时不重复询问；否则在发起计费请求前取得确认。
5. 发起生成；保存 jobId。按接口规定轮询，遇到 succeeded、failed、blocked、canceled 等终态停止，不无限等待成功。
6. 网络或服务错误后先检查已创建任务，防止重复计费。再次生成可能产生额外费用，不默认为已授权。
7. 下载并实际检查完整画面和声音，核对身份、母版、动作、台词、尺寸及稳定性。失败或未完成如实交付状态。

## 资料选择
- [模型与端点](reference.md)：请求字段、错误处理及模型能力；使用前在线核实。
- [通用提示词指引](prompting/guide.md)：仅参考与当前题材有关的部分。
- [Seedance 指引](prompting/prompt-library/seedance-2.md)、[Sora 指引](prompting/prompt-library/sora-2.md)、[Veo 指引](prompting/prompt-library/veo-3-1.md)、[Kling 指引](prompting/prompt-library/kling-3.md)：选择对应模型后再读。
- [角色参考](prompting/prompt-library/character-sheet.md)：用户要求角色资产时按需读，不默认生成宫格。
