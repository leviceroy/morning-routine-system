#!/bin/bash

# Morning Routine System - Automated Setup Script
# This script installs and configures the morning routine workflow

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging functions
log_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

log_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

log_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

log_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Header
echo ""
echo "🌅 Morning Routine System - Setup"
echo "===================================="
echo ""

# Check prerequisites
log_info "Checking prerequisites..."

# Check Python
if ! command -v python3 &> /dev/null; then
    log_error "Python 3 is not installed"
    exit 1
fi

PYTHON_VERSION=$(python3 --version | cut -d' ' -f2 | cut -d'.' -f1,2)
PYTHON_MAJOR=$(echo $PYTHON_VERSION | cut -d'.' -f1)
PYTHON_MINOR=$(echo $PYTHON_VERSION | cut -d'.' -f2)

if [ "$PYTHON_MAJOR" -lt 3 ] || { [ "$PYTHON_MAJOR" -eq 3 ] && [ "$PYTHON_MINOR" -lt 8 ]; }; then
    log_error "Python 3.8+ required, found $PYTHON_VERSION"
    exit 1
fi

log_success "Python $PYTHON_VERSION found"

# Check pip
if ! command -v pip3 &> /dev/null; then
    log_error "pip3 is not installed"
    exit 1
fi

log_success "pip3 found"

# Check git
if ! command -v git &> /dev/null; then
    log_warning "git not found (optional)"
else
    log_success "git found"
fi

# Detect OS
log_info "Detecting operating system..."
OS="unknown"
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS="linux"
    if grep -qi microsoft /proc/version; then
        OS="wsl2"
    fi
elif [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macos"
fi

log_success "Detected: $OS"

# Create virtual environment
log_info "Creating Python virtual environment..."

VENV_PATH="$HOME/gcalcli-venv"

if [ "$OS" == "wsl2" ]; then
    log_warning "WSL2 detected - creating venv in home directory"
fi

if [ -d "$VENV_PATH" ]; then
    log_warning "Virtual environment already exists at $VENV_PATH"
    read -p "Recreate it? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        rm -rf "$VENV_PATH"
        python3 -m venv "$VENV_PATH"
    fi
else
    python3 -m venv "$VENV_PATH"
fi

log_success "Virtual environment created"

# Install gcalcli
log_info "Installing gcalcli..."

source "$VENV_PATH/bin/activate"
pip install --upgrade pip > /dev/null 2>&1
pip install gcalcli > /dev/null 2>&1

GCALCLI_VERSION=$(gcalcli --version 2>&1 | head -1)
log_success "gcalcli installed: $GCALCLI_VERSION"

# Create directory structure
log_info "Creating directory structure..."

mkdir -p Daily Goals Notes .claude/commands/morning-routine .claude/templates

log_success "Directories created"

# Copy workflow files
log_info "Copying workflow files..."

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

# Copy command files
if [ -d "$PROJECT_DIR/.claude/commands/morning-routine" ]; then
    cp -r "$PROJECT_DIR/.claude/commands/morning-routine/"* .claude/commands/morning-routine/
    log_success "Command files copied"
else
    log_warning "Command files not found in $PROJECT_DIR/.claude/commands/morning-routine"
fi

# Copy templates
if [ -d "$PROJECT_DIR/.claude/templates" ]; then
    cp -r "$PROJECT_DIR/.claude/templates/"* .claude/templates/
    log_success "Template files copied"
else
    log_warning "Template files not found in $PROJECT_DIR/.claude/templates"
fi

# Create example files
log_info "Creating example files..."

# Example goal
cat > "Goals/Example-Goal.md" << 'EOF'
---
status: "In progress"
start: 2026-01-06
end: 2026-03-06
frequency: "Daily"
tags:
  - goal
  - example
---

# Example Goal

## Prerequisites

This is an example goal. Replace with your actual goal.

## Success Criteria

- [ ] Criterion 1
- [ ] Criterion 2
- [ ] Criterion 3

## Log

- 2026-01-06: Goal created as example
EOF

log_success "Example goal created"

# Add alias to shell config
log_info "Setting up shell aliases..."

SHELL_CONFIG=""
if [ -f "$HOME/.bashrc" ]; then
    SHELL_CONFIG="$HOME/.bashrc"
elif [ -f "$HOME/.zshrc" ]; then
    SHELL_CONFIG="$HOME/.zshrc"
fi

if [ -n "$SHELL_CONFIG" ]; then
    if ! grep -q "gcalcli-venv" "$SHELL_CONFIG"; then
        echo "" >> "$SHELL_CONFIG"
        echo "# Morning Routine System - gcalcli alias" >> "$SHELL_CONFIG"
        echo "alias gcalcli='source ~/gcalcli-venv/bin/activate && gcalcli'" >> "$SHELL_CONFIG"
        log_success "Alias added to $SHELL_CONFIG"
    else
        log_warning "Alias already exists in $SHELL_CONFIG"
    fi
fi

# Summary
echo ""
echo "===================================="
log_success "Installation complete!"
echo "===================================="
echo ""

echo "📋 Next steps:"
echo ""
echo "1. Authenticate Google Calendar:"
echo "   $ source ~/gcalcli-venv/bin/activate"
echo "   $ gcalcli init --noauth_local_server"
echo ""
echo "2. Configure your calendar name:"
echo "   $ nano .claude/commands/morning-routine/schedule-day.md"
echo "   (Replace 'YOUR_CALENDAR_NAME' with your actual calendar name)"
echo ""
echo "3. Start Claude Code and run:"
echo "   /morning-routine:main"
echo ""

log_info "For detailed instructions, see docs/INSTALLATION.md"
log_info "For quick start, see docs/QUICKSTART.md"

echo ""
