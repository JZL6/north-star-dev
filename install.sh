#!/usr/bin/env bash
# sdd-tdd-orchestrator — Cross-platform skill installer
# Installs the skill into the detected AI agent's skill directory.

set -euo pipefail

SKILL_NAME="sdd-tdd-orchestrator"
SKILL_DIR="$(cd "$(dirname "$0")" && pwd)"

# Detect platform
detect_platform() {
    if [ -n "${CLAUDE_CODE_CONFIG_DIR:-}" ]; then
        echo "claude-code"
    elif [ -n "${CODESPACE:-}" ] && command -v gh >/dev/null 2>&1; then
        echo "copilot-cli"
    elif [ -d "$HOME/.cursor" ]; then
        echo "cursor"
    elif [ -d "$HOME/.config/windsurf" ]; then
        echo "windsurf"
    elif [ -d "$HOME/.gemini" ]; then
        echo "gemini-cli"
    elif [ -n "${OPENAI_CODEX_CONFIG:-}" ]; then
        echo "codex-cli"
    else
        echo "unknown"
    fi
}

PLATFORM=$(detect_platform)

install_to_dir() {
    local target="$1"
    mkdir -p "$target"
    cp -R "$SKILL_DIR/." "$target/$SKILL_NAME/"
    echo "✓ Installed $SKILL_NAME to $target/$SKILL_NAME"
}

case "$PLATFORM" in
    claude-code)
        install_to_dir "${CLAUDE_CODE_CONFIG_DIR}/skills"
        ;;
    cursor)
        install_to_dir "$HOME/.cursor/skills"
        ;;
    windsurf)
        install_to_dir "$HOME/.config/windsurf/skills"
        ;;
    gemini-cli)
        install_to_dir "$HOME/.gemini/skills"
        ;;
    *)
        echo "Platform: $PLATFORM"
        echo "Could not auto-detect AI agent platform."
        echo "Manual install: copy this folder to your agent's skills directory."
        echo "Skill folder: $SKILL_DIR"
        exit 1
        ;;
esac

echo ""
echo "✓ $SKILL_NAME installed successfully."
echo "Activate with: /$SKILL_NAME"
