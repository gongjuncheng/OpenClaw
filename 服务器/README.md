# OpenClaw 服务器部署

这是一个可直接部署到 Node.js 托管平台（如 Wispbyte）的 OpenClaw 应用包。

## 部署方式

### 方式一：通过文件管理器上传

1. 将此文件夹内所有文件打包成 zip
2. 登录 Wispbyte 控制面板 → 文件管理器
3. 上传 zip 并解压
4. 平台会自动执行 `npm install` 和 `npm start`

### 方式二：通过 Git 部署

```bash
git clone <你的仓库>
cd 服务器
npm install
npm start
```

## 配置

在平台的控制面板中设置以下环境变量（推荐）：

| 变量 | 说明 | 默认值 |
|---|---|---|
| `PORT` | 监听端口（平台自动提供） | `8080` |
| `OPENCLAW_GATEWAY_TOKEN` | **管理密码（务必修改！）** | `your-secret-token-here` |
| `OPENCLAW_STATE_DIR` | 状态存储目录 | `./data/.openclaw` |
| `OPENCLAW_WORKSPACE_DIR` | 工作区目录 | `./workspace` |

## 访问

部署成功后访问：
```
https://你的域名/openclaw
```

用 `OPENCLAW_GATEWAY_TOKEN` 登录即可开始使用。
