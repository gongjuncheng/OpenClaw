#!/bin/bash
set -e

echo "======================================"
echo "  OpenClaw 服务器初始化脚本"
echo "======================================"
echo ""
echo "此脚本通常在 install.sh 之后运行，"
echo "用于配置工作区和登录。"

# 设置工作区
export OPENCLAW_STATE_DIR=/data/.openclaw
export OPENCLAW_WORKSPACE_DIR=/data/workspace

mkdir -p /data/.openclaw
mkdir -p /data/workspace/memory

echo "[1/2] 设置 Gateway Token..."
read -sp "请输入 Gateway Token（管理密码）: " TOKEN
echo ""
openclaw config set gateway.auth.token "$TOKEN"
echo "[✓] Token 已设置"

echo ""
echo "[2/2] 启动 setup wizard..."
openclaw onboard

echo ""
echo "======================================"
echo "  初始化完成！"
echo "======================================"
echo ""
echo "启动: systemctl start openclaw-gateway"
echo "访问: https://你的域名/openclaw"
