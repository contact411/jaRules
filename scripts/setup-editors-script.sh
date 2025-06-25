#!/usr/bin/env bash
# jaRules Editor Setup
# Configure VSCode and other editors with legendary settings

set -euo pipefail

# Colors
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly NC='\033[0m'

# Logging functions
log_info() { echo -e "${BLUE}[EDITOR]${NC} $1"; }
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

# Find VSCode configuration directory
find_vscode_config_dir() {
    local platform=$(detect_platform)
    local vscode_dir=""
    
    case "$platform" in
        "macos")
            vscode_dir="$HOME/Library/Application Support/Code/User"
            ;;
        "linux")
            vscode_dir="$CONFIG_DIR/Code/User"
            ;;
        "windows")
            vscode_dir="$HOME/AppData/Roaming/Code/User"
            ;;
    esac
    
    # Check for VSCode Insiders
    if [[ ! -d "$vscode_dir" ]]; then
        case "$platform" in
            "macos")
                vscode_dir="$HOME/Library/Application Support/Code - Insiders/User"
                ;;
            "linux")
                vscode_dir="$CONFIG_DIR/Code - Insiders/User"
                ;;
            "windows")
                vscode_dir="$HOME/AppData/Roaming/Code - Insiders/User"
                ;;
        esac
    fi
    
    echo "$vscode_dir"
}

# Setup VSCode
setup_vscode() {
    log_info "Setting up VSCode configuration"
    
    # Check if VSCode is installed
    if ! command -v code >/dev/null 2>&1 && ! command -v code-insiders >/dev/null 2>&1; then
        log_warning "VSCode not found. Install it from https://code.visualstudio.com"
        return
    fi
    
    local vscode_dir=$(find_vscode_config_dir)
    
    if [[ ! -d "$vscode_dir" ]]; then
        log_warning "VSCode configuration directory not found"
        log_info "Expected location: $vscode_dir"
        log_info "Please ensure VSCode has been run at least once"
        return
    fi
    
    # Create directory if needed
    mkdir -p "$vscode_dir"
    
    # Install settings
    local settings_template="$SCRIPT_DIR/../config/vscode/settings.template.json"
    local settings_target="$vscode_dir/settings.json"
    
    if [[ -f "$settings_template" ]]; then
        # Backup existing settings
        if [[ -f "$settings_target" ]] && [[ ! -f "$settings_target.jarules-backup" ]]; then
            cp "$settings_target" "$settings_target.jarules-backup"
            log_info "Backed up existing VSCode settings"
        fi
        
        # Process template
        envsubst < "$settings_template" > "$settings_target"
        log_success "VSCode settings installed"
    else
        log_warning "VSCode settings template not found"
    fi
    
    # Install extensions list
    local extensions_file="$SCRIPT_DIR/../config/vscode/extensions.json"
    local extensions_target="$vscode_dir/.vscode/extensions.json"
    
    if [[ -f "$extensions_file" ]]; then
        mkdir -p "$(dirname "$extensions_target")"
        cp "$extensions_file" "$extensions_target"
        log_success "VSCode extensions recommendations installed"
        
        # Offer to install extensions
        install_vscode_extensions
    fi
}

# Install VSCode extensions
install_vscode_extensions() {
    log_info "Installing recommended VSCode extensions"
    
    # Determine which VSCode command to use
    local vscode_cmd=""
    if command -v code >/dev/null 2>&1; then
        vscode_cmd="code"
    elif command -v code-insiders >/dev/null 2>&1; then
        vscode_cmd="code-insiders"
    else
        return
    fi
    
    # Essential extensions
    local essential_extensions=(
        "catppuccin.catppuccin-vsc"
        "catppuccin.catppuccin-vsc-icons"
        "github.copilot"
        "continue.continue"
        "esbenp.prettier-vscode"
        "dbaeumer.vscode-eslint"
        "eamodio.gitlens"
        "gruntfuggly.todo-tree"
    )
    
    echo ""
    echo "Essential extensions to install:"
    for ext in "${essential_extensions[@]}"; do
        echo "  - $ext"
    done
    echo ""
    read -p "Install essential VSCode extensions? (y/N) " -n 1 -r
    echo
    
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        for ext in "${essential_extensions[@]}"; do
            log_info "Installing $ext"
            $vscode_cmd --install-extension "$ext" || log_warning "Failed to install $ext"
        done
        log_success "Essential extensions installed"
    fi
}

# Setup Vim/Neovim
setup_vim() {
    log_info "Setting up Vim/Neovim configuration"
    
    # Check what's available
    local vim_cmd=""
    if command -v nvim >/dev/null 2>&1; then
        vim_cmd="nvim"
        local vim_config_dir="$CONFIG_DIR/nvim"
    elif command -v vim >/dev/null 2>&1; then
        vim_cmd="vim"
        local vim_config_dir="$HOME/.vim"
    else
        log_warning "Neither Vim nor Neovim found"
        return
    fi
    
    # Create config directory
    mkdir -p "$vim_config_dir"
    
    # Create basic init.vim/vimrc
    local vim_config_file=""
    if [[ "$vim_cmd" == "nvim" ]]; then
        vim_config_file="$vim_config_dir/init.vim"
    else
        vim_config_file="$HOME/.vimrc"
    fi
    
    # Backup existing config
    if [[ -f "$vim_config_file" ]] && [[ ! -f "$vim_config_file.jarules-backup" ]]; then
        cp "$vim_config_file" "$vim_config_file.jarules-backup"
        log_info "Backed up existing Vim configuration"
    fi
    
    # Create modern Vim configuration
    cat > "$vim_config_file" << 'EOF'
" jaRules Vim Configuration
" Modern, minimal, and powerful

" General Settings
set encoding=utf-8
set number relativenumber
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set smartindent
set wrap
set linebreak
set hidden
set ignorecase
set smartcase
set incsearch
set hlsearch
set termguicolors
set scrolloff=8
set signcolumn=yes
set updatetime=50
set colorcolumn=80
set clipboard=unnamedplus

" Better splits
set splitbelow
set splitright

" Enable mouse
set mouse=a

" Persistent undo
set undofile
set undodir=~/.vim/undodir

" Key mappings
let mapleader = " "

" Easy escape
inoremap jk <Esc>
inoremap kj <Esc>

" Better navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Quick save
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>

" Clear search highlight
nnoremap <leader>h :noh<CR>

" File explorer
nnoremap <leader>e :Ex<CR>

" Install vim-plug if not present
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins
call plug#begin('~/.vim/plugged')

" Color scheme
Plug 'catppuccin/vim', { 'as': 'catppuccin' }

" Essential plugins
Plug 'tpope/vim-fugitive'         " Git integration
Plug 'tpope/vim-surround'         " Surround text objects
Plug 'tpope/vim-commentary'       " Easy commenting
Plug 'vim-airline/vim-airline'    " Status line
Plug 'airblade/vim-gitgutter'     " Git diff in gutter
Plug 'preservim/nerdtree'         " File explorer

" Language support
Plug 'sheerun/vim-polyglot'       " Multiple language packs

" Fuzzy finder (if fzf is installed)
if executable('fzf')
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
endif

call plug#end()

" Color scheme
try
  colorscheme catppuccin_mocha
catch
  colorscheme desert
endtry

" Airline configuration
let g:airline_theme = 'catppuccin_mocha'
let g:airline_powerline_fonts = 1

" NERDTree configuration
nnoremap <leader>n :NERDTreeToggle<CR>
let NERDTreeShowHidden = 1

" FZF mappings
if executable('fzf')
  nnoremap <leader>f :Files<CR>
  nnoremap <leader>b :Buffers<CR>
  nnoremap <leader>g :Rg<CR>
endif

" Auto-install plugins on first run
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif
EOF
    
    log_success "Vim configuration installed"
    log_info "Run ':PlugInstall' in Vim to install plugins"
}

# Setup Nano (simple but better than default)
setup_nano() {
    log_info "Setting up Nano configuration"
    
    local nanorc_file="$HOME/.nanorc"
    
    # Backup existing config
    if [[ -f "$nanorc_file" ]] && [[ ! -f "$nanorc_file.jarules-backup" ]]; then
        cp "$nanorc_file" "$nanorc_file.jarules-backup"
        log_info "Backed up existing Nano configuration"
    fi
    
    # Create improved nano configuration
    cat > "$nanorc_file" << 'EOF'
# jaRules Nano Configuration
# Making nano slightly less painful

# Display
set linenumbers
set constantshow
set titlecolor brightwhite,blue
set statuscolor brightwhite,green
set keycolor green
set functioncolor yellow
set numbercolor cyan

# Behavior
set autoindent
set tabsize 2
set tabstospaces
set smooth
set softwrap
set mouse

# Syntax highlighting
include "/usr/share/nano/*.nanorc"

# Key bindings
bind ^S savefile main
bind ^Q exit all
bind ^F whereis all
bind ^G gotoline all
EOF
    
    log_success "Nano configuration installed"
}

# Setup cursor position for file types
setup_editorconfig() {
    log_info "Setting up EditorConfig"
    
    local editorconfig_file="$HOME/.editorconfig"
    
    if [[ -f "$editorconfig_file" ]]; then
        log_info "EditorConfig already exists"
        return
    fi
    
    # Create EditorConfig file
    cat > "$editorconfig_file" << 'EOF'
# jaRules EditorConfig
# https://editorconfig.org

root = true

[*]
charset = utf-8
end_of_line = lf
insert_final_newline = true
trim_trailing_whitespace = true
indent_style = space
indent_size = 2

[*.{js,jsx,ts,tsx,json}]
indent_size = 2

[*.{py,pyw}]
indent_size = 4

[*.{go,mod,sum}]
indent_style = tab

[*.{md,markdown}]
trim_trailing_whitespace = false

[Makefile]
indent_style = tab

[*.{yaml,yml}]
indent_size = 2

[*.rs]
indent_size = 4

[*.{html,css,scss,sass}]
indent_size = 2

[*.sh]
indent_size = 2

[{package.json,.travis.yml}]
indent_size = 2
EOF
    
    log_success "EditorConfig installed"
}

# Main setup function
main() {
    log_info "🚀 Starting jaRules editor setup..."
    
    setup_vscode
    setup_vim
    setup_nano
    setup_editorconfig
    
    log_success "🎉 Editor setup completed!"
    log_info "💡 Restart your editors to load new configurations"
}

# Run main function if script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
