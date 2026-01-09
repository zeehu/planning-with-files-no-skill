#!/bin/bash
# Planning with Files - 安装脚本

set -e

# 获取脚本所在的源目录
SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 检查是否提供了目标目录参数
if [ -z "$1" ]; then
    echo "用法: bash install.sh <项目目录路径>"
    echo "示例: bash install.sh ./my-awesome-project"
    exit 1
fi

TARGET_DIR="$1"

# 处理相对路径和绝对路径，获取绝对路径
if [[ "$TARGET_DIR" != /* ]]; then
    TARGET_DIR="$(pwd)/$TARGET_DIR"
fi

# 检查目标目录是否存在
if [ ! -d "$TARGET_DIR" ]; then
    echo "错误: 目标目录不存在: $TARGET_DIR"
    exit 1
fi

DEST_DIR="$TARGET_DIR/.planning"

echo "-----------------------------------------------"
echo "正在安装 Planning with Files 协议工具..."
echo "目标项目: $TARGET_DIR"
echo "-----------------------------------------------"

# 在目标目录创建 .planning 结构
mkdir -p "$DEST_DIR/scripts"
mkdir -p "$DEST_DIR/templates"

# 从源目录复制脚本和模板到目标 .planning 目录
cp "$SOURCE_DIR/scripts/"*.sh "$DEST_DIR/scripts/"
cp "$SOURCE_DIR/templates/"*.md "$DEST_DIR/templates/"
cp "$SOURCE_DIR/SYSTEM_PROMPT.md" "$DEST_DIR/"

# 赋予执行权限
chmod +x "$DEST_DIR/scripts/"*.sh

echo "正在初始化计划文件..."

# 执行初始化逻辑
PROJECT_NAME=$(basename "$TARGET_DIR")
DATE=$(date +%Y-%m-%d)
TEMPLATE_DIR="$DEST_DIR/templates"

# 在目标目录根部初始化文件
cd "$TARGET_DIR"

# 初始化 task_plan.md
if [ ! -f "task_plan.md" ]; then
    cp "$TEMPLATE_DIR/task_plan.md" "task_plan.md"
    # 替换标题占位符
    sed -i.bak "s/\[Brief Description\]/$PROJECT_NAME/g" task_plan.md && rm task_plan.md.bak
    echo "已创建 task_plan.md"
else
    echo "task_plan.md 已存在，跳过"
fi

# 初始化 findings.md
if [ ! -f "findings.md" ]; then
    cp "$TEMPLATE_DIR/findings.md" "findings.md"
    echo "已创建 findings.md"
else
    echo "findings.md 已存在，跳过"
fi

# 初始化 progress.md
if [ ! -f "progress.md" ]; then
    cp "$TEMPLATE_DIR/progress.md" "progress.md"
    # 替换日期
    sed -i.bak "s/\$DATE/$DATE/g" progress.md && rm progress.md.bak
    echo "已创建 progress.md"
else
    echo "progress.md 已存在，跳过"
fi

echo "✅ 安装与初始化成功！"
echo ""
echo "项目文件已安装至: $DEST_DIR"
echo "已在项目根目录生成: task_plan.md, findings.md, progress.md"
echo ""
echo "下一步操作："
echo "1. 将 $DEST_DIR/SYSTEM_PROMPT.md 的内容告知您的 AI Agent"
echo "2. 随着任务进展，不断更新生成的 Markdown 文件"
echo "3. 任务完成后在该目录下运行: ./.planning/scripts/check.sh"
echo "-----------------------------------------------"
