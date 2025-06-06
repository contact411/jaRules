#!/usr/bin/env bash
# jaRule's Legendary Node.js Setup
# Using fnm (Fast Node Manager) for blazing speed across all platforms

set -euo pipefail

# Colors for output
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly NC='\033[0m' # No Color

# Logging functions
log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# Configuration
readonly NODE_LTS_VERSION="20"  # Latest LTS
readonly FNM_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/fnm"
readonly NPM_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/npm"

# Platform detection
detect_platform() {
    case "$(uname -s)" in
        Darwin*) echo "macos" ;;
        Linux*)  echo "linux" ;;
        CYGWIN*|MINGW*|MSYS*) echo "windows" ;;
        *) log_error "Unsupported platform: $(uname -s)"; exit 1 ;;
    esac
}

# Install fnm (Fast Node Manager)
install_fnm() {
    local platform
    platform=$(detect_platform)
    
    log_info "Installing fnm (Fast Node Manager)..."
    
    if command -v fnm >/dev/null 2>&1; then
        log_warning "fnm already installed, skipping..."
        return 0
    fi
    
    case "$platform" in
        "macos"|"linux")
            if command -v brew >/dev/null 2>&1; then
                brew install fnm
            else
                # Use official installer
                curl -fsSL https://fnm.vercel.app/install | bash
            fi
            ;;
        "windows")
            if command -v winget >/dev/null 2>&1; then
                winget install Schniz.fnm
            elif command -v choco >/dev/null 2>&1; then
                choco install fnm
            else
                log_error "Please install fnm manually: https://github.com/Schniz/fnm#installation"
                exit 1
            fi
            ;;
    esac
    
    log_success "fnm installed successfully"
}

# Configure fnm environment
setup_fnm_environment() {
    log_info "Configuring fnm environment..."
    
    # Create fnm directory
    mkdir -p "$FNM_DIR"
    
    # Set environment variables
    export FNM_DIR
    export PATH="$FNM_DIR:$PATH"
    
    # Initialize fnm if available
    if command -v fnm >/dev/null 2>&1; then
        eval "$(fnm env --use-on-cd)"
    fi
    
    log_success "fnm environment configured"
}

# Install Node.js LTS
install_node() {
    log_info "Installing Node.js LTS (v${NODE_LTS_VERSION})..."
    
    if ! command -v fnm >/dev/null 2>&1; then
        log_error "fnm not found. Please restart your shell or source your shell config."
        exit 1
    fi
    
    # Install and use Node.js LTS
    fnm install "$NODE_LTS_VERSION"
    fnm use "$NODE_LTS_VERSION"
    fnm default "$NODE_LTS_VERSION"
    
    # Verify installation
    local node_version
    node_version=$(node --version)
    log_success "Node.js installed: $node_version"
    
    local npm_version
    npm_version=$(npm --version)
    log_success "npm version: $npm_version"
}

# Setup npm configuration
setup_npm_config() {
    log_info "Configuring npm with jaRule's legendary settings..."
    
    # Create npm config directory
    mkdir -p "$NPM_CONFIG_DIR"
    
    # Copy npmrc template if it exists
    local npmrc_template="${SCRIPT_DIR}/../config/npm/npmrc.template"
    local npmrc_target="${NPM_CONFIG_DIR}/npmrc"
    
    if [[ -f "$npmrc_template" ]]; then
        # Substitute environment variables
        envsubst < "$npmrc_template" > "$npmrc_target"
        log_success "npm configuration applied from template"
    else
        log_warning "npmrc template not found, creating basic config..."
        cat > "$npmrc_target" << 'EOF'
# Basic npm configuration
audit-level=moderate
fund=false
update-notifier=false
save-exact=true
EOF
    fi
    
    # Set npm prefix for global packages (XDG compliant)
    local npm_global_dir="${XDG_DATA_HOME:-$HOME/.local/share}/npm"
    mkdir -p "$npm_global_dir"
    npm config set prefix "$npm_global_dir"
    
    log_success "npm configuration completed"
}

# Install essential global packages
install_global_packages() {
    log_info "Installing jaRule's essential global npm packages..."
    
    local packages_file="${SCRIPT_DIR}/../config/npm/global-packages.txt"
    
    if [[ -f "$packages_file" ]]; then
        # Read packages from file (skip comments and empty lines)
        while IFS= read -r line; do
            # Skip comments and empty lines
            [[ "$line" =~ ^[[:space:]]*# ]] && continue
            [[ -z "${line// }" ]] && continue
            
            # Extract package name (first word)
            local package_name
            package_name=$(echo "$line" | awk '{print $1}')
            
            if [[ -n "$package_name" ]]; then
                log_info "Installing $package_name..."
                npm install -g "$package_name" || log_warning "Failed to install $package_name"
            fi
        done < "$packages_file"
    else
        log_warning "Global packages file not found, installing essentials..."
        npm install -g @antfu/ni typescript tsx nodemon prettier eslint
    fi
    
    log_success "Global packages installation completed"
}

# Add shell integration
setup_shell_integration() {
    log_info "Setting up shell integration for fnm..."
    
    local shell_config
    local fnm_init='eval "$(fnm env --use-on-cd)"'
    
    # Detect shell and add fnm initialization
    case "$SHELL" in
        */zsh)
            shell_config="$HOME/.zshrc"
            ;;
        */bash)
            shell_config="$HOME/.bashrc"
            ;;
        */fish)
            shell_config="$HOME/.config/fish/config.fish"
            fnm_init='fnm env --use-on-cd | source'
            ;;
        *)
            log_warning "Unknown shell: $SHELL. Please add fnm initialization manually."
            return 0
            ;;
    esac
    
    # Add fnm initialization if not already present
    if [[ -f "$shell_config" ]] && ! grep -q "fnm env" "$shell_config"; then
        echo "" >> "$shell_config"
        echo "# jaRule's fnm (Fast Node Manager) initialization" >> "$shell_config"
        echo "$fnm_init" >> "$shell_config"
        log_success "fnm initialization added to $shell_config"
    else
        log_info "fnm already configured in shell or shell config not found"
    fi
}

# Main installation function
main() {
    # Get script directory for relative paths
    readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    
    log_info "🚀 Starting jaRule's legendary Node.js setup..."
    
    install_fnm
    setup_fnm_environment
    install_node
    setup_npm_config
    install_global_packages
    setup_shell_integration
    
    log_success "🎉 Node.js setup completed! Restart your shell to use fnm."
    log_info "💡 Pro tip: Use 'fnm list' to see installed versions"
    log_info "💡 Pro tip: Use 'ni' instead of 'npm install' for better DX"
}

# Run main function if script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi