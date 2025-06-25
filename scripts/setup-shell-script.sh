#!/usr/bin/env bash
# jaRules Shell Setup
# Transform your terminal into a thing of beauty and efficiency

set -euo pipefail

# Colors
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly CYAN='\033[0;36m'
readonly NC='\033[0m'

# Logging functions
log_info() { echo -e "${BLUE}[SHELL]${NC} $1"; }
log_success() { echo -e "${GREEN}[✓]${NC} $1"; }
log_warning() { echo -e "${YELLOW}[⚠]${NC} $1"; }
log_error() { echo -e "${RED}[✗]${NC} $1"; }

# Get script directory
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"
readonly DATA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}"
readonly STATE_DIR="${XDG_STATE_HOME:-$HOME/.local/state}"

# Detect current shell
detect_shell() {
    local shell_name=$(basename "$SHELL")
    echo "$shell_name"
}

# Detect platform
detect_platform() {
    case "$(uname -s)" in
        Darwin*) echo "macos" ;;
        Linux*)  echo "linux" ;;
        CYGWIN*|MINGW*|MSYS*) echo "windows" ;;
        *) echo "unknown" ;;
    esac
}

# Create shell directories
create_shell_directories() {
    log_info "Creating shell configuration directories"
    
    mkdir -p "$CONFIG_DIR/shells"
    mkdir -p "$STATE_DIR"/{zsh,bash,fish}
    mkdir -p "$DATA_DIR"/zsh/plugins
    
    log_success "Shell directories created"
}

# Install shell components
install_shell_components() {
    log_info "Installing shell components"
    
    local shell_config_dir="$SCRIPT_DIR/../config/shells"
    local target_dir="$CONFIG_DIR/shells"
    
    # Copy core components
    for component in aliases exports functions; do
        if [[ -f "$shell_config_dir/$component" ]]; then
            cp "$shell_config_dir/$component" "$target_dir/$component"
            log_success "Installed $component"
        else
            log_warning "Component not found: $component"
        fi
    done
}

# Install Starship prompt
install_starship() {
    log_info "Checking Starship prompt"
    
    if command -v starship >/dev/null 2>&1; then
        log_success "Starship already installed"
    else
        log_info "Installing Starship prompt"
        
        local platform=$(detect_platform)
        case "$platform" in
            "macos")
                if command -v brew >/dev/null 2>&1; then
                    brew install starship
                else
                    curl -fsSL https://starship.rs/install.sh | sh -s -- -y
                fi
                ;;
            "linux"|"windows")
                curl -fsSL https://starship.rs/install.sh | sh -s -- -y
                ;;
        esac
    fi
    
    # Install Starship configuration
    local starship_config_dir="$CONFIG_DIR/starship"
    mkdir -p "$starship_config_dir"
    
    if [[ -f "$SCRIPT_DIR/../config/starship/starship.toml" ]]; then
        cp "$SCRIPT_DIR/../config/starship/starship.toml" "$starship_config_dir/starship.toml"
        log_success "Starship configuration installed"
    fi
}

# Install modern CLI tools
install_modern_tools() {
    log_info "Checking for modern CLI tools"
    
    local platform=$(detect_platform)
    local missing_tools=()
    
    # Check for tools
    local tools=("exa" "bat" "fd" "rg" "fzf" "delta" "duf" "dust" "procs" "zoxide")
    
    for tool in "${tools[@]}"; do
        if ! command -v "$tool" >/dev/null 2>&1; then
            missing_tools+=("$tool")
        fi
    done
    
    if [[ ${#missing_tools[@]} -eq 0 ]]; then
        log_success "All modern CLI tools already installed"
        return
    fi
    
    log_info "Missing tools: ${missing_tools[*]}"
    
    case "$platform" in
        "macos")
            if command -v brew >/dev/null 2>&1; then
                log_info "Installing tools via Homebrew"
                # Map tool names to brew packages
                local brew_packages=()
                for tool in "${missing_tools[@]}"; do
                    case "$tool" in
                        "exa") brew_packages+=("exa") ;;
                        "bat") brew_packages+=("bat") ;;
                        "fd") brew_packages+=("fd") ;;
                        "rg") brew_packages+=("ripgrep") ;;
                        "fzf") brew_packages+=("fzf") ;;
                        "delta") brew_packages+=("git-delta") ;;
                        "duf") brew_packages+=("duf") ;;
                        "dust") brew_packages+=("dust") ;;
                        "procs") brew_packages+=("procs") ;;
                        "zoxide") brew_packages+=("zoxide") ;;
                    esac
                done
                if [[ ${#brew_packages[@]} -gt 0 ]]; then
                    brew install "${brew_packages[@]}"
                fi
            fi
            ;;
        "linux")
            log_warning "Please install these tools using your package manager:"
            for tool in "${missing_tools[@]}"; do
                case "$tool" in
                    "exa") echo "  - exa (modern ls replacement)" ;;
                    "bat") echo "  - bat (cat with syntax highlighting)" ;;
                    "fd") echo "  - fd-find (fast find alternative)" ;;
                    "rg") echo "  - ripgrep (fast grep alternative)" ;;
                    "fzf") echo "  - fzf (fuzzy finder)" ;;
                    "delta") echo "  - git-delta (better git diffs)" ;;
                    "duf") echo "  - duf (better df)" ;;
                    "dust") echo "  - dust (better du)" ;;
                    "procs") echo "  - procs (better ps)" ;;
                    "zoxide") echo "  - zoxide (better cd)" ;;
                esac
            done
            ;;
    esac
}

# Setup Zsh configuration
setup_zsh() {
    log_info "Setting up Zsh configuration"
    
    local zshrc_template="$SCRIPT_DIR/../config/shells/zshrc.template"
    local zshrc_target="$HOME/.zshrc"
    
    # Backup existing .zshrc
    if [[ -f "$zshrc_target" ]] && [[ ! -f "$zshrc_target.jarules-backup" ]]; then
        cp "$zshrc_target" "$zshrc_target.jarules-backup"
        log_info "Backed up existing .zshrc"
    fi
    
    # Process template
    if [[ -f "$zshrc_template" ]]; then
        envsubst < "$zshrc_template" > "$zshrc_target"
        log_success "Zsh configuration installed"
    else
        # Create minimal zshrc that sources our components
        cat > "$zshrc_target" << 'EOF'
# jaRules Zsh Configuration

# Source jaRules components
for component in exports aliases functions; do
    [[ -f "$HOME/.config/shells/$component" ]] && source "$HOME/.config/shells/$component"
done

# Initialize tools
command -v starship >/dev/null 2>&1 && eval "$(starship init zsh)"
command -v fnm >/dev/null 2>&1 && eval "$(fnm env --use-on-cd)"
command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init zsh)"

# Load local customizations
[[ -f "$HOME/.config/shells/zshrc.local" ]] && source "$HOME/.config/shells/zshrc.local"
EOF
        log_success "Created minimal Zsh configuration"
    fi
}

# Setup Bash configuration
setup_bash() {
    log_info "Setting up Bash configuration"
    
    local bashrc_target="$HOME/.bashrc"
    
    # Backup existing .bashrc
    if [[ -f "$bashrc_target" ]] && [[ ! -f "$bashrc_target.jarules-backup" ]]; then
        cp "$bashrc_target" "$bashrc_target.jarules-backup"
        log_info "Backed up existing .bashrc"
    fi
    
    # Create bash configuration
    cat > "$bashrc_target" << 'EOF'
# jaRules Bash Configuration

# Source jaRules components
for component in exports aliases functions; do
    [[ -f "$HOME/.config/shells/$component" ]] && source "$HOME/.config/shells/$component"
done

# Initialize tools
command -v starship >/dev/null 2>&1 && eval "$(starship init bash)"
command -v fnm >/dev/null 2>&1 && eval "$(fnm env --use-on-cd)"
command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init bash)"

# Load local customizations
[[ -f "$HOME/.config/shells/bashrc.local" ]] && source "$HOME/.config/shells/bashrc.local"
EOF
    
    log_success "Bash configuration installed"
}

# Install shell plugins (optional)
install_shell_plugins() {
    local current_shell=$(detect_shell)
    
    if [[ "$current_shell" != "zsh" ]]; then
        return
    fi
    
    log_info "Installing Zsh plugins (optional)"
    
    local plugins_dir="$DATA_DIR/zsh/plugins"
    
    # Array of recommended plugins
    local plugins=(
        "zsh-users/zsh-autosuggestions"
        "zsh-users/zsh-syntax-highlighting"
        "zsh-users/zsh-completions"
    )
    
    echo "Recommended Zsh plugins:"
    echo "  - zsh-autosuggestions (fish-like suggestions)"
    echo "  - zsh-syntax-highlighting (syntax colors)"
    echo "  - zsh-completions (additional completions)"
    echo ""
    read -p "Install recommended Zsh plugins? (y/N) " -n 1 -r
    echo
    
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        for plugin in "${plugins[@]}"; do
            local plugin_name=$(basename "$plugin")
            local plugin_dir="$plugins_dir/$plugin_name"
            
            if [[ ! -d "$plugin_dir" ]]; then
                log_info "Installing $plugin_name"
                git clone "https://github.com/$plugin" "$plugin_dir"
            else
                log_info "Updating $plugin_name"
                cd "$plugin_dir" && git pull
            fi
        done
        log_success "Plugins installed"
    fi
}

# Setup shell for current platform
setup_platform_specific() {
    local platform=$(detect_platform)
    
    case "$platform" in
        "macos")
            # macOS specific setup
            if [[ -f "/usr/local/bin/brew" ]] || [[ -f "/opt/homebrew/bin/brew" ]]; then
                log_info "Configuring Homebrew shell integration"
            fi
            ;;
        "linux")
            # Linux specific setup
            log_info "Linux shell setup complete"
            ;;
        "windows")
            # Windows specific setup
            log_warning "Windows shell setup requires manual configuration"
            ;;
    esac
}

# Main setup function
main() {
    log_info "🚀 Starting jaRules shell setup..."
    
    local current_shell=$(detect_shell)
    log_info "Current shell: $current_shell"
    
    create_shell_directories
    install_shell_components
    install_starship
    install_modern_tools
    
    # Setup shell-specific configuration
    case "$current_shell" in
        "zsh")
            setup_zsh
            install_shell_plugins
            ;;
        "bash")
            setup_bash
            ;;
        *)
            log_warning "Unsupported shell: $current_shell"
            log_info "Manual configuration required"
            ;;
    esac
    
    setup_platform_specific
    
    log_success "🎉 Shell setup completed!"
    log_info "💡 Restart your terminal to load the new configuration"
    log_info "💡 Run 'jarule_help' to see available functions"
}

# Run main function if script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
