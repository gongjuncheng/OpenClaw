# OpenClaw 服务器部署

将 OpenClaw AI 助手部署到 Linux 服务器（Wispbyte 1GB VPS）的完整配置。

## 环境

- **系统**: Alpine Linux / Debian 最小化
- **Node.js**: v22.22.3+
- **OpenClaw**: 最新版
- **反向代理**: Nginx + Cloudflare Tunnel
- **总占用**: ~750 MB / 1 GB

## 目录结构

```
服务器/
├── README.md                 # 本文件
├── install.sh                # 一键安装脚本
├── openclaw/
│   └── gateway.yaml          # Gateway 配置文件
├── workspace/                # 工作区（OpenClaw 的记忆和配置）
│   ├── AGENTS.md
│   ├── SOUL.md
│   ├── IDENTITY.md
│   ├── USER.md
│   ├── TOOLS.md
│   └── memory/
├── systemd/
│   └── openclaw-gateway.service  # systemd 服务
├── cloudflare/
│   ├── config.yml            # Tunnel 配置
│   └── tunnel-setup.sh       # Tunnel 安装脚本
├── nginx/
│   └── openclaw.conf         # Nginx 反向代理配置
└── scripts/
    ├── setup.sh              # 初始化脚本
    ├── start.sh              # 启动脚本
    └── backup.sh             # 备份脚本
```

## 快速部署

```bash
# 服务器上执行
chmod +x install.sh
./install.sh
```
