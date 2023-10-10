return {
  {
    "NeogitOrg/neogit",
    opts = {
       mappings = {
        -- modify status buffer mappings
        status = {
          ["F"] = "PullPopup",
          ["p"] = "PushPopup",
        }
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
