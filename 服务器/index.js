/**
 * OpenClaw 服务器入口
 * 适用于 Wispbyte 等 Node.js 托管平台
 */
import { runLegacyCliEntry } from 'openclaw';

// ===== 【重要】修改这个密码！ =====
const GATEWAY_TOKEN = 'your-secret-token-here';

// ===== 启动配置 =====
// 端口：托管平台会提供 PORT 环境变量
const PORT = process.env.PORT || '8080';

// 状态目录
const STATE_DIR = process.env.OPENCLAW_STATE_DIR || '/home/container/data/.openclaw';

// 工作区目录
const WORKSPACE_DIR = process.env.OPENCLAW_WORKSPACE_DIR || '/home/container/workspace';

// 设置环境变量
process.env.OPENCLAW_GATEWAY_PORT = PORT;
process.env.OPENCLAW_STATE_DIR = STATE_DIR;
process.env.OPENCLAW_WORKSPACE_DIR = WORKSPACE_DIR;
process.env.OPENCLAW_GATEWAY_TOKEN = GATEWAY_TOKEN;
process.env.OPENCLAW_HOST = '0.0.0.0';

// 创建必要目录
import { mkdirSync, existsSync } from 'fs';

for (const dir of [STATE_DIR, WORKSPACE_DIR]) {
  if (!existsSync(dir)) mkdirSync(dir, { recursive: true });
}

console.log('🚀 OpenClaw Gateway 启动中...');
console.log(`📡 地址: 0.0.0.0:${PORT}`);
console.log(`🔗 访问: /openclaw`);
console.log(`🔑 Token: ${GATEWAY_TOKEN === 'your-secret-token-here' ? '⚠️  请修改密码！' : '✅ 已设置'}`);

try {
  await runLegacyCliEntry(['node', 'openclaw', 'gateway', 'start']);
} catch (err) {
  console.error('❌ 启动失败:', err.message);
  process.exit(1);
}
