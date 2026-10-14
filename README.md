# Dotfiles

Terminal configuration for Zsh, tmux, Ghostty, Herdr, Powerlevel10k, and Hammerspoon.

## Setup

### Prerequisites

Required to run setup:

- macOS
- Xcode Command Line Tools, which provide Git, `make`, and a C compiler
- Internet access to GitHub

Install these applications and command-line tools separately:

- Ghostty
- Hammerspoon
- JetBrains Mono NL font
- Neovim 0.11 or newer
- `fzf`, `yazi`, `zoxide`, `bat`, `tmux`, `opencode`, `rg`, and `tree-sitter`

Hammerspoon shortcuts also expect Google Chrome, Google Chat, and Cloudflare applications. Missing shortcut applications do not prevent setup.

The script installs Oh My Zsh, Powerlevel10k, Zsh plugins, gitstatus, TPM, and configured tmux plugins.

Install Xcode Command Line Tools:

```sh
xcode-select --install
```

Install [Homebrew](https://brew.sh/) if needed, then install applications and command-line tools:

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install fzf yazi zoxide neovim bat tmux ripgrep opencode tree-sitter-cli
brew install --cask ghostty hammerspoon font-jetbrains-mono
```

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

### First Launch

Open Neovim after setup:

```sh
nvim
```

The first launch clones lazy.nvim, installs plugins from `lazy-lock.json`, and installs configured Treesitter parsers. Open `:Lazy` to inspect plugin status. Git, `make`, a C compiler, and internet access are required during this bootstrap.

Open Hammerspoon once, then enable it under **System Settings > Privacy & Security > Accessibility**. Choose **Reload Config** from the Hammerspoon menu after permission is granted.

Ghostty uses the `JetBrains Mono NL` face supplied by the `font-jetbrains-mono` cask. Restart Ghostty after installing the font.

### Optional Language Tooling

Install only the language tooling needed for your projects:

```sh
brew install lua-language-server rust-analyzer gopls basedpyright ruff
brew install helm-ls yaml-language-server gofumpt golangci-lint
```

Terraform support requires `terraform-ls` from HashiCorp. Follow current [terraform-ls installation instructions](https://github.com/hashicorp/terraform-ls/blob/main/docs/installation.md) because recent Homebrew versions may require explicitly trusting the HashiCorp tap.

YARA support requires `yls`:

```sh
brew install pipx
pipx install yls-yara
```

TypeScript support is optional and requires Node.js plus TypeScript tooling. This does not add Node setup to `.zshrc`:

```sh
brew install node
npm install --global typescript typescript-language-server
```

Go formatting and linting use `gofumpt` and `golangci-lint`, included in the Homebrew commands above. Language servers are not installed by `setup.sh`.
