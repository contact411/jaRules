# Changelog

All notable changes to jaRules will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Fixed
- Fixed script filename references in install.sh (2025-06-25)
  - Updated all script calls to match actual filenames with -script.sh suffix
  - Fixed setup-git.sh → setup-git-script.sh
  - Fixed setup-shell.sh → setup-shell-script.sh  
  - Fixed setup-editors.sh → setup-editors-script.sh
  - Fixed setup-ai-rules.sh → setup-ai-rules-script.sh
  - Fixed setup-tools.sh → setup-tools-script.sh
  - Resolves 'No such file or directory' errors during installation
  - Installation now progresses through all components successfully

### Added
- Comprehensive troubleshooting section in README.md
  - Script permission error fixes
  - Git circular include error solutions
  - Platform detection guidance
  - Missing dependencies installation instructions

## [1.0.0] - Initial Release

### Added
- Complete cross-platform installation system
- AI-first development environment setup
- Comprehensive dotfiles collection
- Security-first configuration templates
- XDG Base Directory compliance
- Modern CLI tool integration
- Starship prompt with Catppuccin theme
- Node.js environment with fnm
- Git configuration with GPG signing
- VSCode settings and extensions
- Shell aliases and functions
- AI rules and prompt templates
