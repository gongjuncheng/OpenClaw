#!/bin/bash
set -e

echo "======================================"
echo "  OpenClaw 一键启动脚本"
echo "======================================"

# 检查是否已安装
if ! command -v openclaw &>/dev/null; then
    echo "[✗] OpenClaw 未安装，请先运行 install.sh"
    exit 1
fi

# 环境变量
export OPENCLAW_STATE_DIR=/data/.openclaw
export OPENCLAW_WORKSPACE_DIR=/data/workspace
export OPENCLAW_NO_RESPAWN=1
export NODE_COMPILE_CACHE=/var/tmp/openclaw-compile-cache
mkdir -p /var/tmp/openclaw-compile-cache

echo "[✓] 环境变量已设置"
echo ""
echo "启动 OpenClaw Gateway..."
echo "访问地址: http://localhost:8080/openclaw"
echo ""
echo "按 Ctrl+C 停止"
echo ""

# 启动
openclaw gateway start
