#!/usr/bin/env bash
# jaRules Git Setup
# Modern security standards with legendary workflow enhancements

set -euo pipefail

# Colors
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly NC='\033[0m'

# Logging functions
log_info() { echo -e "${BLUE}[GIT]${NC} $1"; }
log_success() { echo -e "${GREEN}[✓]${NC} $1"; }
log_warning() { echo -e "${YELLOW}[⚠]${NC} $1"; }
log_error() { echo -e "${RED}[✗]${NC} $1"; }

# Get script directory
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"
readonly GIT_CONFIG_DIR="$CONFIG_DIR/git"

# Create git config directory
create_git_directory() {
    log_info "Creating Git configuration directory"
    mkdir -p "$GIT_CONFIG_DIR"
}

# Check for required Git identity
check_git_identity() {
    local name=$(git config --global user.name 2>/dev/null || echo "")
    local email=$(git config --global user.email 2>/dev/null || echo "")
    
    if [[ -z "$name" ]] || [[ -z "$email" ]]; then
        log_warning "Git identity not configured"
        
        # Try to get from environment
        if [[ -n "${GIT_AUTHOR_NAME:-}" ]] && [[ -n "${GIT_AUTHOR_EMAIL:-}" ]]; then
            log_info "Using Git identity from environment variables"
            export GIT_AUTHOR_NAME
            export GIT_AUTHOR_EMAIL
        else
            log_warning "Please set your Git identity:"
            echo "  export GIT_AUTHOR_NAME=\"Your Name\""
            echo "  export GIT_AUTHOR_EMAIL=\"your.email@example.com\""
            echo ""
            echo "Or configure directly:"
            echo "  git config --global user.name \"Your Name\""
            echo "  git config --global user.email \"your.email@example.com\""
            
            # Set placeholder values for template
            export GIT_AUTHOR_NAME="${name:-Your Name}"
            export GIT_AUTHOR_EMAIL="${email:-your.email@example.com}"
        fi
    else
        export GIT_AUTHOR_NAME="$name"
        export GIT_AUTHOR_EMAIL="$email"
        log_success "Git identity found: $name <$email>"
    fi
}

# Setup GPG signing (optional)
setup_gpg_signing() {
    log_info "Checking GPG configuration"
    
    # Check if GPG is available
    if ! command -v gpg >/dev/null 2>&1; then
        log_warning "GPG not found, skipping commit signing setup"
        export GIT_SIGNING_KEY=""
        return
    fi
    
    # Check for existing GPG keys
    local gpg_keys=$(gpg --list-secret-keys --keyid-format=long 2>/dev/null | grep ^sec | awk '{print $2}' | cut -d'/' -f2)
    
    if [[ -z "$gpg_keys" ]]; then
        log_warning "No GPG keys found. To enable commit signing:"
        echo "  1. Generate a key: gpg --full-generate-key"
        echo "  2. Configure Git: git config --global user.signingkey YOUR_KEY_ID"
        export GIT_SIGNING_KEY=""
    else
        # Check if signing key is already configured
        local signing_key=$(git config --global user.signingkey 2>/dev/null || echo "")
        
        if [[ -n "$signing_key" ]]; then
            export GIT_SIGNING_KEY="$signing_key"
            log_success "GPG signing key configured: $signing_key"
        else
            log_info "Available GPG keys:"
            echo "$gpg_keys" | sed 's/^/  - /'
            log_warning "No signing key configured. Use: git config --global user.signingkey KEY_ID"
            export GIT_SIGNING_KEY=""
        fi
    fi
}

# Install Git configuration from template
install_git_config() {
    log_info "Installing Git configuration"
    
    local template_file="$SCRIPT_DIR/../config/git/config.template"
    local config_file="$GIT_CONFIG_DIR/config"
    
    if [[ ! -f "$template_file" ]]; then
        log_error "Git config template not found: $template_file"
        return 1
    fi
    
    # Backup existing config
    if [[ -f "$config_file" ]] && [[ ! -f "$config_file.backup" ]]; then
        cp "$config_file" "$config_file.backup"
        log_info "Backed up existing config to $config_file.backup"
    fi
    
    # Process template with environment substitution
    envsubst < "$template_file" > "$config_file"
    
    # Set as global config
    git config --global include.path "$config_file"
    
    log_success "Git configuration installed"
}

# Install global gitignore
install_gitignore() {
    log_info "Installing global gitignore"
    
    local ignore_file="$SCRIPT_DIR/../config/git/ignore_global"
    local target_file="$GIT_CONFIG_DIR/ignore_global"
    
    if [[ ! -f "$ignore_file" ]]; then
        log_error "Global gitignore not found: $ignore_file"
        return 1
    fi
    
    # Copy gitignore
    cp "$ignore_file" "$target_file"
    
    # Configure Git to use it
    git config --global core.excludesfile "$target_file"
    
    log_success "Global gitignore installed"
}

# Setup SSH keys
setup_ssh_keys() {
    log_info "Checking SSH keys"
    
    local ssh_dir="$HOME/.ssh"
    mkdir -p "$ssh_dir"
    chmod 700 "$ssh_dir"
    
    # Check for Ed25519 key (preferred)
    if [[ -f "$ssh_dir/id_ed25519" ]]; then
        log_success "Ed25519 SSH key already exists"
    else
        log_warning "No Ed25519 SSH key found"
        echo "To generate a secure Ed25519 key:"
        echo "  ssh-keygen -t ed25519 -C \"$GIT_AUTHOR_EMAIL\""
        echo ""
        read -p "Generate Ed25519 SSH key now? (y/N) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            ssh-keygen -t ed25519 -C "$GIT_AUTHOR_EMAIL" -f "$ssh_dir/id_ed25519"
            log_success "Ed25519 SSH key generated"
            
            # Add to SSH agent
            if command -v ssh-add >/dev/null 2>&1; then
                ssh-add "$ssh_dir/id_ed25519" 2>/dev/null || true
            fi
            
            # Show public key
            echo ""
            log_info "Add this public key to GitHub/GitLab:"
            echo ""
            cat "$ssh_dir/id_ed25519.pub"
            echo ""
        fi
    fi
}

# Install delta (better diff tool)
install_delta() {
    log_info "Checking for delta (enhanced diff viewer)"
    
    if command -v delta >/dev/null 2>&1; then
        log_success "Delta already installed"
        return
    fi
    
    local platform=$(uname -s | tr '[:upper:]' '[:lower:]')
    
    case "$platform" in
        "darwin")
            if command -v brew >/dev/null 2>&1; then
                log_info "Installing delta via Homebrew"
                brew install git-delta
            fi
            ;;
        "linux")
            log_warning "Delta not found. Install it for beautiful diffs:"
            echo "  Ubuntu/Debian: Download from https://github.com/dandavison/delta/releases"
            echo "  Arch: pacman -S git-delta"
            echo "  Fedora: dnf install git-delta"
            ;;
    esac
}

# Configure conditional includes
setup_conditional_includes() {
    log_info "Setting up conditional Git includes"
    
    # Work configuration
    if [[ -d "$HOME/work" ]]; then
        local work_config="$GIT_CONFIG_DIR/work_config"
        if [[ ! -f "$work_config" ]]; then
            cat > "$work_config" << 'EOF'
# Work-specific Git configuration
[user]
    # email = your.work.email@company.com
    
[core]
    # sshCommand = ssh -i ~/.ssh/work_key
EOF
            log_info "Created work Git config template at $work_config"
        fi
    fi
    
    # Personal configuration
    if [[ -d "$HOME/personal" ]]; then
        local personal_config="$GIT_CONFIG_DIR/personal_config"
        if [[ ! -f "$personal_config" ]]; then
            cat > "$personal_config" << 'EOF'
# Personal Git configuration
[user]
    # email = your.personal.email@example.com
    
[core]
    # sshCommand = ssh -i ~/.ssh/personal_key
EOF
            log_info "Created personal Git config template at $personal_config"
        fi
    fi
}

# Main setup function
main() {
    log_info "🚀 Starting jaRules Git setup..."
    
    create_git_directory
    check_git_identity
    setup_gpg_signing
    install_git_config
    install_gitignore
    setup_ssh_keys
    install_delta
    setup_conditional_includes
    
    log_success "🎉 Git setup completed!"
    log_info "💡 Pro tip: Use 'git lg' for a beautiful commit history"
    log_info "💡 Pro tip: Use 'git sync' to fetch and rebase on main"
}

# Run main function if script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
