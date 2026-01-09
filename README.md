# Planning with Files (No-Skill Version)

这是一个基于文件系统的持久化规划工作流工具，旨在帮助 AI 代理（或人类开发者）在处理复杂任务时保持上下文、跟踪进度并记录发现。

本项目的灵感和核心模式参考了 [OthmanAdi/planning-with-files](https://github.com/OthmanAdi/planning-with-files)，特别感谢其提出的 "Manus AI" 风格的持久化 Markdown 规划工作流。

## 核心理念

通过使用文件系统作为“工作记忆”，本项目通过三个核心 Markdown 文件解决以下问题：
- **内存易失**：AI 代理的上下文窗口有限，重要信息容易丢失。
- **目标漂移**：在长任务中容易偏离最初的目标。
- **错误隐藏**：失败的尝试往往被滚动出上下文。
- **上下文堆积**：无关紧要的细节占据了宝贵的 Token 空间。

## 三文件模式

1.  **`task_plan.md`**: 任务蓝图。记录总体目标、拆分的阶段（Phases）以及当前的详细步骤。
2.  **`findings.md`**: 知识库。记录研究成果、关键决策、API 细节和重要的代码片段。
3.  **`progress.md`**: 操作日志。按时间顺序记录已完成的工作、测试结果和遇到的困难。

## 简易版使用指南 (推荐)

如果你只想让 AI Agent 遵循该规划工作流，而不需要安装额外的脚本，可以使用 `SYSTEM_PROMPT_simple.md`。

### 使用方法：
直接将 `SYSTEM_PROMPT_simple.md` 的文件内容复制到你的 AI Agent 系统提示词（System Prompt）或项目上下文提示词中。

### 示例：Gemini CLI
对于使用 **Gemini CLI** 的开发者，可以实现“开箱即用”：
1. 在你的开发项目根目录下创建一个名为 `GEMINI.md` 的文件。
2. 将本项目中的 `SYSTEM_PROMPT_simple.md` 内容全部复制进去。
3. 当你启动 Gemini CLI 并与之对话时，它会自动读取 `GEMINI.md` 并激活该规划模式。

---

## 完整版安装指南

如果你需要更强大的功能（如自动化初始化、完成度检查脚本等），请按照以下步骤安装。

### 项目结构

```text
.
├── scripts/           # 实用脚本
│   ├── init.sh        # 初始化三个核心文件
│   └── check.sh       # 检查计划完成情况
├── templates/         # 核心文件的 Markdown 模板
│   ├── findings.md
│   ├── progress.md
│   └── task_plan.md
├── install.sh         # 安装脚本（配置环境）
└── SYSTEM_PROMPT.md   # 建议配合使用的系统提示词
```

### 1. 安装与初始化

在本项目（工具包）目录下运行安装脚本，并指定你的**开发项目路径**：

```bash
# 格式：bash install.sh <目标项目路径>
bash install.sh ../path/to/your/project
```

该脚本将执行以下操作：
1.  在目标项目目录创建 `.planning/` 文件夹并安装脚本、模板和系统提示词。
2.  在目标项目目录初始化核心文件：`task_plan.md`、`findings.md` 和 `progress.md`。

### 2. 开始规划

1.  将 `.planning/SYSTEM_PROMPT.md` 的内容告知你的 AI Agent，让它理解此工作流。
2.  按照模板填充 `task_plan.md`，并随着任务的进行不断更新这三个文件。
3.  任务结束时，运行 `./.planning/scripts/check.sh` 验证所有阶段是否已完成。

## 鸣谢

本项目是对 [OthmanAdi/planning-with-files](https://github.com/OthmanAdi/planning-with-files) 的精简/通用版本实现，适用于任何能够读写文件的 AI 代理或开发环境。

## 许可证

本项目采用 [MIT License](LICENSE) 授权。