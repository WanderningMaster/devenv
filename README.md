# DEVENV

A simple Bash script to manage and deploy dotfiles and configurations using GNU Stow.

## Features

* **Dry-run mode** (`--dry`): Preview actions without modifying any files.
* **System update** (`--update`): Sync and upgrade system packages before processing.
* **Module filtering** (`--mods`): Include only specified modules.
* **Cleanup**: Automatically remove existing configuration files to prevent symlink conflicts.
* **Help** (`-h`, `--help`): Show usage information.

## Installation

1. Clone this repository into your desired development environment directory (default: `$HOME/devenv`):

   ```bash
   git clone https://github.com/yourusername/dev-stow.git "$DEVPATH"
   ```
2. Make the script executable:

   ```bash
   bash install.sh
   ```
3. (Optional) Add `DEVPATH` to your shell profile if you use a custom location:

   ```bash
   export DEVPATH="$HOME/devenv"
   ```
