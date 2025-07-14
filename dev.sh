#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<EOF
Usage: devenv [OPTIONS]

Options:
  --help, -h
        Show this help message and exit.

  --dry, -d
        Dry-run mode. Only log what would be done; do not make any changes.

  --update, -u
        Sync & upgrade system packages (via pacman -Syu) before processing.

  --mods, -m <list>
        Comma-separated list of module names to include.
        If omitted, all subdirectories of \$DEV_PATH are processed.
        Example: --mods nvim,zsh,ghostty

Environment:
  DEVPATH
        Base directory for your modules. Defaults to \$HOME/devenv.

Examples:
  # Process everything under \$HOME/devenv:
  devenv

  # Preview actions without touching files:
  devenv --dry

  # Only update system and process nvim + zsh:
  devenv --update --mods nvim,zsh

  # Combine dry-run with mods filter:
  devenv --dry --mods ghostty
EOF
}


DEV_PATH="${DEVPATH:-$HOME/devenv}"
DRY=false
UPDATE=false
MODS=()


while [[ $# -gt 0 ]]; do
  case "$1" in
    -h|--help)
      usage
      exit 0
      ;;
    -d|--dry)
      DRY=true
      shift
      ;;
    -u|--update)
      UPDATE=true
      shift
      ;;
    -m|--mods)
      shift
      if [[ $# -eq 0 ]]; then
        echo "Error: --mods requires a comma-separated list argument" >&2
        exit 1
      fi
      IFS=',' read -r -a MODS <<< "$1"
      shift
      ;;
    *)
      echo "Unknown option: $1" >&2
      exit 1
      ;;
  esac
done


if [[ $UPDATE == true ]]; then
  echo "Syncing & upgrading system packages..."
  sudo pacman -Syu
fi
sudo pacman -S --needed stow

echo "DEVPATH: $DEV_PATH"
if [[ ${#MODS[@]} -gt 0 ]]; then
  echo "Included mods: ${MODS[*]}"
fi
if [[ $DRY == true ]]; then
  echo "Dry-run mode: no changes will be made"
fi
echo


dirs=($DEV_PATH/*/)
if (( ${#MODS[@]} )); then
  filtered=()
  for d in "${dirs[@]}"; do
    name="${d%/}"            # strip trailing slash
    for want in "${MODS[@]}"; do
      if [[ $(basename "$name") == "$want" ]]; then
        filtered+=("$d")
        break
      fi
    done
  done
  dirs=("${filtered[@]}")
fi

for d in "${dirs[@]}"; do
  echo "Found configuration: ${d%/}"
done

if [[ $DRY == false ]]; then
  for d in "${dirs[@]}"; do
	mod=$(basename ${d%/})
	echo "Creating symlinks for $mod"

	if [[ "$mod" == "ghostty" ]]; then
	   # ghostty creates non-empty config if its not exists
	   # so we need to delete it before creating symlink 

	   rm -rf $HOME/.config/ghostty
	fi


        stow -d $DEV_PATH $mod
	if [[ "$mod" == "zsh" ]]; then
	   echo "NOTE: To reload config reopen terminal or run 'source $HOME/.zshrc'"
	fi
	if [[ "$mod" == "ghostty" ]]; then
	   echo "NOTE: To reload config press 'CTRL+SHIFT+,'"
	fi
  done

  pkill waybar && hyprctl dispatch exec waybar
  pkill swaync && hyprctl dispatch exec swaync

  hyprctl reload
fi
