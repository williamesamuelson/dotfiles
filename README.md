# Dotfiles

My personal configuration files for various tools and applications, managed with symlinks and versioned for portability.

## Structure

The repository is organized as follows:

```plaintext
~/dotfiles/
├── config/
│   ├── git/                # Git configuration
│   │   └── gitconfig
│   ├── julia/              # Julia configuration
│   │   └── startup.jl
│   ├── tmux/               # Tmux configuration
│   │   └── tmux.conf
│   ├── zsh/                # Zsh configuration
│   │   ├── zshrc
│   │   └── zprofile
│   ├── nvim/               # Neovim configuration
│   │   ├── init.vim
│   │   └── lua/
│   ├── wezterm/            # WezTerm configuration
│   │   └── wezterm.lua
└── setup.sh                # Script to set up symlinks
```

## Usage

### 1. Clone the Repository

```bash
git clone https://github.com/<your-username>/dotfiles.git ~/dotfiles
```

### 2. Run the Setup Script
The `setup.sh` script creates symlinks for configuration files in their expected locations.

```bash
cd ~/dotfiles
./setup.sh
```

### 3. Verify the Setup
Ensure the symlinks point to the correct files:

```bash
ls -l ~/.gitconfig
ls -l ~/.julia/config/startup.jl
ls -l ~/.tmux.conf
ls -l ~/.zshrc
ls -l ~/.config/nvim
ls -l ~/.config/wezterm
```

### Adding New Configurations
1. Place the new configuration file in `~/dotfiles/config/<tool>/`.
2. Update the `setup.sh` script with the appropriate target:link pair.
3. Re-run the script to apply the changes.

