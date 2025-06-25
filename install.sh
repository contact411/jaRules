#!/usr/bin/env bash
# jaRules Installation Script
# The one script to rule them all
set -euo pipefail

# Colors for legendary output
readonly BOLD='\033[1m'
readonly DIM='\033[2m'
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly PURPLE='\033[0;35m'
readonly CYAN='\033[0;36m'
readonly NC='\033[0m' # No Color

# Logging functions with style
log() { echo -e "${BLUE}[jaRules]${NC} $1"; }
log_success() { echo -e "${GREEN}[✓]${NC} $1"; }
log_warning() { echo -e "${YELLOW}[⚠]${NC} $1"; }
log_error() { echo -e "${RED}[✗]${NC} $1"; }
log_info() { echo -e "${CYAN}[i]${NC} $1"; }

# The legendary banner
show_banner() {
    echo -e "${PURPLE}"
    echo '     _       ____        _           '
    echo '    (_) __ _|  _ \ _   _| | ___  ___ '
    echo '    | |/ _` | |_) | | | | |/ _ \/ __|'
    echo '    | | (_| |  _ <| |_| | |  __/\__ \'
    echo '   _/ |\__,_|_| \_\\__,_|_|\___||___/'
    echo '  |__/                               '
    echo -e "${NC}"
    echo -e "${BOLD}Master of All Things Smooth${NC}"
    echo -e "${DIM}The most opinionated dotfiles in the Joloverse${NC}"
    echo ""
}

# Configuration
readonly JARULES_VERSION="1.0.0"
readonly JARULES_REPO="${JARULES_REPO:-https://github.com/contact411/jaRules.git}"
readonly JARULES_DIR="${JARULES_DIR:-$HOME/.local/share/jarules}"
readonly CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"
readonly DATA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}"
readonly CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}"
readonly STATE_DIR="${XDG_STATE_HOME:-$HOME/.local/state}"

# Installation modes
INSTALL_DOTFILES=true
INSTALL_AI_RULES=true
INSTALL_MINIMAL=false
FORCE_INSTALL=false
SKIP_BACKUP=false

# Platform detection
detect_platform() {
    case "$(uname -s)" in
        Darwin*) echo "macos" ;;
        Linux*)  echo "linux" ;;
        CYGWIN*|MINGW*|MSYS*) echo "windows" ;;
        *) log_error "Unsupported platform: $(uname -s)"; exit 1 ;;
    esac
}

# Distribution detection for Linux
detect_distro() {
    if [[ -f /etc/os-release ]]; then
        . /etc/os-release
        echo "$ID"
    elif command -v lsb_release >/dev/null 2>&1; then
        lsb_release -si | tr '[:upper:]' '[:lower:]'
    else
        echo "unknown"
    fi
}

# Check for required tools
check_requirements() {
    local missing=()
    
    # Essential tools
    for tool in git curl; do
        if ! command -v "$tool" >/dev/null 2>&1; then
            missing+=("$tool")
        fi
    done
    
    if [[ ${#missing[@]} -gt 0 ]]; then
        log_error "Missing required tools: ${missing[*]}"
        log_info "Please install them and try again"
        exit 1
    fi
}

# Parse command line arguments
parse_args() {
    while [[ $# -gt 0 ]]; do
        case "$1" in
            --dotfiles-only)
                INSTALL_AI_RULES=false
                shift
                ;;
            --rules-only)
                INSTALL_DOTFILES=false
                shift
                ;;
            --minimal)
                INSTALL_MINIMAL=true
                shift
                ;;
            --force)
                FORCE_INSTALL=true
                shift
                ;;
            --skip-backup)
                SKIP_BACKUP=true
                shift
                ;;
            --help|-h)
                show_help
                exit 0
                ;;
            *)
                log_error "Unknown option: $1"
                show_help
                exit 1
                ;;
        esac
    done
}

# Show help
show_help() {
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  --dotfiles-only    Install only dotfiles (skip AI rules)"
    echo "  --rules-only       Install only AI rules (skip dotfiles)"
    echo "  --minimal          Minimal installation (essentials only)"
    echo "  --force            Force installation (overwrite existing)"
    echo "  --skip-backup      Skip backing up existing configs"
    echo "  --help, -h         Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0                      # Full installation"
    echo "  $0 --dotfiles-only     # Just the legendary dotfiles"
    echo "  $0 --rules-only        # Just the AI configurations"
    echo "  $0 --minimal           # Quick essential setup"
}

# Backup existing configurations
backup_configs() {
    if [[ "$SKIP_BACKUP" == "true" ]]; then
        log_info "Skipping backup as requested"
        return
    fi
    
    local backup_dir="$HOME/.config-backup-$(date +%Y%m%d-%H%M%S)"
    local items_to_backup=()
    
    # Check what needs backing up
    [[ -f "$HOME/.zshrc" ]] && items_to_backup+=("$HOME/.zshrc")
    [[ -f "$HOME/.bashrc" ]] && items_to_backup+=("$HOME/.bashrc")
    [[ -f "$HOME/.gitconfig" ]] && items_to_backup+=("$HOME/.gitconfig")
    [[ -d "$CONFIG_DIR/git" ]] && items_to_backup+=("$CONFIG_DIR/git")
    [[ -d "$CONFIG_DIR/npm" ]] && items_to_backup+=("$CONFIG_DIR/npm")
    [[ -d "$CONFIG_DIR/starship" ]] && items_to_backup+=("$CONFIG_DIR/starship")
    
    if [[ ${#items_to_backup[@]} -gt 0 ]]; then
        log_info "Backing up existing configurations to $backup_dir"
        mkdir -p "$backup_dir"
        
        for item in "${items_to_backup[@]}"; do
            if [[ -e "$item" ]]; then
                cp -r "$item" "$backup_dir/" || true
            fi
        done
        
        log_success "Backup completed"
    fi
}

# Clone or update the repository
setup_repository() {
    if [[ -d "$JARULES_DIR/.git" ]]; then
        log_info "Updating existing jaRules installation"
        cd "$JARULES_DIR"
        git pull origin main || {
            log_warning "Failed to update, continuing with existing version"
        }
    else
        log_info "Cloning jaRules repository"
        mkdir -p "$(dirname "$JARULES_DIR")"
        git clone "$JARULES_REPO" "$JARULES_DIR"
    fi
    
    cd "$JARULES_DIR"
    log_success "Repository ready at $JARULES_DIR"
}

# Install package managers
install_package_managers() {
    local platform=$(detect_platform)
    
    case "$platform" in
        "macos")
            if ! command -v brew >/dev/null 2>&1; then
                log_info "Installing Homebrew..."
                /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            else
                log_success "Homebrew already installed"
            fi
            ;;
        "linux")
            log_success "Using system package manager"
            ;;
        "windows")
            if ! command -v choco >/dev/null 2>&1; then
                log_warning "Chocolatey not found. Please install it manually"
            else
                log_success "Chocolatey already installed"
            fi
            ;;
    esac
}

# Create XDG directories
create_xdg_directories() {
    log_info "Creating XDG Base Directory structure"
    
    mkdir -p "$CONFIG_DIR"/{git,npm,shells,starship,vscode}
    mkdir -p "$DATA_DIR"/{npm,fnm}
    mkdir -p "$CACHE_DIR"/{npm,fnm}
    mkdir -p "$STATE_DIR"/{zsh,bash,python}
    
    log_success "XDG directories created"
}

# Install individual components
install_git_config() {
    log_info "Installing Git configuration"
    "$JARULES_DIR/scripts/setup-git.sh"
}

install_shell_config() {
    log_info "Installing Shell configuration"
    "$JARULES_DIR/scripts/setup-shell.sh"
}

install_node_setup() {
    log_info "Installing Node.js environment"
    "$JARULES_DIR/scripts/setup-node.sh"
}

install_editor_config() {
    log_info "Installing Editor configurations"
    "$JARULES_DIR/scripts/setup-editors.sh"
}

install_ai_rules() {
    log_info "Installing AI rules and templates"
    "$JARULES_DIR/scripts/setup-ai-rules.sh"
}

install_essential_tools() {
    log_info "Installing essential tools"
    "$JARULES_DIR/scripts/setup-tools.sh"
}

# The main installation flow
main() {
    # Show the legendary banner
    show_banner
    
    # Parse arguments
    parse_args "$@"
    
    # Check requirements
    check_requirements
    
    # Get platform info
    local platform=$(detect_platform)
    log_info "Detected platform: $platform"
    
    if [[ "$platform" == "linux" ]]; then
        local distro=$(detect_distro)
        log_info "Linux distribution: $distro"
    fi
    
    # Backup existing configs
    backup_configs
    
    # Setup repository
    setup_repository
    
    # Create directory structure
    create_xdg_directories
    
    # Install package managers
    install_package_managers
    
    # Install components based on mode
    if [[ "$INSTALL_MINIMAL" == "true" ]]; then
        log_info "Running minimal installation"
        install_shell_config
        install_git_config
    else
        if [[ "$INSTALL_DOTFILES" == "true" ]]; then
            log_info "Installing dotfiles components"
            install_shell_config
            install_git_config
            install_node_setup
            install_editor_config
            install_essential_tools
        fi
        
        if [[ "$INSTALL_AI_RULES" == "true" ]]; then
            log_info "Installing AI rules"
            install_ai_rules
        fi
    fi
    
    # Success message
    echo ""
    log_success "${GREEN}${BOLD}jaRules installation complete!${NC}"
    echo ""
    echo -e "${CYAN}What's next?${NC}"
    echo -e "  ${DIM}•${NC} Restart your terminal to load the new configuration"
    echo -e "  ${DIM}•${NC} Run ${YELLOW}jarule_help${NC} to see available functions"
    echo -e "  ${DIM}•${NC} Set up your Git identity: ${YELLOW}git config --global user.name \"Your Name\"${NC}"
    echo -e "  ${DIM}•${NC} Check out the AI rules in ${YELLOW}~/.config/ai-rules/${NC}"
    echo ""
    echo -e "${PURPLE}Welcome to the Joloverse. Your setup will never be the same.${NC} ✨"
}

# Run main function if script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
