# Directoy stack
alias d='dirs -v'
for index ({1..9}) alias "$index"="cd +${index}"; unset index


# Compress pdf using ghostscript
# Usage: compresspdf [input file] [output file] [screen*|ebook|printer|prepress]
compresspdf() {
    gs -sDEVICE=pdfwrite -dNOPAUSE -dQUIET -dBATCH -dPDFSETTINGS=/${3:-"screen"} -dCompatibilityLevel=1.4 -sOutputFile="$2" "$1"
}


# Some more ls aliases
alias ls="ls -p"
alias la='ls -A'

# Setup eza if available
#if command -v eza >/dev/null 2>&1; then
if [[ -x $(command -v eza) ]]; then
  ll() {
    eza -la --header --group-directories-first --git --icons=auto --color-scale --color-scale-mode=gradient "$@"
  }
else
  ll() {
    ls -alF "$@"
  }
fi

# Setup bat if available
if [[ -x $(command -v bat) ]]; then
  alias cat="bat"
fi


# Setup Neovim if available
if [[ -x $(command -v nvim) ]]; then
  alias vi="nvim"
fi


# My aliases
alias pullall="ls | xargs -I{} git -C {} pull"
alias ghostty="/Applications/Ghostty.app/Contents/MacOS/ghostty"


case $(uname) in
Darwin)
  # commands for macOS go here
  alias brew_leaves_desc="brew leaves | xargs brew desc --eval-all"
  ;;
Linux)
  # commands for Linux go here'
  ;;
esac
