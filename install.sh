#!/bin/bash

# 获取脚本所在的源目录
SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 检查是否提供了目标目录参数
if [ -z "$1" ]; then
    read -p "请输入安装目标目录: " TARGET_DIR
else
    TARGET_DIR="$1"
fi

# 处理相对路径
if [[ "$TARGET_DIR" != /* ]]; then
    TARGET_DIR="$(pwd)/$TARGET_DIR"
fi

# 检查目标目录是否存在
if [ ! -d "$TARGET_DIR" ]; then
    echo "错误: 目标目录不存在: $TARGET_DIR"
    exit 1
fi

echo "正在安装..."

# 复制 planning-with-files 目录到目标目录
cp -r "$SOURCE_DIR/planning-with-files" "$TARGET_DIR/"

echo "✅ 安装成功！"
echo ""
echo "提示：下一步操作将 SKILL.md 内容复制到系统 prompt 中，如果是 gemini cli 的话，直接复制到 target 目录下的 GEMINI.md 文件中。"