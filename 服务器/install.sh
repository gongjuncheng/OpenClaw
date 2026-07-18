#!/bin/bash
set -e

echo "======================================"
echo "  OpenClaw 服务器一键安装脚本"
echo "======================================"

# 检测系统
if [ -f /etc/alpine-release ]; then
    PKG_MGR="apk"
    PKG_INSTALL="apk add"
    echo "[✓] Alpine Linux 检测到"
elif command -v apt &>/dev/null; then
    PKG_MGR="apt"
    PKG_INSTALL="apt install -y"
    echo "[✓] Debian/Ubuntu 检测到"
else
    echo "[✗] 不支持的 Linux 发行版"
    exit 1
fi

echo ""
echo "[1/5] 安装依赖..."
if [ "$PKG_MGR" = "apk" ]; then
    $PKG_INSTALL curl nodejs npm bash 2>/dev/null
elif [ "$PKG_MGR" = "apt" ]; then
    $PKG_INSTALL curl gnupg
    curl -fsSL https://deb.nodesource.com/setup_22.x | bash -
    $PKG_INSTALL nodejs
fi
echo "[✓] 依赖安装完成"

echo ""
echo "[2/5] 安装 OpenClaw..."
npm install -g openclaw@latest
echo "[✓] OpenClaw 安装完成 ($(openclaw --version))"

echo ""
echo "[3/5] 初始化工作区..."
mkdir -p /data/workspace/memory
mkdir -p /data/.openclaw
echo "[✓] 工作区创建完成"

echo ""
echo "[4/5] 配置 Gateway..."
mkdir -p ~/.config/openclaw
cp openclaw/gateway.yaml ~/.config/openclaw/gateway.yaml 2>/dev/null || true
echo "[✓] Gateway 配置完成"

echo ""
echo "[5/5] 安装系统服务..."
cp systemd/openclaw-gateway.service /etc/systemd/system/ 2>/dev/null || {
    mkdir -p ~/.config/systemd/user/
    cp systemd/openclaw-gateway.service ~/.config/systemd/user/
}
systemctl daemon-reload 2>/dev/null || true
systemctl enable openclaw-gateway 2>/dev/null || true
echo "[✓] 系统服务安装完成"

echo ""
echo "======================================"
echo "  OpenClaw 部署完成！"
echo "======================================"
echo ""
echo "启动: systemctl start openclaw-gateway"
echo "查看状态: systemctl status openclaw-gateway"
echo "查看日志: journalctl -u openclaw-gateway -f"
echo ""
echo "访问: http://localhost:8080/openclaw"
echo ""
echo "如需配置 Cloudflare Tunnel，请运行:"
echo "  bash cloudflare/tunnel-setup.sh"
