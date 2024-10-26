#!/usr/bin/env bash

if [ -n "$(grep -i nixos < /etc/os-release)" ]; then
  echo "Verified this is NixOS."
  echo "-----"
else
  echo "This is not NixOS or the distribution information is not available."
  exit
fi

if command -v git &> /dev/null; then
  echo "Git is installed, continuing with installation."
  echo "-----"
else
  echo "Git is not installed. Please install Git and try again."
  echo "Example: nix-shell -p git"
  exit
fi

echo "Default options are in brackets []"
echo "Just press enter to select the default"
sleep 2

echo "-----"

echo "Ensure In Home Directory"
cd || exit

echo "-----"

backupname=$(date "+%Y-%m-%d-%H-%M-%S")
if [ -d "nixos-dots" ]; then
  echo "nixos-dots exists, backing up to .config/nixos-dots-backups folder."
  if [ -d ".config/nixos-dots-backups" ]; then
    echo "Moving current version of nixos-dots to backups folder."
    mv "$HOME"/nixos-dots .config/nixos-dots-backups/"$backupname"
    sleep 1
  else
    echo "Creating the backups folder & moving nixos-dots to it."
    mkdir -p .config/nixos-dots-backups
    mv "$HOME"/nixos-dots .config/nixos-dots-backups/"$backupname"
    sleep 1
  fi
else
  echo "Thank you for choosing nixos-dots."
  echo "I hope you find your time here enjoyable!"
fi

echo "-----"

echo "Cloning & Entering nixos-dots Repository"
git clone https://github.com/BruhaBruh/nixos-dots.git
cd nixos-dots || exit
mkdir hosts/"$hostName"
cp -r hosts/default hosts/"$hostName"
git config --global user.name "installer"
git config --global user.email "installer@gmail.com"
git add .

echo "-----"

read -rp "Enter Your Hostname: [ default ] " hostName
if [ -z "$hostName" ]; then
  hostName="default"
fi

sed -i "/^\s*hostName[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$hostName\"/" ./flake.nix

echo "-----"

installusername=$(echo $USER)
read -rp "Enter Your Username: [ ${installusername} ] " installusername
if [ -z "$installusername" ]; then
  installusername=$(echo $USER)
fi

sed -i "/^\s*username[[:space:]]*=[[:space:]]*\"/s/\"\(bruhabruh\)\"/\"$installusername\"/" ./flake.nix

echo "-----"

read -rp "Enter Your Flake Directory: [ \$HOME/nixos-dots ] " flakeDirectory
if [ -z "$flakeDirectory" ]; then
  flakeDirectory="\$HOME/nixos-dots"
fi

sed -i "/^\s*flakeDirectory[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$flakeDirectory\"/" ./flake.nix

echo "-----"

read -rp "Enter Your Git Username: [ BruhaBruh ] " gitUsername
if [ -z "$gitUsername" ]; then
  gitUsername="BruhaBruh"
fi

sed -i "/^\s*username[[:space:]]*=[[:space:]]*\"/s/\"\(BruhaBruh\)\"/\"$gitUsername\"/" ./flake.nix

echo "-----"

read -rp "Enter Your Git Email: [ drugsho.jaker@gmail.com ] " gitEmail
if [ -z "$gitEmail" ]; then
  gitEmail="drugsho.jaker@gmail.com"
fi

sed -i "/^\s*email[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$gitEmail\"/" ./flake.nix

echo "-----"

read -rp "Enter Your Git Default Branch: [ main ] " gitDefaultBranch
if [ -z "$gitDefaultBranch" ]; then
  gitDefaultBranch="main"
fi

sed -i "/^\s*defaultBranch[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$gitDefaultBranch\"/" ./flake.nix

echo "-----"

echo "Generating The Hardware Configuration"
sudo nixos-generate-config --show-hardware-config > ./hosts/$hostName/hardware-configuration.nix

echo "-----"

echo "Setting Required Nix Settings Then Going To Install"
NIX_CONFIG="experimental-features = nix-command flakes"

echo "-----"

sudo nixos-rebuild switch --flake ~/nixos-dots/#${hostName}
