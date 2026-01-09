#!/bin/bash
# 初始化计划文件
# 用法: ./init.sh [项目名称]

set -e

PROJECT_NAME="${1:-project}"
DATE=$(date +%Y-%m-%d)
# 尝试定位模板目录
# 如果在 .planning 目录下运行
if [ -d "../templates" ]; then
    TEMPLATE_DIR="../templates"
elif [ -d "./templates" ]; then
    TEMPLATE_DIR="./templates"
elif [ -d ".planning/templates" ]; then
    TEMPLATE_DIR=".planning/templates"
else
    echo "错误: 找不到 templates 目录。"
    exit 1
fi

echo "正在为项目 [$PROJECT_NAME] 初始化计划文件..."

# 初始化 task_plan.md
if [ ! -f "task_plan.md" ]; then
    cp "$TEMPLATE_DIR/task_plan.md" "task_plan.md"
    # 替换标题占位符 (如果模板中有)
    # 使用 sed 简单替换，注意兼容性
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

echo ""
echo "✨ 计划文件初始化完成！"
echo "生成文件: task_plan.md, findings.md, progress.md"