{
  homeConfig,
  lib,
  pkgs,
  ...
}:
{
  globals.mapleader = " ";

  plugins.lualine.enable = true;
  plugins.neo-tree.enable = true;
  plugins.noice.enable = true;
  plugins.oil.enable = true;

  plugins.telescope = {
    enable = true;

    settings = {
      defaults.file_ignore_patterns = [
        "node_modules"
        "target"
      ];
    };
  };

  plugins.mini = {
    enable = true;
    mockDevIcons = true;

    modules = {
      icons.style = "glyph";
    };
  };

  opts = {
    signcolumn = "yes";
    termguicolors = true;
    wrap = false;
    scrolloff = 10;

    number = true;
    relativenumber = true;

    shiftwidth = 4;
    tabstop = 4;
    softtabstop = 4;
    expandtab = false;
    smartindent = true;
    list = true;

    hlsearch = false;
    incsearch = true;
  };

  colorschemes.catppuccin = {
    enable = true;

    settings = {
      flavour = homeConfig.catppuccin.flavor;
      transparent_background = true;
    };
  };

  plugins.lsp = {
    enable = true;

    servers = {
      cssls.enable = true;
      eslint.enable = true;
      html.enable = true;
      lua_ls.enable = true;
      nixd.enable = true;
      pylsp.enable = true;
      svelte.enable = true;
      tailwindcss.enable = true;
      ts_ls.enable = true;
    };

    servers.rust_analyzer = {
      enable = true;
      installCargo = true;
      installRustc = true;
    };
  };

  plugins.blink-cmp = {
    enable = true;

    settings.keymap = {
      preset = "enter";

      "<Tab>" = [
        "select_next"
        "fallback"
      ];

      "<S-Tab>" = [
        "select_prev"
        "fallback"
      ];
    };
  };

  plugins.conform-nvim = {
    enable = true;

    settings.format_on_save = {
      timeout_ms = 500;
      lsp_format = "fallback";
    };

    settings.formatters_by_ft = {
      bash = [ "shfmt" ];
      html = [ "prettierd" ];
      javascript = [ "prettierd" ];
      json = [ "prettierd" ];
      jsonc = [ "prettierd" ];
      just = [ "just" ];
      lua = [ "stylua" ];
      nix = [ "nixfmt" ];
      python = [ "black" ];
      qml = [ "qmlformat" ];
      rust = [ "rustfmt" ];
      sh = [ "shfmt" ];
      svelte = [ "prettierd" ];
      typescript = [ "prettierd" ];
    };

    settings.formatters_by_ft._ = [
      "squeeze_blanks"
      "trim_whitespace"
      "trim_newlines"
    ];

    settings.formatters = {
      black.command = lib.getExe pkgs.black;
      just.command = lib.getExe pkgs.just;
      nixfmt.command = lib.getExe pkgs.nixfmt;
      prettierd.command = lib.getExe pkgs.prettierd;
      qmlformat.command = lib.getExe' pkgs.kdePackages.qtdeclarative "qmlformat";
      rustfmt.command = lib.getExe pkgs.rustfmt;
      stylua.command = lib.getExe pkgs.stylua;
    };

    settings.formatters.shfmt = {
      command = lib.getExe pkgs.shfmt;

      args = [
        "-s"
        "-i"
        "2"
      ];
    };
  };

  plugins.treesitter = {
    enable = true;
    highlight.enable = true;
    indent.enable = true;

    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      bash
      css
      devicetree
      gitattributes
      gitignore
      html
      javascript
      json
      just
      lua
      markdown
      nix
      python
      qmljs
      rust
      svelte
      typescript
    ];
  };

  files."ftplugin/nix.lua".localOpts = {
    shiftwidth = 2;
    tabstop = 2;
    softtabstop = 2;
    expandtab = true;
  };

  files."ftplugin/json.lua".localOpts = {
    shiftwidth = 2;
    tabstop = 2;
    softtabstop = 2;
    expandtab = true;
  };

  files."ftplugin/jsonc.lua".localOpts = {
    shiftwidth = 2;
    tabstop = 2;
    softtabstop = 2;
    expandtab = true;
  };

  files."ftplugin/html.lua".localOpts = {
    shiftwidth = 2;
    tabstop = 2;
    softtabstop = 2;
    expandtab = true;
  };

  files."ftplugin/svelte.lua".localOpts = {
    shiftwidth = 2;
    tabstop = 2;
    softtabstop = 2;
    expandtab = true;
  };

  files."ftplugin/css.lua".localOpts = {
    shiftwidth = 2;
    tabstop = 2;
    softtabstop = 2;
    expandtab = true;
  };

  files."ftplugin/qml.lua".localOpts = {
    expandtab = true;
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>fe";
      action = ":Neotree toggle<CR>";
      options.desc = "Toggle file tree";
      options.silent = true;
    }
    {
      mode = "n";
      key = "-";
      action = ":Oil<CR>";
      options.desc = "Open file explorer";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<leader>fp";
      action = lib.nixvim.mkRaw ''require("telescope.builtin").find_files'';
      options.desc = "Find files";
    }
  ];
}
