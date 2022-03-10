#!/bin/bash
set -e

#Defaults vars
BRANCH="develop"
#shellcheck disable=SC2034
GIT_URL="https://github.com/ilyakubryakov/k3lmiir-dotfiles"

if [ -t 1 ]; then
  is_tty() {
    true
  }
else
  is_tty() {
    false
  }
fi

# Source: https://gist.github.com/XVilka/8346728
supports_truecolor() {
  case "$COLORTERM" in
  truecolor|24bit) return 0 ;;
  esac

  case "$TERM" in
  iterm           |\
  tmux-truecolor  |\
  linux-truecolor |\
  xterm-truecolor |\
  screen-truecolor) return 0 ;;
  esac

  return 1
}

fmt_link() {
  # $1: text, $2: url, $3: fallback mode
  if supports_hyperlinks; then
    printf '\033]8;;%s\a%s\033]8;;\a\n' "$2" "$1"
    return
  fi    

  case "$3" in
  --text) printf '%s\n' "$1" ;;
  --url|*) fmt_underline "$2" ;;
  esac
}

fmt_underline() {
  is_tty && printf '\033[4m%s\033[24m\n' "$*" || printf '%s\n' "$*"
}

# shellcheck disable=SC2016 # backtick in single-quote
fmt_code() {
  is_tty && printf '`\033[2m%s\033[22m`\n' "$*" || printf '`%s`\n' "$*"
}

fmt_error() {
  printf '%sError: %s%s\n' "${FMT_BOLD}${FMT_RED}" "$*" "$FMT_RESET" >&2
}

setup_color() {
  # Only use colors if connected to a terminal
  if ! is_tty; then
    FMT_RAINBOW=""
    FMT_RED=""
    FMT_GREEN=""
    FMT_YELLOW=""
    FMT_BLUE=""
    FMT_BOLD=""
    FMT_RESET=""
    return
  fi

  if supports_truecolor; then
    FMT_RAINBOW="
      $(printf '\033[38;2;255;0;0m')
      $(printf '\033[38;2;255;97;0m')
      $(printf '\033[38;2;247;255;0m')
      $(printf '\033[38;2;0;255;30m')
      $(printf '\033[38;2;77;0;255m')
      $(printf '\033[38;2;168;0;255m')
      $(printf '\033[38;2;245;0;172m')
    "
  else
    #shellcheck disable=SC2034
    FMT_RAINBOW="
      $(printf '\033[38;5;196m')
      $(printf '\033[38;5;202m')
      $(printf '\033[38;5;226m')
      $(printf '\033[38;5;082m')
      $(printf '\033[38;5;021m')
      $(printf '\033[38;5;093m')
      $(printf '\033[38;5;163m')
    "
  fi

  FMT_RED=$(printf '\033[31m')
  FMT_GREEN=$(printf '\033[32m')
  FMT_YELLOW=$(printf '\033[33m')
  #shellcheck disable=SC2034
  FMT_BLUE=$(printf '\033[34m')
  FMT_BOLD=$(printf '\033[1m')
  FMT_RESET=$(printf '\033[0m')
}

info_msg () {
    printf '\n'
    echo "$FMT_GREEN $FMT_BOLD $1 $FMT_RESET"
    printf '\n'
}

wrn_msg () {
    printf '\n'
    echo "$RED $FMT_BOLD $1 $FMT_RESET"
    printf '\n'
}

git_clone () {
  info_msg "Cloning repo"
  git clone $GIT_URL "$HOME/k3lmiir_dotfiles"
  git branch $BRANCH
  git checkout $BRANCH
}

ostype=$(uname)
  if [ -z "${ostype%CYGWIN*}" ] && git --version | grep -q msysgit; then
    fmt_error "Windows/MSYS Git is not supported on Cygwin"
    exit 1
  fi

setup_color
printf '\n'
printf "$FMT_GREEN $FMT_BOLD %s %s %s This script will install and configure some softwere that I(k3lmiir) like to use.\n $FMT_RESET" 
printf "$FMT_GREEN $FMT_BOLD %s %s %s Hope it will save some time for you. Enjoy :)\n $FMT_RESET"
printf "$FMT_GREEN $FMT_BOLD %s %s %s  • Follow https://www.instagram.com/k3lmiir/ • \n $FMT_RESET"
printf "$FMT_GREEN $FMT_BOLD %s %s %s • 🇺🇦   STOP WAR IN UKRAINE   🇺🇦 • "
printf '\n'

if [ -z "${ostype%Darwin*}" ]; then
    printf '\n'
    printf "$FMT_YELLOW $FMT_BOLD %s %s %s ...It seems you using macOS. Well, let's configure it...\n $FMT_RESET"
    printf '\n'
    if ! [ -x "$(command -v brew)" ]; then
      wrn_msg 'Error: Homebrew is not installed.' >&2
      info_msg "Please install Homebrew. https://brew.sh/index_ru"
      exit 1
    else
        if ! [ -x "$(command -v git)" ]; then
          info_msg "You forgot install GIT... Installing..."
          brew install git
          git_clone
          # shellcheck source=/dev/null
          source "$HOME/k3lmiir_dotfiles/macos/config_macos.sh"
        else
          git_clone
          # shellcheck source=/dev/null
          source "$HOME/k3lmiir_dotfiles/macos/config_macos.sh"
        fi
    fi
elif [ -z "${ostype%Linux*}" ]; then
      distrotype=$(grep -E  '^(NAME)=' /etc/os-release | awk '{ print substr( $0, 6 ) }' | sed 's/"//g')
      if [ -z "${distrotype%Ubuntu*}" ]; then
          printf '\n'
          printf "$FMT_YELLOW $FMT_BOLD %s %s %s ...It seems you using $distrotype Linux. Well, let's configure it...\n $FMT_RESET"
          printf '\n'
          if ! [ -x "$(command -v git)" ]; then
          info_msg "You forgot install GIT... Installing..."
          sudo apt -y install git vim
          git_clone
          # shellcheck source=/dev/null
          source "$HOME/k3lmiir_dotfiles/macos/config_macos.sh"
        else
          git_clone
          # shellcheck source=/dev/null
          source "$HOME/k3lmiir_dotfiles/macos/config_macos.sh"
        fi
      fi
else
wrn_msg "...Unfortunately right now operating systems other than macOS/Ubuntu is not supported, come back soon..."
fi
