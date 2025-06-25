#!/usr/bin/env bash
# jaRules Essential Tools Setup
# Install and configure the tools that make development legendary

set -euo pipefail

# Colors
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly NC='\033[0m'

# Logging functions
log_info() { echo -e "${BLUE}[TOOLS]${NC} $1"; }
log_success() { echo -e "${GREEN}[✓]${NC} $1"; }
log_warning() { echo -e "${YELLOW}[⚠]${NC} $1"; }
log_error() { echo -e "${RED}[✗]${NC} $1"; }

# Get script directory
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"

# Detect platform
detect_platform() {
    case "$(uname -s)" in
        Darwin*) echo "macos" ;;
        Linux*)  echo "linux" ;;
        CYGWIN*|MINGW*|MSYS*) echo "windows" ;;
        *) echo "unknown" ;;
    esac
}

# Detect Linux distribution
detect_distro() {
    if [[ -f /etc/os-release ]]; then
        . /etc/os-release
        echo "$ID"
    else
        echo "unknown"
    fi
}

# Install tools based on platform
install_platform_tools() {
    local platform=$(detect_platform)
    
    case "$platform" in
        "macos")
            install_macos_tools
            ;;
        "linux")
            install_linux_tools
            ;;
        "windows")
            install_windows_tools
            ;;
        *)
            log_error "Unsupported platform"
            return 1
            ;;
    esac
}

# macOS tools installation
install_macos_tools() {
    log_info "Installing macOS tools via Homebrew"
    
    # Check for Homebrew
    if ! command -v brew >/dev/null 2>&1; then
        log_error "Homebrew not found. Please install it first"
        return 1
    fi
    
    # Update Homebrew
    log_info "Updating Homebrew"
    brew update
    
    # Essential tools
    local brew_packages=(
        # Core utilities
        "coreutils"
        "findutils"
        "gnu-sed"
        "gawk"
        "grep"
        
        # Modern replacements
        "exa"           # ls replacement
        "bat"           # cat replacement
        "fd"            # find replacement
        "ripgrep"       # grep replacement
        "fzf"           # fuzzy finder
        "zoxide"        # smart cd
        "delta"         # git diff
        "duf"           # df replacement
        "dust"          # du replacement
        "procs"         # ps replacement
        "bottom"        # top replacement
        "tealdeer"      # tldr pages
        
        # Development tools
        "git"
        "gh"            # GitHub CLI
        "hub"           # Git wrapper
        "tig"           # Git TUI
        "lazygit"       # Git TUI
        "jq"            # JSON processor
        "yq"            # YAML processor
        "httpie"        # HTTP client
        "curl"
        "wget"
        
        # File tools
        "tree"
        "ncdu"          # Disk usage
        "entr"          # File watcher
        "direnv"        # Environment management
        
        # System tools
        "htop"
        "neofetch"
        "watch"
        "tmux"
        
        # Security tools
        "gnupg"
        "openssh"
        "openssl"
        
        # Compression
        "gzip"
        "unzip"
        "p7zip"
    )
    
    # Check and install missing packages
    local missing_packages=()
    for package in "${brew_packages[@]}"; do
        if ! brew list --formula | grep -q "^${package}$"; then
            missing_packages+=("$package")
        fi
    done
    
    if [[ ${#missing_packages[@]} -gt 0 ]]; then
        log_info "Installing missing packages: ${missing_packages[*]}"
        brew install "${missing_packages[@]}"
    else
        log_success "All essential tools already installed"
    fi
    
    # Install useful casks
    local brew_casks=(
        "visual-studio-code"
        "iterm2"
        "docker"
    )
    
    echo ""
    log_info "Recommended applications:"
    for cask in "${brew_casks[@]}"; do
        echo "  - $cask"
    done
    echo ""
    read -p "Install recommended applications? (y/N) " -n 1 -r
    echo
    
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        for cask in "${brew_casks[@]}"; do
            if ! brew list --cask | grep -q "^${cask}$"; then
                log_info "Installing $cask"
                brew install --cask "$cask"
            fi
        done
    fi
}

# Linux tools installation
install_linux_tools() {
    local distro=$(detect_distro)
    log_info "Installing Linux tools for $distro"
    
    case "$distro" in
        "ubuntu"|"debian")
            install_debian_tools
            ;;
        "fedora"|"rhel"|"centos")
            install_fedora_tools
            ;;
        "arch"|"manjaro")
            install_arch_tools
            ;;
        *)
            log_warning "Unknown distribution: $distro"
            log_info "Please install tools manually"
            ;;
    esac
}

# Debian/Ubuntu tools
install_debian_tools() {
    log_info "Installing tools for Debian/Ubuntu"
    
    # Update package list
    sudo apt update
    
    # Essential packages
    local apt_packages=(
        # Build essentials
        "build-essential"
        "curl"
        "wget"
        "git"
        
        # Modern tools (if available)
        "fd-find"
        "ripgrep"
        "fzf"
        "bat"
        "exa"
        
        # Development tools
        "jq"
        "httpie"
        "tmux"
        "htop"
        "tree"
        "ncdu"
        "direnv"
        
        # Security
        "gnupg"
        "openssh-client"
        "openssl"
        
        # Compression
        "gzip"
        "unzip"
        "p7zip-full"
    )
    
    # Install packages
    sudo apt install -y "${apt_packages[@]}" || {
        log_warning "Some packages failed to install"
    }
    
    # Install tools not in standard repos
    install_additional_linux_tools
}

# Fedora tools
install_fedora_tools() {
    log_info "Installing tools for Fedora/RHEL"
    
    # Essential packages
    local dnf_packages=(
        # Development tools
        "git"
        "curl"
        "wget"
        "jq"
        "httpie"
        "tmux"
        "htop"
        "tree"
        "ncdu"
        
        # Modern tools
        "fd-find"
        "ripgrep"
        "fzf"
        "bat"
        "exa"
        
        # Security
        "gnupg2"
        "openssh-clients"
        "openssl"
    )
    
    # Install packages
    sudo dnf install -y "${dnf_packages[@]}" || {
        log_warning "Some packages failed to install"
    }
    
    install_additional_linux_tools
}

# Arch tools
install_arch_tools() {
    log_info "Installing tools for Arch Linux"
    
    # Essential packages
    local pacman_packages=(
        # Base development
        "base-devel"
        "git"
        "curl"
        "wget"
        
        # Modern tools
        "fd"
        "ripgrep"
        "fzf"
        "bat"
        "exa"
        "zoxide"
        "delta"
        "duf"
        "dust"
        "procs"
        "bottom"
        "tealdeer"
        
        # Development tools
        "jq"
        "httpie"
        "tmux"
        "htop"
        "tree"
        "ncdu"
        "direnv"
        
        # Security
        "gnupg"
        "openssh"
        "openssl"
    )
    
    # Install packages
    sudo pacman -S --needed --noconfirm "${pacman_packages[@]}" || {
        log_warning "Some packages failed to install"
    }
}

# Install additional Linux tools not in standard repos
install_additional_linux_tools() {
    log_info "Installing additional tools from binary releases"
    
    # Tools to install from GitHub releases
    local tools_to_install=()
    
    # Check what's missing
    command -v delta >/dev/null 2>&1 || tools_to_install+=("delta")
    command -v duf >/dev/null 2>&1 || tools_to_install+=("duf")
    command -v dust >/dev/null 2>&1 || tools_to_install+=("dust")
    command -v zoxide >/dev/null 2>&1 || tools_to_install+=("zoxide")
    command -v bottom >/dev/null 2>&1 || tools_to_install+=("bottom")
    
    if [[ ${#tools_to_install[@]} -eq 0 ]]; then
        return
    fi
    
    log_info "Missing tools that need manual installation: ${tools_to_install[*]}"
    log_info "Visit these URLs for installation:"
    
    for tool in "${tools_to_install[@]}"; do
        case "$tool" in
            "delta")
                echo "  - Delta: https://github.com/dandavison/delta/releases"
                ;;
            "duf")
                echo "  - Duf: https://github.com/muesli/duf/releases"
                ;;
            "dust")
                echo "  - Dust: https://github.com/bootandy/dust/releases"
                ;;
            "zoxide")
                echo "  - Zoxide: https://github.com/ajeetdsouza/zoxide/releases"
                ;;
            "bottom")
                echo "  - Bottom: https://github.com/ClementTsang/bottom/releases"
                ;;
        esac
    done
}

# Windows tools installation
install_windows_tools() {
    log_info "Installing Windows tools"
    
    # Check for Chocolatey
    if command -v choco >/dev/null 2>&1; then
        log_info "Installing tools via Chocolatey"
        
        local choco_packages=(
            "git"
            "curl"
            "wget"
            "jq"
            "ripgrep"
            "fd"
            "fzf"
            "bat"
            "delta"
            "gh"
        )
        
        for package in "${choco_packages[@]}"; do
            choco install -y "$package"
        done
    else
        log_warning "Chocolatey not found"
        log_info "Install from: https://chocolatey.org"
    fi
    
    # Check for winget
    if command -v winget >/dev/null 2>&1; then
        log_info "Additional tools can be installed via winget"
    fi
}

# Configure installed tools
configure_tools() {
    log_info "Configuring installed tools"
    
    # FZF configuration
    if command -v fzf >/dev/null 2>&1; then
        log_info "Configuring FZF"
        
        # Install FZF key bindings and completion
        local fzf_base=""
        if [[ -d "/usr/share/fzf" ]]; then
            fzf_base="/usr/share/fzf"
        elif [[ -d "/opt/homebrew/opt/fzf" ]]; then
            fzf_base="/opt/homebrew/opt/fzf"
        elif [[ -d "/usr/local/opt/fzf" ]]; then
            fzf_base="/usr/local/opt/fzf"
        fi
        
        if [[ -n "$fzf_base" ]] && [[ -f "$fzf_base/install" ]]; then
            "$fzf_base/install" --key-bindings --completion --no-update-rc --no-bash --no-fish
        fi
    fi
    
    # Direnv setup
    if command -v direnv >/dev/null 2>&1; then
        log_info "Direnv is installed - add 'eval \"\$(direnv hook zsh)\"' to your shell"
    fi
    
    # Tealdeer setup
    if command -v tldr >/dev/null 2>&1; then
        log_info "Updating tldr pages"
        tldr --update || true
    fi
}

# Install Docker
install_docker() {
    log_info "Checking Docker installation"
    
    if command -v docker >/dev/null 2>&1; then
        log_success "Docker already installed"
        return
    fi
    
    local platform=$(detect_platform)
    
    echo ""
    log_info "Docker is not installed"
    read -p "Install Docker? (y/N) " -n 1 -r
    echo
    
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        return
    fi
    
    case "$platform" in
        "macos")
            log_info "Install Docker Desktop from: https://www.docker.com/products/docker-desktop"
            ;;
        "linux")
            log_info "Installing Docker via official script"
            curl -fsSL https://get.docker.com | sh
            sudo usermod -aG docker "$USER"
            log_success "Docker installed. Log out and back in for group changes"
            ;;
        "windows")
            log_info "Install Docker Desktop from: https://www.docker.com/products/docker-desktop"
            ;;
    esac
}

# Main setup function
main() {
    log_info "🚀 Starting jaRules essential tools setup..."
    
    local platform=$(detect_platform)
    log_info "Platform: $platform"
    
    install_platform_tools
    configure_tools
    install_docker
    
    log_success "🎉 Essential tools setup completed!"
    log_info "💡 Some tools may require a terminal restart to work properly"
}

# Run main function if script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
