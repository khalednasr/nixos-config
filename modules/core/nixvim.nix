# Home Manager Module
{ inputs, ... }: {
  imports = [ inputs.nixvim.homeModules.nixvim ];

  programs.nixvim = {
    enable = true;

    # Vim options
    opts = {
      termguicolors = true;
      number = true;
      relativenumber = true;
      wrap = false;
      tabstop = 2;
      softtabstop = 2;
      shiftwidth = 2;
      expandtab = true;
      autoindent = true;
      ignorecase = true;
      smartcase = true;
      hlsearch = false;
      incsearch = true;
      scrolloff = 8;
      sidescrolloff = 8;
    };

    # Colorscheme
    colorschemes.gruvbox-material = {
      enable = true;
      settings = {
        enable_italic = true;
        forground = "original";
        transparent_background = 2; 
      };
    };

    # LSP
    plugins.lsp = {
      enable = true;
      servers = {
        # Nix
        nixd.enable = true;

        # Python
        basedpyright.enable = true;
        ruff.enable = true;

        # Rust
        rust_analyzer.enable = true;
        rust_analyzer.installRustc = true;
        rust_analyzer.installCargo = true;

        # System Verilog
        svls.enable = true;
      };
    };

    # Autocomplete
    plugins.blink-cmp = {
      enable = true;
      settings = {
        documentation.auto_show = true;
        keymap.preset = "super-tab";
        signature.enabled = true;
      };
    };

    # Treesitter
    plugins.treesitter = {
      enable = true;
      settings = {
        auto_install = true;
        highlight.enable = true;
        indent.enable = true;
      };
    };

    # Snacks
    plugins.snacks = {
      enable = true;
      settings = {
        picker.enable = true;
        bigfile.enable = true;
        bufdelete.enable = true;
        indent.enable = true;
        scroll.enable = true;
        words.enable = true;
      };
    };

    # Simple plugins with default configuration
    plugins.yazi.enable = true;
    plugins.web-devicons.enable = true;
    plugins.lualine.enable = true;
    plugins.bufferline.enable = true;

    # Custom keymaps
    globals.mapleader = " ";
    keymaps = [
      # Buffer navigation
      { key = "H"; action = "<cmd>bp<cr>"; mode = "n"; options.desc = "Previous buffer"; }
      { key = "L"; action = "<cmd>bn<cr>"; mode = "n"; options.desc = "Next buffer"; }

      # Horizontal scrolling
      { key = "<C-S-h>"; action = "20zh"; mode = ["n"]; options.desc = "Scroll left"; }
      { key = "<C-S-l>"; action = "20zl"; mode = ["n"]; options.desc = "Scroll right"; }

      # Clipboard interaction
      { key = "<leader>y"; action = "\"+y"; mode = ["n" "v"]; options.desc = "Yank to clipboard"; }
      { key = "<leader>d"; action = "\"+d"; mode = ["n" "v"]; options.desc = "Delete into clipboard"; }
      { key = "<leader>p"; action = "\"+p"; mode = ["n" "v"]; options.desc = "Paste from clipboard (after)"; }
      { key = "<leader>P"; action = "\"+P"; mode = ["n" "v"]; options.desc = "Paste from clipboard (before)"; } 
      { key = "<C-c>"; action = "\"+y"; mode = ["v"]; options.desc = "Copy selection to clipboard"; }
      { key = "<C-x>"; action = "\"+d"; mode = ["v"]; options.desc = "Cut selection to clipboard"; }
      { key = "<C-v>"; action = "<ESC>\"+pa"; mode = ["i"]; options.desc = "Insert from clipboard"; }
      { key = "<C-v>"; action = "d\"+P"; mode = ["v"]; options.desc = "Replace selection from clipboard"; }

      # Selections
      { key = "<C-a>"; action = "ggvG"; mode = ["n"]; options.desc = "Select all"; }

      # File explorer and picker
      { key = "<leader>e"; action = "<cmd>Yazi cwd<cr>"; mode = ["n" "v"]; options.desc = "Yazi in CWD"; }
      { key = "<leader>E"; action = "<cmd>Yazi<cr>"; mode = ["n" "v"]; options.desc = "Yazi at current buffer"; }
      { key = "<leader>f"; action.__raw = "function() Snacks.picker.files() end"; mode = ["n"]; options.desc = "Pick file"; }

      # Search
      { key = "<leader>sf"; action.__raw = "function() Snacks.picker.lines() end"; mode = ["n"]; options.desc = "Search in current file"; }
      { key = "<leader>sw"; action.__raw = "function() Snacks.picker.grep() end"; mode = ["n"]; options.desc = "Search files in CWD"; }
      { key = "<leader>sd"; action.__raw = "function() Snacks.picker.diagnostics_buffer() end"; mode = ["n"]; options.desc = "Search file diagnostics"; }
      { key = "<leader>sc"; action.__raw = "function() Snacks.picker.commands() end"; mode = ["n"]; options.desc = "Search commands"; }
      { key = "<leader>sk"; action.__raw = "function() Snacks.picker.keymaps() end"; mode = ["n"]; options.desc = "Search keymaps"; }
      { key = "<leader>sh"; action.__raw = "function() Snacks.picker.help() end"; mode = ["n"]; options.desc = "Search help pages"; }
    ];
  };
}
