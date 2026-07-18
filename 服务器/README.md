# OpenClaw 服务器部署文件

此文件夹内的文件**按服务器实际路径排列**，你直接用文件管理器上传到对应位置即可。

## 文件对应表

| 仓库里的位置 | 服务器上的位置 |
|---|---|
| `etc/systemd/system/openclaw-gateway.service` | → `/etc/systemd/system/openclaw-gateway.service` |
| `etc/nginx/sites-available/openclaw.conf` | → `/etc/nginx/sites-available/openclaw.conf` |
| `root/.config/openclaw/gateway.yaml` | → `/root/.config/openclaw/gateway.yaml` |
| `root/.cloudflared/config.yml` | → `/root/.cloudflared/config.yml` |
| `data/workspace/*` | → `/data/workspace/` |
| `usr/local/bin/*` | → `/usr/local/bin/` |

## 快速上手

```bash
# 1. 安装 Node.js + OpenClaw
curl -fsSL https://openclaw.ai/install.sh | bash

# 2. 或者用 install.sh（在服务器上跑）
cp install.sh /root/
bash /root/install.sh
```

## 配置修改

上传前请修改以下文件中的占位内容：
- `root/.config/openclaw/gateway.yaml` → 改 `your-secret-token-here` 为你的密码
- `root/.cloudflared/config.yml` → 改域名
- `etc/nginx/sites-available/openclaw.conf` → 改域名
