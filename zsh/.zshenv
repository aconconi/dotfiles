# -----------------------------
# XDG directories
# -----------------------------
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export GEMINI_CLI_HOME="$XDG_CONFIG_HOME/gemini"
# -----------------------------
# Editor
# -----------------------------
export EDITOR="nvim"
export VISUAL="nvim"
# -----------------------------
# Zsh config location
# -----------------------------
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
# -----------------------------
# Homebrew (macOS and Linuxbrew)
# -----------------------------
for brew_bin in /opt/homebrew/bin/brew /home/linuxbrew/.linuxbrew/bin/brew /usr/local/bin/brew; do
    if [ -x "$brew_bin" ]; then
        eval "$("$brew_bin" shellenv)"
        break
    fi
done
