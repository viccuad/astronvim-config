-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  -- import/override with your plugins folder

  { import = "astrocommunity.colorscheme.sonokai" },
  { import = "astrocommunity.colorscheme.monokai-pro-nvim" },
  { import = "astrocommunity.colorscheme.catppuccin" },

  { import = "astrocommunity.lsp.garbage-day-nvim" },

  { import = "astrocommunity.debugging.nvim-dap-virtual-text" },
  -- { import = "astrocommunity.debugging.persistent-breakpoints-nvim" },
  --
  { import = "astrocommunity.diagnostics.trouble-nvim" },

  -- { import = "astrocommunity.editing-support.rainbow-delimiters-nvim" },
  { import = "astrocommunity.editing-support.telescope-undo-nvim" },
  { import = "astrocommunity.editing-support.todo-comments-nvim" },
  { import = "astrocommunity.editing-support.neogen" },
  -- { import = "astrocommunity.editing-support.true-zen-nvim" }, under spc+z, not there yet

  { import = "astrocommunity.git.neogit" },
  { import = "astrocommunity.git.diffview-nvim" }, -- used by neogit, TODO. Use d or D while hovering a file
  { import = "astrocommunity.git.octo-nvim" },
  { import = "astrocommunity.git.openingh-nvim" }, -- TODO configure <spc g Y> and so

  { import = "astrocommunity.note-taking.neorg" },

  -- { import = "astrocommunity.pack.ansible" }, FIXME mason ls reinstalls
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.bash" },
  { import = "astrocommunity.pack.docker" },
  { import = "astrocommunity.pack.go" },
  { import = "astrocommunity.pack.helm" },
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.pack.nix" },
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.toml" },
  { import = "astrocommunity.pack.yaml" },
  { import = "astrocommunity.pack.json" },
  { import = "astrocommunity.pack.terraform" },

  { import = "astrocommunity.programming-language-support.rest-nvim" },

  -- { import = "astrocommunity.scrolling.nvim-scrollbar" }, performance hit
  -- { import = "astrocommunity.scrolling.satellite-nvim" }, -- needs nvim >= 0.10
  { import = "astrocommunity.scrolling.vim-smoothie" },

  { import = "astrocommunity.test.neotest" },

  { import = "astrocommunity.completion.copilot-lua" }, -- default keybinds: accept <Alt-l>, next <Alt-]>, dismiss <Ctrl-l>
}
