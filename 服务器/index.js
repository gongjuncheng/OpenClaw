/**
 * OpenClaw 服务器入口
 * 适用于 Node.js 托管平台（Wispbyte 等）
 * 
 * 平台会自动执行 npm install → npm start
 */

import { runLegacyCliEntry } from 'openclaw';

// ---------- 环境变量配置 ----------
// 这些可以在平台的控制面板里设置，不用改代码

// 端口：托管平台通常会提供 PORT 环境变量
process.env.OPENCLAW_GATEWAY_PORT = process.env.PORT || '8080';

// 状态目录（存聊天记录、配置等）
process.env.OPENCLAW_STATE_DIR = process.env.OPENCLAW_STATE_DIR || './data/.openclaw';

// 工作区目录（存记忆文件）
process.env.OPENCLAW_WORKSPACE_DIR = process.env.OPENCLAW_WORKSPACE_DIR || './workspace';

// 管理密码——【重要】务必修改！
process.env.OPENCLAW_GATEWAY_TOKEN = process.env.OPENCLAW_GATEWAY_TOKEN || 'your-secret-token-here';

// ---------- 启动 Gateway ----------
console.log('🚀 OpenClaw Gateway 启动中...');
console.log(`📡 端口: ${process.env.OPENCLAW_GATEWAY_PORT}`);
console.log(`📁 工作区: ${process.env.OPENCLAW_WORKSPACE_DIR}`);
console.log(`🔗 访问: /openclaw`);

try {
  await runLegacyCliEntry(['node', 'openclaw', 'gateway', 'start']);
} catch (err) {
  console.error('❌ 启动失败:', err.message);
  process.exit(1);
}
