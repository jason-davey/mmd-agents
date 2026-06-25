#!/usr/bin/env bash
# install.sh — MMD Agents FREE tier installer
# Lives in: github.com/jason-davey/mmd-agents (PUBLIC repo)
#
# Installs: /brief command + decision-log skill
#
# Usage — run from any new project folder:
#   bash <(curl -fsSL https://raw.githubusercontent.com/jason-davey/mmd-agents/main/install.sh)
#
# For the full pro suite, use install-pro.sh from the private mmd-agents-pro repo.

set -euo pipefail

GITHUB_USER="jason-davey"
REPO_NAME="mmd-agents"
BRANCH="main"
BASE_URL="https://raw.githubusercontent.com/$GITHUB_USER/$REPO_NAME/$BRANCH"

COMMANDS_DIR=".claude/commands"
SKILLS_DIR=".claude/skills"

echo ""
echo "📦  MMD Agents — Free tier"
echo "    Source : github.com/$GITHUB_USER/$REPO_NAME"
echo "    Target : $(pwd)/.claude"
echo ""

mkdir -p "$COMMANDS_DIR" "$SKILLS_DIR"

# ── FREE COMMAND: /brief ───────────────────────────────────────────────────────
echo "── Commands ─────────────────────────────────────────────────────────────"
echo ""

install_command() {
  local name="$1"
  local url="$BASE_URL/commands/$name.md"
  local dest_cmd="$COMMANDS_DIR/$name.md"
  local dest_skill_dir="$SKILLS_DIR/$name"
  local dest_skill="$dest_skill_dir/SKILL.md"

  mkdir -p "$dest_skill_dir"

  if curl -fsSL "$url" -o "$dest_cmd" 2>/dev/null; then
    cp "$dest_cmd" "$dest_skill"
    echo "  ✓  /$name"
  else
    echo "  ⚠️  /$name — not found at $url"
  fi
}

install_command "brief"

echo ""

# ── FREE SKILL: decision-log ───────────────────────────────────────────────────
echo "── Skills ───────────────────────────────────────────────────────────────"
echo ""

install_skill() {
  local name="$1"
  local url="$BASE_URL/skills/$name/SKILL.md"
  local dest_dir="$SKILLS_DIR/$name"
  local dest_file="$dest_dir/SKILL.md"

  mkdir -p "$dest_dir"

  if curl -fsSL "$url" -o "$dest_file" 2>/dev/null; then
    echo "  ✓  $name"
  else
    echo "  ⚠️  $name — not found at $url"
  fi
}

install_skill "decision-log"

echo ""
echo "────────────────────────────────────────────────────────────────────────"
echo "Done."
echo ""
echo "  /brief         → scope any feature or screen with Claude"
echo "  decision-log   → Claude captures design decisions automatically"
echo ""
echo "Want the full suite? Ask about MMD Pro."
echo ""
