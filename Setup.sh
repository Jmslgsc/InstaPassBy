#!/bin/bash
#Instagram: @Jmslgsc
#Credit: github.com/Jmslgsc

set -euo pipefail
trap 'printf "%b\n" "exiting cleanly..."; exit 1' SIGINT SIGTSTP

checkroot() {

if [[ "$(id -u)" -ne 0 ]]; then
   printf "%b\n" "\e[1;77mPlease, run this program as root!\n\e[0m"
   exit 1
fi

}

checkroot

install_if_missing() {
  local cmd="$1"
  local pkg="$2"
  if ! command -v "$cmd" > /dev/null 2>&1; then
    printf "%b\n" "\e[1;92mInstalling ${pkg}, please wait...\n\e[0m" >&2
    # avoid interactive prompts in automation
    export DEBIAN_FRONTEND=noninteractive
    apt-get update -qq
    if ! apt-get -y install "$pkg" -qq; then
      printf "%b\n" "\e[1;91m${pkg} not installed.\n\e[0m" >&2
      return 1
    fi
  fi
}

install_if_missing tor tor
install_if_missing openssl openssl
install_if_missing curl curl

printf "%b\n" "\e[1;92mAll required packages are installed!\n\e[0m"