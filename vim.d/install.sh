#!/bin/bash

if ! [ "$(command -v vim)" ]; then
    red "Cannot find vim. Aborting..."
    return
fi

PLUGINS_DIR="$HOME/.vim/pack/$USER/start"
mkdir -p "$PLUGINS_DIR"

plugins=(
    "w0rp/ale"
    "pearofducks/ansible-vim"
    "kylef/apiblueprint.vim"
    "Raimondi/delimitMate"
    "editorconfig/editorconfig-vim"
    "junegunn/fzf.vim"
    "scrooloose/nerdtree"
    "xuyuanp/nerdtree-git-plugin"
    "joshdick/onedark.vim"
    "python-mode/python-mode"
    "SirVer/ultisnips"
    "bling/vim-airline"
    "vim-airline/vim-airline-themes"
    "pseewald/vim-anyfold"
    "ryanoasis/vim-devicons"
    "tpope/vim-fugitive"
    "airblade/vim-gitgutter"
    "fatih/vim-go"
    "nathanaelkane/vim-indent-guides"
    "tiagofumo/vim-nerdtree-syntax-highlight"
    "sheerun/vim-polyglot"
    "honza/vim-snippets"
    "tpope/vim-surround"
    "hashivim/vim-terraform"
    "posva/vim-vue"
    "Valloric/YouCompleteMe"
)

for plugin in "${plugins[@]}"; do
    plugin_dir="$PLUGINS_DIR/$(basename "$plugin")"
    if [ -d "$plugin_dir" ]; then
        green "Plugin already exists: $plugin. Checking updates"
        git -C "$plugin_dir" fetch | info
        git -C "$plugin_dir" pull --recurse-submodules | info
    else
        yellow "Downloading plugin: $plugin"
        git clone --recurse-submodules "https://github.com/$plugin" "$plugin_dir" | info
    fi
done

if ! [ -L "$HOME/.vimrc" ]; then
    rm -r "$HOME/.vimrc"
    ln -s "$CONF_DIR/vim.d/vimrc" "$HOME/.vimrc"
    yellow "Created link: $HOME/.vimrc"
else
    green "Link already exists: $HOME/.vimrc"
fi
