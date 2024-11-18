#!/usr/bin/env bash
set -e

# Set some colors for output messages
OK="$(tput setaf 2)[OK]$(tput sgr0)"
ERROR="$(tput setaf 1)[ERROR]$(tput sgr0)"
NOTE="$(tput setaf 3)[NOTE]$(tput sgr0)"
WARN="$(tput setaf 5)[WARN]$(tput sgr0)"
ACTION="$(tput setaf 6)[ACTION]$(tput sgr0)"
INPUT="$(tput setaf 4)[INPUT]$(tput sgr0)"
QUESTION="$(tput setaf 5)[?]$(tput sgr0)"
STRICT_QUESTION="$(tput setaf 1)[?!]$(tput sgr0)"
ORANGE=$(tput setaf 166)
YELLOW=$(tput setaf 3)
GRAY=$(tput setaf 8)
RESET=$(tput sgr0)

input() {
  local message="$1"
  local -n answer_var="$2"
  local default="$3"

  echo -e "$INPUT $message"
  if [[ -n "$default" ]]; then
    printf "\t$GRAY${default}: $RESET"
  else
    printf "\t$GRAY: $RESET"
  fi
  
  read user_input

  if [[ -z "${user_input}" && -n "$default" ]]; then
    answer_var="$default"
  else
    answer_var="$user_input"
  fi
}

question() {
  local message="$1"
  local -n answer_var="$2"

  echo -e "$QUESTION $message"
  printf "\t$GRAY(y/n): $RESET"
  
  read user_input
  
  if [[ -z "$user_input" || "$user_input" =~ ^[Yy]$ || "$user_input" == "yes" ]]; then
    answer_var="true"
  else
    answer_var="false"
  fi
}


strict_question() {
  local message="$1"
  local -n answer_var="$2"

  echo -e "$STRICT_QUESTION $message"
  printf "\t$GRAY(y/n): $RESET"
  
  read user_input
  
  if [[ "$user_input" =~ ^[Yy]$ || "$user_input" == "yes" ]]; then
    answer_var="true"
  else
    answer_var="false"
  fi
}

echo "$NOTE BruhOS"
echo "$NOTE Default values is ${GRAY}GRAY"

echo

if [ -n "$(grep -i nixos < /etc/os-release)" ]; then
  echo "$OK Verified this is NixOS."
else
  echo "$ERROR This is not NixOS or the distribution information is not available."
  exit
fi

echo

echo "$ACTION Ensure in home directory"
cd || exit

echo

input "Enter flake directory" flakeDirectory "$HOME/.dotfiles"

cd $flakeDirectory || exit

sed -i "s|flakeDirectory = \".*\"|flakeDirectory = \"$flakeDirectory\"|g" flake.nix

echo

input "Enter hostname" hostName "nixos"

sed -i "s|hostName = \".*\"|hostName = \"$hostName\"|g" flake.nix

echo

input "Enter username" username "bruhabruh"

sed -i "s|username = \".*\"; # user|username = \"$username\"; # user|g" flake.nix

echo

input "Enter time zone" timeZone "Asia/Yekaterinburg"

sed -i "s|timeZone = \".*\"|timeZone = \"$timeZone\"|g" flake.nix

echo

input "Enter default locale" defaultLocale "en_US.UTF-8"

sed -i "s|default = \".*\"|default = \"$defaultLocale\"|g" flake.nix
sed -i "s|\".*\" # default|\"$defaultLocale/UTF-8\" # default|g" flake.nix

echo

input "Enter extra locale" extraLocale "ru_RU.UTF-8"

sed -i "s|extra = \".*\"|extra = \"$extraLocale\"|g" flake.nix
sed -i "s|\".*\" # extra|\"$extraLocale/UTF-8\" # extra|g" flake.nix

echo

input "Enter git username" gitUsername "BruhaBruh"

sed -i "s|username = \".*\"; # git|username = \"$gitUsername\"; # git|g" flake.nix

echo

input "Enter git email" gitEmail "drugsho.jaker@gmail.com"

sed -i "s|email = \".*\"|email = \"$gitEmail\"|g" flake.nix

echo

input "Enter git default branch" gitDefaultBranch "main"

sed -i "s|defaultBranch = \".*\"|defaultBranch = \"$gitDefaultBranch\"|g" flake.nix

question "Enable proxy?" answer
if [[ "$answer" == "true" ]]; then
  sed -i "s|enableProxy = .*;|enableProxy = true;|g" flake.nix
else
  sed -i "s|enableProxy = .*;|enableProxy = false;|g" flake.nix
fi

echo "$OK Complete reconfiguration with values:"
echo "$GRAY  flake directory: $flakeDirectory"
echo "$GRAY  hostname: $hostName"
echo "$GRAY  username: $username"
echo "$GRAY  time zone: $timeZone"
echo "$GRAY  default locale: $defaultLocale"
echo "$GRAY  extra locale: $extraLocale"
echo "$GRAY  git username: $gitUsername"
echo "$GRAY  git email: $gitEmail"
echo "$GRAY  git default branch: $gitDefaultBranch"
echo "$GRAY  proxy: $answer"