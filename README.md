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
- `fzf`, `yazi`, `zoxide`, `nvim`, `bat`, `tmux`, and `opencode`

Hammerspoon shortcuts also expect Google Chrome, Google Chat, and Cloudflare applications. Missing shortcut applications do not prevent setup.

The script installs Oh My Zsh, Powerlevel10k, Zsh plugins, gitstatus, TPM, and configured tmux plugins.

### Run

```sh
git clone https://github.com/jihoro/dotfiles.git
cd dotfiles
./setup.sh
```

Existing configs are copied to `~/.dotfiles-backup/<timestamp>/` before replacement. Re-running the script skips identical files and existing Git plugin checkouts.

Options:

```text
--skip-plugins    Copy configs without installing plugins
--apply-defaults  Apply macOS defaults without prompting
--skip-defaults   Do not prompt or apply macOS defaults
```

Import `iterm.itermcolors` manually if using iTerm2.
