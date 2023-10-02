return {
  -- You can also add new plugins here as well:
  -- Add plugins, the lazy syntax
  -- "andweeb/presence.nvim",
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function()
  --     require("lsp_signature").setup()
  --   end,
  -- },
  { 
    -- show colored chunks in file when on merge conflicts
    -- TODO doesn't get autoloaded, one needs to set lazy to false in init.lua
    "akinsho/git-conflict.nvim",
    version = "v1.1.2",
    opts = {
      disable_diagnostics = true, -- This will disable the diagnostics in a buffer whilst it is conflicted
    },
  },
}
