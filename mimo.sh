#!/bin/bash

# Mimo Setup Script
# Cài đặt cấu hình mặc định cho Mimo Code CLI
# Usage: curl -fsSL <url_to_mimo.sh> | sh
#    hoặc: sudo ./mimo.sh

set -e

# Kiểm tra quyền root, nếu không có thì tự động xin quyền sudo
if [ "$EUID" -ne 0 ]; then 
  echo "Yêu cầu quyền root để cài đặt vào /root/.config/"
  exec sudo "$0" "$@"
fi

echo "🚀 Bắt đầu cài đặt cấu hình Mimo Code..."

# Tạo thư mục cấu hình
CONFIG_DIR="/root/.config/mimocode"
mkdir -p "$CONFIG_DIR"

# Đường dẫn file config
CONFIG_FILE="$CONFIG_DIR/mimocode.jsonc"

# Ghi file cấu hình
cat > "$CONFIG_FILE" <<'EOF'
{
  "$schema": "https://mimo.xiaomi.com/mimocode/config.json ",
  "instructions": [
    "AGENTS.md",
    ".mimo/rules/*.md",
    "Luôn luôn trả lời bằng tiếng Việt, kể cả khi câu hỏi bằng tiếng Anh.",
    "Giữ nguyên tiếng Anh: source code, comment, log, error message, lệnh terminal, tên biến/hàm/file, commit message.",
    "Không dịch thuật ngữ kỹ thuật sang tiếng Việt.",
    "Trả lời ngắn gọn, đi thẳng vào vấn đề."
  ],
  "provider": {
    "claude": {
      "name": "claude",
      "env": [
        "CLAUDE_API_KEY=Work1234"
      ],
      "npm": "@ai-sdk/openai-compatible",
      "options": {
        "baseURL": "http://localhost:11234/v1",
        "setCacheKey": true
      },
      "models": {
        "opus": { "name": "opus" },
        "haiku": { "name": "haiku" },
        "sonnet": { "name": "sonnet" }
      }
    },
    "qwen": {
      "name": "Qwen Local",
      "npm": "@ai-sdk/openai-compatible",
      "options": {
        "baseURL": "http://172.25.57.241:9090/v1"
      },
      "models": {
        "qwen36-35b": {
          "name": "qwen36-35b",
          "settings": {
            "maxInputTokens": 92160,
            "maxOutputTokens": 8192
          }
        }
      }
    }
  }
}
EOF

echo "✅ Đã tạo file cấu hình tại: $CONFIG_FILE"
echo ""
echo "📝 Nội dung chính:"
echo "   - Provider Claude (localhost:11234)"
echo "   - Provider Qwen (172.25.57.241:9090)"
echo "   - Instructions: Trả lời tiếng Việt, giữ nguyên thuật ngữ kỹ thuật."
echo ""
echo "⚠️  Lưu ý: Hãy thay đổi 'CLAUDE_API_KEY' và 'baseURL' trong file config nếu cần."
echo "👉  Để xác minh, chạy: cat $CONFIG_FILE"
