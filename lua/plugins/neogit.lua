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
    },
    keys = {
      { "<leader>gg", ":Neogit kind=vsplit<CR>", desc = "Open Neogit" },
    },
  },
}
