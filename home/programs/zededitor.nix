{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nixd
    nil
    nixpkgs-fmt
    nginx-language-server
  ];

  programs.zed-editor = {
    enable = true;
    extensions = [
      "html"
      "dockerfile"
      "git-firefly"
      "docker-compose"
      "toml"
      "nix"
      "prisma"
      "basher"
      "snippets"
      "nginx"
      "0x96f"
    ];
    userSettings = {
      autosave = "on_focus_change";
      auto_update = false;
      base_keymap = "JetBrains";
      buffer_font_family = "JetBrainsMono Nerd Font";
      buffer_font_size = 16;
      buffer_font_weight = 600;
      format_on_save = "on";
      languages = {
        TSX = {
          code_actions_on_format = {
            "source.fixAll.eslint" = true;
            "source.organizeImports" = true;
          };
        };
        TypeScript = {
          code_actions_on_format = {
            "source.fixAll.eslint" = true;
            "source.organizeImports" = true;
          };
        };
        Nix = {
          language_server = {
            command = "nixd";
          };
          formatter = {
            external = {
              command = "nixpkgs-fmt";
            };
          };
        };
        Nginx = {
          language_server = {
            command = "nginx-language-server";
            arguments = [ ];
          };
        };
      };
      scrollbar = {
        show = "never";
      };
      show_whitespaces = "boundary";
      tab_size = 2;
      tabs = {
        file_icons = true;
        git_status = true;
      };
      telemetry = {
        diagnostics = false;
        metrics = false;
      };
      terminal = {
        copy_on_select = true;
        toolbar = {
          breadcrumbs = false;
        };
      };
      theme = {
        dark = "0x96f Theme";
        light = "Ayu Light";
        mode = "dark";
      };
      toolbar = {
        breadcrumbs = false;
      };
      ui_font_family = "JetBrainsMono Nerd Font";
      ui_font_size = 16;
    };
  };
}
