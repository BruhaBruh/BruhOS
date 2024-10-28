{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (pkgs.writeShellScriptBin "openproject" ''
      editor="$EDITOR"
      edit_flag="false"
      project_name=""

      print_usage() {
        script_name=$(basename "$0")
        echo "Usage: $script_name [-e|--edit] [--editor] <name>"
        echo ""
        echo -e "\t-e --edit \t- open in editor"
        echo -e "\t--editor \t- editor to open"
      }

      process_flags() {
        while [[ "$#" -gt 0 ]]; do
          case "$1" in
            -e|--edit)
              edit_flag='true'
              shift
              ;;
            --editor)
              if [[ -n "$2" && "$2" != -* ]]; then
                editor="$2"
                shift 2
              else
                echo "Error: --editor requires a editor argument."
                print_usage
                exit 1
              fi
              ;;
            *)
              if [[ "$1" == -* ]]; then
                echo "Error: '$1' is not a valid project name."
                print_usage
                exit 1
              fi
              
              if [[ -n "$project_name" ]]; then
                echo "Error: project name '$project_name' already exists. '$1'"
                print_usage
                exit 1
              fi

              project_name="$1"
              shift
              ;;
          esac
        done
      }

      validate_inputs() {
        if [[ -z "$project_name" ]]; then
          echo "Error: project name is empty"
          print_usage
          exit 1
        fi
      }

      create_project() {
        local project_path="$HOME/projects/$project_name"

        if [ ! -d "$project_path" ]; then
          read -p "Project $project_name doesn't exists. Create? (y/n): " response
          if [[ "$response" == "y" || "$response" == "Y" || -z "$response" ]]; then
            mkdir -p "$project_path"
            echo "Project created at $project_path"
          else
            echo "Project does not exists"
            exit 1
          fi
        fi
      }

      open_project() {
        local project_path="$HOME/projects/$project_name"

        if [[ "$edit_flag" == "true" ]]; then
          $editor "$project_path" || exit
        else
          cd "$project_path" || exit
        fi
      }

      if [[ $# -eq 0 ]]; then
        print_usage
        exit 1
      fi
      process_flags "$@"

      validate_inputs

      create_project

      open_project
    '')
  ];
}
