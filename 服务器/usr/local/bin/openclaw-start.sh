#!/bin/bash
set -e

echo "======================================"
echo "  OpenClaw 服务器启动"
echo "======================================"

export OPENCLAW_STATE_DIR=/data/.openclaw
export OPENCLAW_WORKSPACE_DIR=/data/workspace
export OPENCLAW_NO_RESPAWN=1
export NODE_COMPILE_CACHE=/var/tmp/openclaw-compile-cache

mkdir -p /var/tmp/openclaw-compile-cache /data/.openclaw

echo "启动中..."
echo "访问: http://localhost:8080/openclaw"
echo ""

openclaw gateway start
