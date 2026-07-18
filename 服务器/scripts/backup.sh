#!/bin/bash
set -e

BACKUP_DIR="/data/backup"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="$BACKUP_DIR/openclaw-backup-$TIMESTAMP.tar.gz"

echo "======================================"
echo "  OpenClaw 备份脚本"
echo "======================================"

mkdir -p "$BACKUP_DIR"

echo "[1/3] 备份工作区..."
tar czf /tmp/workspace-backup.tar.gz -C /data workspace 2>/dev/null || echo "  (工作区为空或不存在)"
echo "[✓]"

echo "[2/3] 备份状态..."
tar czf /tmp/state-backup.tar.gz -C /data .openclaw 2>/dev/null || echo "  (状态为空或不存在)"
echo "[✓]"

echo "[3/3] 打包..."
tar czf "$BACKUP_FILE" -C /tmp workspace-backup.tar.gz state-backup.tar.gz 2>/dev/null
rm -f /tmp/workspace-backup.tar.gz /tmp/state-backup.tar.gz
echo "[✓]"

echo ""
echo "备份完成: $BACKUP_FILE"
echo "大小: $(du -h "$BACKUP_FILE" | cut -f1)"

# 保留最近 7 天备份，删除更早的
find "$BACKUP_DIR" -name "openclaw-backup-*.tar.gz" -mtime +7 -delete 2>/dev/null
echo "已清理 7 天前的旧备份"
