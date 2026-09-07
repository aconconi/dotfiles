# inspired by https://satya164.page/posts/my-zsh-setup

# Enable zsh recompilation
autoload -Uz zrecompile


zstyle ':autocomplete:*' min-input 2
zstyle ':autocomplete:*' insert-unambiguous no
zstyle ':autocomplete:*' delay 0.2
zstyle ':autocomplete:history-incremental-search-backward:*' list-lines 8

PLUGIN_DIR=$HOME/.zsh_plugins
_load_plugin() {
  local plugin="$1"
  if [[ ! -d $PLUGIN_DIR/${plugin:t} ]]; then
    git clone --depth 1 "https://github.com/${plugin}" "$PLUGIN_DIR/${plugin:t}"

    for f in $PLUGIN_DIR/${plugin:t}/**/*.zsh; do
      echo "Recompiling $f"
      zrecompile -pq "$f"
    done
  fi

  if [[ -f $PLUGIN_DIR/${plugin:t}/${plugin:t}.plugin.zsh ]]; then
    source "$PLUGIN_DIR/${plugin:t}/${plugin:t}.plugin.zsh"
  fi
}

# Syntax highlighting: load early
_load_plugin zdharma-continuum/fast-syntax-highlighting

# zsh-users/zsh-autosuggestions and zsh-users/zsh-history-substring-search
# are superseded by zsh-autocomplete, loaded later below

# Starship
eval "$(starship init zsh)"

# Save history so we get auto suggestions
HISTFILE=$HOME/.zsh_history # path to the history file
HISTSIZE=100000 # number of history items to store in memory
HISTDUP=erase # remove older duplicate entries from history
SAVEHIST=$HISTSIZE # number of history items to save to the history file

# Stop zsh autocorrect from suggesting undesired completions
CORRECT_IGNORE_FILE=".*"
CORRECT_IGNORE="_*"

# Options
setopt auto_cd # cd by typing directory name if it's not a command
setopt auto_list # automatically list choices on ambiguous completion
setopt auto_menu # automatically use menu completion
setopt always_to_end # move cursor to end if word had one match
setopt hist_expire_dups_first # expire duplicate entries first when trimming history
setopt hist_find_no_dups # don't display duplicate entries in history
setopt hist_ignore_space # ignore commands starting with space
setopt hist_ignore_all_dups # remove older duplicate entries from history
setopt hist_reduce_blanks # remove superfluous blanks from history items
setopt hist_save_no_dups # don't save duplicate entries in history
setopt hist_verify # don't execute immediately upon history expansion
setopt inc_append_history # save history entries as soon as they are entered
setopt share_history # share history between different instances
setopt correct_all # autocorrect commands
setopt interactive_comments # allow comments in interactive shells

# Load the completion system, builds/reads the .zcompdump cache under $ZDOTDIR
autoload -Uz compinit
compinit -d "$XDG_CACHE_HOME/zsh/.zcompdump"

# Improve autocompletion style
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' # case-insensitive completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}" # colorize filenames
zstyle ':completion:*' menu no # disable menu completion for fzf-tab

# Keybindings
bindkey '^[[3~' delete-char                  # DELETE key
bindkey "^[[H" beginning-of-line             # HOME key
bindkey "^[[F" end-of-line                   # END key

# Disable paste highlighting for syntax-highlighting plugin
zle_highlight+=(paste:none)

# Setup fuzzy finder
export FZF_DEFAULT_OPTS=" \
--color=bg+:#424762,spinner:#b0bec5,hl:#f78c6c \
--color=fg:#bfc7d5,header:#ff9e80,info:#82aaff,pointer:#a5adce \
--color=marker:#89ddff,fg+:#eeffff,prompt:#c792ea,hl+:#ff9e80 \
--color=selected-bg:#424762"
if [[ -x $(command -v fzf) ]]; then eval "$(fzf --zsh)"; fi

# Setup eza
export EZA_CONFIG_DIR="$XDG_CONFIG_HOME/eza"

# Aliases
[[ -f "$ZDOTDIR/aliases.zsh" ]] && source "$ZDOTDIR/aliases.zsh"

# PATH
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.opencode/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# Setup npm global bin so that we do not clutter $HOME
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/.npmrc"
export PATH="$HOME/.npm-global/bin:$PATH"

# zerobrew (only set up if actually installed on this machine)
if [[ -d "$HOME/.zerobrew" ]]; then
  export ZEROBREW_DIR="$HOME/.zerobrew"
  export ZEROBREW_BIN="$HOME/.zerobrew/bin"
  export ZEROBREW_ROOT=/opt/zerobrew
  export ZEROBREW_PREFIX=/opt/zerobrew/prefix
  export PKG_CONFIG_PATH="$ZEROBREW_PREFIX/lib/pkgconfig:${PKG_CONFIG_PATH:-}"

  # SSL/TLS certificates (only if ca-certificates is installed)
  if [ -f "$ZEROBREW_PREFIX/opt/ca-certificates/share/ca-certificates/cacert.pem" ]; then
    export CURL_CA_BUNDLE="$ZEROBREW_PREFIX/opt/ca-certificates/share/ca-certificates/cacert.pem"
    export SSL_CERT_FILE="$ZEROBREW_PREFIX/opt/ca-certificates/share/ca-certificates/cacert.pem"
  elif [ -f "$ZEROBREW_PREFIX/etc/ca-certificates/cacert.pem" ]; then
    export CURL_CA_BUNDLE="$ZEROBREW_PREFIX/etc/ca-certificates/cacert.pem"
    export SSL_CERT_FILE="$ZEROBREW_PREFIX/etc/ca-certificates/cacert.pem"
  elif [ -f "$ZEROBREW_PREFIX/share/ca-certificates/cacert.pem" ]; then
    export CURL_CA_BUNDLE="$ZEROBREW_PREFIX/share/ca-certificates/cacert.pem"
    export SSL_CERT_FILE="$ZEROBREW_PREFIX/share/ca-certificates/cacert.pem"
  fi

  if [ -d "$ZEROBREW_PREFIX/etc/ca-certificates" ]; then
    export SSL_CERT_DIR="$ZEROBREW_PREFIX/etc/ca-certificates"
  elif [ -d "$ZEROBREW_PREFIX/share/ca-certificates" ]; then
    export SSL_CERT_DIR="$ZEROBREW_PREFIX/share/ca-certificates"
  fi

  # Helper function to safely append to PATH
  _zb_path_append() {
      local argpath="$1"
      case ":${PATH}:" in
          *:"$argpath":*) ;;
          *) export PATH="$argpath:$PATH" ;;
      esac;
  }

  _zb_path_append "$ZEROBREW_BIN"
  _zb_path_append "$ZEROBREW_PREFIX/bin"
fi

# zsh-autocomplete must load last: it needs completion, zstyle, bindkey,
# and fzf already configured above to hook into them correctly
_load_plugin marlonrichert/zsh-autocomplete

# Re-run compinit now that zsh-autocomplete has added its Completions/ dir
# to fpath, so autoload picks up its internal _autocomplete__* functions
# (they'd otherwise be invisible: compinit already scanned fpath before
# the plugin got a chance to extend it)
compinit -d "$XDG_CACHE_HOME/zsh/.zcompdump"
