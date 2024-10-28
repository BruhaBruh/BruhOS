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

echo "$NOTE BruhaBruh NixOS Dots"
echo "$NOTE Default values is ${GRAY}GRAY"

echo

if [ -n "$(grep -i nixos < /etc/os-release)" ]; then
  echo "$OK Verified this is NixOS."
else
  echo "$ERROR This is not NixOS or the distribution information is not available."
  exit
fi

echo

if [[ -x "$(command -v git)" ]]; then
  echo "$OK Git is installed continuing with installation."
else
  echo "$ERROR Git is not installed. Please install Git and try again."
  echo "$NOTE Example: nix-shell -p git"
  exit
fi


echo "$ACTION Ensure in home directory"
cd || exit

echo

input "Enter flake directory" flakeDirectory "$HOME/.dotfiles"

echo

backupname=$(date "+%Y-%m-%d-%H-%M-%S")
if [[ -d ".dotfiles" ]]; then
  echo "$NOTE Dot files exists. backing up to ${flakeDirectory}-${backupname}"
  mv "$flakeDirectory" "$flakeDirectory-$backupname"
  sleep 1
fi

echo

echo "$ACTION Cloning nixos-dots Repository & entering"
git clone https://github.com/BruhaBruh/nixos-dots.git $flakeDirectory
cd $flakeDirectory || exit

sed -i "s|flakeDirectory = \"\$HOME/.dotfiles\"|flakeDirectory = \"$flakeDirectory\"|g" flake.nix

echo

input "Enter hostname" hostName "nixos"

mkdir hosts/"$hostName"
cp -r hosts/default/* hosts/"$hostName"/

sed -i "s|hostName = \"default\"|hostName = \"$hostName\"|g" flake.nix

echo

input "Enter username" username "bruhabruh"

sed -i "s|username = \"bruhabruh\"|username = \"$username\"|g" flake.nix

echo

input "Enter time zone" timeZone "Asia/Yekaterinburg"

sed -i "s|timeZone = \"Asia/Yekaterinburg\"|timeZone = \"$timeZone\"|g" flake.nix

echo

input "Enter default locale" defaultLocale "en_US.UTF-8"

sed -i "s|default = \"en_US.UTF-8\"|default = \"$defaultLocale\"|g" flake.nix
sed -i "s|\"en_US.UTF-8/UTF-8\"|\"$defaultLocale/UTF-8\"|g" flake.nix

echo

input "Enter extra locale" extraLocale "ru_RU.UTF-8"

sed -i "s|extra = \"ru_RU.UTF-8\"|extra = \"$extraLocale\"|g" flake.nix
sed -i "s|\"ru_RU.UTF-8/UTF-8\"|\"$extraLocale/UTF-8\"|g" flake.nix

echo

input "Enter git username" gitUsername "BruhaBruh"

sed -i "s|username = \"BruhaBruh\"|username = \"$gitUsername\"|g" flake.nix

echo

input "Enter git email" gitEmail "drugsho.jaker@gmail.com"

sed -i "s|email = \"drugsho.jaker@gmail.com\"|email = \"$gitEmail\"|g" flake.nix

echo

input "Enter git default branch" gitDefaultBranch "main"

sed -i "s|defaultBranch = \"main\"|defaultBranch = \"$gitDefaultBranch\"|g" flake.nix

echo

echo "$ACTION Generating The Hardware Configuration"
sudo nixos-generate-config --show-hardware-config > ./hosts/$hostName/host/hardware-configuration.nix
sleep 2

echo

git add .