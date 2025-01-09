{ ... }:

{
  programs.zed-editor = {
    enable = true;
    extensions = [
      "html"
      "dockerfile"
      "git-firefly"
      "docker-compose"
      "nix"
      "prisma"
      "basher"
      "snippets"
      "nginx"
    ];
    userSettings = {
      autosave = "on_focus_change";
      base_keymap = "JetBrains";
      buffer_font_family = "JetBrainsMono Nerd Font";
      buffer_font_size = 16;
      buffer_font_weight = 600;
      format_on_save = "on";
      inlay_hints = {
        enabled = true;
      };
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
      };
      scrollbar = {
        show = "never";
      };
      show_whitespaces = "boundary";
      soft_wrap = "preferred_line_length";
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
        dark = "Andromeda";
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
