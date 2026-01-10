# Planning with Files (No-Skill Version)

**为不支持 Skill 插件系统的 Code Agent 量身定制的持久化规划工作流。**

本项目提供了一套轻量级的指令协议和文件模板，旨在通过简单的 **Prompt 注入**，让任何具有文件读写能力的 AI 代理（如 Gemini CLI、Open-webui 等）都能拥有类似 [Manus AI](https://manus.ai/) 的“持久化规划”能力。

## 🚀 为什么需要本项目？

本项目通过将“工作记忆”从内存转移到文件系统（Disk），大幅提升 AI 处理复杂逻辑的成功率。
- **上下文持久化**：所有的阶段、发现和错误都记录在 `.planning/` 目录下。
- **错误循环规避**：通过强制记录 Error Log，防止 AI 在同一个问题上反复尝试。

---

## 💡 核心理念：Manus 风格工作流

1.  **`task_plan.md` (总计划)**：拆分阶段，实时更新。
2.  **`findings.md` (知识库)**：存入调研细节，永不丢失。
3.  **`progress.md` (操作日志)**：记录每一步的操作和遇到的错误。

---

## 🛠️ 安装与使用指南

本项目提供两种使用方式，请根据需求选择。

### 方式一：完整版 (推荐)
**适合长期项目**，安装包含完整协议文档、模板和辅助脚本的 `planning-with-files` 目录。

#### 1. 运行安装脚本
在本项目目录下运行：
```bash
# 用法: bash install.sh <目标项目路径>
bash install.sh ../my-awesome-project
```
脚本会将 `planning-with-files` 文件夹完整复制到你的目标项目根目录下。

#### 2. 配置 System Prompt
*   **通用 Agent**：打开目标项目中的 `planning-with-files/SKILL.md`，将其内容复制并粘贴到你的 Agent System Prompt 中。
*   **Gemini CLI**：直接将 `planning-with-files/SKILL.md` 的内容复制到项目根目录下的 `GEMINI.md` 文件中。

#### 3. 开始任务
Agent 启动后，会根据协议要求在项目根目录下（注意：不是在 `planning-with-files` 目录内）依据模板初始化 `task_plan.md` 等文件。

---

### 方式二：简易版 (Lite)
**适合快速体验或临时任务**，无需安装任何文件，仅需一段 Prompt。

#### 1. 获取 Prompt
复制本项目根目录下的 [SYSTEM_PROMPT_simple.md](SYSTEM_PROMPT_simple.md) 文件内容。

#### 2. 配置 System Prompt
将其粘贴到你的 AI Agent 的 System Prompt 中。

#### 3. 开始任务
直接向 Agent 下达复杂任务指令。Agent 会根据 Prompt 中的指令，自动在当前目录下创建 `.planning/` 目录并初始化所需的三大规划文件。
如果需要强制触发 planning-with-files，可在任务 prompt 前加入`使用 planning_with_files：`.

---

## 鸣谢

本项目是对 [OthmanAdi/planning-with-files](https://github.com/OthmanAdi/planning-with-files) 的精简与通用化实现。

## 许可证

本项目采用 [MIT License](LICENSE) 授权。