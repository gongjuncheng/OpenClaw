#!/bin/bash
set -e

BACKUP_DIR="/data/backup"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="$BACKUP_DIR/openclaw-backup-$TIMESTAMP.tar.gz"

mkdir -p "$BACKUP_DIR"

echo "备份工作区..."
tar czf /tmp/workspace.tar.gz -C /data workspace 2>/dev/null

echo "备份状态..."
tar czf /tmp/state.tar.gz -C /data .openclaw 2>/dev/null

echo "打包..."
tar czf "$BACKUP_FILE" /tmp/workspace.tar.gz /tmp/state.tar.gz 2>/dev/null
rm -f /tmp/workspace.tar.gz /tmp/state.tar.gz

echo "完成: $BACKUP_FILE ($(du -h "$BACKUP_FILE" | cut -f1))"

# 保留 7 天
find "$BACKUP_DIR" -name "openclaw-backup-*.tar.gz" -mtime +7 -delete
