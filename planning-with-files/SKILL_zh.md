---
name: planning-with-files
version: "2.0.1"
description: 为复杂任务实现 Manus 风格的基于文件的规划。创建 task_plan.md、findings.md 和 progress.md。在开始复杂的、多步骤的任务、研究项目或任何需要超过 5 次工具调用的任务时使用。
allowed-tools: Read, Write, Edit, Bash, Glob, Grep, WebFetch, WebSearch
hooks:
  PreToolUse:
    - matcher: "Write|Edit|Bash"
      hooks:
        - type: command
          command: "cat task_plan.md 2>/dev/null | head -30 || true"
  Stop:
    - hooks:
        - type: command
          command: "planning-with-files/scripts/check-complete.sh"
---

# 文件化规划 (Planning with Files)

像 Manus 一样工作：使用持久化的 Markdown 文件作为你的“磁盘工作内存”。

## 重要：文件存放位置

使用此技能时：

- **模板** 存储在技能目录中：`planning-with-files/templates/`
- **你的规划文件** (`task_plan.md`, `findings.md`, `progress.md`) 应当创建在 **你的项目目录** 中 —— 即你当前工作的文件夹。

| 位置 | 存放内容 |
|----------|-----------------|
| 技能目录 (`planing-with-files/`) | 模板、脚本、参考文档 |
| 你的项目目录 | `task_plan.md`, `findings.md`, `progress.md` |

这确保了你的规划文件与代码并存，而不是埋没在技能安装文件夹中。

## 快速开始

在执行任何复杂任务之前：

1. **在项目中创建 `task_plan.md`** — 参考 [templates/task_plan.md](templates/task_plan.md)
2. **在项目中创建 `findings.md`** — 参考 [templates/findings.md](templates/findings.md)
3. **在项目中创建 `progress.md`** — 参考 [templates/progress.md](templates/progress.md)
4. **决策前重新阅读计划** — 在注意力窗口中刷新目标
5. **每个阶段后更新** — 标记完成，记录错误

> **注意：** 所有三个规划文件都应创建在当前工作目录（项目根目录）中，而不是技能的安装文件夹中。

## 核心模式

```
上下文窗口 (Context Window) = RAM (易失性，有限)
文件系统 (Filesystem) = 磁盘 (持久性，无限)

→ 任何重要的内容都写入磁盘。
```

## 文件用途

| 文件 | 用途 | 何时更新 |
|------|---------|----------------|
| `task_plan.md` | 阶段、进度、决策 | 每个阶段结束后 |
| `findings.md` | 研究、发现 | 任何发现之后 |
| `progress.md` | 会话日志、测试结果 | 贯穿整个会话 |

## 核心规则

### 1. 计划先行
绝对不要在没有 `task_plan.md` 的情况下开始复杂任务。这是不可逾越的底线。

### 2. “2次行动”规则
> “每进行 2 次查看/浏览器/搜索操作后，立即将关键发现保存到文本文件中。”

这可以防止视觉/多模态信息的丢失。

### 3. 先读后决
在做出重大决策之前，阅读计划文件。这能让目标始终保持在你的注意力范围内。

### 4. 动后更新
完成任何阶段后：
- 标记阶段状态：`in_progress` → `complete`
- 记录遇到的任何错误
- 注明创建/修改的文件

### 5. 记录所有错误
每一个错误都要记录在计划文件中。这能积累知识并防止重复出错。

```markdown
## 遇到的错误
| 错误 | 尝试次数 | 解决方法 |
|-------|---------|------------|
| FileNotFoundError | 1 | 创建了默认配置 |
| API timeout | 2 | 添加了重试逻辑 |
```

### 6. 永不重复失败
```
if action_failed:
    next_action != same_action
```
追踪你尝试过的方法。改变你的策略。

## 三阶段错误处理协议 (The 3-Strike Error Protocol)

```
尝试 1：诊断与修复
  → 仔细阅读错误
  → 识别根本原因
  → 应用针对性修复

尝试 2：替代方案
  → 同样的错误？尝试不同的方法
  → 不同的工具？不同的库？
  → 绝对不要重复完全相同的失败操作

尝试 3：全面反思
  → 质疑假设
  → 搜索解决方案
  → 考虑更新计划

3 次失败后：上报用户
  → 说明你尝试过的方法
  → 分享具体的错误信息
  → 请求指导
```

## 读 vs 写决策矩阵

| 情况 | 行动 | 原因 |
|-----------|--------|--------|
| 刚写完一个文件 | 不要读 | 内容仍在上下文中 |
| 查看了图片/PDF | 立即写入发现 | 多模态内容在丢失前转为文本 |
| 浏览器返回了数据 | 写入文件 | 截图无法持久化 |
| 开始新阶段 | 阅读计划/发现 | 如果上下文陈旧，需重新定位 |
| 发生错误 | 阅读相关文件 | 需要当前状态来修复 |
| 中断后恢复 | 阅读所有规划文件 | 恢复状态 |

## 五问重启测试 (The 5-Question Reboot Test)

如果你能回答这些问题，说明你的上下文管理非常稳健：

| 问题 | 答案来源 |
|----------|---------------|
| 我在哪？ | task_plan.md 中的当前阶段 |
| 我要去哪？ | 剩余的阶段 |
| 目标是什么？ | 计划中的目标陈述 |
| 我学到了什么？ | findings.md |
| 我做了什么？ | progress.md |

## 何时使用此模式

**适用于：**
- 多步骤任务（3步以上）
- 研究任务
- 构建/创建项目
- 跨越多次工具调用的任务
- 任何需要组织的工作

**跳过：**
- 简单问题
- 单文件编辑
- 快速查询

## 模板

复制这些模板以开始：

- [templates/task_plan.md](templates/task_plan.md) — 阶段追踪
- [templates/findings.md](templates/findings.md) — 研究存储
- [templates/progress.md](templates/progress.md) — 会话日志

## 脚本

用于自动化的辅助脚本：

- `scripts/init-session.sh` — 初始化所有规划文件
- `scripts/check-complete.sh` — 验证所有阶段已完成

## 高级主题

- **Manus 原则：** 参见 [reference.md](reference.md)
- **真实案例：** 参见 [examples.md](examples.md)

## 反面模式 (Anti-Patterns)

| 不要 | 而是 |
|-------|------------|
| 使用 TodoWrite 进行持久化 | 创建 task_plan.md 文件 |
| 陈述一次目标后就忘记 | 决策前重新阅读计划 |
| 隐藏错误并默默重试 | 将错误记录到计划文件中 |
| 将所有内容塞进上下文 | 将大量内容存储在文件中 |
| 立即开始执行 | 先创建计划文件 |
| 重复失败的操作 | 追踪尝试，改变方法 |
| 在技能目录中创建文件 | 在你的项目中创建文件 |
