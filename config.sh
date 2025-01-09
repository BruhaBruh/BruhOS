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

print_wallpapers() {
  echo "$NOTE Available wallpapers in dotfiles"
  find ./config/wallpapers \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) \
    | sed 's|./config/wallpapers/||' \
    | sort \
    | paste -d $'\t' - - \
    | column -t \
    | sed 's/^/\t/'
  echo
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

sed -i "/# flakeDirectory/{n;s|= .*;|= \"$flakeDirectory\";|}" variables.nix

echo

echo "$NOTE Main configuration"

echo

input "Enter hostname" hostName "nixos"

sed -i "/# hostName/{n;s|= .*;|= \"$hostName\";|}" variables.nix

echo

input "Enter username" username "bruhabruh"

sed -i "/# username/{n;s|= .*;|= \"$username\";|}" variables.nix

echo

echo "$NOTE i18n configuration"

echo

input "Enter time zone" timeZone "Asia/Yekaterinburg"

sed -i "/# timeZone/{n;s|= .*;|= \"$timeZone\";|}" variables.nix

echo

input "Enter default locale" defaultLocale "en_US.UTF-8"

sed -i "/# locale.default/{n;s|= .*;|= \"$defaultLocale\";|}" variables.nix

sed -i "/# locale.supported\[0\]/{n;s|\".*\"|\"$defaultLocale/UTF-8\"|}" variables.nix

echo

input "Enter extra locale" extraLocale "ru_RU.UTF-8"

sed -i "/# locale.extra/{n;s|= .*;|= \"$extraLocale\";|}" variables.nix

sed -i "/# locale.supported\[1\]/{n;s|\".*\"|\"$extraLocale/UTF-8\"|}" variables.nix

echo

echo "$NOTE Git configuration"

echo

input "Enter git username" gitUsername "BruhaBruh"

sed -i "/# git.username/{n;s|= .*;|= \"$gitUsername\";|}" variables.nix

echo

input "Enter git email" gitEmail "drugsho.jaker@gmail.com"

sed -i "/# git.email/{n;s|= .*;|= \"$gitEmail\";|}" variables.nix

echo

input "Enter git default branch" gitDefaultBranch "main"

sed -i "/# git.defaultBranch/{n;s|= .*;|= \"$gitDefaultBranch\";|}" variables.nix

echo

echo "$NOTE Theme configuration"

echo

question "Use Apple cursors instead of Catppuccin?" enableAppleCursors

sed -i "/# apple.cursors.enabled/{n;s|= .*;|= $enableAppleCursors;|}" variables.nix

echo

question "Use Apple icons instead of Papirus?" enableAppleIcons

sed -i "/# apple.icons.enabled/{n;s|= .*;|= $enableAppleIcons;|}" variables.nix

echo

print_wallpapers

input "Enter default wallpaper" defaultWallpaper "forest.jpg"

sed -i "/# wallpaper.default/{n;s|= .*;|= \"$defaultWallpaper\";|}" variables.nix

echo

question "Enable random wallpaper service?" enableRandomWallpaperService

sed -i "/# wallpaper.service.enabled/{n;s|= .*;|= $enableRandomWallpaperService;|}" variables.nix

if [[ "$enableRandomWallpaperService" == "true" ]]; then
  echo

  input "Enter random wallpaper interval in minutes" randomWallpaperInterval "1"

  sed -i "/# wallpaper.service.interval/{n;s|= .*;|= $randomWallpaperInterval;|}" variables.nix
fi

echo

echo "$NOTE Other configuration"

echo

echo "$OK Complete reconfiguration with values:"
echo -e "$GRAY\tflake directory: $YELLOW$flakeDirectory"
echo -e "$GRAY$RESET\tMain"
echo -e "$GRAY\t\thostname: $YELLOW$hostName"
echo -e "$GRAY\t\tusername: $YELLOW$username"
echo -e "$GRAY$RESET\ti18n"
echo -e "$GRAY\t\ttimeZone: $YELLOW$timeZone"
echo -e "$GRAY\t\tdefault locale: $YELLOW$defaultLocale"
echo -e "$GRAY\t\textra locale: $YELLOW$extraLocale"
echo -e "$GRAY$RESET\tGit"
echo -e "$GRAY\t\tusername: $YELLOW$gitUsername"
echo -e "$GRAY\t\temail: $YELLOW$gitEmail"
echo -e "$GRAY\t\tdefault branch: $YELLOW$gitDefaultBranch"
echo -e "$GRAY$RESET\tTheme"
echo -e "$GRAY\t\tcursors: $YELLOW$([[ "$enableAppleCursors" == "true" ]] && echo "Apple" || echo "Catppuccin")"
echo -e "$GRAY\t\ticons: $YELLOW$([[ "$enableAppleCursors" == "true" ]] && echo "Apple" || echo "Papirus")"
echo -e "$GRAY\t\tdefault wallpaper: $YELLOW$defaultWallpaper"
echo -e "$GRAY\t\trandom wallpaper service is enabled: $YELLOW$enableRandomWallpaperService"
echo -e "$GRAY\t\trandom wallpaper interval: $YELLOW${randomWallpaperInterval:-1}m"
echo -e "$GRAY$RESET\tOther"