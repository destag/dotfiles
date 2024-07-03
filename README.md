# Installation

We are using dotbot to set things up. Steps:

Clone this repo with: `git clone https://github.com/destag/dotfiles .dotfiles`
Run: `.dotfiles/install`

# Install tools with asdf

Run: `asdf install`

# Install FiraCode Nerd font

```sh
git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git    # warning: takes a while

cd nerd-fonts/
./install.sh FiraCode
./install.sh JetBrainsMono
```

# Set gnome keybindings

```sh
gsettings set org.gnome.desktop.wm.keybindings close "['<Super>w']"
gsettings set org.gnome.desktop.input-sources xkb-options "['caps:escape_shifted_capslock']"
gsettings set org.gnome.settings-daemon.plugins.media-keys terminal "['<Super>t', '<Primary><Alt>Return']"
```
