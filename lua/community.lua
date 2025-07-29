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

  -- general recipes:
  { import = "astrocommunity.recipes.astrolsp-no-insert-inlay-hints" }, -- disable lsp hints in insert mode
  -- { import = "astrocommunity.recipes.ai" }, -- Use tab for snippet and AI completion, <C-n> & <C-p> for completion lists
  -- { import = "astrocommunity.recipes.diagnostic-virtual-lines-current-line" },

  -- { import = "astrocommunity.lsp.garbage-day-nvim" }, -- close longrunning lsp servers
  { import = "astrocommunity.lsp.actions-preview-nvim" },

  { import = "astrocommunity.debugging.nvim-dap-virtual-text" },
  -- { import = "astrocommunity.debugging.persistent-breakpoints-nvim" },

  -- { import = "astrocommunity.diagnostics.trouble-nvim" },
  { import = "astrocommunity.diagnostics.lsp_lines-nvim" },

  -- { import = "astrocommunity.editing-support.rainbow-delimiters-nvim" },
  { import = "astrocommunity.editing-support.telescope-undo-nvim" },
  { import = "astrocommunity.editing-support.todo-comments-nvim" },
  { import = "astrocommunity.editing-support.neogen" },
  -- { import = "astrocommunity.editing-support.true-zen-nvim" }, under spc+z, not there yet

  { import = "astrocommunity.git.neogit" },
  { import = "astrocommunity.git.diffview-nvim" }, -- used by neogit, TODO. Use d or D while hovering a file
  { import = "astrocommunity.git.octo-nvim" },

  -- { import = "astrocommunity.note-taking.neorg" },

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
  -- { import = "astrocommunity.pack.cs" },
  -- { import = "astrocommunity.pack.typescript-all-in-one" },
  { import = "astrocommunity.pack.typescript" },
  { import = "astrocommunity.pack.html-css" },
  { import = "astrocommunity.pack.rego" },
  -- { import = "astrocommunity.pack.ruby" },

  -- { import = "astrocommunity.markdown-and-latex.vimtex" },
  { import = "astrocommunity.programming-language-support.rest-nvim" },

  -- { import = "astrocommunity.scrolling.nvim-scrollbar" }, performance hit
  -- { import = "astrocommunity.scrolling.satellite-nvim" }, -- needs nvim >= 0.10
  { import = "astrocommunity.scrolling.vim-smoothie" },

  { import = "astrocommunity.test.neotest" },

  -- Activated by default, to disable it, create a `.lazy.lua` file in the root of your project and add the following:
  -- contents of .lazy.lua
  -- ---@type LazySpec
  -- return {
  --     { "copilot.lua", enabled = false },
  -- }
  { import = "astrocommunity.completion.copilot-lua" }, -- default keybinds: accept <Alt-l>, next <Alt-]>, dismiss <Ctrl-l>
  { import = "astrocommunity.editing-support.copilotchat-nvim" },
}
