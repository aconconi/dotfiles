# Homebrew

*   **Dump the list of installed leaves into Brewfile**: `brew bundle dump --describe`
*   **Reinstall from Brewfile**: `brew bundle install`
*   **List installed tools with short description**: `brew leaves | xargs brew desc --eval-all`
*   **Uninstall everything that is NOT in the Brewfile**: `brew bundle --cleanup`


# Stow

This repository uses GNU Stow to manage symlinks from this directory to your home directory.

## Getting Started

1. **Clone the repository** (standard location is `~/dotfiles`):
   ```bash
   git clone <repo_url> ~/dotfiles
   cd ~/dotfiles
   ```
2. **Install GNU Stow**:
   ```bash
   brew install stow
   ```

3. **Stow everything, leveraging stowrc and ignore files**
   ```bash
   cd ~/dotfiles
   stow --no-folding --verbose */
   ```


## Using Stow Safely

Stow assumes the target for symlinks is the **parent directory** of where you run the command. If you are in `~/dotfiles`, it will target `~/`.

### 1. Watch the Path (Dry Run)
Before making changes, always use a "dry run" with verbose output to see exactly where links will be created.
```bash
# -n: dry run, -v: verbose, -t ~: explicitly target home
stow -nvt ~ ghostty
```

### 2. Linking Files vs. Directories (--no-folding)
By default, if a directory (like `.config/ghostty`) doesn't exist in your home folder, Stow may "fold" it by symlinking the entire directory from this repo. To ensure Stow creates the directory structure and links **individual files** instead, use the `--no-folding` flag.

This is safer if you want to keep your home directory organized without creating large directory symlinks that might conflict with other tools.
```bash
stow --no-folding -vt ~ nvim
```

### 3. Basic Commands
Run these from the root of your `~/dotfiles` directory:

*   **Link a configuration**: `stow -vt ~ <folder_name>`
*   **Remove symlinks**: `stow -Dvt ~ <folder_name>`
*   **Restow (refresh links)**: `stow -Rvt ~ <folder_name>`

### 4. Conflict Handling
If a file already exists at the target location (and isn't a symlink), Stow will refuse to overwrite it. You must move or delete the existing file before running `stow`.
```bash
mv ~/.zshrc ~/.zshrc.bak
stow -vt ~ zsh
```

### 5. Adopt Existing Files (--adopt)
Use this if you have an existing config in your home directory (e.g., `~/.zshrc`) and you want to manage it with Stow.

**Workflow to "Pull" into Repo:**
1. Starting scenario

     There is a "live" file e.g. `~/.config/zsh/.zshrc`.\
     There is a folder in dotfiles e.g. `~/dotfiles/zsh/.config/zsh`.\
     Note that if `~/dotfiles/zsh/.config/zsh/.zshrc` exists, it will be overwritten by the adopt command.

2. Run the adopt command:
   ```bash
    cd ~/dotfiles
    stow -v --adopt zsh
   ```
   *This moves the content of `~/.config/zsh/.zshrc` into ~/dotfiles/zsh/.config/zsh/.zshrc` and then creates the symlink.*
