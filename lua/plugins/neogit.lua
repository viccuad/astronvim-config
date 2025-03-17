return {
  {
    "NeogitOrg/neogit",
    opts = {
      -- The time after which an output console is shown for slow running commands
      console_timeout = 5000,
      mappings = {
        -- modify popup buffer mappings
        popup = {
          ["F"] = "PullPopup",
          ["p"] = "PushPopup",
        },
      },
      sections = {
        unstaged = {
          folded = false,
        },
        staged = {
          folded = false,
        },
      },
      integrations = {
        diffview = nil, -- sometimes diffview appears when doing rebases on its own. Better to trigger it manually
      },
    },
    keys = {
      { "<leader>gg", ":Neogit kind=vsplit<CR>", desc = "Open Neogit" },
    },
  },
}
