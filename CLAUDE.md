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
config/                      # XDG-compliant configuration templates
├── git/                    # Git configuration and global ignore
│   ├── config.template     # Modern Git config with security & performance
│   └── ignore_global       # Comprehensive global .gitignore
├── npm/                    # Node.js and npm configuration
│   ├── npmrc.template      # Security & performance optimized npm config
│   └── global-packages.txt # Curated essential global packages
├── shells/                 # Shell configuration components
│   ├── aliases             # 100+ intelligent aliases with modern tools
│   ├── exports             # XDG-compliant environment variables
│   ├── functions           # Powerful utility functions library
│   └── zshrc.template      # Performance-optimized zsh configuration
├── starship/               # Starship prompt configuration
│   └── starship.toml       # Catppuccin theme with language detection
└── vscode/                 # VSCode configuration
    ├── settings.template.json  # Opinionated productivity settings
    └── extensions.json     # Curated extensions for modern development
scripts/                    # Installation and setup scripts
├── setup-node.sh          # fnm and Node.js setup with cross-platform support
└── install.sh             # Main installation orchestrator (planned)
ai-rules/                   # AI assistant configurations
├── templates/              # AI tool-specific rule templates
│   ├── cline/             # Cline assistant configurations
│   ├── claude-code/       # Claude-Code specific rules
│   ├── cursor/            # Cursor AI rules
│   └── shared/            # Common rules across tools
├── prompt-library/        # Professional prompt templates
│   ├── foundational/      # System requirements templates
│   ├── prd/              # Product Requirements Documents
│   ├── common/           # Code review, debugging, optimization
│   └── project-types/    # Framework-specific prompts
└── mcp-servers/          # Claude Desktop MCP configurations
```

## Development Commands

### Installation
```bash
# Clone and run full setup
git clone <repo> && cd jaRules && ./install.sh

# Modular installation options  
./install.sh --dotfiles-only    # Skip AI rules
./install.sh --rules-only       # Skip dotfiles
./install.sh --minimal          # Essentials only

# Individual component setup
./scripts/setup-node.sh         # Node.js and npm configuration
```

### AI Configuration
```bash
# Initialize AI rules for new project
./jarule ai-init --tool=cline --type=web-app
./jarule ai-init --tool=claude-code --type=api-server

# Apply professional prompt templates  
./jarule prompts --add=foundational-requirements
./jarule prompts --add=prd-template

# Sync AI configurations from shared templates
./jarule ai-sync

# Update MCP server paths and project context
./jarule ai-update-mcp
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

## Dotfiles Architecture

### XDG Base Directory Compliance
All configurations follow the XDG Base Directory Specification for clean, organized file placement:
- `$XDG_CONFIG_HOME` (~/.config) - Configuration files
- `$XDG_DATA_HOME` (~/.local/share) - Application data
- `$XDG_CACHE_HOME` (~/.cache) - Cache files
- `$XDG_STATE_HOME` (~/.local/state) - State files (logs, history)

### Template-Based Configuration
- **Security**: All sensitive data uses environment variable substitution
- **Portability**: Template files work across different environments
- **Customization**: Local overrides without modifying base templates
- **Variable format**: `${VARIABLE_NAME}` for environment substitution

### Modern Tool Integration
- **fnm** over nvm for Node.js version management (faster, more reliable)
- **exa** over ls for enhanced directory listings with icons
- **bat** over cat for syntax-highlighted file viewing
- **fd** over find for faster, more intuitive file searching
- **ripgrep** over grep for blazing fast content search
- **delta** over diff for beautiful Git diffs
- **starship** for consistent, fast shell prompts

### Performance Optimizations
- **Lazy loading**: Shell plugins and tools load only when needed
- **Efficient caching**: npm, shell completions, and tool caches optimized
- **Minimal startup time**: Shell configuration targets sub-second initialization
- **Smart detection**: Tools are only configured if they're available

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
1. **ai-rules/templates/shared/** - Universal rules for all AI tools
2. **ai-rules/templates/[tool-specific]/** - Extensions for individual AI assistants (Cline, Claude-Code, Cursor)
3. **ai-rules/prompt-library/** - Professional prompt templates (foundational, PRD, code review, debugging, optimization)
4. **project-generated** - Final configs combining shared + tool-specific + project context

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
- **Template inheritance**: Base rules + tool-specific + project overrides
- **Professional prompt library**: Comprehensive templates for requirements, PRDs, code review, debugging, optimization
- **Project type auto-detection**: From package.json, requirements.txt, framework detection
- **Variable substitution**: Dynamic configuration based on project context
- **Consistent formatting**: Unified structure across all AI tools (Cline, Claude-Code, Cursor, etc.)

### Cross-Platform Compatibility
All AI configurations must work across macOS, Linux, and Windows with appropriate path handling and tool availability checks.