/**
 * OpenClaw 服务器入口
 * 适用于 Wispbyte 等 Node.js 托管平台
 */
import { spawn } from 'child_process';
import { fileURLToPath } from 'url';
import { dirname, join } from 'path';
import { mkdirSync, existsSync } from 'fs';

const __dirname = dirname(fileURLToPath(import.meta.url));

// ===== 配置 =====
const TOKEN = process.env.OPENCLAW_GATEWAY_TOKEN || 'admin123';
const PORT = process.env.PORT || '8080';

// 创建必要目录
for (const dir of [
  '/home/container/data/.openclaw',
  '/home/container/workspace/memory'
]) {
  if (!existsSync(dir)) mkdirSync(dir, { recursive: true });
}

console.log('🚀 OpenClaw Gateway 启动中...');
console.log(`📡 0.0.0.0:${PORT}`);
console.log(`🔗 /openclaw`);
console.log(`🔑 Token: ${TOKEN === 'admin123' ? '⚠️ 请改密码！' : '✅ 已设置'}`);

// 直接 spawn openclaw 进程
const openclawPath = join(__dirname, 'node_modules', 'openclaw', 'openclaw.mjs');
const proc = spawn('node', [openclawPath, 'gateway', 'run', '--port', PORT, '--allow-unconfigured'], {
  stdio: 'inherit',
  env: {
    ...process.env,
    OPENCLAW_GATEWAY_PORT: PORT,
    OPENCLAW_GATEWAY_TOKEN: TOKEN,
    OPENCLAW_HOST: '0.0.0.0',
    OPENCLAW_STATE_DIR: '/home/container/data/.openclaw',
    OPENCLAW_WORKSPACE_DIR: '/home/container/workspace',
  }
});

proc.on('exit', (code) => {
  console.log(`Gateway 进程退出 (code: ${code})`);
  process.exit(code || 0);
});
