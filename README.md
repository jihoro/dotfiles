# Dotfiles

Terminal configuration for Zsh, tmux, Ghostty, Powerlevel10k, and Hammerspoon.

## Setup

Install applications and command-line tools first. The setup script reports anything missing but only installs configuration dependencies and plugins.

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

The script installs Oh My Zsh, Powerlevel10k, Zsh plugins, gitstatus, TPM, and configured tmux plugins. Ghostty expects the `JetBrains Mono NL` font. Import `iterm.itermcolors` manually if using iTerm2.
