/**
 * OpenClaw 首次设置脚本
 * 运行: npm run setup
 */

import { runLegacyCliEntry } from 'openclaw';

console.log('🔧 OpenClaw 初始化向导...\n');

// 创建必要目录
import { mkdirSync, existsSync } from 'fs';
import { join, dirname } from 'path';
import { fileURLToPath } from 'url';

const __dirname = dirname(fileURLToPath(import.meta.url));

const dirs = [
  join(__dirname, 'data/.openclaw'),
  join(__dirname, 'workspace/memory'),
];

for (const dir of dirs) {
  if (!existsSync(dir)) {
    mkdirSync(dir, { recursive: true });
    console.log(`  📁 创建目录: ${dir}`);
  }
}

console.log('\n✅ 目录创建完成');
console.log('💡 部署后访问 /openclaw 进行初始化\n');

// 启动设置向导
await runLegacyCliEntry(['node', 'openclaw', 'onboard']);
