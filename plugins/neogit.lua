return {
  {
    "NeogitOrg/neogit",
    setup = {
      --  mappings = {
      --   -- modify status buffer mappings
      --   status = {
      --     ["F"] = "PullPopup",
      --     ["p"] = "PushPopup",
      --   }
      -- },
      use_magit_keybindings = true,
      integrations = {
        -- requires sindrets/diffview.nvim installed, which is installed from community
        diffview = enabled,
      },
      sections = {
        unstaged = {
          folded = false,
        },
        staged = {
          folded = false,
        },
      },
    },
    keys = {
      { "<leader>gg", ":Neogit kind=vsplit<CR>", desc = "Open Neogit" },
    },
  },
}
