{ pkgs, ... }:

pkgs.writeShellScriptBin "openproject" ''
  set -e

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
      printf "\t$GRAY''${default}: $RESET"
    else
      printf "\t$GRAY: $RESET"
    fi
    
    read user_input

    if [[ -z "''${user_input}" && -n "$default" ]]; then
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

  input "Project name" project_name

  mkdir -p "$HOME/projects/$project_name"

  question "Open in editor?" answer
  if [[ "$answer" == "false" ]]; then
    cd "$HOME/projects/$project_name"
    exec $SHELL
    exit
  fi

  input "Editor" editor "code"

  $editor "$HOME/projects/$project_name"
''
