# Brewfiles

Standalone Homebrew Bundle files to set up a new machine (macOS or Linux),
split by domain so each one can be installed independently.

`macos-specific.Brewfile`, `gui-apps.Brewfile`, `fonts.Brewfile`, and
`retro-emulators.Brewfile` use `cask`, which only works on macOS. Skip them
on Ubuntu.

## 1. Install Homebrew

**macOS:**

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Homebrew installs under `/opt/homebrew` (Apple Silicon) or `/usr/local`
(Intel) and is usually already on your PATH afterwards. If not, the
installer's final output tells you the `eval "$(brew shellenv)"` line to
add to your shell profile.

**If your dotfiles already have a `.zshenv` with this guard:**

```
if command -v brew >/dev/null 2>&1; then
    eval "$(brew shellenv)"
fi
```

you don't need to add anything manually — it picks up Homebrew
automatically once installed, no matter which file the installer tells you
to edit. If your `.zshenv` also sets `ZDOTDIR` (e.g. to
`$XDG_CONFIG_HOME/zsh`), zsh reads `.zshrc` from there instead of
`~/.zshrc` — so ignore any "add this to `.zshrc`" instruction from an
installer and, if you ever do need to add something, put it in
`$ZDOTDIR/.zshrc`, not `~/.zshrc`. This is also a good reason to run
`stow` before installing Homebrew: `.zshenv` needs to already be in place
for the auto-detection to work in the first new shell you open.

**Linux (Linuxbrew):**

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

At the end, the installer prints next steps you need to run yourself
(paths may differ slightly based on your username):

```
echo >> ~/.bashrc
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv bash)"' >> ~/.bashrc
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv bash)"

sudo apt-get install build-essential
```

The `build-essential` step installs Homebrew's build dependencies and
requires sudo. Without it some formulae may fail to compile.


## 2. Run stow first, if you use it

If you manage dotfiles with `stow`, run it before installing packages, so
tools find their config symlinks already in place at first launch instead
of writing their own defaults.


## 3. Install a bundle

```
brew bundle --file=shell-essentials.Brewfile
```

Repeat with the name of any other file you want installed.

## 5. Or install everything at once

**macOS:**

```
for f in *.Brewfile; do brew bundle --file="$f"; done
```

**Linux** (skips the cask-only files):

```
for f in *.Brewfile; do
  case "$f" in
    macos-specific.Brewfile|gui-apps.Brewfile|fonts.Brewfile|retro-emulators.Brewfile) continue ;;
  esac
  brew bundle --file="$f"
done
```
