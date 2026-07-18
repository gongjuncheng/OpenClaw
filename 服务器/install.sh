#!/bin/bash
set -e

echo "======================================"
echo "  OpenClaw 服务器一键安装脚本"
echo "  请在服务器上以 root 身份运行"
echo "======================================"

# 1. 安装 Node.js + OpenClaw
echo ""
echo "[1/3] 安装 Node.js + OpenClaw..."
curl -fsSL https://openclaw.ai/install.sh | bash
echo "[✓]"

# 2. 创建目录
echo ""
echo "[2/3] 创建持久化目录..."
mkdir -p /data/workspace/memory
mkdir -p /data/.openclaw
echo "[✓]"

# 3. 复制配置文件（假设本脚本在 服务器/ 目录下运行）
echo ""
echo "[3/3] 安装配置文件..."
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Gateway 配置
mkdir -p /root/.config/openclaw
cp "$SCRIPT_DIR/root/.config/openclaw/gateway.yaml" /root/.config/openclaw/ 2>/dev/null || true

# Systemd 服务
cp "$SCRIPT_DIR/etc/systemd/system/openclaw-gateway.service" /etc/systemd/system/ 2>/dev/null || true
systemctl daemon-reload 2>/dev/null || true
systemctl enable openclaw-gateway 2>/dev/null || true

# 工作区
cp -r "$SCRIPT_DIR/data/workspace/"* /data/workspace/ 2>/dev/null || true

# 脚本
cp "$SCRIPT_DIR/usr/local/bin/"* /usr/local/bin/ 2>/dev/null || true
chmod +x /usr/local/bin/openclaw-*.sh

# Nginx
mkdir -p /etc/nginx/sites-available
cp "$SCRIPT_DIR/etc/nginx/sites-available/openclaw.conf" /etc/nginx/sites-available/ 2>/dev/null || true

echo "[✓]"

echo ""
echo "======================================"
echo "  安装完成！"
echo "======================================"
echo ""
echo "下一步:"
echo "  1. 修改 /root/.config/openclaw/gateway.yaml 中的 token"
echo "  2. 启动: systemctl start openclaw-gateway"
echo "  3. 查看状态: systemctl status openclaw-gateway"
echo ""
echo "  如果要配 Cloudflare Tunnel:"
echo "    cloudflared tunnel login"
echo "    cloudflared tunnel create openclaw"
echo "    cloudflared tunnel route dns openclaw <你的域名>"
echo "    cloudflared tunnel run openclaw"
