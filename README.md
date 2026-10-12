# Dotfiles

Terminal configuration for Zsh, tmux, Ghostty, Powerlevel10k, and Hammerspoon.

## Setup

### Prerequisites

Required to run setup:

- macOS
- Git
- Internet access to GitHub

Install these applications and command-line tools separately:

- Ghostty
- Hammerspoon
- JetBrains Mono NL font
- Neovim 0.11 or newer
- `fzf`, `yazi`, `zoxide`, `bat`, `tmux`, `opencode`, `rg`, and `make`

Hammerspoon shortcuts also expect Google Chrome, Google Chat, and Cloudflare applications. Missing shortcut applications do not prevent setup.

The script installs Oh My Zsh, Powerlevel10k, Zsh plugins, gitstatus, TPM, and configured tmux plugins.

Neovim installs plugins automatically through lazy.nvim. Language features require their matching language servers: `lua_ls`, `rust_analyzer`, `gopls`, `basedpyright`, `ruff`, `helm_ls`, `yamlls`, `terraformls`, and `yls`. TypeScript support requires Node.js separately; the setup script does not install or configure Node.js.

### Run

```sh
git clone https://github.com/jihoro/dotfiles.git
cd dotfiles
./setup.sh
```

Existing configs are copied to `~/.dotfiles-backup/<timestamp>/` before replacement. Neovim files are overlaid individually, preserving unrelated files and existing Git metadata. Re-running the script skips identical files and existing Git plugin checkouts.

Options:

```text
--skip-plugins    Copy configs without installing plugins
--apply-defaults  Apply macOS defaults without prompting
--skip-defaults   Do not prompt or apply macOS defaults
```

Import `iterm.itermcolors` manually if using iTerm2.
