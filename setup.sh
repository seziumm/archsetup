#/!/bin/bash

# unzip RosePine-Dark-B-MB.zip
# sudo cp -r Rosepine-Dark/ /usr/share/themes
# sudo pacman -S nvidia nvidia-utils lib32-nvidia-utils
# sudo pacman -S nvidia-settings
#
#
# edit 
#
# sudo grub-mkconfig -o /boot/grub/grub.cfg
#
# sudo nvim /etc/default/grub
# GRUB_CMDLINE_LINUX_DEFAULT="quiet splash nvidia-drm.modeset=1"
#
# sudo nvim /etc/mkinitcpio.conf
# MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)
# HOOKS=()
# sudo mkinitcpio -P

# Adding the Pacman Hook:
# Get the nvidia.hook -file from this repository
#
#     cd ~
#     wget https://raw.githubusercontent.com/korvahannu/arch-nvidia-drivers-installation-guide/main/nvidia.hook
#
# Open the file with your preferred editor.
#
#     nano nvidia.hook
#
# Find the line that says Target=nvidia.
# Replace the word nvidia with the base driver you installed, e.g., nvidia-470xx-dkms
#
#     The edited line should look something like this: Target=nvidia-470xx-dkms
#
# Save the file with CTRL+S and close nano with CTRL+X
# Move the file to /etc/pacman.d/hooks/ with: sudo mkdir -p /etc/pacman.d/hooks/ && sudo mv ./nvidia.hook /etc/pacman.d/hooks



timedatectl set-local-rtc 1 --adjust-system-clock
# --------------------- PACKAGES --------------------- #

sudo pacman -Syu
sudo pacman -S --noconfirm pacman-contrib ttf-meslo-nerd fastfetch zsh git ripgrep wl-clipboard neovim eza alacritty firefox thunar wofi waybar hyprland hyprpaper unzip


# --------------------- ZSH SHELL --------------------- #
chsh -s $(which zsh)


# xdg-mime default thunar.desktop inode/directory
# set defualt file manager for firefox

# --------------------- BLUETOOTH --------------------- #

sudo pacman -S --noconfirm bluez bluez-utils pulseaudio blueman pulseaudio-bluetooth
sudo systemctl start bluetooth
sudo systemctl enable bluetooth


# ---------------------     YAY      --------------------- #


cd ~
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd ~


# ------------------------- NVIM ------------------------- #

# Clone Packer.nvim
echo "Installing nvim packer..." 

# Rimuovi la vecchia cartella di packer.nvim se esiste
rm -rf ~/.local/share/nvim/site/pack/packer/start/packer.nvim
if [ $? -ne 0 ]; then
  echo "Failed to remove old packer.nvim directory."
  exit 1
fi

# Clona il repository di packer.nvim
git clone --quiet --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
if [ $? -ne 0 ]; then
  echo "Failed to clone packer.nvim."
  exit 1
fi

# Elimina le vecchie configurazioni di nvim
echo "Deleting older nvim config..." 
rm -rf ~/.config/nvim/

mkdir -p ~/.config/nvim

if [ $? -ne 0 ]; then
  echo "Failed to remove old nvim config directory."
  exit 1
fi

rm -rf ~/.local/share/nvim
if [ $? -ne 0 ]; then
  echo "Failed to remove old nvim data directory."
  exit 1
fi

# Clona il nuovo repository di configurazione nvim in una cartella temporanea
git clone --quiet --depth 1 https://github.com/seziumm/nvim.git ~/.config/nvim
if [ $? -ne 0 ]; then
  echo "Failed to clone new nvim configuration."
  exit 1
fi

echo "Use g + ? to see nvim-tree commands\n\n"
echo "Nvim is done"


# --------------------- ALACRITTY --------------------- #

# sudo pacman -Syu ttf-meslo
rm -rf ~/.config/alacritty/

mkdir -p ~/.config/alacritty


if [ $? -ne 0 ]; then
  echo "Failed to remove old alacritty config."
  exit 1
fi

git clone --quiet --depth 1 https://github.com/seziumm/alacritty.git ~/.config/alacritty
if [ $? -ne 0 ]; then
  echo "Failed to clone new alacritty configuration."
  exit 1
fi

echo "Alacritty is done"


# ---------------------   CURSOR     --------------------- #

echo "Installing cursor theme..."
sudo pacman -Syu
sudo pacman -S nwg-look yay -S rose-pine-cursor
yay -S rose-pine-hyprcursor
nwg-look

echo "Cursor is done"


# ---------------------   HYPRLAND --------------------- #

echo "Installing hyprland..."
rm -rf ~/.config/hypr/

mkdir -p ~/.config/hypr

if [ $? -ne 0 ]; then
  echo "Failed to remove old hypr config."
  exit 1
fi

git clone --quiet --depth 1 https://github.com/seziumm/hypr.git ~/.config/hypr
if [ $? -ne 0 ]; then
  echo "Failed to clone new hypr configuration."
  exit 1
fi

echo "Hyprland is done"

# ---------------------   WAYBAR --------------------- #

echo "Installing Waybar..."
rm -rf ~/.config/waybar/

mkdir -p ~/.config/waybar

if [ $? -ne 0 ]; then
  echo "Failed to remove old Waybar config."
  exit 1
fi

git clone --quiet --depth 1 https://github.com/seziumm/waybar.git ~/.config/waybar
if [ $? -ne 0 ]; then
  echo "Failed to clone new waybar configuration."
  exit 1
fi

echo "Waybar is done"



# ---------------------  WOFI --------------------- #

echo "Installing Wofi..."
rm -rf ~/.config/waybar/

mkdir -p ~/.config/wofi

if [ $? -ne 0 ]; then
  echo "Failed to remove old Wofi config."
  exit 1
fi

git clone --quiet --depth 1 https://github.com/seziumm/wofi.git ~/.config/wofi
if [ $? -ne 0 ]; then
  echo "Failed to clone new wofi configuration."
  exit 1
fi

echo "Wofi is done"

echo "ALL DONE!"


 
# mkdir ~/.config/zsh
# cd ~/.config/zsh
# git clone https://github.com/romkatv/powerlevel10k.git
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
# git clone https://github.com/zsh-users/zsh-autosuggestions.git
#
# nvim ~/.p10k.zsh
#   search for this line and set to 0
#   typeset -g POWERLEVEL9K_DIR_BACKGROUND=0




# --------------------- ZSH CONF ------------------- #

# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi
#
# #--------------------------------------------------#
#
# export EDITOR=nvim
# export VISUAL=nvim
# export LANG=en_US.UTF-8
# export LC_TIME=en_US.UTF-8
# #--------------------------------------------------#
#
# HISTFILE=~/.config/zsh/.zsh_history
#
# SAVEHIST=1000
# HISTSIZE=999
# setopt share_history
# setopt hist_expire_dups_first
# setopt hist_ignore_dups
# setopt hist_verify
# setopt globdots
#
# bindkey '^P' history-search-backward
# bindkey '^N' history-search-forward
# bindkey '^[I' autosuggest-accept
# #--------------------------------------------------#
#
# alias nvimconf="nvim ~/.config/nvim/"
# alias zshconf="nvim ~/.zshrc"
# alias hyprconf="nvim ~/.config/hypr/"
# alias alacrittyconf="nvim ~/.config/alacritty/alacritty.toml"
# alias h="history"
# alias vi="nvim"
# alias svi="sudoedit nvim"
#
# alias ls="eza --color=always --long --icons=always --no-time --no-permissions --no-user" 
# alias tree="eza --color=always --long --icons=always --no-time --no-permissions --tree --no-user" 
# # --all per vedere i file nascosti
#
# #--------------------------------------------------#
# source ~/.config/zsh/powerlevel10k/powerlevel10k.zsh-theme
# source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
# source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#
# # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
#
