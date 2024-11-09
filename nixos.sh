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

question "You want to format disk?" answer

if [[ "$answer" == "true" ]]; then
  echo

  echo "$NOTE Available disks:"
  echo -e "$(fdisk -l | grep -E "^Disk /dev/[a-z]+:" | sed -E 's#^Disk\s+(/dev/[a-z]+: [^,]+B),.*#\t\1#')"
  input "Enter disk to format" disk "/dev/sda"

  echo

  question "Selected disk is $YELLOW$disk$RESET. It's right?" answer
  if [[ "$answer" == "false" ]]; then
    echo "$ERROR Invalid disk"
    exit
  fi

  echo

  echo "$ACTION Create disko.nix for $YELLOW$disk$RESET disk"

  if [[ -f "./disko.nix" ]]; then
    backupname=$(date "+%H-%M-%S-%d-%m-%Y")
    echo "$WARN disko.nix exists. Backup to disko-$backupname.nix"
    mv disko.nix disko-$backupname.bkp
  fi

  curl -s -S -L https://github.com/BruhaBruh/BruhOS/raw/main/disko.nix > disko.nix

  sed -i "s|/dev/sda|$disk|g" ./disko.nix

  echo

  strict_question "You are not stupid? Selected disk is $YELLOW$disk" answer
  if [[ "$answer" == "false" ]]; then
    echo "$ERROR Invalid disk"
    exit
  fi

  echo

  echo "$ACTION Format selected disk by disko"
  sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode disko ./disko.nix

  echo

  echo "$OK Disk is formatted"
else
  echo
  question "Did you format the disk?" answer
  if [[ "$answer" == "false" ]]; then
    echo "$NOTE To format disk use:"
    echo "$NOTE   $ parted /dev/sd# -- mklabel gpt"
    echo "$NOTE   $ parted /dev/sd# -- mkpart root btrfs 512MB 100%"
    echo "$NOTE   $ parted /dev/sd# -- mkpart ESP fat32 1MB 512MB"
    echo "$NOTE   $ parted /dev/sd# -- set 2 esp on"
    echo "$NOTE   $ parted /dev/sd# -- set 2 esp on"
    echo "$NOTE   $ mkfs.btrfs -L nixos /dev/sd#1"
    echo "$NOTE   $ mkfs.fat -F 32 -n boot /dev/sd#2"
    echo "$NOTE   $ mount /dev/disk/by-label/nixos /mnt"
    echo "$NOTE   $ mkdir -p /mnt/boot"
    echo "$NOTE   $ mount -o umask=077 /dev/disk/by-label/boot /mnt/boot"
    exit
  fi
fi

echo

question "Install NixOS with dots configuration.nix?" answer
if [[ "$answer" == "false" ]]; then
  echo "$NOTE To install NixOS use: nixos-generate-config --root /mnt && nixos-install"
  exit
fi

echo

echo "$ACTION Generate configuration"
sudo nixos-generate-config --root /mnt

echo

echo "$ACTION Copy disko.nix to /mnt/etc/nixos/disko.nix"

cp ./disko.nix /mnt/etc/nixos/disko.nix

echo

echo "$ACTION Download configuration.nix"
curl -s -S -L https://github.com/BruhaBruh/BruhOS/raw/main/configuration.nix > /mnt/etc/nixos/configuration.nix

echo

input "Enter hostname" hostName "nixos"

sed -i "s|hostName = \"nixos\"|hostName = \"$hostName\"|g" /mnt/etc/nixos/configuration.nix

echo

input "Enter username" username "bruhabruh"

sed -i "s|username = \"bruhabruh\"|username = \"$username\"|g" /mnt/etc/nixos/configuration.nix

echo

echo "$OK Configuration is generated"

echo

strict_question "Run nixos-install?" answer
if [[ "$answer" == "false" ]]; then
  echo "$NOTE To install NixOS use: nixos-install"
  exit
fi

echo

echo "$ACTION Install NixOS"

nixos-install

echo "$OK NixOS successfully installed!"