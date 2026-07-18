#!/bin/bash
set -e

echo "======================================"
echo "  Cloudflare Tunnel 安装脚本"
echo "======================================"
echo ""

# 检测架构
ARCH=$(uname -m)
case $ARCH in
    x86_64)  CF_ARCH="amd64" ;;
    aarch64) CF_ARCH="arm64" ;;
    armv7l)  CF_ARCH="arm" ;;
    *)       echo "不支持的架构: $ARCH"; exit 1 ;;
esac

echo "[1/3] 下载 cloudflared ($ARCH)..."
curl -fsSL "https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-${CF_ARCH}" -o /usr/local/bin/cloudflared
chmod +x /usr/local/bin/cloudflared
echo "[✓] 下载完成"

echo ""
echo "[2/3] 登录 Cloudflare..."
echo "  将打开浏览器，请登录你的 Cloudflare 账号"
cloudflared tunnel login
echo "[✓] 登录完成"

echo ""
echo "[3/3] 创建隧道..."
cloudflared tunnel create openclaw
echo "[✓] 隧道创建完成"

echo ""
echo "======================================"
echo "  下一步操作"
echo "======================================"
echo ""
echo "1. 配置 DNS 路由:"
echo "   cloudflared tunnel route dns openclaw <你的域名>"
echo ""
echo "2. 复制 config.yml 到 ~/.cloudflared/config.yml"
echo ""
echo "3. 启动隧道:"
echo "   cloudflared tunnel run openclaw"
echo ""
echo "4. 或安装为系统服务:"
echo "   cloudflared service install"
