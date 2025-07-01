# CLAUDE.md

This file provides guidance to Claude Code when working with code in this repository.

## Project Overview

Cross-platform dotfiles repository for rapid system setup across macOS, Linux, and Windows. Provides one-liner setup commands creating a consistent development environment with AI integration.

## Architecture

### Core Components
- **Platform detection** - Abstracts macOS (Homebrew), Linux (apt/yum), Windows (WinGet)
- **Idempotent scripts** - Safe to run multiple times, only installs missing components
- **AI rules management** - Centralized configuration for Cursor, Cline, Roo, and Claude Code
- **Secure credentials** - Apple keychain integration

### Repository Structure
```
install.sh / install.ps1     # Entry points
config/                      # XDG-compliant configurations
├── git/                    # Git config and global ignore
│   ├── config.template     # Modern Git config with security & performance
│   └── ignore_global       # Comprehensive global .gitignore
├── npm/                    # Node.js and npm config
│   ├── npmrc.template      # Security & performance optimized npm config
│   └── global-packages.txt # Curated essential global packages
├── shells/                 # Shell configuration components
│   ├── aliases             # 100+ intelligent aliases with modern tools
│   ├── exports             # XDG-compliant environment variables
│   ├── functions           # Powerful utility functions library
│   └── zshrc.template      # Performance-optimized zsh configuration
├── starship/               # Starship prompt configuration
│   ├── starship.toml       # Jetpack theme with language detection
│   └── fonts.template      # Fonts required by starship theme (https://www.jetbrains.com/lp/mono/)
└── vscode/                 # VSCode settings and extensions
scripts/                    # Installation scripts
├── setup-*.sh              # Component installers
└── install.sh              # Main orchestrator
ai-rules/                   # AI assistant configurations
├── templates/              # Tool-specific rules
├── prompt-library/        # Professional prompts
│   ├── foundational/      # System requirements templates
│   ├── prd/              # Product Requirements Documents
│   ├── common/           # Code review, debugging, optimization
│   └── project-types/    # Framework-specific prompts
└── mcp-servers/          # Claude Desktop MCP config
```

## Development Commands

### Installation
```bash
# Clone and run
git clone https://github.com/YOUR_USERNAME/jaRules.git
cd jaRules && ./install.sh

# Options
./install.sh --dotfiles-only    # Skip AI rules
./install.sh --rules-only       # Skip dotfiles
./install.sh --minimal          # Essentials only
```

### AI Configuration
```bash
# Initialize AI rules
./jarule ai-init --tool=cline --type=web-app
./jarule ai-init --tool=claude-code --type=api-server

# Apply prompt templates
./jarule prompts --add=foundational-requirements

# Sync configurations
./jarule ai-sync
```

## Implementation Standards

### XDG Compliance

- `$XDG_CONFIG_HOME` (~/.config) - Configuration files
- `$XDG_DATA_HOME` (~/.local/share) - Application data
- `$XDG_CACHE_HOME` (~/.cache) - Cache files
- `$XDG_STATE_HOME` (~/.local/state) - State files

### Modern Tools

- **fnm** > nvm (40x faster Node.js management)
- **exa** > ls (icons, colors, tree view)
- **bat** > cat (syntax highlighting)
- **fd** > find (5x faster, intuitive)
- **ripgrep** > grep (10x faster search)
- **delta** > diff (beautiful git diffs)
- **starship** for consistent, fast shell prompts


#### Secure Storage Integration

- macOS: Use `security` command for Keychain access
- Windows: Check for Apple Passwords app, fallback to PowerShell credential cmdlets
- Linux: Prefer `secret-tool`, fallback to `pass` or GPG-encrypted files

### Key Patterns

#### Platform Detection

```bash
case "$(uname -s)" in
    Darwin*) setup_macos ;;
    Linux*)  setup_linux ;;
    CYGWIN*|MINGW*) setup_windows ;;
esac
```

#### Idempotent Installation

```bash
command -v tool >/dev/null 2>&1 || install_tool
```



### Security Requirements

- No hardcoded secrets - use environment variables
- Never commit API keys, tokens, or credentials
- Platform-appropriate secure storage
- Ed25519 SSH keys
- GPG commit signing (optional)
- Validate downloaded scripts

## Testing Strategy

- CI/CD on fresh VMs for each OS
- Docker containers for Linux distros
- Version matrix testing
- Clean environment validation

## AI Integration Standards

### MCP Server Configuration

Claude Desktop should auto-configure with project-aware MCP servers:

- Filesystem access to active projects
- Git integration for repository context
- Dynamic loading based on detected project types

### Rules File Management

- **Template inheritance**: Base rules + tool-specific + project overrides
- **Professional prompt library**: Comprehensive templates for requirements, PRDs, code review, debugging, optimization
- **Project type auto-detection**: From package.json, requirements.txt, framework detection
- **Variable substitution**: Dynamic configuration based on project context
- **Consistent formatting**: Unified structure across all AI tools (Cline, Claude-Code, Cursor, etc.)

#### AI Rules Hierarchy

1. `ai-rules/templates/shared/` - Base rules for all tools
2. `ai-rules/templates/[tool]/` - Tool-specific extensions
3. `project-generated` - Combined final configs

### Cross-Platform Compatibility

All AI configurations must work across macOS, Linux, and Windows with appropriate path handling and tool availability checks.