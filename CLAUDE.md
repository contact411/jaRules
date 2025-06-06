# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a cross-platform dotfiles repository designed for rapid system setup across macOS, Linux, and Windows. The goal is to provide one-liner setup commands that create a consistent development environment with AI integration.

## Architecture

### Core Components
- **Platform detection and package management** - Abstracts differences between macOS (Homebrew), Linux (apt/yum), and Windows (Chocolatey)
- **Idempotent installation scripts** - Safe to run multiple times, only installs missing components
- **AI rules management** - Centralized configuration for Cursor, Cline, Aider, and GitHub Copilot
- **Secure credential storage** - Platform-specific keychain integration (Apple Passwords, Windows Credential Manager, Linux secret-tool)

### Repository Structure
```
install.sh / install.ps1     # Entry points for Unix/Windows
common/                      # Cross-platform configurations
├── starship.toml           # Universal shell prompt
├── gitconfig               # Git settings and aliases  
└── aliases                 # Shell aliases
platform-specific/          # OS-specific tooling
├── macos/                  # Homebrew, system defaults
├── linux/                  # Package management, SSH
└── windows/                # PowerShell, terminal config
editors/                    # Editor configurations
├── vscode/                 # Settings sync, extensions
├── vim/                    # Sensible defaults, themes
└── nano/                   # Basic enhancements
ai-rules/                   # AI assistant configurations
├── templates/              # Standard rule templates
├── mcp-servers/           # Claude Desktop MCP config
└── shared/                # Common context for all AI tools
```

## Development Commands

### Installation
```bash
# Clone and run full setup
git clone <repo> && cd dotfiles && ./install.sh

# Minimal mode (essentials only)
./install.sh --minimal

# Custom installation
./install.sh --interactive
```

### AI Configuration
```bash
# Initialize AI rules for new project
./dotfiles ai-init [web|api|mobile|fullstack|data-science]

# Sync AI configurations from shared templates
./dotfiles ai-sync

# Update MCP server paths and project context
./dotfiles ai-update-mcp
```

### Maintenance
```bash
# Update all tools and configurations
./dotfiles update

# Backup current configs before changes
./dotfiles backup

# Test installation on clean system
./test/run-ci.sh
```

## Key Implementation Notes

### Platform Detection Pattern
All scripts should detect OS early and branch appropriately:
```bash
case "$(uname -s)" in
    Darwin*) setup_macos ;;
    Linux*)  setup_linux ;;
    CYGWIN*|MINGW*) setup_windows ;;
esac
```

### Idempotent Installation
Check for existing installations before installing:
```bash
command -v starship >/dev/null 2>&1 || install_starship
```

### AI Rules Hierarchy
1. **shared/base-context.md** - Universal rules for all AI tools
2. **tool-specific/** - Extensions for individual AI assistants  
3. **project-generated** - Final configs combining shared + specific

### Secure Storage Integration
- macOS: Use `security` command for Keychain access
- Windows: Check for Apple Passwords app, fallback to PowerShell credential cmdlets
- Linux: Prefer `secret-tool`, fallback to `pass` or GPG-encrypted files

## Testing Strategy

- **CI/CD testing** on fresh VMs for each supported OS
- **Docker containers** for Linux distribution testing
- **Version matrix** testing against multiple OS versions
- All installation scripts must be tested in clean environments

## Security Requirements

- Never commit API keys, tokens, or credentials
- Use platform-appropriate secure storage for sensitive data
- Generate SSH keys with Ed25519 algorithm
- Optional GPG setup for commit signing
- Validate all downloaded scripts and binaries

## AI Integration Standards

### MCP Server Configuration
Claude Desktop should auto-configure with project-aware MCP servers:
- Filesystem access to active projects
- Git integration for repository context
- Dynamic loading based on detected project types

### Rules File Management  
- Template-based generation from shared context
- Project type auto-detection from package.json, requirements.txt, etc.
- Consistent formatting and structure across all AI tools

### Cross-Platform Compatibility
All AI configurations must work across macOS, Linux, and Windows with appropriate path handling and tool availability checks.