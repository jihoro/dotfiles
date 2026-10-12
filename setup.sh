#!/usr/bin/env bash

set -euo pipefail

repo_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
backup_dir=""
install_plugins=true
defaults_mode="prompt"

usage() {
  printf 'Usage: %s [--skip-plugins] [--apply-defaults|--skip-defaults]\n' "$0"
}

while (($#)); do
  case "$1" in
    --skip-plugins)
      install_plugins=false
      ;;
    --apply-defaults)
      defaults_mode="apply"
      ;;
    --skip-defaults)
      defaults_mode="skip"
      ;;
    -h | --help)
      usage
      exit 0
      ;;
    *)
      printf 'Unknown option: %s\n' "$1" >&2
      usage >&2
      exit 1
      ;;
  esac
  shift
done

if [[ "$(uname -s)" != "Darwin" ]]; then
  printf 'This setup supports macOS only.\n' >&2
  exit 1
fi

if [[ "$install_plugins" == true ]] && ! command -v git >/dev/null 2>&1; then
  printf 'Git is required to install plugins.\n' >&2
  exit 1
fi

ensure_backup_dir() {
  if [[ -z "$backup_dir" ]]; then
    backup_dir="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)-$$"
    mkdir -p "$backup_dir"
  fi
}

copy_config() {
  local relative_path="$1"
  local source_path="$repo_dir/$relative_path"
  local target_path="$HOME/$relative_path"

  if [[ -e "$target_path" || -L "$target_path" ]]; then
    if [[ -f "$target_path" ]] && cmp -s "$source_path" "$target_path"; then
      printf 'Unchanged: ~/%s\n' "$relative_path"
      return
    fi

    ensure_backup_dir
    mkdir -p "$backup_dir/$(dirname "$relative_path")"
    cp -pP "$target_path" "$backup_dir/$relative_path"
    rm -f "$target_path"
  fi

  mkdir -p "$(dirname "$target_path")"
  cp -p "$source_path" "$target_path"
  printf 'Installed: ~/%s\n' "$relative_path"
}

clone_if_missing() {
  local url="$1"
  local destination="$2"

  if [[ -d "$destination/.git" ]]; then
    printf 'Present: %s\n' "$destination"
    return
  fi

  if [[ -e "$destination" ]]; then
    printf 'Skipped non-Git path: %s\n' "$destination" >&2
    return
  fi

  mkdir -p "$(dirname "$destination")"
  git clone --depth=1 "$url" "$destination"
}

copy_config ".zshrc"
copy_config ".p10k.zsh"
copy_config ".tmux.conf"
copy_config ".hammerspoon/init.lua"
copy_config ".config/ghostty/config"
copy_config ".config/ghostty/themes/orng-dark"

if [[ "$install_plugins" == true ]]; then
  clone_if_missing "https://github.com/ohmyzsh/ohmyzsh.git" "$HOME/.oh-my-zsh"

  zsh_custom="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
  clone_if_missing "https://github.com/romkatv/powerlevel10k.git" "$zsh_custom/themes/powerlevel10k"
  clone_if_missing "https://github.com/zsh-users/zsh-syntax-highlighting.git" "$zsh_custom/plugins/zsh-syntax-highlighting"
  clone_if_missing "https://github.com/MichaelAquilina/zsh-you-should-use.git" "$zsh_custom/plugins/you-should-use"
  clone_if_missing "https://github.com/fdellwing/zsh-bat.git" "$zsh_custom/plugins/zsh-bat"
  clone_if_missing "https://github.com/zsh-users/zsh-autosuggestions.git" "$zsh_custom/plugins/zsh-autosuggestions"
  clone_if_missing "https://github.com/romkatv/gitstatus.git" "$HOME/gitstatus"
  clone_if_missing "https://github.com/tmux-plugins/tpm.git" "$HOME/.tmux/plugins/tpm"
  clone_if_missing "https://github.com/tmux-plugins/tmux-resurrect.git" "$HOME/.tmux/plugins/tmux-resurrect"
  clone_if_missing "https://github.com/christoomey/vim-tmux-navigator.git" "$HOME/.tmux/plugins/vim-tmux-navigator"
fi

missing_commands=()
for command_name in fzf yazi zoxide nvim bat tmux opencode; do
  if ! command -v "$command_name" >/dev/null 2>&1; then
    missing_commands+=("$command_name")
  fi
done

if ((${#missing_commands[@]})); then
  printf 'Missing applications: %s\n' "${missing_commands[*]}" >&2
fi

for app_name in Ghostty Hammerspoon; do
  if [[ ! -d "/Applications/$app_name.app" && ! -d "$HOME/Applications/$app_name.app" ]]; then
    printf 'Missing application: %s\n' "$app_name" >&2
  fi
done

printf 'Ghostty requires the JetBrains Mono NL font.\n'

apply_defaults=false
case "$defaults_mode" in
  apply)
    apply_defaults=true
    ;;
  prompt)
    if [[ -t 0 ]]; then
      if read -r -p "Apply macOS keyboard and window defaults? [y/N] " answer &&
        [[ "$answer" == [yY] || "$answer" == [yY][eE][sS] ]]; then
        apply_defaults=true
      fi
    else
      printf 'Skipped macOS defaults: no interactive terminal.\n'
    fi
    ;;
esac

if [[ "$apply_defaults" == true ]]; then
  bash "$repo_dir/mac_defaults_override.sh"
  printf 'Applied macOS defaults. Log out and back in for all changes to take effect.\n'
fi

if [[ -n "$backup_dir" ]]; then
  printf 'Backups: %s\n' "$backup_dir"
fi

printf 'Setup complete. Start a new shell to load the configuration.\n'
