# Planning with Files (No-Skill Version)

**为不支持 Skill 插件系统的 Code Agent 量身定制的持久化规划工作流。**

本项目提供了一套轻量级的指令协议和文件模板，旨在通过简单的 **Prompt 注入**，让任何具有文件读写能力的 AI 代理（如 Gemini CLI、Open-webui 等）都能拥有类似 [Manus AI](https://manus.ai/) 的“持久化规划”能力。

## 🚀 为什么需要本项目？

大多数传统的 Code Agent 在面对复杂、多步骤的任务时经常会遇到以下痛点：
- **上下文漂移**：随着对话变长，AI 容易忘记最初的目标或关键约束。
- **内存易失**：AI 的上下文窗口是有限且易逝的，深层逻辑容易被冗长的输出冲刷掉。
- **错误循环**：遇到错误时，AI 往往在同一个坑里反复尝试，没有持久的错误日志指导。

**本项目通过将“工作记忆”从内存转移到文件系统（Disk），大幅提升 AI 处理复杂逻辑的成功率。**

---

## 💡 核心理念：Manus 风格工作流

本项目的核心模式参考了 [OthmanAdi/planning-with-files](https://github.com/OthmanAdi/planning-with-files)。它强迫 AI 在执行代码前先“思考并记录”：

1.  **`task_plan.md` (总计划)**：AI 必须先拆分阶段，并在每个阶段完成后更新进度。
2.  **`findings.md` (知识库)**：调研出的 API 细节、决策依据存入此文件，永不丢失。
3.  **`progress.md` (操作日志)**：记录每一步的操作和遇到的 Error，确保错误能被总结和规避。

---

## 🛠️ 简易版使用指南 (推荐：零配置启动)

如果你正在使用不支持 Skill 扩展的 Agent（例如 **Gemini CLI**），这是最快的使用方式。

### 1. 复制 Prompt
直接打开本项目中的 [`SYSTEM_PROMPT_simple.md`](SYSTEM_PROMPT_simple.md)，将其内容复制。

### 2. 注入上下文
- **通用方法**：将内容直接粘贴到 AI 的 System Prompt 或对话开始的首条指令中。
- **Gemini CLI 用户 (最佳实践)**：
    1. 在你的开发项目根目录下创建 `GEMINI.md` 文件。
    2. 将 `SYSTEM_PROMPT_simple.md` 的内容粘贴进去。
    3. 启动 Gemini CLI，它将自动读取该协议并进入“规划模式”。

---

## 📦 完整版安装指南 (带自动化工具)

如果你希望在本地项目中保留这套工具包，并使用自动初始化和检查脚本：

### 项目结构
```text
.
├── scripts/           # 包含完成度检查逻辑 (check.sh)
├── templates/         # 核心 Markdown 模板
├── install.sh         # 一键安装脚本
└── SYSTEM_PROMPT.md   # 完整版协议
```

### 安装步骤
在本项目目录下运行：
```bash
# bash install.sh <目标项目路径>
bash install.sh ../my-project
```
脚本会自动在目标项目中创建 `.planning/` 目录并初始化所有必要的规划文件。

---

## 鸣谢

本项目是对 [OthmanAdi/planning-with-files](https://github.com/OthmanAdi/planning-with-files) 的精简与通用化实现。

## 许可证

本项目采用 [MIT License](LICENSE) 授权。
