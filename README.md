# Dotfiles

This repository contains my personal dotfiles managed with GNU Stow.

## Prerequisites

Install GNU Stow:

```bash
# Ubuntu/Debian
sudo apt install stow

# Fedora
sudo dnf install stow

# Arch
sudo pacman -S stow
# or
yay -S stow
```

## Installation

1. Clone this repository to your home directory:
```bash
git clone https://github.com/allgaleano/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

2. Before stowing, backup any existing configurations:
```bash
mv ~/.config/alacritty ~/.config/alacritty.backup
mv ~/.zshrc ~/.zshrc.backup
```

3. Use stow to create symlinks:
```bash
# Stow individual configurations
stow alacritty  # Terminal configuration
stow zsh        # ZSH configuration

# Or stow everything at once
stow */
```

## Removing Configurations

To remove the symlinks created by stow:
```bash
stow -D alacritty  # Remove alacritty config
stow -D zsh        # Remove zsh config

# Or remove everything
stow -D */
```

## Updating Configurations

To update (restow) configurations after changes:
```bash
stow -R alacritty  # Restow alacritty config
stow -R zsh        # Restow zsh config

# Or restow everything
stow -R */
```

## Troubleshooting

### Conflicts with existing files
If you get a warning about conflicts:
```bash
# Backup the existing file/directory
mv ~/.config/alacritty ~/.config/alacritty.backup

# Then try stowing again
stow alacritty
```

### Checking symlinks
To verify symlinks are correctly created:
```bash
ls -la ~/.config/alacritty
ls -la ~/.zshrc
ls -la ~/.config/dconf/dash-to-panel.config
```

## Additional Notes

- The directory structure in this repository mirrors the structure in your home directory
- Each directory at the root level represents a package that can be stowed independently
- Symlinks will be created from your home directory to the files in this repository
- Always backup your existing configurations before stowing new ones

## Contributing

Feel free to fork this repository and customize it for your own use. Pull requests for improvements are welcome!

